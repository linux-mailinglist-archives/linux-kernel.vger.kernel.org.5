Return-Path: <linux-kernel+bounces-60579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 461CC85074D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01DDD28639E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E148F5FEFE;
	Sat, 10 Feb 2024 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6t6/Ssa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0E81E4B0;
	Sat, 10 Feb 2024 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707608194; cv=none; b=ii8CuukkAOm7uIoRIYa44h8bCtl95KT4Nzc2LCWrtND/nyt8HD9Z1SX7QdMSaPBV4YyDOykjM8yrEBomVHD4pysGBxe1tlr9xcIDREfhY9O8MdiY7qk64yHEZOLHD2Pl10OiFE4dzKdtXvtr+hxkc75wM0babVTApmCcnme7UpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707608194; c=relaxed/simple;
	bh=8C4oWiGJS6yH0qp9Eaxr3aYeI/i7oae3HE05t0tAldw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrS7sNumZTiMamOe3hoKKU8j6RJceHEutJxChSBMf6OXoVyhROkS696M0mNj9kDiFZzbDE1eQ7G/4cr1AcV6VQoFcrF0au7xvGksu6GbcllHhyG8S+o3JACo2+csnb2yimhZ5RJ6wV4EaNxPQa4hEiqkzcfvdVW8skm+W6ulz0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6t6/Ssa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07CBC433C7;
	Sat, 10 Feb 2024 23:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707608193;
	bh=8C4oWiGJS6yH0qp9Eaxr3aYeI/i7oae3HE05t0tAldw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r6t6/SsaqOeeKJNUPVfZVjJbcNK3RRFmjuHojyVxfSItVDZ2TZuyB0EoFbkGs6cmN
	 fGZld4TdjiPZzaIrvGq0du2QE1WrRIwg1uaqftL/+TqHZD3PNrucg9KdOFYRvRjKht
	 Kk1w763J7dFF4u8iFKmo/Al3fa5jdjRgBZmxwu3QQfGQKxR2EAZ/epiWFzxP2MBMLL
	 6EpLosITDbsxVYxLRJlLLsek+7D2LtphnIXyz/MDB66zxzPmJbFpf348/1QD6IEBDf
	 JkxUs5J1dYgy0PVeh32WpGx+62i+nsng5YkqPRc8G/xgNnSiNVpMiC7yg4l3Cyh7DN
	 UQ+VQmrfIJsvQ==
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3392b045e0aso1322796f8f.2;
        Sat, 10 Feb 2024 15:36:33 -0800 (PST)
X-Gm-Message-State: AOJu0YwPRaM8OrHd0NFs5WFUmhUwxfpT54x2p083qacR14RdRT+IcXyv
	RJY1ai0UTrSXPvp7tclfdPUcsPVxovXwDih/8Q9FhFH0IZ/TcBNXFcUEQ7xwlE9gysDiVdZDcu1
	tqdR5z5I9YxXGPBaS57FpaJY5y3g=
X-Google-Smtp-Source: AGHT+IHoPMgBc81DnEPnPXoeHzmCqVcP4g7071LwOfBl3+AxfjKX8A2egkFqcIRNQszoXkfIPToNa/RR1WwBksr57rI=
X-Received: by 2002:a19:e048:0:b0:511:68d4:1e39 with SMTP id
 g8-20020a19e048000000b0051168d41e39mr2050802lfj.0.1707608171430; Sat, 10 Feb
 2024 15:36:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210074601.5363-1-xtex@envs.net> <20240210074601.5363-2-xtex@envs.net>
 <ZcdP7CC+OMbp5ZMi@shell.armlinux.org.uk> <ZcfoZKJHkdEh5JmV@fjasle.eu>
In-Reply-To: <ZcfoZKJHkdEh5JmV@fjasle.eu>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 11 Feb 2024 08:35:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQPm7PXoKM+id25wX9AtVmmXvE7i8GrGB9etU__EMUwdg@mail.gmail.com>
Message-ID: <CAK7LNAQPm7PXoKM+id25wX9AtVmmXvE7i8GrGB9etU__EMUwdg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: Abort make on install failures
To: Nicolas Schier <nicolas@fjasle.eu>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Zhang Bingwu <xtex@envs.net>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Zhang Bingwu <xtexchooser@duck.com>, Nathan Chancellor <nathan@kernel.org>, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 6:21=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu> =
wrote:
>
> On Sat, Feb 10, 2024 at 10:29:00AM +0000 Russell King (Oracle) wrote:
> > On Sat, Feb 10, 2024 at 03:46:00PM +0800, Zhang Bingwu wrote:
> > > From: Zhang Bingwu <xtexchooser@duck.com>
> > >
> > > Setting '-e' flag tells shells to exit with error exit code immediate=
ly
> > > after any of commands fails, and causes make(1) to regard recipes as
> > > failed.
> > >
> > > Before this, make will still continue to succeed even after the
> > > installation failed, for example, for insufficient permission or
> > > directory does not exist.
> > >
> > > Signed-off-by: Zhang Bingwu <xtexchooser@duck.com>
> > > ---
>
> Thanks for fixing!
>
> [...]
> > > diff --git a/arch/arm/boot/install.sh b/arch/arm/boot/install.sh
> > > index 9ec11fac7d8d..34e2c6e31fd1 100755
> > > --- a/arch/arm/boot/install.sh
> > > +++ b/arch/arm/boot/install.sh
> > > @@ -17,6 +17,8 @@
> > >  #   $3 - kernel map file
> > >  #   $4 - default install path (blank if root directory)
> > >
> > > +set -e
> > > +
> >
> > What about #!/bin/sh -e on the first line, which is the more normal way
> > to do this for an entire script?
>
> are you sure?  I can find many more occurrences of 'set -e' than the
> shebang version in the Linux tree, especially in the kbuild scripts, thus
> it's bike-shedding, isn't it?
>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
>
> Kind regards,
> Nicolas






When you put -e on the shebang line, like

    #!/bin/sh -e

the option -e is set when you do:

    $ arch/arm/boot/install.sh


But, -e is not set when you do:

    $ sh arch/arm/boot/install.sh



The reason is obvious because the latter case
does not use the shebang line.




In Kbuild, some places run the script directly like the former case,
and others use CONFIG_SHELL like

   $(CONFIG_SHELL) arch/arm/boot/install.sh


The inconsistency is not nice, but that is a different issue.


The separate 'set -e' statement works for both cases,
so I think this is safer, though it is kind of bike-shedding.





--=20
Best Regards
Masahiro Yamada

