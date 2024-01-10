Return-Path: <linux-kernel+bounces-21694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BFA8292D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E12A8B2346F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A726AC2;
	Wed, 10 Jan 2024 03:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U/lHJwLw"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2AF63B9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd053d5683so43627101fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 19:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704858480; x=1705463280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2+4rGDZbgxlEOXtTyTMHdiNTQYBzXDVTG62J0p7rI0=;
        b=U/lHJwLwW+/D2yaW0UYNslJrjvt3xtfA77fmRrK3yF0RipxB+OfTXSMwgis7y5UBD9
         fIdXvFL1sF4e0WiMf7BuHGLgMR4H3I+2KiB+TS1wL5S+9lMaV+TQ2Env10K9Klxe4jA5
         XhF6Fh+IdOQpeoMLxI746Wy8tAY3dls+pOIDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704858480; x=1705463280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2+4rGDZbgxlEOXtTyTMHdiNTQYBzXDVTG62J0p7rI0=;
        b=OuAE8K/fEHS+0emO4rL/+v+m57qLcXYhOW8nJCjVZuTUQAqis9ZPhBLQEQrmPyZw0S
         xVgqbe+KpAs4an0qI5eNfeAPkO4YVs09haMiljD3AdAEuAuW33VR6xH05fEWptNbJh3u
         vbqSNKsfMj4U7ul6nwere5akXb7/hDOVftmfPs/dElahygDxLy2K72tW33j3GUMnXesc
         b40P0Kr2tpQEknv29ZENBA1E3J/9RWzIxO49IIE/bsb3r7kON1ntudk8Fr3pDg+yngOO
         4JSCBXDE+TRAKc2HMJ0krXBUg+EuFj2LXadVP9knfNvtrARaW0J8XUlTj2h5UzHpUh8z
         Tq5w==
X-Gm-Message-State: AOJu0YzffZYqEOM3lL6jioFs3u063fN0R78vW1R/cfrj8UqjjIo/2Bhs
	44ZZZt1Aa0zWSRTCnDcYG8RoW09rwK7ixatMFJ1ps23Uw0Yo
X-Google-Smtp-Source: AGHT+IFFXmCpkZVFW3xR9rgNHbV3KC98xfvsuLx7hdj5Mj3t0V3s0pw+zaW++EUyL5pvC3aqJgqkzbkwV+wCxdEjgc0=
X-Received: by 2002:a2e:6a12:0:b0:2cc:8437:1bdc with SMTP id
 f18-20020a2e6a12000000b002cc84371bdcmr161339ljc.47.1704858479581; Tue, 09 Jan
 2024 19:47:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org> <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com> <20231207142723.GA3187877@google.com>
 <20231207143814.GD15521@pendragon.ideasonboard.com> <CAGXv+5Go_0pEVAOLQmRCc_a9-YUtZEmBfXtMuBupX_nb9iqwbw@mail.gmail.com>
 <20231209152946.GC13421@pendragon.ideasonboard.com> <CAMuHMdVMZs6mnwWBgFwktO=8o=QzROv60cfZe085MhD6HxQjpQ@mail.gmail.com>
 <CAGXv+5Est3FL-XcEL-vB-6zVNas0mqb2cNYa==Yb7W2SQU9xVQ@mail.gmail.com>
 <CAK7LNATyD-PeNbaLTjJmU9=koqqE+V6QvFe09c2VrXopWvjpcw@mail.gmail.com>
 <CAK7LNAR7Fm-1yaZmyH78vG5yNbbW2Avjj5F63u+aST6JQoMd5A@mail.gmail.com>
 <CAFLszTjfN8dzBNpr6+EVQiwen5BPoYtu8LJM3dCcd-sMP3=Nvw@mail.gmail.com> <CAK7LNAT8GWNNaMcBN+WZfzRQDmRjGC8Ek5u=E7r1iaTHMY70iw@mail.gmail.com>
In-Reply-To: <CAK7LNAT8GWNNaMcBN+WZfzRQDmRjGC8Ek5u=E7r1iaTHMY70iw@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 10 Jan 2024 11:47:48 +0800
Message-ID: <CAGXv+5G0wYh368GHic-fjx--LLJSkqGCcK-L=yaWrC_oV6h7UA@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, U-Boot Mailing List <u-boot@lists.denx.de>, 
	Nicolas Schier <nicolas@fjasle.eu>, Tom Rini <trini@konsulko.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 9:47=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> On Fri, Dec 29, 2023 at 3:39=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Masahiro,
> >
> > On Thu, Dec 14, 2023 at 7:34=E2=80=AFAM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > On Thu, Dec 14, 2023 at 3:12=E2=80=AFPM Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
> > > >
> > > > On Thu, Dec 14, 2023 at 1:03=E2=80=AFPM Chen-Yu Tsai <wenst@chromiu=
m.org> wrote:
> > > > >
> > > > > On Sun, Dec 10, 2023 at 1:31=E2=80=AFAM Geert Uytterhoeven <geert=
@linux-m68k.org> wrote:
> > > > > >
> > > > > > Hi Laurent,
> > > > > >
> > > > > > On Sat, Dec 9, 2023 at 4:29=E2=80=AFPM Laurent Pinchart
> > > > > > <laurent.pinchart@ideasonboard.com> wrote:
> > > > > > > On Sat, Dec 09, 2023 at 10:13:59PM +0900, Chen-Yu Tsai wrote:
> > > > > > > > On Thu, Dec 7, 2023 at 11:38=E2=80=AFPM Laurent Pinchart
> > > > > > > > <laurent.pinchart@ideasonboard.com> wrote:
> > > > > > > > > On Thu, Dec 07, 2023 at 10:27:23PM +0800, Chen-Yu Tsai wr=
ote:
> > > > > > > > > > On Sun, Dec 03, 2023 at 05:34:01PM +0200, Laurent Pinch=
art wrote:
> > > > > > > > > > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass=
 wrote:
> > > > > > > > > > > > Add a script which produces a Flat Image Tree (FIT)=
, a single file
> > > > > > > > > > > > containing the built kernel and associated devicetr=
ee files.
> > > > > > > > > > > > Compression defaults to gzip which gives a good bal=
ance of size and
> > > > > > > > > > > > performance.
> > > > > > > > > > > >
> > > > > > > > > > > > The files compress from about 86MB to 24MB using th=
is approach.
> > > > > > > > > > > >
> > > > > > > > > > > > The FIT can be used by bootloaders which support it=
, such as U-Boot
> > > > > > > > > > > > and Linuxboot. It permits automatic selection of th=
e correct
> > > > > > > > > > > > devicetree, matching the compatible string of the r=
unning board with
> > > > > > > > > > > > the closest compatible string in the FIT. There is =
no need for
> > > > > > > > > > > > filenames or other workarounds.
> > > > > > > > > > > >
> > > > > > > > > > > > Add a 'make image.fit' build target for arm64, as w=
ell. Use
> > > > > > > > > > > > FIT_COMPRESSION to select a different algorithm.
> > > > > > > > > > > >
> > > > > > > > > > > > The FIT can be examined using 'dumpimage -l'.
> > > > > > > > > > > >
> > > > > > > > > > > > This features requires pylibfdt (use 'pip install l=
ibfdt'). It also
> > > > > > > > > > > > requires compression utilities for the algorithm be=
ing used. Supported
> > > > > > > > > > > > compression options are the same as the Image.xxx f=
iles. For now there
> > > > > > > > > > > > is no way to change the compression other than by e=
diting the rule for
> > > > > > > > > > > > $(obj)/image.fit
> > > > > > > > > > > >
> > > > > > > > > > > > While FIT supports a ramdisk / initrd, no attempt i=
s made to support
> > > > > > > > > > > > this here, since it must be built separately from t=
he Linux build.
> > > > > > > > > > >
> > > > > > > > > > > FIT images are very useful, so I think this is a very=
 welcome addition
> > > > > > > > > > > to the kernel build system. It can get tricky though:=
 given the
> > > > > > > > > > > versatile nature of FIT images, there can't be any
> > > > > > > > > > > one-size-fits-them-all solution to build them, and st=
riking the right
> > > > > > > > > > > balance between what makes sense for the kernel and t=
he features that
> > > > > > > > > > > users may request will probably lead to bikeshedding.=
 As we all love
> > > > > > > > > > > bikeshedding, I thought I would start selfishly, with=
 a personal use
> > > > > > > > > > > case :-) This isn't a yak-shaving request though, I d=
on't see any reason
> > > > > > > > > > > to delay merging this series.
> > > > > > > > > > >
> > > > > > > > > > > Have you envisioned building FIT images with a subset=
 of DTBs, or adding
> > > > > > > > > > > DTBOs ? Both would be fairly trivial extensions to th=
is script by
> > > > > > > > > > > extending the supported command line arguments. It wo=
uld perhaps be more
> > > > > > > > > > > difficult to integrate in the kernel build system tho=
ugh. This leads me
> > > > > > > > > > > to a second question: would you consider merging exte=
nsions to this
> > > > > > > > > > > script if they are not used by the kernel build syste=
m, but meant for
> > > > > > > > > > > users who manually invoke the script ? More generally=
, is the script
> > > > > > > > > >
> > > > > > > > > > We'd also be interested in some customization, though i=
n a different way.
> > > > > > > > > > We imagine having a rule file that says X compatible st=
ring should map
> > > > > > > > > > to A base DTB, plus B and C DTBO for the configuration =
section. The base
> > > > > > > > > > DTB would carry all common elements of some device, whi=
le the DTBOs
> > > > > > > > > > carry all the possible second source components, like d=
ifferent display
> > > > > > > > > > panels or MIPI cameras for instance. This could drastic=
ally reduce the
> > > > > > > > > > size of FIT images in ChromeOS by deduplicating all the=
 common stuff.
> > > > > > > > >
> > > > > > > > > Do you envision the "mapping" compatible string mapping t=
o a config
> > > > > > > > > section in the FIT image, that would bundle the base DTB =
and the DTBOs ?
> > > > > > > >
> > > > > > > > That's exactly the idea. The mapping compatible string coul=
d be untied
> > > > > > > > from the base board's compatible string if needed (which we=
 probably do).
> > > > > > > >
> > > > > > > > So something like:
> > > > > > > >
> > > > > > > > config {
> > > > > > > >     config-1 {
> > > > > > > >         compatible =3D "google,krane-sku0";
> > > > > > > >         fdt =3D "krane-baseboard", "krane-sku0-overlay";
> > > > > > > >     };
> > > > > > > > };
> > > > > > > >
> > > > > > > > With "krane-sku0-overlay" being an overlay that holds the d=
ifferences
> > > > > > > > between the SKUs, in this case the display panel and MIPI c=
amera (not
> > > > > > > > upstreamed) that applies to SKU0 in particular.
> > > > > > >
> > > > > > > The kernel DT makefiles already contain information on what o=
verlays to
> > > > > > > apply to what base boards, in order to test the overlays and =
produce
> > > > > > > "full" DTBs. Maybe that information could be leveraged to cre=
ate the
> > > > > > > configurations in the FIT image ?
> > > > > >
> > > > > > Although the "full" DTBs created may only be a subset of all po=
ssible
> > > > > > combinations (I believe Rob just started with creating one "ful=
l" DTB
> > > > > > for each overlay, cfr. the additions I made in commit a09c3e105=
a208580
> > > > > > ("arm64: dts: renesas: Apply overlays to base dtbs")), that cou=
ld
> > > > > > definitely be a start.
> > > > > >
> > > > > > Now, since the kernel build system already creates "full" DTBs,=
 does
> > > > > > that mean that all of the base DTBs, overlays, and "full" DTBs =
will
> > > > > > end up in the FIT image?
> > > > >
> > > > > I suppose we could add an option to the packing tool to be able t=
o _not_
> > > > > add the "full" DTBs if they can also be assembled with a base DTB=
 and
> > > > > overlays. Think of it as a firmware compatibility option: if the =
firmware
> > > > > supports overlays, then you almost always want the deconstructed =
parts,
> > > > > not the fully assembled ones. Vice versa.
> > > > >
> > > > > If we don't we could end up with two configurations that have the=
 same
> > > > > compatible string?
> > > >
> > > >
> > > > Right.
> > > >
> > > > We would end up with such situations because applying
> > > > an overlay does not change the compatible string.
> > > >
> > > >
> > > >
> > > > With this code in arch/arm64/boot/dts/ti/Makefile:
> > > >
> > > > k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs :=3D \
> > > >       k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sd=
card.dtbo
> > > > k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs :=3D \
> > > >       k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-wl=
an.dtbo
> > > >
> > > >
> > > >
> > > >
> > > > $ fdtdump  arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl-sdcar=
d.dtb
> > > > 2>/dev/null| head -n15 | tail -n2
> > > >     model =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier board";
> > > >     compatible =3D "tq,am642-tqma6442l-mbax4xxl", "tq,am642-tqma644=
2l",
> > > > "ti,am642";
> > > >
> > > >
> > > > $ fdtdump  arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl-wlan.=
dtb
> > > > 2>/dev/null| head -n15 | tail -n2
> > > >     model =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier board";
> > > >     compatible =3D "tq,am642-tqma6442l-mbax4xxl", "tq,am642-tqma644=
2l",
> > > > "ti,am642";
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > These two go into image.fit, but one of them is completely dead
> > > > since there is no way to distinguish them.
> > > >
> > > >
> > > > $ fdtdump  arch/arm64/boot/image.fit
> > > >
> > > >         ...
> > > >
> > > >         conf-10 {
> > > >             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> > > > "tq,am642-tqma6442l", "ti,am642";
> > > >             description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL c=
arrier board";
> > > >             fdt =3D "fdt-10";
> > > >             kernel =3D "kernel";
> > > >         };
> > > >
> > > >         ...
> > > >
> > > >         conf-25 {
> > > >             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> > > > "tq,am642-tqma6442l", "ti,am642";
> > > >             description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL c=
arrier board";
> > > >             fdt =3D "fdt-25";
> > > >             kernel =3D "kernel";
> > > >         };
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > I agree with Chen-Yu.
> > > >
> > > > FIT should not include full DTBs.
> > > >
> > > > Bootloaders should assemble the final DTB
> > > > from base and overlays on-the-fly.
> > > >
> > > >
> > > > The FIT spec allows the "fdt" property to list
> > > > multiple image nodes.
> > > >
> > > >
> > > > o config-1
> > > >  |- description =3D "configuration description"
> > > >  |- kernel =3D "kernel sub-node unit name"
> > > >  |- fdt =3D "fdt sub-node unit-name" [, "fdt overlay sub-node unit-=
name", ...]
> > > >  |- loadables =3D "loadables sub-node unit-name"
> > > >  |- script =3D "
> > > >  |- compatible =3D "vendor
> > >
> > >
> > >
> > >
> > >
> > > This is a question for U-Boot (and barebox).
> > >
> > >
> > >
> > >
> > >    images {
> > >           base {
> > >                 ...
> > >           };
> > >
> > >           addon1 {
> > >                 ...
> > >           };
> > >
> > >           addon2 {
> > >                 ...
> > >           };
> > >     };
> > >
> > >     configurations {
> > >           ...
> > >           fdt =3D "base", "addon1", "addon2";
> > >     };
> > >
> > >
> > >
> > >
> > > Is U-Boot's "bootm" command able to dynamically construct
> > > the full DTB from "base" + "addon1" + "addon2"
> > > and pass to the kernel?
> > >
> > >
> > >
> > > When I used overlay from U-Boot command line last time,
> > > I typed complicated commands, following this manual:
> > > https://docs.u-boot.org/en/latest/usage/fdt_overlays.html
> > >
> > >
> >
> > So far this is not possible with bootm, no. But if we can add
> > extensions to the FIT spec, then it should be possible to implement
> > this.
> >
> > Is it (or will it be) possible to get Linux to build the DT + overlay
> > combinations?
>
>
> As Chen-Yu replied, dtb files specified in the -dtbs syntax in Makefiles
> are assembled at build time using fdtoverlay.
>
> Once they are built, you will never know how they are built
> unless you parse Makefiles.
>
> Your script simply picks up *.dtb files found under arch/*/boot/dts/.
> There are three possibilities in *.dtb files:
>
> [1] *.dtb assembled from other base and overlays
> [2] *.dtb directly compiled from a single *.dts
> [3] *.dtb meant to be used as a base of overlay,
>      but not meant for direct use.
>
>
> It would be challenging to include only appropriate *.dtb
> (and *.dtbo) files into the FIT image.

Irrespective of how and which DTB files are built, I think it would help
if we could decouple the compatible string in the configuration node from
the compatible string in the DTB.

Many of the overlays currently in-tree are extensions of a given board,
enabling a certain feature. Same could be said for all the out-of-tree
Raspberry Pi overlays. Fundamentally it is still the same board, and
the DTB's compatible shouldn't change. However the compatible string
in the configuration node is only used by the firmware for selection
purposes. It could be much more expansive including the extension
features.

We could have an extra config file that lists DTB files to exclude from
the FIT image, and replacement compatible strings for the configuration
node for certain DTB files.

Using an in-tree example: instead of "gw,imx8mm-gw73xx-0x" mapping to
imx8mm-venice-gw73xx-0x-*.dtb in addition to the base DT file
imx8mm-venice-gw73xx-0x.dtb, each could be mapped to a different
extension compatible, so "gw,imx8mm-gw73xx-0x-imx219" would map to
imx8mm-venice-gw73xx-0x-imx219.dtb.

How these configuration compatible strings should be defined is another
matter...

> I wrote the following patch set, which might be useful
> to address this issue.
>
> https://lore.kernel.org/linux-kbuild/20240109120738.346061-1-masahiroy@ke=
rnel.org/T/#t

I think this would help with selecting between the combined DTB vs base DTB
plus DTBO overlays, and perhaps automatic exclusion of combined DTBs when
board compatibles collide. But I do think device vendors and maintainers
would want the extra flexibility I illustrated above.


Regards
ChenYu

> > > One more question to confirm if I can use this
> > > for my practical use-cases.
> > >
> > > Is U-Boot able to handle FIT (includes kernel + DTs)
> > > and a separate initrd?
> > >
> > >   # bootm  <fit-address>:<conf-name>  <ramdisk-address>
> > >
> > >
> > > Presumably, it would be difficult to inject initramdisk
> > > into image.fit later, so I am hoping bootm would work like that,
> > > but I did not delve into U-Boot code.
> > >
> > >
> >
> > The ramdisk is handled by the FIT configuration. I suppose it would be
> > possible to add a way to bypass the logic in select_ramdisk(), but I
> > wonder what is the use case for this?
>
>
> I believe ramdisk is likely used to boot the arm64 Linux system.
>
> Since the FIT image generated by this lacks ramdisk,
> it looks useless to me unless there is a way to pass a ramdisk somehow.
>
>
> Barebox is good because it already supports FIT + separate ramdisk.
>
> I usually use U-Boot for my work, so I need to inject a ramdisk
> if I want to use this patch.
>
>
>
>
> > >
> > > If it works, is it possible to verify the integrity of initrd?
> > > The kernel and DTs inside FIT will be verified, but not sure
> > > if it is possible for ramdisk.
> >
> > I do have thoughts about a possible new FIT feature to allow external
> > files, which could perhaps include an initrd.
> >
> > Regards,
> > Simon
> >
>
>
> --
> Best Regards
> Masahiro Yamada

