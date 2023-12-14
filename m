Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2A1813083
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573149AbjLNMsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573147AbjLNMsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:48:30 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF3411D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:48:35 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5e248b40c97so25178107b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1702558114; x=1703162914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ynkzbg0VcmBQfCgEEi+/Ynn+2q0pEZCQki+1b/U8ctA=;
        b=pynAIBAW+ctVhvJnJMUhIlXY5iWlq2jO67tZdhuSn0zaeqiqrikwRLa2uKob4oG0us
         Cb/u91eLXMIzyb062WNfN41pYwlRr7eSWqI+pKpzoMAuKosvIlgKdLQmipWVq6ZjhLlD
         JmCNBG2jHEhNbhF7Rord7LDE3WBwfrhflF5tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702558114; x=1703162914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynkzbg0VcmBQfCgEEi+/Ynn+2q0pEZCQki+1b/U8ctA=;
        b=hVuZF+3RD/goPvi6umoT0EP8euk3eRWx0AMGiR7s5SNTXqq6kAr6tfEPbem67jbkuv
         y2xGO0/nBL/+A3S1Syv1AXtfAoaeYV+QJR1Ah8pyJ8uG41HthXuvxocqZ1HjufOCHLJ0
         F3r5OVL/UVFDkFr/Aw8HOUYS/24fQlZ3hDb3HzjFaRB6hmTdG6YQw+cc6EYpwvKMxdVx
         SVUrmz5V0aG2S6u2Pf5Q7H8Sb1h16/S7eld91D+1NyKAj7IilMpNvUzUJsIsrgJySahS
         3HOnxIkumkgh8wWH3KMtkyQkI6FbAL5fXTL+y/poRujQHfXJSm7BLR06iFZ3NAkd0D4J
         rYgA==
X-Gm-Message-State: AOJu0YzLW+JG/EEVF5VD6BqDXDHC8vZ9sWwBFXFmRRXMAWd8BamCapKr
        Ewnk1tGoAHpcrhr+Pq75dP2DoQ==
X-Google-Smtp-Source: AGHT+IE3enZpmTguDFDdaq/NlSHNW19uxf+vbgAd53vociQtjZbBAL3ndXs2cO0bNb0DczobieA+MQ==
X-Received: by 2002:a81:c30e:0:b0:5e3:9b5f:e3f with SMTP id r14-20020a81c30e000000b005e39b5f0e3fmr659201ywk.59.1702558114476;
        Thu, 14 Dec 2023 04:48:34 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com. [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
        by smtp.gmail.com with ESMTPSA id y185-20020a0dd6c2000000b005e309c357desm1021315ywd.145.2023.12.14.04.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:48:33 -0800 (PST)
Date:   Thu, 14 Dec 2023 07:48:31 -0500
From:   Tom Rini <trini@konsulko.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Glass <sjg@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, workflows@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
Message-ID: <20231214124831.GX2513409@bill-the-cat>
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com>
 <20231207142723.GA3187877@google.com>
 <20231207143814.GD15521@pendragon.ideasonboard.com>
 <CAGXv+5Go_0pEVAOLQmRCc_a9-YUtZEmBfXtMuBupX_nb9iqwbw@mail.gmail.com>
 <20231209152946.GC13421@pendragon.ideasonboard.com>
 <CAMuHMdVMZs6mnwWBgFwktO=8o=QzROv60cfZe085MhD6HxQjpQ@mail.gmail.com>
 <CAGXv+5Est3FL-XcEL-vB-6zVNas0mqb2cNYa==Yb7W2SQU9xVQ@mail.gmail.com>
 <CAK7LNATyD-PeNbaLTjJmU9=koqqE+V6QvFe09c2VrXopWvjpcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B/bTjf96qQSCoIlX"
Content-Disposition: inline
In-Reply-To: <CAK7LNATyD-PeNbaLTjJmU9=koqqE+V6QvFe09c2VrXopWvjpcw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B/bTjf96qQSCoIlX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 03:12:07PM +0900, Masahiro Yamada wrote:
> On Thu, Dec 14, 2023 at 1:03=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org>=
 wrote:
> >
> > On Sun, Dec 10, 2023 at 1:31=E2=80=AFAM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > >
> > > Hi Laurent,
> > >
> > > On Sat, Dec 9, 2023 at 4:29=E2=80=AFPM Laurent Pinchart
> > > <laurent.pinchart@ideasonboard.com> wrote:
> > > > On Sat, Dec 09, 2023 at 10:13:59PM +0900, Chen-Yu Tsai wrote:
> > > > > On Thu, Dec 7, 2023 at 11:38=E2=80=AFPM Laurent Pinchart
> > > > > <laurent.pinchart@ideasonboard.com> wrote:
> > > > > > On Thu, Dec 07, 2023 at 10:27:23PM +0800, Chen-Yu Tsai wrote:
> > > > > > > On Sun, Dec 03, 2023 at 05:34:01PM +0200, Laurent Pinchart wr=
ote:
> > > > > > > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
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
> > > > > > > >
> > > > > > > > FIT images are very useful, so I think this is a very welco=
me addition
> > > > > > > > to the kernel build system. It can get tricky though: given=
 the
> > > > > > > > versatile nature of FIT images, there can't be any
> > > > > > > > one-size-fits-them-all solution to build them, and striking=
 the right
> > > > > > > > balance between what makes sense for the kernel and the fea=
tures that
> > > > > > > > users may request will probably lead to bikeshedding. As we=
 all love
> > > > > > > > bikeshedding, I thought I would start selfishly, with a per=
sonal use
> > > > > > > > case :-) This isn't a yak-shaving request though, I don't s=
ee any reason
> > > > > > > > to delay merging this series.
> > > > > > > >
> > > > > > > > Have you envisioned building FIT images with a subset of DT=
Bs, or adding
> > > > > > > > DTBOs ? Both would be fairly trivial extensions to this scr=
ipt by
> > > > > > > > extending the supported command line arguments. It would pe=
rhaps be more
> > > > > > > > difficult to integrate in the kernel build system though. T=
his leads me
> > > > > > > > to a second question: would you consider merging extensions=
 to this
> > > > > > > > script if they are not used by the kernel build system, but=
 meant for
> > > > > > > > users who manually invoke the script ? More generally, is t=
he script
> > > > > > >
> > > > > > > We'd also be interested in some customization, though in a di=
fferent way.
> > > > > > > We imagine having a rule file that says X compatible string s=
hould map
> > > > > > > to A base DTB, plus B and C DTBO for the configuration sectio=
n. The base
> > > > > > > DTB would carry all common elements of some device, while the=
 DTBOs
> > > > > > > carry all the possible second source components, like differe=
nt display
> > > > > > > panels or MIPI cameras for instance. This could drastically r=
educe the
> > > > > > > size of FIT images in ChromeOS by deduplicating all the commo=
n stuff.
> > > > > >
> > > > > > Do you envision the "mapping" compatible string mapping to a co=
nfig
> > > > > > section in the FIT image, that would bundle the base DTB and th=
e DTBOs ?
> > > > >
> > > > > That's exactly the idea. The mapping compatible string could be u=
ntied
> > > > > from the base board's compatible string if needed (which we proba=
bly do).
> > > > >
> > > > > So something like:
> > > > >
> > > > > config {
> > > > >     config-1 {
> > > > >         compatible =3D "google,krane-sku0";
> > > > >         fdt =3D "krane-baseboard", "krane-sku0-overlay";
> > > > >     };
> > > > > };
> > > > >
> > > > > With "krane-sku0-overlay" being an overlay that holds the differe=
nces
> > > > > between the SKUs, in this case the display panel and MIPI camera =
(not
> > > > > upstreamed) that applies to SKU0 in particular.
> > > >
> > > > The kernel DT makefiles already contain information on what overlay=
s to
> > > > apply to what base boards, in order to test the overlays and produce
> > > > "full" DTBs. Maybe that information could be leveraged to create the
> > > > configurations in the FIT image ?
> > >
> > > Although the "full" DTBs created may only be a subset of all possible
> > > combinations (I believe Rob just started with creating one "full" DTB
> > > for each overlay, cfr. the additions I made in commit a09c3e105a208580
> > > ("arm64: dts: renesas: Apply overlays to base dtbs")), that could
> > > definitely be a start.
> > >
> > > Now, since the kernel build system already creates "full" DTBs, does
> > > that mean that all of the base DTBs, overlays, and "full" DTBs will
> > > end up in the FIT image?
> >
> > I suppose we could add an option to the packing tool to be able to _not_
> > add the "full" DTBs if they can also be assembled with a base DTB and
> > overlays. Think of it as a firmware compatibility option: if the firmwa=
re
> > supports overlays, then you almost always want the deconstructed parts,
> > not the fully assembled ones. Vice versa.
> >
> > If we don't we could end up with two configurations that have the same
> > compatible string?
>=20
>=20
> Right.
>=20
> We would end up with such situations because applying
> an overlay does not change the compatible string.
>=20
>=20
>=20
> With this code in arch/arm64/boot/dts/ti/Makefile:
>=20
> k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs :=3D \
>       k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.d=
tbo
> k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs :=3D \
>       k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
>=20
>=20
>=20
>=20
> $ fdtdump  arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb
> 2>/dev/null| head -n15 | tail -n2
>     model =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier board";
>     compatible =3D "tq,am642-tqma6442l-mbax4xxl", "tq,am642-tqma6442l",
> "ti,am642";
>=20
>=20
> $ fdtdump  arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl-wlan.dtb
> 2>/dev/null| head -n15 | tail -n2
>     model =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier board";
>     compatible =3D "tq,am642-tqma6442l-mbax4xxl", "tq,am642-tqma6442l",
> "ti,am642";
>=20
>=20
>=20
>=20
>=20
> These two go into image.fit, but one of them is completely dead
> since there is no way to distinguish them.

I'd asked Rob about the problem of multiple platforms that don't have a
unique compatible string, and never did quite conclude if the spec needs
to spell out one way or another if they really need to be unique.
There's some valid use cases where you might not, but then there's cases
like the above where that really seems like a dts bug (and those
platforms should have their dts* files reworked to be like other
carrier+som+different peripherals and likely be
tq,am642-tqma6442l-mbax4xxl-wlan and so on).

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
>=20
>=20
>=20
>=20
>=20
> I agree with Chen-Yu.

> FIT should not include full DTBs.
>=20
> Bootloaders should assemble the final DTB
> from base and overlays on-the-fly.

I think we need to think about that more because both FIT and UKI try
and solve the problem of a single verifiyable (in the various security /
secure boot meanings of the word) image. So saying "but not DTBs" will I
believe become "let the distribution people worry about it".

Or am I misunderstanding your comment, and this is only in the context
of real or quasi overlays?

--=20
Tom

--B/bTjf96qQSCoIlX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV6+ZwACgkQFHw5/5Y0
tyxjZgv/c9kJRHcdwKjxJfBNyd3mWhLVjkey7xi1A9ypEqph2eyZR1XLfN8/ynRW
TzyE3UF113bhTFT1ejsUwUUVRBrPkZKTdEUmzEgPxOcSVwu43txkexSLcoiPLFhl
Z8ELDoBQ6XJCBxL3SOHUWuuSrOoxoAoYbQt2YK+H12vCpuCG0stKyzALRmyAlONL
9F/TbqlsA/GPLH1cm7JeZYJeZ03l0IvBFkKgqEWPgk0mQfYNSHOpz6TyKaf3uVdq
UBsoJpor/OtUiba3rvdbFUZ2B0zyKij5i4CrmbS/nddpUwR0gskHjultJS+2LT9o
Hb/XtRWUN8c3V5VBE/EjKzUXRld9ZgkWnhb9jJrngjJmWg/EBvsZjpCFW/gybegM
AvEffJyA703dfXLpsNQhnVL9YOYFd37G/1oNSVART5kxj+gD+NEP+YKKKqSt1B4P
yxwViPPcvfq7mfiAsyNgUgB8VxAafx2LSd5uvZqDVQhkCXrpjEv5MR/eMjRgBxmP
Fa/6zHfn
=9yva
-----END PGP SIGNATURE-----

--B/bTjf96qQSCoIlX--
