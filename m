Return-Path: <linux-kernel+bounces-20815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399B4828593
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D5B288A8D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A5937160;
	Tue,  9 Jan 2024 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Vt8eCdKq"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB2F374CA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 74FB73F582
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704801435;
	bh=ZGy/wfG3TQf/vRE/4F986f8vqNPMiqYWXQi5KrKjYik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Vt8eCdKq3qFentUmDqmXlpkHokTgrtJCpbYzOQ1yXdLW5SzjSwBIyHz4TRGGDpZ5f
	 r62lLF0dmnvyCJb3yGMoZCkgfY4fiU8Z3+zrIWv7FqmPCd7whZ4dzBlBc3gemeD1Za
	 bK42b3chb/U3SEWIwwFxnbl7fJByyRv+XcRgRddJrpBBKp7wq1QnjjA6Mr+CThwJGS
	 IlLqalYf7AxcFiVe67+bTi7iJHL19Jw4Z+1HNw6YKYQTrBzYv/zJYdpNEEmr/w1vQC
	 MN3W2uJkKcwdGq6gU1zob/dM6N39ibN16C0W47by7kZto6KeHcHfK8709tGxrkZz0i
	 6LiCSg8w7PGCA==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40d2fa6b23eso23846865e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 03:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704801435; x=1705406235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGy/wfG3TQf/vRE/4F986f8vqNPMiqYWXQi5KrKjYik=;
        b=lNcW9uztMxnus/nCb6frR7k2n4v9eD1xuERkEv2BBT99DbAUtwaVkVeg+HkkJW0Nph
         WDV1jri7Rvp/9tHlcpZNlXIW2lGOS8pEKJ/ArIzaLkHyDEwFvaoXMQrOGOFWHq9nspYN
         1iFi3cFectFGzYAZxaF4DOFTuVzDLFh1ehmRZNCX3+avkgOlvilzZv3xgDcrIO67OAih
         5gvjD6zE1Lq4p+X6w2MtgVp1zCndyTKwEXynVpk0t/BYqYcjISt3LZiKT04n4+Xol4Y8
         AWLq2y8ba+g4+rWqYYpPzOZxv80XT8xzWAYqlOh1cks8Ek94e7xgTwaGYLuFgOzfPQ9u
         mKUw==
X-Gm-Message-State: AOJu0Yyd7zGrATLwE28Tm0loNgj+CfFcT4GnAZFRZIPKIqnLZ+joK9WY
	/haGzEBFB5NuPWBuOEDnHoaI69KAgPbRX1zihV/canbpe/4VY01WTAmAG+i/nUw84VcqccylzEX
	t4qmglzD2nDhJQFNllIG9objaiqLO0mjB5iEWLYryTouYReqh83cDCwENpVFAA15Qyy9pcIBOLP
	f7vA==
X-Received: by 2002:a05:600c:3d13:b0:40e:5121:d89c with SMTP id bh19-20020a05600c3d1300b0040e5121d89cmr227627wmb.58.1704801434967;
        Tue, 09 Jan 2024 03:57:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH50bFMQ3t77QnvCf0i+p5ZxeTPVd8YSEzDUAcOZkozb5Paffh1FcLU3FUn/qpT0DWBViHyPtDppZNdlog3ATI=
X-Received: by 2002:a05:600c:3d13:b0:40e:5121:d89c with SMTP id
 bh19-20020a05600c3d1300b0040e5121d89cmr227617wmb.58.1704801434644; Tue, 09
 Jan 2024 03:57:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZwk8nFBTIMISLXp@shell.armlinux.org.uk> <CADWks+Y7JOsvzWc50syVwOB9LF2Lxc_YiLzLxCkhEv8sBxrNvw@mail.gmail.com>
 <ZZw/XK12CnSgPtaB@shell.armlinux.org.uk> <CADWks+YdQ_1QkbhT5tzVA0c_5z0Yn39-nyfNMH201=Anu7DCJQ@mail.gmail.com>
 <ZZxyrFkTmrGneP0H@shell.armlinux.org.uk> <ZZ0qvM9uVOh5wQ59@shell.armlinux.org.uk>
In-Reply-To: <ZZ0qvM9uVOh5wQ59@shell.armlinux.org.uk>
From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date: Tue, 9 Jan 2024 11:56:37 +0000
Message-ID: <CADWks+Z5iZ=P_OAanA-PiePFbMpwtRe3_dF8wRTak8YAi87zvQ@mail.gmail.com>
Subject: Re: [BUG] SHA-3 causes kmod 28 to segfault
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jan 2024 at 11:15, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Jan 08, 2024 at 10:09:49PM +0000, Russell King (Oracle) wrote:
> > On Mon, Jan 08, 2024 at 06:46:10PM +0000, Dimitri John Ledkov wrote:
> > > On Mon, 8 Jan 2024 at 18:30, Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > On Mon, Jan 08, 2024 at 06:14:17PM +0000, Dimitri John Ledkov wrote:
> > > > > Hi,
> > > > >
> > > > > On Mon, 8 Jan 2024 at 16:38, Russell King (Oracle)
> > > > > <linux@armlinux.org.uk> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > When building 6.7 under Debian Oldstable with kmod 28, the installation
> > > > > > of modules fails during depmod with a SEGV.
> > > > > >
> > > > >
> > > > > What is your kernel configuration, and I hope you make config choices
> > > > > compatible with your target host OS.
> > > >
> > > > "target host OS" - that's a total misnomer. "host" is generally what
> > > > you're building under. "target" is generally what you're building _for_.
> > > > So I don't fully understand your comment. Maybe you meant "target _and_
> > > > host" ?
> > >
> > > the kernel configuration you use, should target the operating system
> > > you are planning to use the given kernel on.
> >
> > Thank you for stating the damn obvious. I've been developing Linux
> > kernels for 30 years, I think I know this.
> >
> > > using bleeding edge kernel features, with an obsolete userspace often
> > > can have compatibility issues.
> >
> > You're still not being clear. I wonder whether you understand the
> > terms "target" and "host".
> >
> > > > > > Running under gdb:
> > > > > >
> > > > > > Program received signal SIGSEGV, Segmentation fault.
> > > > > > __strlen_sse2 () at ../sysdeps/x86_64/multiarch/strlen-vec.S:133
> > > > > >
> > > > > > I have no further information as I can't remember how to get the debug
> > > > > > info for packages under Debian - and even if I could, it's probably a
> > > > > > bug in the kmod package that Debian will have absolutely no interest in
> > > > > > fixing (based on previous experience reporting bugs to Debian.)
> > > > >
> > > > > For latest kernel and latest kernel features support in kmod, latest
> > > > > kmod is required. I.e. patched with
> > > > > https://github.com/kmod-project/kmod/commit/510c8b7f7455c6613dd1706e5e41ec7b09cf6703
> > > >
> > > > Would be nice if there was some documentation. Also, as kconfig provides
> > > > a mechanism to detect e.g. the version of tooling used to build the
> > > > kernel, it would've been nice to detect whether depmod was sufficiently
> > > > recent to support SHA3 and make the module signing SHA3 options depend
> > > > on that.
> > > >
> > > > Leaving this to a SEGV to indicate that something is wrong isn't user
> > > > friendly.
> > > >
> > >
> > > There is no ability to detect runtime kmod at build time, given the
> > > two are usually often not the same.
> >
> > Again, you CLEARLY don't understand the problem. I am *NOT* reporting
> > a problem on the target. I am reporting a problem on the *build*
> > *host*.
> >
> > > Can you please provide your config?
> > > Can you please explain how you chose it?
> >
> > No, because it's totally irrelevant to the problem I'm reporting.
> >
> > What I'm reporting to you is that _IF_ you build a kernel with the
> > SHA3 modsigning options on a HOST that has kmod 28, then depmod
> > SEGVs when _INSTALLING_ the modules to a directory on the _HOST_.
> >
> > This has *nothing* to do with the capabilities of the _TARGET_.
> > Whether the configuration matches the capabilities of the _TARGET_
> > is *totally* irrelevant at _this_ stage. In fact, with the _HOST_
> > depmod segfaulting, one can't complete the installation process
> > to even _think_ about transferring it to the _TARGET_.
>
> Here's a patch that checks the version of depmod on the _build_
> _host_, preventing the use of the SHA3 module signing if it isn't
> recent enough, which causes
>
>         make modules_install INSTALL_MOD_PATH=/foo/bar/bzz
>
> run on the _build_ _host_ to fail with a segfault.
>
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index 0ea1b2970a23..d2ba454026a9 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -223,6 +223,11 @@ config MODULE_SIG_ALL
>           Sign all modules during make modules_install. Without this option,
>           modules must be signed manually, using the scripts/sign-file tool.
>
> +config DEPMOD_VERSION
> +       int
> +       default $(depmod-version)
> +       default 0
> +
>  comment "Do not forget to sign required modules with scripts/sign-file"
>         depends on MODULE_SIG_FORCE && !MODULE_SIG_ALL
>
> @@ -250,14 +255,17 @@ config MODULE_SIG_SHA512
>
>  config MODULE_SIG_SHA3_256
>         bool "Sign modules with SHA3-256"
> +       depends on DEPMOD_VERSION > 28
>         select CRYPTO_SHA3
>

Did you test that things are successful wtih kmod 29, 30, 31?

The code to correctly support sha3 in kmod was committed after 31 was
tagged, and there is no newer tag yet hence the revision that has the
correct code is v31-6-g510c8b7f74.
If such check is desired, kmod 32 should be tagged and check should
check for 32.

>  config MODULE_SIG_SHA3_384
>         bool "Sign modules with SHA3-384"
> +       depends on DEPMOD_VERSION > 28
>         select CRYPTO_SHA3
>
>  config MODULE_SIG_SHA3_512
>         bool "Sign modules with SHA3-512"
> +       depends on DEPMOD_VERSION > 28
>         select CRYPTO_SHA3
>
>  endchoice
> diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
> index 5a84b6443875..052f581c86da 100644
> --- a/scripts/Kconfig.include
> +++ b/scripts/Kconfig.include
> @@ -63,3 +63,6 @@ ld-version := $(shell,set -- $(ld-info) && echo $2)
>  cc-option-bit = $(if-success,$(CC) -Werror $(1) -E -x c /dev/null -o /dev/null,$(1))
>  m32-flag := $(cc-option-bit,-m32)
>  m64-flag := $(cc-option-bit,-m64)
> +
> +# depmod version
> +depmod-version := $(shell,$(srctree)/scripts/depmod-version.sh)
> diff --git a/scripts/depmod-version.sh b/scripts/depmod-version.sh
> new file mode 100755
> index 000000000000..32a8a6f6b737
> --- /dev/null
> +++ b/scripts/depmod-version.sh
> @@ -0,0 +1,11 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +: ${DEPMOD:=depmod}
> +
> +# legacy behavior: "depmod" in /sbin, no /sbin in PATH
> +PATH="$PATH:/sbin"
> +
> +LC_ALL=C "$DEPMOD" --version | sed -n '1s/kmod version //p'
>

If possible please use min-tool-version.sh to set the lower bound of
kmod that is supported by the build. Assuming module signing is
generally desired to be supported, the minimum required kmod should be
set to 26. Otherwise at least modinfo doesn't work.

-- 
Dimitri

Sent from Ubuntu Pro
https://ubuntu.com/pro

