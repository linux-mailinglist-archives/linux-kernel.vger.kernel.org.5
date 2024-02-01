Return-Path: <linux-kernel+bounces-48845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39AE846246
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B06B284892
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548F53CF5B;
	Thu,  1 Feb 2024 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cxjo1K37"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4647AA35;
	Thu,  1 Feb 2024 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821413; cv=none; b=Ue+mRjpUIfv+Z/8TKDW1QZVanmXoz66puK67xJEHbx79/wRdcOnceIvMA2wAPJEvQus/RV+YQ/CY8/Hhv2VHPOtO0oQtDTym3owElsk/0FJZEz/IwLA5Wq43MO5QT5y/hyjR1IJLhQlbyf0X2K7RdTg2WQyu3QRKZuwN4itdj3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821413; c=relaxed/simple;
	bh=+flYHaxiiXVtYmqDZv2gN3djzmehGKcoz3OtVdDwp+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTZ7OqrTeU8uL/L8ob1nw8WYDq8voXe/PLi7uYMZXPMm3szqr4SaiA2irj7O7Jgu8+4/UeqjMBBQG34yFAxCUIi40c5/cGqeyZSqXlMkxHmt+5WHvZMOBCUF4qGtboGMXeDq3SYj540XiLDcRXnd4cHmIg0PUF1PqeJGyE48d9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cxjo1K37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879EBC43330;
	Thu,  1 Feb 2024 21:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706821412;
	bh=+flYHaxiiXVtYmqDZv2gN3djzmehGKcoz3OtVdDwp+o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Cxjo1K376rwpu7UYZOr9aMO05t3cCz8KPneQVPj5PntewwHD5ilzB/iZtE70cyzkU
	 0SYQx5DUPgm6jjHgi2N7DGMy3ipkEuhbV0IDfIabUcmWdOlj8KvTUExZqcj3mwD9Fb
	 8JgAfatIOABoVeZbddpMKNZaw05amlCjr1ScbtzQKcdnSOaA0C/iTHJP9QbrKu/Qux
	 yRIesFBy7B6rl2kltacE6QqNq/7VSkAxL3i03uVzDVt9r39TO/hWn986n4b6MLhwSj
	 Fnkj22LEfpoj2v4kR2h/0afQW1d6Wym+c9CSSw2Pb1lKF9Hf5rcnhANyKhMsMr1EKN
	 MNEmkefUbKa6g==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0512f6e32so17674011fa.1;
        Thu, 01 Feb 2024 13:03:32 -0800 (PST)
X-Gm-Message-State: AOJu0YyZobdL/d5cMYryAsOQUUPzdutSDsCJUjzZZc3ck8yMhjODJFPr
	EEhkvQnwBxt6pPJF5T/TwDBf+KiEB0UcokP7XwYjoZHG+tn75bS6ksb86Ot0ZvNozbh+Fu6Z5yy
	+Xa+o25knAO1dRM+xryomfk5nmA==
X-Google-Smtp-Source: AGHT+IGzXNSqC7E6769kd/2xdpiea6EMl2p9n2g6bO3UOt4X6FoIKqHQBCJAG835S2EUEqj7TL/aui7eP8q5hFngQDQ=
X-Received: by 2002:a2e:80d5:0:b0:2cf:20f5:efdb with SMTP id
 r21-20020a2e80d5000000b002cf20f5efdbmr2335478ljg.38.1706821410513; Thu, 01
 Feb 2024 13:03:30 -0800 (PST)
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
 <CAK7LNARsY6-rrx=sNFq6oFqpqf0s5S_=3DrUsCOS7zF0BXcoTg@mail.gmail.com>
 <CAL_JsqLYB0D5wAfedsb6tQp4EmD1AROgxiCncwO7gvA2p1C6Lg@mail.gmail.com> <CAK7LNAR-3rL6=YdhRRXB9dz+94y2yHTA=9mF4p7OPj7KExd7rg@mail.gmail.com>
In-Reply-To: <CAK7LNAR-3rL6=YdhRRXB9dz+94y2yHTA=9mF4p7OPj7KExd7rg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Feb 2024 15:03:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLeTDALoKBuk9r+4NGXo0pc9LbK6bhDiZET+=UHG60fEA@mail.gmail.com>
Message-ID: <CAL_JsqLeTDALoKBuk9r+4NGXo0pc9LbK6bhDiZET+=UHG60fEA@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
	U-Boot Mailing List <u-boot@lists.denx.de>, Nicolas Schier <nicolas@fjasle.eu>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 8:09=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Feb 1, 2024 at 7:03=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
> >
> > On Tue, Jan 30, 2024 at 3:16=E2=80=AFAM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > On Fri, Jan 26, 2024 at 1:04=E2=80=AFAM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Wed, 17 Jan 2024 at 06:14, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Masahiro, Tom,
> > > > >
> > > > > On Tue, 9 Jan 2024 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Jan 09, 2024 at 11:01:42PM +0900, Masahiro Yamada wrote=
:
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > >
> > > > > > > On Wed, Jan 3, 2024 at 8:47=E2=80=AFAM Simon Glass <sjg@chrom=
ium.org> wrote:
> > > > > > > >
> > > > > > > > Hi Masahiro,
> > > > > > > >
> > > > > > > > On Wed, Dec 13, 2023 at 5:14=E2=80=AFAM Will Deacon <will@k=
ernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wro=
te:
> > > > > > > > > > Add a script which produces a Flat Image Tree (FIT), a =
single file
> > > > > > > > > > containing the built kernel and associated devicetree f=
iles.
> > > > > > > > > > Compression defaults to gzip which gives a good balance=
 of size and
> > > > > > > > > > performance.
> > > > > > > > > >
> > > > > > > > > > The files compress from about 86MB to 24MB using this a=
pproach.
> > > > > > > > > >
> > > > > > > > > > The FIT can be used by bootloaders which support it, su=
ch as U-Boot
> > > > > > > > > > and Linuxboot. It permits automatic selection of the co=
rrect
> > > > > > > > > > devicetree, matching the compatible string of the runni=
ng board with
> > > > > > > > > > the closest compatible string in the FIT. There is no n=
eed for
> > > > > > > > > > filenames or other workarounds.
> > > > > > > > > >
> > > > > > > > > > Add a 'make image.fit' build target for arm64, as well.=
 Use
> > > > > > > > > > FIT_COMPRESSION to select a different algorithm.
> > > > > > > > > >
> > > > > > > > > > The FIT can be examined using 'dumpimage -l'.
> > > > > > > > > >
> > > > > > > > > > This features requires pylibfdt (use 'pip install libfd=
t'). It also
> > > > > > > > > > requires compression utilities for the algorithm being =
used. Supported
> > > > > > > > > > compression options are the same as the Image.xxx files=
 For now there
> > > > > > > > > > is no way to change the compression other than by editi=
ng the rule for
> > > > > > > > > > $(obj)/image.fit
> > > > > > > > > >
> > > > > > > > > > While FIT supports a ramdisk / initrd, no attempt is ma=
de to support
> > > > > > > > > > this here, since it must be built separately from the L=
inux build.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > Changes in v9:
> > > > > > > > > > - Move the compression control into Makefile.lib
> > > > > > > > > >
> > > > > > > > > > Changes in v8:
> > > > > > > > > > - Drop compatible string in FDT node
> > > > > > > > > > - Correct sorting of MAINTAINERS to before ARM64 PORT
> > > > > > > > > > - Turn compress part of the make_fit.py comment in to a=
 sentence
> > > > > > > > > > - Add two blank lines before parse_args() and setup_fit=
()
> > > > > > > > > > - Use 'image.fit: dtbs' instead of BUILD_DTBS var
> > > > > > > > > > - Use '$(<D)/dts' instead of '$(dir $<)dts'
> > > > > > > > > > - Add 'mkimage' details Documentation/process/changes.r=
st
> > > > > > > > > > - Allow changing the compression used
> > > > > > > > > > - Tweak cover letter since there is only one clean-up p=
atch
> > > > > > > > > >
> > > > > > > > > > Changes in v7:
> > > > > > > > > > - Add Image as a dependency of image.fit
> > > > > > > > > > - Drop kbuild tag
> > > > > > > > > > - Add dependency on dtbs
> > > > > > > > > > - Drop unnecessary path separator for dtbs
> > > > > > > > > > - Rebase to -next
> > > > > > > > > >
> > > > > > > > > > Changes in v5:
> > > > > > > > > > - Drop patch previously applied
> > > > > > > > > > - Correct compression rule which was broken in v4
> > > > > > > > > >
> > > > > > > > > > Changes in v4:
> > > > > > > > > > - Use single quotes for UIMAGE_NAME
> > > > > > > > > >
> > > > > > > > > > Changes in v3:
> > > > > > > > > > - Drop temporary file image.itk
> > > > > > > > > > - Drop patch 'Use double quotes for image name'
> > > > > > > > > > - Drop double quotes in use of UIMAGE_NAME
> > > > > > > > > > - Drop unnecessary CONFIG_EFI_ZBOOT condition for help
> > > > > > > > > > - Avoid hard-coding "arm64" for the DT architecture
> > > > > > > > > >
> > > > > > > > > > Changes in v2:
> > > > > > > > > > - Drop patch previously applied
> > > > > > > > > > - Add .gitignore file
> > > > > > > > > > - Move fit rule to Makefile.lib using an intermediate f=
ile
> > > > > > > > > > - Drop dependency on CONFIG_EFI_ZBOOT
> > > > > > > > > > - Pick up .dtb files separately from the kernel
> > > > > > > > > > - Correct pylint too-many-args warning for write_kernel=
()
> > > > > > > > > > - Include the kernel image in the file count
> > > > > > > > > > - Add a pointer to the FIT spec and mention of its wide=
 industry usage
> > > > > > > > > > - Mention the kernel version in the FIT description
> > > > > > > > > >
> > > > > > > > > >  Documentation/process/changes.rst |   9 +
> > > > > > > > > >  MAINTAINERS                       |   7 +
> > > > > > > > > >  arch/arm64/Makefile               |   7 +-
> > > > > > > > > >  arch/arm64/boot/.gitignore        |   1 +
> > > > > > > > > >  arch/arm64/boot/Makefile          |   6 +-
> > > > > > > > > >  scripts/Makefile.lib              |  16 ++
> > > > > > > > > >  scripts/make_fit.py               | 291 ++++++++++++++=
++++++++++++++++
> > > > > > > > > >  7 files changed, 334 insertions(+), 3 deletions(-)
> > > > > > > > > >  create mode 100755 scripts/make_fit.py
> > > > > > > > >
> > > > > > > > > I'll need Masahiro's Ack on the scripts/ changes before I=
 can take this
> > > > > > > > > one.
> > > > > > > >
> > > > > > > > Any thoughts on this request, please?
> > > > > > > >
> > > > > > > > Regards,
> > > > > > > > Simon
> > > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > As I mentioned before, I am concerned with having
> > > > > > > the same "compatible" entries, with different contents,
> > > > > > > as you use the "compatible" string as an ID to selecting
> > > > > > > the target config node, right?
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > $ fdtdump  arch/arm64/boot/image.fit
> > > > > > >
> > > > > > >         ...
> > > > > > >
> > > > > > >         conf-10 {
> > > > > > >             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> > > > > > > "tq,am642-tqma6442l", "ti,am642";
> > > > > > >             description =3D "TQ-Systems TQMa64xxL SoM on MBax=
4xxL carrier board";
> > > > > > >             fdt =3D "fdt-10";
> > > > > > >             kernel =3D "kernel";
> > > > > > >         };
> > > > > > >
> > > > > > >         ...
> > > > > > >
> > > > > > >         conf-25 {
> > > > > > >             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> > > > > > > "tq,am642-tqma6442l", "ti,am642";
> > > > > > >             description =3D "TQ-Systems TQMa64xxL SoM on MBax=
4xxL carrier board";
> > > > > > >             fdt =3D "fdt-25";
> > > > > > >             kernel =3D "kernel";
> > > > > > >         };
> > > > > >
> > > > > > I had asked Rob a while ago about if having the same compatible=
 for two
> > > > > > functionally different machines is a feature, or a bug, and I d=
on't
> > > > > > think either of us fully agreed either way. I'd be leaning towa=
rds
> > > > > > saying the above example is a bug in the dts files, it's just n=
ot been a
> > > > > > bug people have worried about before due to (sadly) how little =
the
> > > > > > top-level compatible has been used.
> >
> > I much prefer being able to use compatibles over filenames.
> >
> > > > >
> > > > > Yes I believe this is a bug in the files.
> > > > >
> > > > > What should the script do in this case? Print a warning, perhaps?
> > > >
> > > > Is there anything I should do here? Would a warning be helpful, or
> > > > just confusing?
> > >
> > >
> > >
> > > I do not think it is useful.
> > > You would almost always get a warning, and there is no way to fix it.
> >
> > The above case is due to overlays. Why would you have a FIT image with
> > both a base tree and applied overlays?
>
>
>
> Because they are different hardware.

Meaning the base tree is valid on its own without any overlays?

> If FIT includes only base DTBs, how to use a base with extensions?

I would expect that you package up base and overlays or DTs with
already applied overlays, but not both together. That would be based
on whether your bootloader can apply overlays or not.

This problem boils down to your firmware knows or gains the knowledge
of some set of extra features or h/w pop options. The result is you
need base plus X, Y, Z whether those are a list of overlays or an
encoding of filename or something else. For example, FIT entries could
have a field that just lists those X, Y, Z features. But I'd much
rather have something that works outside of FIT images.

> > In any case, maybe we need to record in dtb overlays that have been
> > applied (which you asked about recently on dtc list). Not sure what
> > that looks like though. Overlays have a 'top-level' compatible that we
> > add in either separately or merged with the base's top-level
> > compatible?
>
>
> If there is a way to make "compatible" unique, that will be good.
>
> But, in my understanding, we can replace a property value,
> but not modify it.

Currently yes, but that shouldn't be too hard to add. The dtc
modification is the easy part. The hard part is figuring out the
policy around how we would use that.

But I don't really know what you want to accomplish with FIT here.
IMO, if you need filenames, then use a filesystem. They work pretty
well for storing large collections of files.

Rob

