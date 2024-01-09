Return-Path: <linux-kernel+bounces-20988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 445B8828828
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A521F24C7A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9143985B;
	Tue,  9 Jan 2024 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="ttBibp+7"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CC226AFD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbd6e3795eso2724212b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 06:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1704810833; x=1705415633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KndaEanNVFQPZ7Lw6pt5cv26Ibm+dtDXNTXdZgR28WQ=;
        b=ttBibp+7cqncCuWlkMmYZ8MY29t/RxYrj9ZUVNUrZ7HvDF4jXvcuqEfUZDDs+7s4UW
         3fQaNz9jIbSuOq/zN79PVAEdidiofG7EY7NZVipF5eS5DFK1D64bIpsJHevcZ2duUMxf
         A1G5m7h26PH0WmPdze9FdrgmSI7x5VnuMsCac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704810833; x=1705415633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KndaEanNVFQPZ7Lw6pt5cv26Ibm+dtDXNTXdZgR28WQ=;
        b=VhIekWKeiyvozFC/1CD1N4pEDmB1Sm/wb4lP1dUahGs9UEJ77zN6s1Hg8D6pBcfSh1
         zMGmhLvoq289AL9wksI3SJvNgcIKoGLrKFToEmCBPKnJNz0AIvMC5DUGdfQqSNIN/cvK
         yn2NP8FYno2vQvw9hRVATMcM2yimpxKxOwC6QY+fUHVr6q252FP4K4xhEIJUVnrkVw7L
         0495UDXtgLd5wVYD38cgdOV6+t3Yaqk5yUD3CJWKN6+i8l9DY6kmn8nbJ2Wc1PPz4Kb0
         yDUYdHzr9hCSMRIeS7UmgPVpBc5CcV/Sv4hj0Wxrc+bFs21l3tHXTFRtUhPJQ3PZm6cC
         GdIg==
X-Gm-Message-State: AOJu0YyyHLbdKBehhSKZQmGdQfPWxudWCnG3JZvkOwYfeVqs04gj5Xai
	ZeYRLQczhlNCL12t0qExDLZx1Z055uiYzw==
X-Google-Smtp-Source: AGHT+IGuTLpONWsP7VKq5UjGPl/Es4KMJFkKp6ldUZWiWuDm0uOjRn5jMKDhiVkKUbu7uGjUSn0xCg==
X-Received: by 2002:a05:6808:318a:b0:3ba:8e3:f4f4 with SMTP id cd10-20020a056808318a00b003ba08e3f4f4mr7530220oib.107.1704810832929;
        Tue, 09 Jan 2024 06:33:52 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com. [2603:6081:7b00:3119::1002])
        by smtp.gmail.com with ESMTPSA id eh14-20020a056214186e00b0068112217ecasm833392qvb.117.2024.01.09.06.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:33:52 -0800 (PST)
Date: Tue, 9 Jan 2024 09:33:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	U-Boot Mailing List <u-boot@lists.denx.de>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Terrell <terrelln@fb.com>, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
Message-ID: <20240109143349.GR1610741@bill-the-cat>
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
 <20231213121353.GA31326@willie-the-truck>
 <CAFLszTjfmSx1YMqzb2TsQf7sP4KrcQB=X7DY_HxRQp0J5HAppQ@mail.gmail.com>
 <CAK7LNAQRCDC03e=TVO=k4FuD2a2RdTy7yLr3UptQjVCX7pM1CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0FoRISOaCA+A7e3o"
Content-Disposition: inline
In-Reply-To: <CAK7LNAQRCDC03e=TVO=k4FuD2a2RdTy7yLr3UptQjVCX7pM1CA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett


--0FoRISOaCA+A7e3o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 11:01:42PM +0900, Masahiro Yamada wrote:
> Hi Simon,
>=20
>=20
> On Wed, Jan 3, 2024 at 8:47=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Masahiro,
> >
> > On Wed, Dec 13, 2023 at 5:14=E2=80=AFAM Will Deacon <will@kernel.org> w=
rote:
> > >
> > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> > > > Add a script which produces a Flat Image Tree (FIT), a single file
> > > > containing the built kernel and associated devicetree files.
> > > > Compression defaults to gzip which gives a good balance of size and
> > > > performance.
> > > >
> > > > The files compress from about 86MB to 24MB using this approach.
> > > >
> > > > The FIT can be used by bootloaders which support it, such as U-Boot
> > > > and Linuxboot. It permits automatic selection of the correct
> > > > devicetree, matching the compatible string of the running board with
> > > > the closest compatible string in the FIT. There is no need for
> > > > filenames or other workarounds.
> > > >
> > > > Add a 'make image.fit' build target for arm64, as well. Use
> > > > FIT_COMPRESSION to select a different algorithm.
> > > >
> > > > The FIT can be examined using 'dumpimage -l'.
> > > >
> > > > This features requires pylibfdt (use 'pip install libfdt'). It also
> > > > requires compression utilities for the algorithm being used. Suppor=
ted
> > > > compression options are the same as the Image.xxx files. For now th=
ere
> > > > is no way to change the compression other than by editing the rule =
for
> > > > $(obj)/image.fit
> > > >
> > > > While FIT supports a ramdisk / initrd, no attempt is made to support
> > > > this here, since it must be built separately from the Linux build.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v9:
> > > > - Move the compression control into Makefile.lib
> > > >
> > > > Changes in v8:
> > > > - Drop compatible string in FDT node
> > > > - Correct sorting of MAINTAINERS to before ARM64 PORT
> > > > - Turn compress part of the make_fit.py comment in to a sentence
> > > > - Add two blank lines before parse_args() and setup_fit()
> > > > - Use 'image.fit: dtbs' instead of BUILD_DTBS var
> > > > - Use '$(<D)/dts' instead of '$(dir $<)dts'
> > > > - Add 'mkimage' details Documentation/process/changes.rst
> > > > - Allow changing the compression used
> > > > - Tweak cover letter since there is only one clean-up patch
> > > >
> > > > Changes in v7:
> > > > - Add Image as a dependency of image.fit
> > > > - Drop kbuild tag
> > > > - Add dependency on dtbs
> > > > - Drop unnecessary path separator for dtbs
> > > > - Rebase to -next
> > > >
> > > > Changes in v5:
> > > > - Drop patch previously applied
> > > > - Correct compression rule which was broken in v4
> > > >
> > > > Changes in v4:
> > > > - Use single quotes for UIMAGE_NAME
> > > >
> > > > Changes in v3:
> > > > - Drop temporary file image.itk
> > > > - Drop patch 'Use double quotes for image name'
> > > > - Drop double quotes in use of UIMAGE_NAME
> > > > - Drop unnecessary CONFIG_EFI_ZBOOT condition for help
> > > > - Avoid hard-coding "arm64" for the DT architecture
> > > >
> > > > Changes in v2:
> > > > - Drop patch previously applied
> > > > - Add .gitignore file
> > > > - Move fit rule to Makefile.lib using an intermediate file
> > > > - Drop dependency on CONFIG_EFI_ZBOOT
> > > > - Pick up .dtb files separately from the kernel
> > > > - Correct pylint too-many-args warning for write_kernel()
> > > > - Include the kernel image in the file count
> > > > - Add a pointer to the FIT spec and mention of its wide industry us=
age
> > > > - Mention the kernel version in the FIT description
> > > >
> > > >  Documentation/process/changes.rst |   9 +
> > > >  MAINTAINERS                       |   7 +
> > > >  arch/arm64/Makefile               |   7 +-
> > > >  arch/arm64/boot/.gitignore        |   1 +
> > > >  arch/arm64/boot/Makefile          |   6 +-
> > > >  scripts/Makefile.lib              |  16 ++
> > > >  scripts/make_fit.py               | 291 ++++++++++++++++++++++++++=
++++
> > > >  7 files changed, 334 insertions(+), 3 deletions(-)
> > > >  create mode 100755 scripts/make_fit.py
> > >
> > > I'll need Masahiro's Ack on the scripts/ changes before I can take th=
is
> > > one.
> >
> > Any thoughts on this request, please?
> >
> > Regards,
> > Simon
> >
>=20
>=20
>=20
> As I mentioned before, I am concerned with having
> the same "compatible" entries, with different contents,
> as you use the "compatible" string as an ID to selecting
> the target config node, right?
>=20
>=20
>=20
>=20
>=20
> $ fdtdump  arch/arm64/boot/image.fit
>=20
>         ...
>=20
>         conf-10 {
>             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> "tq,am642-tqma6442l", "ti,am642";
>             description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier=
 board";
>             fdt =3D "fdt-10";
>             kernel =3D "kernel";
>         };
>=20
>         ...
>=20
>         conf-25 {
>             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> "tq,am642-tqma6442l", "ti,am642";
>             description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier=
 board";
>             fdt =3D "fdt-25";
>             kernel =3D "kernel";
>         };

I had asked Rob a while ago about if having the same compatible for two
functionally different machines is a feature, or a bug, and I don't
think either of us fully agreed either way. I'd be leaning towards
saying the above example is a bug in the dts files, it's just not been a
bug people have worried about before due to (sadly) how little the
top-level compatible has been used.

--=20
Tom
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> --=20
> Best Regards
> Masahiro Yamada

--=20
Tom

--0FoRISOaCA+A7e3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWdWUMACgkQFHw5/5Y0
tywKZQv9E6Suvs8TGK4s6Y2tSOz3YdMeCLMOPVuGXp/0Duv37bRe86JoJEsBtoRg
V/Mh5pUlhEzjemCpKbbacBrtDTnCtME59FjkhnTPM+P4UND7ghA1UVvD5/+0a/m0
PbvZsm3U2H5yJygYGqhYNOQm1SZGj5erfzxalNZtIoVCgUeVuXrBQ3NO6EwVEx81
VgXq1TFRiX+SJ61lSDvWSJX4/T51ED30k9/UAILCkmnDPza84WhiEdGBwc2EksJ9
3P2KCOTM/iyhzJSFXUV1pvO/kvLej0inNejaowQ3YyeG2g855EALltR7MBdIBpe4
hhdFq+1jviO5mN4TtSBXrk1b+HqFL73adbemUduJnnRQXnQnnDmeZtDJFIGKyJxA
hQB2lc7MBHc0KLs/A/yi4tp82IlE/S+DmL+2x1Bf99XNydSER5Jlp/DCkE7rBz7C
vTY/kl3z2krvdS5m82BOY0c9muA/908zhpXr6zkov1yvgEM0V7Oyt61M5DQjZEdb
fmjpGQb0
=GoFt
-----END PGP SIGNATURE-----

--0FoRISOaCA+A7e3o--

