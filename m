Return-Path: <linux-kernel+bounces-32120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4488356BC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4761C2148E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F7B3770F;
	Sun, 21 Jan 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YifFATis"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657A381AD
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705855798; cv=none; b=YXbgMDNTLngNAB7UxD7R5lqHIEuiJytUv7avHD5gjRf5FgJZsdpyimah0/47O89ktewlFUj/OPT55S1ZyOD1+qXpVVVTbOZNJlAZ3dnsFOp0a5cMlQETBZZ3IuXINEGWy6FWHEQW4Okw3IBSjPaNo9hBYww9vBrONY0phxMancQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705855798; c=relaxed/simple;
	bh=Yu2mnmzL/2zG52YkN0D/5mY9ox1CRlA9H7snmZd4sAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dfyy+fidc4tz8IvAdqQ7y8bfvicm0Gk/zp/FtMkqTGQJ/J4REQ+tnFmfMbV09oDMpHCkUPU4HZjGtI88TLcursCf1K981BzKYj+wuFpdJ4JslrAvwTpMMqRqfsULgFIbHwhXc+HH7kXAogddsaxSMtxkgRIqGyiUi5/YrvYtx2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YifFATis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCBDC43330
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 16:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705855798;
	bh=Yu2mnmzL/2zG52YkN0D/5mY9ox1CRlA9H7snmZd4sAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YifFATisI4S9mzV53Yaxg2FHC9cxCheQBRH1SBe53+9QBCSn8s/x3+A35TCG/EuC/
	 /90uMLiBSObEMGDnSdCGvXatnN1T29M00Fz4tUUcW50meVi/pkvrPJ1B+RnqKp7BGJ
	 pnA8qS0DyQYN52wN0U8WW+CjXKFD2GP5n2BvukE5n3x5n75hZKKrLMhdvDI8QXrqae
	 UaIFL6+7A3gj3wicPM6HJYCNh89IvQShOCrO/GgLFTBlvKrULFeLtYHfzS+AUMHNvU
	 jUpzyTH0VL0/YYiKsU/dAHvEQf8DTKyAn3MQDSAX6ftzkusPyE+wqqzHoyHITyBz+T
	 GHf5xG2n7t6ZA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cd2f472665so21749111fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 08:49:58 -0800 (PST)
X-Gm-Message-State: AOJu0YwGHZW5SSXxpugBuetxD1Qg7hMad6rVKwJzNTNsTLn3sw+/AII7
	zz0hUmRqrZZN57EiNOfWzCgfvJy2sWrYwExpB3OXro2eWhEsWRYn577GkTsiocIIp+DyLQc7o5Y
	ZkfFYZvxxhE4lCkknJLXj6AlhF1I=
X-Google-Smtp-Source: AGHT+IGHEkqWt2FccuGrB0odXcj0oConLNVLfjg1Y7N6s0ozISSAAdvFhsepXzXFkzLk/10PUHmViAzGLDAZ+PzrD3U=
X-Received: by 2002:a2e:a784:0:b0:2cd:463f:6c34 with SMTP id
 c4-20020a2ea784000000b002cd463f6c34mr1315834ljf.78.1705855796240; Sun, 21 Jan
 2024 08:49:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ7YuEexYSaZYmLK@tassilo> <20240111223650.3502633-1-kevinloughlin@google.com>
 <20240115204634.GHZaWZqsVyU_fvn_RW@fat_crate.local> <CAMj1kXH=k26nNyB+LQJ7WUJgbD2f3PREyjCzSngMCGc+72XJ6w@mail.gmail.com>
 <20240117130557.GDZafQtfRyeVFbBUXA@fat_crate.local> <CAMj1kXEML99u7a8mZMhiWXXozsJYhVPaaTzYkegiSJcLw2pNJg@mail.gmail.com>
 <CAMj1kXGO68zBNXtdxDXbcQ0U7NRFe4m9bF4L_qFmYZ6mkOvmww@mail.gmail.com> <20240121153702.GAZa06Hvt8b0hQ4LjR@fat_crate.local>
In-Reply-To: <20240121153702.GAZa06Hvt8b0hQ4LjR@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 21 Jan 2024 17:49:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFMe6WqKXJsK1Lqk++naM8D=MZADhgpO_FjUd0RuFQU2w@mail.gmail.com>
Message-ID: <CAMj1kXFMe6WqKXJsK1Lqk++naM8D=MZADhgpO_FjUd0RuFQU2w@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
To: Borislav Petkov <bp@alien8.de>
Cc: Kevin Loughlin <kevinloughlin@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Kelley <mikelley@microsoft.com>, 
	Pankaj Gupta <pankaj.gupta@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Arnd Bergmann <arnd@arndb.de>, Steve Rutherford <srutherford@google.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Wang Jinchao <wangjinchao@xfusion.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Brian Gerst <brgerst@gmail.com>, Hugh Dickins <hughd@google.com>, Joerg Roedel <jroedel@suse.de>, 
	Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-coco@lists.linux.dev, 
	Ashish Kalra <ashish.kalra@amd.com>, Andi Kleen <ak@linux.intel.com>, 
	Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>, 
	Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Jan 2024 at 16:38, Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, Jan 21, 2024 at 03:12:56PM +0100, Ard Biesheuvel wrote:
> > The SEV boot code is especially tricky here as very few
> > people can even test it,
>
> No worries about that - us, the Google cloud folks, AWS and a bunch of
> others are people I could think of who could help out. :-)
>

Yeah. I have been trying to find people internally at Google that can
help me set up some CI that I can throw kernel builds at and they will
be test booted in a SEV guest, but so far progress has been slow.

> > 1)
> > WARNING: modpost: vmlinux: section mismatch in reference:
> > startup_64_pi+0x33 (section: .pi.text) -> sme_enable (section:
> > .init.text)
>
> sme_enable() is in the 1:1 mapping TU
> arch/x86/mm/mem_encrypt_identity.c, see
>
>   1cd9c22fee3a ("x86/mm/encrypt: Move page table helpers into separate translation unit")
>
> so might as well move it to .pi.text
>

Ack.

> The rest below look like they'd need more serious untangling.
>
> Btw, I just had another idea: we could remove -mcmodel=kernel from the
> build flags of the whole kernel once -fPIC is enabled so that gcc can be
> forced to do rIP-relative addressing.
>
> I'm being told the reason it doesn't allow mcmodel=kernel with -fPIC is
> only a matter of removing that check and that it *should* otherwise work
> but someone needs to try that. And then there are older gccs which we
> cannot fix.
>

-fPIE -mcmodel=small should work fine afaik. The only problem i
encountered is that it changes the default per-CPU base register to FS
but that can be overridden on the command line.

The problem with building the entire kernel -fPIE is that it increases
code size: RIP-relative LEA instructions are 1 byte longer than
absolute 32-bit MOVs.

