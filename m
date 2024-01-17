Return-Path: <linux-kernel+bounces-28873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E583830408
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22AD1F25AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4951CD3C;
	Wed, 17 Jan 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUmbAnsI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281B21CF8C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489168; cv=none; b=f2r3hU1uCviySmob0SjLeVnsv1j/7eJkyL7j8gTH88WiaN3JHFHCBbmoDRzLIXCWc41tq6AW/AbxX4k5BWaOk79pjku5sKQXsXJnr4E+Xm1jVp2DqO13afzWz2De3YXTsLjYF+1xIfZVPdPG1NvcVAYk2b3kWwz5SOqxt+PE9fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489168; c=relaxed/simple;
	bh=z++aPhqJYmV8VB4OIKDmSI4vg9WbQB6P+vqni7mLX4M=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type; b=SXVrJulbw4RJWpHdRvx4EGHERy648gsRK25w0/9dQIivu0GkiTFsKK/wL8rP1uPa7xhyCq6NG0liS+jxL5QKxZlAnYMJrlNUSRYtjUq0aFRb3RYWogUWs/AruW7AcRH3pgPD0Abkrchwc+li0KIabSRmBTFbPoQQfi8kIS27sKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUmbAnsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C97C43609
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705489167;
	bh=z++aPhqJYmV8VB4OIKDmSI4vg9WbQB6P+vqni7mLX4M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IUmbAnsIE5vCKOMG92SfDaJvvsQbn0Gd9j+ni1Xumo7BbhtLTqu7AKam6IsvwF1b+
	 Jlcr14KUq6L5ESg5D0E49101sji45b+wC4YBgTE4eZ6IYwvdWD/Tj+f4lTk9GgQ83/
	 QCQ0CYq8jJJ260HIui8AqoqEC6ls7r8Fv5qED3KcDrKf2XQ545aXrNbZsuK5Hs9B8U
	 b6yjz0yNnHvvq4qxZ+F39BjZFbivVM+DtSH5lMhzp6Zg0RadvC4r283C4gi1YOBl3A
	 6ljYXjh8ELhx+2NzE/8ermEEzBtTQZx7CgJVxsO4jX/YTAM2MTHGzRi2fOy/OFX9iI
	 WZ3rdiK6djkbQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso12730743e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 02:59:27 -0800 (PST)
X-Gm-Message-State: AOJu0YyikwyYQaRkK4a3JEAZnFF4ivBNnMkVmaQDBrPdKhyhl9rIXqO0
	lyNM3U8yUs4QypNWzfrpUnYmSZ2b39W0zy4aBL4=
X-Google-Smtp-Source: AGHT+IFxh5QrJ1gWQCd/4YDEkFNTtChPK1g37tz97wiiKd3o0JeZrjXVzdzGAYAydUm+Cs0LLEXbDoyNQCA1Pd1yKTw=
X-Received: by 2002:a05:6512:33cf:b0:50e:506c:a2b7 with SMTP id
 d15-20020a05651233cf00b0050e506ca2b7mr2662609lfg.249.1705489165792; Wed, 17
 Jan 2024 02:59:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ7YuEexYSaZYmLK@tassilo> <20240111223650.3502633-1-kevinloughlin@google.com>
 <20240115204634.GHZaWZqsVyU_fvn_RW@fat_crate.local>
In-Reply-To: <20240115204634.GHZaWZqsVyU_fvn_RW@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 17 Jan 2024 11:59:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH=k26nNyB+LQJ7WUJgbD2f3PREyjCzSngMCGc+72XJ6w@mail.gmail.com>
Message-ID: <CAMj1kXH=k26nNyB+LQJ7WUJgbD2f3PREyjCzSngMCGc+72XJ6w@mail.gmail.com>
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

On Mon, 15 Jan 2024 at 21:47, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Jan 11, 2024 at 10:36:50PM +0000, Kevin Loughlin wrote:
> > SEV/SME code can execute prior to page table fixups for kernel
> > relocation. However, as with global variables accessed in
> > __startup_64(), the compiler is not required to generate RIP-relative
> > accesses for SEV/SME global variables, causing certain flavors of SEV
> > hosts and guests built with clang to crash during boot.
>
> So, about that. If I understand my gcc toolchain folks correctly:
>
> mcmodel=kernel - everything fits into the high 31 bit of the address
> space
>
> -fPIE/PIC - position independent
>
> And supplied both don't make a whole lotta of sense: if you're building
> position-independent, then mcmodel=kernel would be overridden by the
> first.
>
> I have no clue why clang enabled it...
>
> So, *actually* the proper fix here should be not to add this "fixed_up"
> gunk everywhere but remove mcmodel=kernel from the build and simply do
> -fPIE/PIC.
>

Fully agree. All this fiddling with RIP relative references from C
code is going to be a maintenance burden going forward.

The proper way to do this is use PIC codegen for the objects that
matter. I had a stab [0] at this a while ago (for the purpose of
increasing the KASLR range, which requires PIE linking) but I didn't
pursue it in the end.

On arm64, we use a separate pseudo-namespace for code that can run
safely at any offset, using the __pi_ prefix (for Position
Independent). Using symbol prefixing at the linker level, we ensure
that __pi_ code can only call other __pi_ code, or code that has been
made available to it via an explicit __pi_ prefixed alias. (Happy to
elaborate more but we should find a smaller audience - your cc list is
a tad long). Perhaps this is something we should explore on x86 as
well (note that the EFI stub does something similar for architectures
that link the EFI stub into the core kernel rather than into the
decompressor)



[0] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=x86-pie&id=4ba81de75d92fafdab2a8a389d1b7791dddf74f3

