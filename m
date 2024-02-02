Return-Path: <linux-kernel+bounces-49234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7CD846788
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2F91C23CB8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E4C17553;
	Fri,  2 Feb 2024 05:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh6doJiC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6851E17546;
	Fri,  2 Feb 2024 05:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706852286; cv=none; b=WgTObbHu+vLFJswaE9BaR8+Qaf43aRswsi5Q7O3GVrhUXbCh5WsPC+WweaZiObHAGMZqAItMkNn2Bsz7Gc4i4PBq5x0dIOYm5gB4kzUOwa9WJzs5XWmZQ05nu1ww8zRRzQfNoiNS4EB0btIWh/sUrFE7ESOGoj0gT4fBzvfPp4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706852286; c=relaxed/simple;
	bh=E2GR5XDHSPikBayOkcLuyu7j9MvZrOlxRVXQ5WJoxgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqGx1AmMnxenaKnGHmfHscZ9Xg8tm2w1GQNHwQU3I0ClpeNb9SXS0LvY9qH5tDXxjMxFYx9ve7Fg8H2OXoXkMOYoW9jk8L7UOCMURHRDkJzfZ8QKh1TU6mkntZfK2Qazo2+y33FFvhF04MYf4oxTSxK6WV64Vgh/43sLEPmBv+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh6doJiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54BCC43390;
	Fri,  2 Feb 2024 05:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706852285;
	bh=E2GR5XDHSPikBayOkcLuyu7j9MvZrOlxRVXQ5WJoxgs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Dh6doJiCFcemsy8VlbfxgnCRA+eZWVPGbFB9UvG3bHNtDfM8WoaTSxgSEJm1/M4oZ
	 NdIop9HwGOQRrcyEozvi7PvbrwZrLc4NPoNc6iIv3Wi070m+J0EtNvoUvJyT2Utehl
	 9ifhg0bvSFE7DARAleCceFpuIa0hv8hLzqq09n5etBFQ3Sfw1JvJz/HPhx8GRWymno
	 h5lHFXJo40UBto6r48dmQCmkOC2ewLwdY8Mr27kCm1UPNFuBfASI8W2SCCS+WAKNnX
	 VyheKGVwxtFxh6xnIKEejK2h9gbVuEDBM3WwaEG5THoyp7WUS5tfgQUCfAlseHTM0n
	 TkVo2+HWX30XA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5112a04c7acso2780112e87.3;
        Thu, 01 Feb 2024 21:38:05 -0800 (PST)
X-Gm-Message-State: AOJu0Yy7V2UDVH/UGuCJ2sItCV1zlsOv9EVg8uyI9cXlk2sPFzuvjVI7
	8kAOua2IlODCNEfwr16IvyhArcamviRwCXdGC8x9dZJh/FjZg2NlT1vXFnoRtIS/HuvjfY8YEaB
	auaf11/63sNdm8oSIOriVQMclpnQ=
X-Google-Smtp-Source: AGHT+IEx5d3cL+SHteHuJJiPnd5pqIM+E+Jcy3+p18zXc92ZL6sviKC9fFLdsRcahqJ5y84jQK7dxuxpkrNT7J8dh8U=
X-Received: by 2002:a19:6702:0:b0:511:341b:ff94 with SMTP id
 b2-20020a196702000000b00511341bff94mr578145lfc.26.1706852283931; Thu, 01 Feb
 2024 21:38:03 -0800 (PST)
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
 <CAL_JsqLYB0D5wAfedsb6tQp4EmD1AROgxiCncwO7gvA2p1C6Lg@mail.gmail.com>
 <CAK7LNAR-3rL6=YdhRRXB9dz+94y2yHTA=9mF4p7OPj7KExd7rg@mail.gmail.com> <CAL_JsqLeTDALoKBuk9r+4NGXo0pc9LbK6bhDiZET+=UHG60fEA@mail.gmail.com>
In-Reply-To: <CAL_JsqLeTDALoKBuk9r+4NGXo0pc9LbK6bhDiZET+=UHG60fEA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 2 Feb 2024 14:37:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNARSHiNGwHy4Tocbfkgyio1SbHV6sRJCA7yTrcTOXYEQHQ@mail.gmail.com>
Message-ID: <CAK7LNARSHiNGwHy4Tocbfkgyio1SbHV6sRJCA7yTrcTOXYEQHQ@mail.gmail.com>
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

On Fri, Feb 2, 2024 at 6:03=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jan 31, 2024 at 8:09=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
org> wrote:
> >
> > On Thu, Feb 1, 2024 at 7:03=E2=80=AFAM Rob Herring <robh@kernel.org> wr=
ote:
> > >
> > > On Tue, Jan 30, 2024 at 3:16=E2=80=AFAM Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
> > > >
> > > > On Fri, Jan 26, 2024 at 1:04=E2=80=AFAM Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Wed, 17 Jan 2024 at 06:14, Simon Glass <sjg@chromium.org> wrot=
e:
> > > > > >
> > > > > > Hi Masahiro, Tom,
> > > > > >
> > > > > > On Tue, 9 Jan 2024 at 07:33, Tom Rini <trini@konsulko.com> wrot=
e:
> > > > > > >
> > > > > > > On Tue, Jan 09, 2024 at 11:01:42PM +0900, Masahiro Yamada wro=
te:
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > >
> > > > > > > > On Wed, Jan 3, 2024 at 8:47=E2=80=AFAM Simon Glass <sjg@chr=
omium.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi Masahiro,
> > > > > > > > >
> > > > > > > > > On Wed, Dec 13, 2023 at 5:14=E2=80=AFAM Will Deacon <will=
@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Add a script which produces a Flat Image Tree (FIT), =
a single file
> > > > > > > > > > > containing the built kernel and associated devicetree=
 files.
> > > > > > > > > > > Compression defaults to gzip which gives a good balan=
ce of size and
> > > > > > > > > > > performance.
> > > > > > > > > > >
> > > > > > > > > > > The files compress from about 86MB to 24MB using this=
 approach.
> > > > > > > > > > >
> > > > > > > > > > > The FIT can be used by bootloaders which support it, =
such as U-Boot
> > > > > > > > > > > and Linuxboot. It permits automatic selection of the =
correct
> > > > > > > > > > > devicetree, matching the compatible string of the run=
ning board with
> > > > > > > > > > > the closest compatible string in the FIT. There is no=
 need for
> > > > > > > > > > > filenames or other workarounds.
> > > > > > > > > > >
> > > > > > > > > > > Add a 'make image.fit' build target for arm64, as wel=
l. Use
> > > > > > > > > > > FIT_COMPRESSION to select a different algorithm.
> > > > > > > > > > >
> > > > > > > > > > > The FIT can be examined using 'dumpimage -l'.
> > > > > > > > > > >
> > > > > > > > > > > This features requires pylibfdt (use 'pip install lib=
fdt'). It also
> > > > > > > > > > > requires compression utilities for the algorithm bein=
g used. Supported
> > > > > > > > > > > compression options are the same as the Image.xxx fil=
es. For now there
> > > > > > > > > > > is no way to change the compression other than by edi=
ting the rule for
> > > > > > > > > > > $(obj)/image.fit
> > > > > > > > > > >
> > > > > > > > > > > While FIT supports a ramdisk / initrd, no attempt is =
made to support
> > > > > > > > > > > this here, since it must be built separately from the=
 Linux build.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > > Changes in v9:
> > > > > > > > > > > - Move the compression control into Makefile.lib
> > > > > > > > > > >
> > > > > > > > > > > Changes in v8:
> > > > > > > > > > > - Drop compatible string in FDT node
> > > > > > > > > > > - Correct sorting of MAINTAINERS to before ARM64 PORT
> > > > > > > > > > > - Turn compress part of the make_fit.py comment in to=
 a sentence
> > > > > > > > > > > - Add two blank lines before parse_args() and setup_f=
it()
> > > > > > > > > > > - Use 'image.fit: dtbs' instead of BUILD_DTBS var
> > > > > > > > > > > - Use '$(<D)/dts' instead of '$(dir $<)dts'
> > > > > > > > > > > - Add 'mkimage' details Documentation/process/changes=
rst
> > > > > > > > > > > - Allow changing the compression used
> > > > > > > > > > > - Tweak cover letter since there is only one clean-up=
 patch
> > > > > > > > > > >
> > > > > > > > > > > Changes in v7:
> > > > > > > > > > > - Add Image as a dependency of image.fit
> > > > > > > > > > > - Drop kbuild tag
> > > > > > > > > > > - Add dependency on dtbs
> > > > > > > > > > > - Drop unnecessary path separator for dtbs
> > > > > > > > > > > - Rebase to -next
> > > > > > > > > > >
> > > > > > > > > > > Changes in v5:
> > > > > > > > > > > - Drop patch previously applied
> > > > > > > > > > > - Correct compression rule which was broken in v4
> > > > > > > > > > >
> > > > > > > > > > > Changes in v4:
> > > > > > > > > > > - Use single quotes for UIMAGE_NAME
> > > > > > > > > > >
> > > > > > > > > > > Changes in v3:
> > > > > > > > > > > - Drop temporary file image.itk
> > > > > > > > > > > - Drop patch 'Use double quotes for image name'
> > > > > > > > > > > - Drop double quotes in use of UIMAGE_NAME
> > > > > > > > > > > - Drop unnecessary CONFIG_EFI_ZBOOT condition for hel=
p
> > > > > > > > > > > - Avoid hard-coding "arm64" for the DT architecture
> > > > > > > > > > >
> > > > > > > > > > > Changes in v2:
> > > > > > > > > > > - Drop patch previously applied
> > > > > > > > > > > - Add .gitignore file
> > > > > > > > > > > - Move fit rule to Makefile.lib using an intermediate=
 file
> > > > > > > > > > > - Drop dependency on CONFIG_EFI_ZBOOT
> > > > > > > > > > > - Pick up .dtb files separately from the kernel
> > > > > > > > > > > - Correct pylint too-many-args warning for write_kern=
el()
> > > > > > > > > > > - Include the kernel image in the file count
> > > > > > > > > > > - Add a pointer to the FIT spec and mention of its wi=
de industry usage
> > > > > > > > > > > - Mention the kernel version in the FIT description
> > > > > > > > > > >
> > > > > > > > > > >  Documentation/process/changes.rst |   9 +
> > > > > > > > > > >  MAINTAINERS                       |   7 +
> > > > > > > > > > >  arch/arm64/Makefile               |   7 +-
> > > > > > > > > > >  arch/arm64/boot/.gitignore        |   1 +
> > > > > > > > > > >  arch/arm64/boot/Makefile          |   6 +-
> > > > > > > > > > >  scripts/Makefile.lib              |  16 ++
> > > > > > > > > > >  scripts/make_fit.py               | 291 ++++++++++++=
++++++++++++++++++
> > > > > > > > > > >  7 files changed, 334 insertions(+), 3 deletions(-)
> > > > > > > > > > >  create mode 100755 scripts/make_fit.py
> > > > > > > > > >
> > > > > > > > > > I'll need Masahiro's Ack on the scripts/ changes before=
 I can take this
> > > > > > > > > > one.
> > > > > > > > >
> > > > > > > > > Any thoughts on this request, please?
> > > > > > > > >
> > > > > > > > > Regards,
> > > > > > > > > Simon
> > > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > As I mentioned before, I am concerned with having
> > > > > > > > the same "compatible" entries, with different contents,
> > > > > > > > as you use the "compatible" string as an ID to selecting
> > > > > > > > the target config node, right?
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > $ fdtdump  arch/arm64/boot/image.fit
> > > > > > > >
> > > > > > > >         ...
> > > > > > > >
> > > > > > > >         conf-10 {
> > > > > > > >             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> > > > > > > > "tq,am642-tqma6442l", "ti,am642";
> > > > > > > >             description =3D "TQ-Systems TQMa64xxL SoM on MB=
ax4xxL carrier board";
> > > > > > > >             fdt =3D "fdt-10";
> > > > > > > >             kernel =3D "kernel";
> > > > > > > >         };
> > > > > > > >
> > > > > > > >         ...
> > > > > > > >
> > > > > > > >         conf-25 {
> > > > > > > >             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> > > > > > > > "tq,am642-tqma6442l", "ti,am642";
> > > > > > > >             description =3D "TQ-Systems TQMa64xxL SoM on MB=
ax4xxL carrier board";
> > > > > > > >             fdt =3D "fdt-25";
> > > > > > > >             kernel =3D "kernel";
> > > > > > > >         };
> > > > > > >
> > > > > > > I had asked Rob a while ago about if having the same compatib=
le for two
> > > > > > > functionally different machines is a feature, or a bug, and I=
 don't
> > > > > > > think either of us fully agreed either way. I'd be leaning to=
wards
> > > > > > > saying the above example is a bug in the dts files, it's just=
 not been a
> > > > > > > bug people have worried about before due to (sadly) how littl=
e the
> > > > > > > top-level compatible has been used.
> > >
> > > I much prefer being able to use compatibles over filenames.
> > >
> > > > > >
> > > > > > Yes I believe this is a bug in the files.
> > > > > >
> > > > > > What should the script do in this case? Print a warning, perhap=
s?
> > > > >
> > > > > Is there anything I should do here? Would a warning be helpful, o=
r
> > > > > just confusing?
> > > >
> > > >
> > > >
> > > > I do not think it is useful.
> > > > You would almost always get a warning, and there is no way to fix i=
t.
> > >
> > > The above case is due to overlays. Why would you have a FIT image wit=
h
> > > both a base tree and applied overlays?
> >
> >
> >
> > Because they are different hardware.
>
> Meaning the base tree is valid on its own without any overlays?



If the base board is directly added to dtb-y, we need to assume
it is valid as a standalone board.


k3-am654-gp-evm-dtbs is a base of other composite DTBs, and
it is also added to dtb-y.


dtb-$(CONFIG_ARCH_K3) +=3D k3-am654-base-board.dtb



Not only the base board.


There are multiple composite DTBs that have the same compatible string.


k3-am654-gp-evm-dtbs :=3D k3-am654-base-board.dtb
k3-am654-base-board-rocktech-rk101-panel.dtbo
k3-am654-evm-dtbs :=3D k3-am654-base-board.dtb k3-am654-icssg2.dtbo



k3-am654-base-board.dtb, k3-am654-gp-evm-dtbs, and k3-am654-evm-dtbs
have the same top-level compatible string.




>
> > If FIT includes only base DTBs, how to use a base with extensions?
>
> I would expect that you package up base and overlays or DTs with
> already applied overlays, but not both together. That would be based
> on whether your bootloader can apply overlays or not.


Correct.



> This problem boils down to your firmware knows or gains the knowledge
> of some set of extra features or h/w pop options. The result is you
> need base plus X, Y, Z whether those are a list of overlays or an
> encoding of filename or something else. For example, FIT entries could
> have a field that just lists those X, Y, Z features. But I'd much
> rather have something that works outside of FIT images.
>
> > > In any case, maybe we need to record in dtb overlays that have been
> > > applied (which you asked about recently on dtc list). Not sure what
> > > that looks like though. Overlays have a 'top-level' compatible that w=
e
> > > add in either separately or merged with the base's top-level
> > > compatible?
> >
> >
> > If there is a way to make "compatible" unique, that will be good.
> >
> > But, in my understanding, we can replace a property value,
> > but not modify it.
>
> Currently yes, but that shouldn't be too hard to add. The dtc
> modification is the easy part. The hard part is figuring out the
> policy around how we would use that.
>
> But I don't really know what you want to accomplish with FIT here.
> IMO, if you need filenames, then use a filesystem. They work pretty
> well for storing large collections of files.


Whom does the term "you" point to?

If you have questions about the motivation for this patch,
ask its author.



There are two ways to look up the config node;
node-name or compatible string.

The key-value lookup works only when the key is unique.

Apparently, the compatible string is not unique
when overlay comes into play.







>
> Rob

--
Best Regards
Masahiro Yamada

