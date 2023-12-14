Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA85081263B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 05:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjLNEDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 23:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNEDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 23:03:09 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EFCD5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 20:03:13 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50be58a751cso8919104e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 20:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702526591; x=1703131391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BVGmaHHT0VTxNDf7ANoSO4oiQpZnXTGuJuyRV1Z/eI=;
        b=jvCqtQbMG3RpBNaxZpEVPo1IzbNHlLYO+qotP17gI5Kwr0eaxLiL/3jSKz5PPZYLxq
         cIWKTF3zlYT5rzPKAWY9G/z1aI90EkhdO4w2EsWRRKiHgxSxMA25hkdVo32k6M5BCrZ3
         EY01xdCBdR7Msiag9Y5eAPV3gpz+tKsfBw6Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702526591; x=1703131391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BVGmaHHT0VTxNDf7ANoSO4oiQpZnXTGuJuyRV1Z/eI=;
        b=wp860fLZfdFFUOAO6TZxjdt2HYrtV2m034CMDZLUoW10MYNIVKI/+zIKDzPRHBbXpF
         ShkPHWUUtDYaCb8mOsADexuKwNKgWske3O22HgAZ8nK4JD2ex7RkC0buvB7R4DETvmrS
         mAmeJrUbJRj2E1mUI2abTLyEzqv1m/T3MuNdNqehA/uBHoKvyI0SrbkJ/pDW8LfQM71J
         xRwJO1aP3oQ3YYjTALt0T0L3yxjf/Jef4hMuOEdAog52p8LH50KkAlqgfzZIIF2E6zVA
         7i8s28jXpJqvloMAYe0rsMEqgYxswMYtu0RZq491kHw6RtB4PTR7ad7EEh2hcCBSuVup
         DDlw==
X-Gm-Message-State: AOJu0Yx4zOEWLr1O8DetIDD9GF/Pu2kuGig5XIbhoGfHTFcF0lw42+tq
        FUiRrYpSwX+JtsZ7C5ijH+iMIs7q/c48QqXZzipn7w==
X-Google-Smtp-Source: AGHT+IGpnoN+ysm9cnTeiQyv3Oa45JaHPkpqumPIr4sCoWU/xTY31KZkmU3OY4UiPx8AToeHKTnCfcuuo2+B3LxIGFs=
X-Received: by 2002:a05:6512:3053:b0:50d:faa1:acce with SMTP id
 b19-20020a056512305300b0050dfaa1accemr3948920lfb.56.1702526591034; Wed, 13
 Dec 2023 20:03:11 -0800 (PST)
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org> <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com> <20231207142723.GA3187877@google.com>
 <20231207143814.GD15521@pendragon.ideasonboard.com> <CAGXv+5Go_0pEVAOLQmRCc_a9-YUtZEmBfXtMuBupX_nb9iqwbw@mail.gmail.com>
 <20231209152946.GC13421@pendragon.ideasonboard.com> <CAMuHMdVMZs6mnwWBgFwktO=8o=QzROv60cfZe085MhD6HxQjpQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVMZs6mnwWBgFwktO=8o=QzROv60cfZe085MhD6HxQjpQ@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 14 Dec 2023 13:02:59 +0900
Message-ID: <CAGXv+5Est3FL-XcEL-vB-6zVNas0mqb2cNYa==Yb7W2SQU9xVQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Glass <sjg@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Tom Rini <trini@konsulko.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 1:31=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Laurent,
>
> On Sat, Dec 9, 2023 at 4:29=E2=80=AFPM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Sat, Dec 09, 2023 at 10:13:59PM +0900, Chen-Yu Tsai wrote:
> > > On Thu, Dec 7, 2023 at 11:38=E2=80=AFPM Laurent Pinchart
> > > <laurent.pinchart@ideasonboard.com> wrote:
> > > > On Thu, Dec 07, 2023 at 10:27:23PM +0800, Chen-Yu Tsai wrote:
> > > > > On Sun, Dec 03, 2023 at 05:34:01PM +0200, Laurent Pinchart wrote:
> > > > > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> > > > > > > Add a script which produces a Flat Image Tree (FIT), a single=
 file
> > > > > > > containing the built kernel and associated devicetree files.
> > > > > > > Compression defaults to gzip which gives a good balance of si=
ze and
> > > > > > > performance.
> > > > > > >
> > > > > > > The files compress from about 86MB to 24MB using this approac=
h.
> > > > > > >
> > > > > > > The FIT can be used by bootloaders which support it, such as =
U-Boot
> > > > > > > and Linuxboot. It permits automatic selection of the correct
> > > > > > > devicetree, matching the compatible string of the running boa=
rd with
> > > > > > > the closest compatible string in the FIT. There is no need fo=
r
> > > > > > > filenames or other workarounds.
> > > > > > >
> > > > > > > Add a 'make image.fit' build target for arm64, as well. Use
> > > > > > > FIT_COMPRESSION to select a different algorithm.
> > > > > > >
> > > > > > > The FIT can be examined using 'dumpimage -l'.
> > > > > > >
> > > > > > > This features requires pylibfdt (use 'pip install libfdt'). I=
t also
> > > > > > > requires compression utilities for the algorithm being used. =
Supported
> > > > > > > compression options are the same as the Image.xxx files. For =
now there
> > > > > > > is no way to change the compression other than by editing the=
 rule for
> > > > > > > $(obj)/image.fit
> > > > > > >
> > > > > > > While FIT supports a ramdisk / initrd, no attempt is made to =
support
> > > > > > > this here, since it must be built separately from the Linux b=
uild.
> > > > > >
> > > > > > FIT images are very useful, so I think this is a very welcome a=
ddition
> > > > > > to the kernel build system. It can get tricky though: given the
> > > > > > versatile nature of FIT images, there can't be any
> > > > > > one-size-fits-them-all solution to build them, and striking the=
 right
> > > > > > balance between what makes sense for the kernel and the feature=
s that
> > > > > > users may request will probably lead to bikeshedding. As we all=
 love
> > > > > > bikeshedding, I thought I would start selfishly, with a persona=
l use
> > > > > > case :-) This isn't a yak-shaving request though, I don't see a=
ny reason
> > > > > > to delay merging this series.
> > > > > >
> > > > > > Have you envisioned building FIT images with a subset of DTBs, =
or adding
> > > > > > DTBOs ? Both would be fairly trivial extensions to this script =
by
> > > > > > extending the supported command line arguments. It would perhap=
s be more
> > > > > > difficult to integrate in the kernel build system though. This =
leads me
> > > > > > to a second question: would you consider merging extensions to =
this
> > > > > > script if they are not used by the kernel build system, but mea=
nt for
> > > > > > users who manually invoke the script ? More generally, is the s=
cript
> > > > >
> > > > > We'd also be interested in some customization, though in a differ=
ent way.
> > > > > We imagine having a rule file that says X compatible string shoul=
d map
> > > > > to A base DTB, plus B and C DTBO for the configuration section. T=
he base
> > > > > DTB would carry all common elements of some device, while the DTB=
Os
> > > > > carry all the possible second source components, like different d=
isplay
> > > > > panels or MIPI cameras for instance. This could drastically reduc=
e the
> > > > > size of FIT images in ChromeOS by deduplicating all the common st=
uff.
> > > >
> > > > Do you envision the "mapping" compatible string mapping to a config
> > > > section in the FIT image, that would bundle the base DTB and the DT=
BOs ?
> > >
> > > That's exactly the idea. The mapping compatible string could be untie=
d
> > > from the base board's compatible string if needed (which we probably =
do).
> > >
> > > So something like:
> > >
> > > config {
> > >     config-1 {
> > >         compatible =3D "google,krane-sku0";
> > >         fdt =3D "krane-baseboard", "krane-sku0-overlay";
> > >     };
> > > };
> > >
> > > With "krane-sku0-overlay" being an overlay that holds the differences
> > > between the SKUs, in this case the display panel and MIPI camera (not
> > > upstreamed) that applies to SKU0 in particular.
> >
> > The kernel DT makefiles already contain information on what overlays to
> > apply to what base boards, in order to test the overlays and produce
> > "full" DTBs. Maybe that information could be leveraged to create the
> > configurations in the FIT image ?
>
> Although the "full" DTBs created may only be a subset of all possible
> combinations (I believe Rob just started with creating one "full" DTB
> for each overlay, cfr. the additions I made in commit a09c3e105a208580
> ("arm64: dts: renesas: Apply overlays to base dtbs")), that could
> definitely be a start.
>
> Now, since the kernel build system already creates "full" DTBs, does
> that mean that all of the base DTBs, overlays, and "full" DTBs will
> end up in the FIT image?

I suppose we could add an option to the packing tool to be able to _not_
add the "full" DTBs if they can also be assembled with a base DTB and
overlays. Think of it as a firmware compatibility option: if the firmware
supports overlays, then you almost always want the deconstructed parts,
not the fully assembled ones. Vice versa.

If we don't we could end up with two configurations that have the same
compatible string?


ChenYu


> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
