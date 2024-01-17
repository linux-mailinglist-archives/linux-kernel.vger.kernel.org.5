Return-Path: <linux-kernel+bounces-28932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E85F8304CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0115E1F24E17
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558831DFD7;
	Wed, 17 Jan 2024 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hr9FF8pO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A31DFC8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705492534; cv=none; b=lj2V6NgkN5tmyzGr147fB0VxAqSGMRy9IXghG4XTqi7tBeRhrmb5ewojphMUIkOGJfEgAOERVsEzTYl6CN8O/iOhXd3YxEBrF+7LjK5tVz1fkH0SbviqrrjkLeLBJPLQJcAt8Ac/HDKsT3jYk21oEyEm8Qrwt6EyyoByddpdTXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705492534; c=relaxed/simple;
	bh=iFQJhKlc7pXhEgIHUu0aIF0uaghXVnVqJojUh4IxmI4=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type; b=ooBQEKY0YRJPj355QNmcNDG4/2QyPHEbWijctImun6eK/oZeGrWy9jgaU99FUOpIQUr9+fXNV7K4mbnev7jAWjafz5IbxDdPItd5lQf2kaLSYbShf1IHtQwFaa3tG9KT5He2ZlpjkaRkg3n7s5DFyogfh8ZZpCp8tkx9AhyFKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hr9FF8pO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10BAC43390
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705492534;
	bh=iFQJhKlc7pXhEgIHUu0aIF0uaghXVnVqJojUh4IxmI4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hr9FF8pOz/m41+DPrnr7ykraOGAUvQ1Dtj6hs9/qXGXKGUtgRZ3JVMDFBpceRShgk
	 u0DJc3CIPjH1bFzDtQU9VZxlC4MUfK/yiiTFVm913hKCpEqtRlZZeRkiJOV/WVkfvk
	 aZLF9xbSpJtJBht/TQBGOW/672DHvVJ87APn14fYSNNjDuCBldKl6o5ZERDIj1aSer
	 t3yZo88PGRle+JzI5mVCYH5YmYxIwSi5yly/TwykR0qctxWxW7lmmsojwSPTTzjcZf
	 sYiE+54Prk6LaffWb1gBhrkwcF2PehHw2Go7p4EnLF0jV4wDWqy2oHhgzwig108TsX
	 oTAcODF0cIv4w==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e7e55c0f6so13162840e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:55:33 -0800 (PST)
X-Gm-Message-State: AOJu0Yzv2KYgusg0SbfweSxiqiZ+LHyjjIF9PyHtEKfBZWMM499RbK4k
	xnpzymnsE3w3LyiMQc2QDupYkxP1W5BJR+ZFl90=
X-Google-Smtp-Source: AGHT+IFFbBbG0vWj2p5uNkZ8YdHfDUfgFtYFIdSJ/4cUNnNIYeSKGVPWM4yfEBslovtfzq3JcgTd9I21iV96p3A1Vns=
X-Received: by 2002:a05:6512:e9f:b0:50e:76dd:6071 with SMTP id
 bi31-20020a0565120e9f00b0050e76dd6071mr2598047lfb.257.1705492532199; Wed, 17
 Jan 2024 03:55:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ7YuEexYSaZYmLK@tassilo> <20240111223650.3502633-1-kevinloughlin@google.com>
 <20240115204634.GHZaWZqsVyU_fvn_RW@fat_crate.local> <CAMj1kXH=k26nNyB+LQJ7WUJgbD2f3PREyjCzSngMCGc+72XJ6w@mail.gmail.com>
 <Zae8ZKTpcN_BzaqU@tassilo>
In-Reply-To: <Zae8ZKTpcN_BzaqU@tassilo>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 17 Jan 2024 12:55:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEbd5tNqqLaPxFTAFnx0S-o8Fftc0fvtQUHRN6d2zSk7w@mail.gmail.com>
Message-ID: <CAMj1kXEbd5tNqqLaPxFTAFnx0S-o8Fftc0fvtQUHRN6d2zSk7w@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
To: Andi Kleen <ak@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Kevin Loughlin <kevinloughlin@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
	Ashish Kalra <ashish.kalra@amd.com>, Adam Dunlap <acdunlap@google.com>, 
	Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>, 
	Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 12:39, Andi Kleen <ak@linux.intel.com> wrote:
>
> On Wed, Jan 17, 2024 at 11:59:14AM +0100, Ard Biesheuvel wrote:
> > On Mon, 15 Jan 2024 at 21:47, Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Thu, Jan 11, 2024 at 10:36:50PM +0000, Kevin Loughlin wrote:
> > > > SEV/SME code can execute prior to page table fixups for kernel
> > > > relocation. However, as with global variables accessed in
> > > > __startup_64(), the compiler is not required to generate RIP-relative
> > > > accesses for SEV/SME global variables, causing certain flavors of SEV
> > > > hosts and guests built with clang to crash during boot.
> > >
> > > So, about that. If I understand my gcc toolchain folks correctly:
> > >
> > > mcmodel=kernel - everything fits into the high 31 bit of the address
> > > space
> > >
> > > -fPIE/PIC - position independent
> > >
> > > And supplied both don't make a whole lotta of sense: if you're building
> > > position-independent, then mcmodel=kernel would be overridden by the
> > > first.
> > >
> > > I have no clue why clang enabled it...
> > >
> > > So, *actually* the proper fix here should be not to add this "fixed_up"
> > > gunk everywhere but remove mcmodel=kernel from the build and simply do
> > > -fPIE/PIC.
>
> For the SEV file this might not work because it also has functions
> that get called later at runtime, and may need to reference real
> globals. I doubt the linker could resolve that.
>

I don't think that should be a problem. If the code and data are
within -/+ 2G of each other, RIP-relative references should always be
in range.

> For linking the whole kernel, I haven't seen the latest numbers, but
> traditionally -fPIE/PIC cost some performance because globals get loaded
> through the GOT instead of directly as immediates. That's why the original
> x86-64 port went with -mcmodel=kernel.
>

We can tell the compiler to avoid the GOT (using 'hidden' visibility),
and even if we don't, the amd64 psABI now defines linker relaxations
that turn GOT loads into LEA instructions (which still bloat the code
a bit but eliminate the GOT accesses in most cases).

