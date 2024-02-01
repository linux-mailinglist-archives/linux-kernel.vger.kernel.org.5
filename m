Return-Path: <linux-kernel+bounces-47529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF19844EFE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B035F1C22B58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFAD125D2;
	Thu,  1 Feb 2024 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZTad7qP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD1B171D0;
	Thu,  1 Feb 2024 02:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706753341; cv=none; b=GAcOv+cWFtAe9dFAVOvq6vRX+JYjzKLNbnDRL2S18bXEE6I6x/x2H2+8i/yzeOVlaSYkWMgq3hMdDY5HmVR9uHQtgLl0myCsnwB6dAqf7HCKSHy+QzAkPHbZgzKtW+GnYTFLY5eqlHnWKwGbMNXJacUrQ2dWAmqGZDd9O6TYqkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706753341; c=relaxed/simple;
	bh=qpgaAko8Zmepj+CsJYgEeQt49UM0kbaD3f1MmT1j9Y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hij+/PMEkTQTX6y+shAS1rmLNP1BnGnAPUDo8Jm79RhDPhHjmTFlYaI2ZwFvBpKRus0g8SX90yiV+NmZ1lodfYZW8c/bpgfVCBUwCtTHPE892Ihz4OyvAfyGBZFbJsrKL+1msVN8KI6oGfPYPU2FEw1G0TwDXpR+BpcYAdhs92Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZTad7qP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBD2C433A6;
	Thu,  1 Feb 2024 02:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706753340;
	bh=qpgaAko8Zmepj+CsJYgEeQt49UM0kbaD3f1MmT1j9Y0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JZTad7qPMEODueqFLCJmkELXm9HqTKqqlK6oRGm1CWsxL5D8nj56bwWj4KHDjoGAT
	 QFSmCQT+VmLNXD+YWswWbYQE+RgWqX9LeAum2/AnCvO+ta9I+CHn50rG4i6XXPokd8
	 U91f0X5GdhMvb5nfvW2v79oE1kHcUNscpAFW+QK7Ai/LtGVpt0yGNS+0lYKmyWPSmr
	 AHcXS6CJVm3qzRq7Z92J/0nfnmbt1MneKUR8vVc9VPcKkURXwokU2LUCQ21wdsOBZ4
	 Dwa7JdsfOwSE6D4WvoP+ZjeyfdoauCZXdMi5OaSZBDyP83OphTzJriJorHSyZI3mhQ
	 73WVBu8JzlQWA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d05d774518so3162391fa.1;
        Wed, 31 Jan 2024 18:09:00 -0800 (PST)
X-Gm-Message-State: AOJu0YxLpS4DL1wbt+pYzC0DV31xoCTFHPLl9fEpKp9eYZUgIEC/zzsn
	bJp73su3l+3w3hVr42EWteCbk6VI5uOaKokJiOzvveCKctrNBlqEeQSXhl5S8rLh2s3LWNKLLr0
	+E4te4n5ZPud5KhD+Ljwhb9CnpN0=
X-Google-Smtp-Source: AGHT+IEZWLOW5AyfTxq3DsArqXYZjZVQKlZdAkdNup913YWdU7itR3gfTo5qLKzEsXv/ztER6wEmyRn8aAlIHDNUV8Y=
X-Received: by 2002:a2e:a414:0:b0:2cc:78b7:1ef0 with SMTP id
 p20-20020a2ea414000000b002cc78b71ef0mr1136378ljn.4.1706753338768; Wed, 31 Jan
 2024 18:08:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org> <20231202035511.487946-3-sjg@chromium.org>
 <20231213121353.GA31326@willie-the-truck> <CAFLszTjfmSx1YMqzb2TsQf7sP4KrcQB=X7DY_HxRQp0J5HAppQ@mail.gmail.com>
 <CAK7LNAQRCDC03e=TVO=k4FuD2a2RdTy7yLr3UptQjVCX7pM1CA@mail.gmail.com>
 <20240109143349.GR1610741@bill-the-cat> <CAFLszTjwhy24UiT6kUJABMC1Xn0h9Q1q9fYpZZJg9DX8Vss9cA@mail.gmail.com>
 <CAFLszTjPAHd6RdO1mvatXC=yRS+h=sgJ_pMdyEnkROTx7yRpog@mail.gmail.com>
 <CAK7LNARsY6-rrx=sNFq6oFqpqf0s5S_=3DrUsCOS7zF0BXcoTg@mail.gmail.com> <CAL_JsqLYB0D5wAfedsb6tQp4EmD1AROgxiCncwO7gvA2p1C6Lg@mail.gmail.com>
In-Reply-To: <CAL_JsqLYB0D5wAfedsb6tQp4EmD1AROgxiCncwO7gvA2p1C6Lg@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 1 Feb 2024 11:08:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR-3rL6=YdhRRXB9dz+94y2yHTA=9mF4p7OPj7KExd7rg@mail.gmail.com>
Message-ID: <CAK7LNAR-3rL6=YdhRRXB9dz+94y2yHTA=9mF4p7OPj7KExd7rg@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To: Rob Herring <robh@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
	U-Boot Mailing List <u-boot@lists.denx.de>, Nicolas Schier <nicolas@fjasle.eu>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:03=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jan 30, 2024 at 3:16=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
org> wrote:
> >
> > On Fri, Jan 26, 2024 at 1:04=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi,
> > >
> > > On Wed, 17 Jan 2024 at 06:14, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Masahiro, Tom,
> > > >
> > > > On Tue, 9 Jan 2024 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Jan 09, 2024 at 11:01:42PM +0900, Masahiro Yamada wrote:
> > > > > > Hi Simon,
> > > > > >
> > > > > >
> > > > > > On Wed, Jan 3, 2024 at 8:47=E2=80=AFAM Simon Glass <sjg@chromiu=
m.org> wrote:
> > > > > > >
> > > > > > > Hi Masahiro,
> > > > > > >
> > > > > > > On Wed, Dec 13, 2023 at 5:14=E2=80=AFAM Will Deacon <will@ker=
nel.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote=
:
> > > > > > > > > Add a script which produces a Flat Image Tree (FIT), a si=
ngle file
> > > > > > > > > containing the built kernel and associated devicetree fil=
es.
> > > > > > > > > Compression defaults to gzip which gives a good balance o=
f size and
> > > > > > > > > performance.
> > > > > > > > >
> > > > > > > > > The files compress from about 86MB to 24MB using this app=
roach.
> > > > > > > > >
> > > > > > > > > The FIT can be used by bootloaders which support it, such=
 as U-Boot
> > > > > > > > > and Linuxboot. It permits automatic selection of the corr=
ect
> > > > > > > > > devicetree, matching the compatible string of the running=
 board with
> > > > > > > > > the closest compatible string in the FIT. There is no nee=
d for
> > > > > > > > > filenames or other workarounds.
> > > > > > > > >
> > > > > > > > > Add a 'make image.fit' build target for arm64, as well. U=
se
> > > > > > > > > FIT_COMPRESSION to select a different algorithm.
> > > > > > > > >
> > > > > > > > > The FIT can be examined using 'dumpimage -l'.
> > > > > > > > >
> > > > > > > > > This features requires pylibfdt (use 'pip install libfdt'=
). It also
> > > > > > > > > requires compression utilities for the algorithm being us=
ed. Supported
> > > > > > > > > compression options are the same as the Image.xxx files. =
For now there
> > > > > > > > > is no way to change the compression other than by editing=
 the rule for
> > > > > > > > > $(obj)/image.fit
> > > > > > > > >
> > > > > > > > > While FIT supports a ramdisk / initrd, no attempt is made=
 to support
> > > > > > > > > this here, since it must be built separately from the Lin=
ux build.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > Changes in v9:
> > > > > > > > > - Move the compression control into Makefile.lib
> > > > > > > > >
> > > > > > > > > Changes in v8:
> > > > > > > > > - Drop compatible string in FDT node
> > > > > > > > > - Correct sorting of MAINTAINERS to before ARM64 PORT
> > > > > > > > > - Turn compress part of the make_fit.py comment in to a s=
entence
> > > > > > > > > - Add two blank lines before parse_args() and setup_fit()
> > > > > > > > > - Use 'image.fit: dtbs' instead of BUILD_DTBS var
> > > > > > > > > - Use '$(<D)/dts' instead of '$(dir $<)dts'
> > > > > > > > > - Add 'mkimage' details Documentation/process/changes.rst
> > > > > > > > > - Allow changing the compression used
> > > > > > > > > - Tweak cover letter since there is only one clean-up pat=
ch
> > > > > > > > >
> > > > > > > > > Changes in v7:
> > > > > > > > > - Add Image as a dependency of image.fit
> > > > > > > > > - Drop kbuild tag
> > > > > > > > > - Add dependency on dtbs
> > > > > > > > > - Drop unnecessary path separator for dtbs
> > > > > > > > > - Rebase to -next
> > > > > > > > >
> > > > > > > > > Changes in v5:
> > > > > > > > > - Drop patch previously applied
> > > > > > > > > - Correct compression rule which was broken in v4
> > > > > > > > >
> > > > > > > > > Changes in v4:
> > > > > > > > > - Use single quotes for UIMAGE_NAME
> > > > > > > > >
> > > > > > > > > Changes in v3:
> > > > > > > > > - Drop temporary file image.itk
> > > > > > > > > - Drop patch 'Use double quotes for image name'
> > > > > > > > > - Drop double quotes in use of UIMAGE_NAME
> > > > > > > > > - Drop unnecessary CONFIG_EFI_ZBOOT condition for help
> > > > > > > > > - Avoid hard-coding "arm64" for the DT architecture
> > > > > > > > >
> > > > > > > > > Changes in v2:
> > > > > > > > > - Drop patch previously applied
> > > > > > > > > - Add .gitignore file
> > > > > > > > > - Move fit rule to Makefile.lib using an intermediate fil=
e
> > > > > > > > > - Drop dependency on CONFIG_EFI_ZBOOT
> > > > > > > > > - Pick up .dtb files separately from the kernel
> > > > > > > > > - Correct pylint too-many-args warning for write_kernel()
> > > > > > > > > - Include the kernel image in the file count
> > > > > > > > > - Add a pointer to the FIT spec and mention of its wide i=
ndustry usage
> > > > > > > > > - Mention the kernel version in the FIT description
> > > > > > > > >
> > > > > > > > >  Documentation/process/changes.rst |   9 +
> > > > > > > > >  MAINTAINERS                       |   7 +
> > > > > > > > >  arch/arm64/Makefile               |   7 +-
> > > > > > > > >  arch/arm64/boot/.gitignore        |   1 +
> > > > > > > > >  arch/arm64/boot/Makefile          |   6 +-
> > > > > > > > >  scripts/Makefile.lib              |  16 ++
> > > > > > > > >  scripts/make_fit.py               | 291 ++++++++++++++++=
++++++++++++++
> > > > > > > > >  7 files changed, 334 insertions(+), 3 deletions(-)
> > > > > > > > >  create mode 100755 scripts/make_fit.py
> > > > > > > >
> > > > > > > > I'll need Masahiro's Ack on the scripts/ changes before I c=
an take this
> > > > > > > > one.
> > > > > > >
> > > > > > > Any thoughts on this request, please?
> > > > > > >
> > > > > > > Regards,
> > > > > > > Simon
> > > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > As I mentioned before, I am concerned with having
> > > > > > the same "compatible" entries, with different contents,
> > > > > > as you use the "compatible" string as an ID to selecting
> > > > > > the target config node, right?
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > $ fdtdump  arch/arm64/boot/image.fit
> > > > > >
> > > > > >         ...
> > > > > >
> > > > > >         conf-10 {
> > > > > >             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> > > > > > "tq,am642-tqma6442l", "ti,am642";
> > > > > >             description =3D "TQ-Systems TQMa64xxL SoM on MBax4x=
xL carrier board";
> > > > > >             fdt =3D "fdt-10";
> > > > > >             kernel =3D "kernel";
> > > > > >         };
> > > > > >
> > > > > >         ...
> > > > > >
> > > > > >         conf-25 {
> > > > > >             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> > > > > > "tq,am642-tqma6442l", "ti,am642";
> > > > > >             description =3D "TQ-Systems TQMa64xxL SoM on MBax4x=
xL carrier board";
> > > > > >             fdt =3D "fdt-25";
> > > > > >             kernel =3D "kernel";
> > > > > >         };
> > > > >
> > > > > I had asked Rob a while ago about if having the same compatible f=
or two
> > > > > functionally different machines is a feature, or a bug, and I don=
't
> > > > > think either of us fully agreed either way. I'd be leaning toward=
s
> > > > > saying the above example is a bug in the dts files, it's just not=
 been a
> > > > > bug people have worried about before due to (sadly) how little th=
e
> > > > > top-level compatible has been used.
>
> I much prefer being able to use compatibles over filenames.
>
> > > >
> > > > Yes I believe this is a bug in the files.
> > > >
> > > > What should the script do in this case? Print a warning, perhaps?
> > >
> > > Is there anything I should do here? Would a warning be helpful, or
> > > just confusing?
> >
> >
> >
> > I do not think it is useful.
> > You would almost always get a warning, and there is no way to fix it.
>
> The above case is due to overlays. Why would you have a FIT image with
> both a base tree and applied overlays?



Because they are different hardware.

If FIT includes only base DTBs, how to use a base with extensions?




>
> In any case, maybe we need to record in dtb overlays that have been
> applied (which you asked about recently on dtc list). Not sure what
> that looks like though. Overlays have a 'top-level' compatible that we
> add in either separately or merged with the base's top-level
> compatible?


If there is a way to make "compatible" unique, that will be good.

But, in my understanding, we can replace a property value,
but not modify it.




--=20
Best Regards
Masahiro Yamada

