Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E347FF0A8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345649AbjK3NtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345581AbjK3NtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:49:04 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E39B9;
        Thu, 30 Nov 2023 05:49:11 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28613d87c4cso927949a91.3;
        Thu, 30 Nov 2023 05:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701352150; x=1701956950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNuxAy4+PElexRfQ7sEzap/pFZOn8VnLezaHyJK+6X8=;
        b=OjjG5kfuMlwsMT/nqZkS1IqergPR/lUwrGiHI97CrdG0YT1C9aKrl9pO68UdfDpb+j
         sXoR94OoqPS+Xffc9Fl6mG0Q5Opz9RcWeh93bOBY4iVo87YNpQ4RB0etGTBx6yqx7Rhi
         CrLPaHicGYKDxdNaPCLhY/s3d7lLjECsRHBezbQevqRpDOsElcsjLDT8bXfDXy0hEgYq
         xM0UZhet3YjRjtj/gLPocG7x5840lnlGreSle6U+W8r60omAX/ouOeyXomKSZyL9wqB8
         IdI8XtlZwYtYKUOwJ47iq5P+8z11jfeg0Ty0x0SkBqZdHwBUjkFGOW2QwEUuk7FhqY/c
         4mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352150; x=1701956950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNuxAy4+PElexRfQ7sEzap/pFZOn8VnLezaHyJK+6X8=;
        b=UBEm6AJZhiOJECPj1K4Lv06iBQv8R5k2TQyBdya41U7UJupgZo/pNJH4dkGQ4jqlZQ
         jN1xgvlL0uPOiZc/EuG1Uxliz1k1pCcD7DzkPT3JfuqF0u/2R5BeUGT6mt0lg04NvZ+f
         xNrmgpE/WQdYiRSAShgQdM/QuZr6/+M8Mx78KatUujKVpoOx4nud/DnzF5CK6Khtl5yb
         otpXMCmElsGMTkBpEPoir9qa8IDYkWUAzGqL1kHyq9gdZdUsXr4Iqh2P8L5sqyh0J+Gv
         Cq/Cwkr6pepuwxUr48I+7JrAnmyJO8f9KEv+gFNqP8QiGrVxL2hGKEveTRAHpu/J232b
         ZRYA==
X-Gm-Message-State: AOJu0Yzi4E1UvoziLZOHzTJjAUOiC5vmEzYsXDxpB34Uk4n1W3SNom5w
        +9tJZkveAf+w0WXpcaeOf9MKMmM5lRmh/cNF5Rs=
X-Google-Smtp-Source: AGHT+IFUXNo2QGXR54PDhl/6L7MWDHAGZgL2I38RByhjC2AkpACb/BVyGj1zILcvOqf3LpZjVq1tddj8vIeEewJ3wzA=
X-Received: by 2002:a17:90b:3504:b0:280:5b33:d30 with SMTP id
 ls4-20020a17090b350400b002805b330d30mr23336773pjb.44.1701352150332; Thu, 30
 Nov 2023 05:49:10 -0800 (PST)
MIME-Version: 1.0
References: <20231129093113.255161-1-paul.elder@ideasonboard.com>
 <7122934.GXAFRqVoOG@steina-w> <20231129151637.GG24293@pendragon.ideasonboard.com>
 <5734628.DvuYhMxLoT@steina-w>
In-Reply-To: <5734628.DvuYhMxLoT@steina-w>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 30 Nov 2023 07:48:58 -0600
Message-ID: <CAHCN7x+hBGmnJ2z8B9awpS1KU7rgVjseMw-uTE2Sc7DZ5+oTKA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp: Add overlays for ISP instances
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Elder <paul.elder@ideasonboard.com>,
        kieran.bingham@ideasonboard.com, tomi.valkeinen@ideasonboard.com,
        umang.jain@ideasonboard.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 3:51=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi Laurent,
>
> Am Mittwoch, 29. November 2023, 16:16:37 CET schrieb Laurent Pinchart:
> > Hi Alexander,
> >
> > On Wed, Nov 29, 2023 at 11:20:07AM +0100, Alexander Stein wrote:
> > > Am Mittwoch, 29. November 2023, 10:31:13 CET schrieb Paul Elder:
> > > > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > >
> > > > Add two overlay to enable each ISP instance. The ISP is wired direc=
tly
> > > > to the CSIS for now, bypassing the ISI completely.
> > >
> > > I'm not sure if this is worth adding in a separate overlay.
> >
> > The trouble is that, at this point, selection between the ISP and the
> > ISI can only be performed through DT :-S That's why this is implemented
> > as an overlay.
>
> I feel a better place would be the overlay which actually adds the sensor=
.
> This knows best whether ISI or ISP should be used.
>
> > > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > > > ---
> > > >
> > > >  arch/arm64/boot/dts/freescale/Makefile        |  2 ++
> > > >  .../arm64/boot/dts/freescale/imx8mp-isp1.dtso | 36 +++++++++++++++=
++++
> > > >  .../arm64/boot/dts/freescale/imx8mp-isp2.dtso | 36 +++++++++++++++=
++++
> > > >  3 files changed, 74 insertions(+)
> > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-isp1.dtso
> > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-isp2.dtso
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > > > b/arch/arm64/boot/dts/freescale/Makefile index
> > > > 300049037eb0..f97dfac11189
> > > > 100644
> > > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > > @@ -113,6 +113,8 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-dhcom-pdk2.d=
tb
> > > >
> > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-dhcom-pdk3.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-evk.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-icore-mx8mp-edimm2.2.dtb
> > > >
> > > > +dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-isp1.dtbo
> > > > +dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-isp2.dtbo
> > > >
> > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-msc-sm2s-ep1.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-phyboard-pollux-rdk.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-tqma8mpql-mba8mpxl.dtb
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-isp1.dtso
> > > > b/arch/arm64/boot/dts/freescale/imx8mp-isp1.dtso new file mode 1006=
44
> > > > index 000000000000..cf394ed224ab
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-isp1.dtso
> > > > @@ -0,0 +1,36 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > +/*
> > > > + * Copyright 2022 Ideas on Board Oy
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +/plugin/;
> > > > +
> > > > +#include <dt-bindings/media/video-interfaces.h>
> > > > +
> > > > +&isi_0 {
> > > > + status =3D "disabled";
> > >
> > > ISI is disabled by default. What is your intention here?
> >
> > It could be enabled by an overlay for a camera module. Ideally we want
> > to be able to enable both the ISI and ISP at runtime, but that's not
> > possible yet and will require a very large amount of work.
>
> Again IMHO this is part of sensor setup, in a very specific overlay. To p=
ut it
> into different words: I barely see the gain of this small overlay.
>
> Runtime switching would require a combined media controller including bot=
h ISI
> and ISP, no?
>
> Best regards,
> Alexander
>
> > > > +
> > > > + ports {
> > > > +         port@0 {
> > > > +                 /delete-node/ endpoint;
> > >
> > > This doesn't work in overlays. See [1]. Otherwise the OF graph connec=
tions
> > > look fine to me. I'm using the same in my local overlay.
> >
> > Interesting, I wasn't aware of that. Maybe we should fix it :-)

When I did my camera implementation, I thought it was simpler to:

/delete-node/ &isi_in_0;

it's a one-line change.

I would suggest we just drop the overlay and make users who have the
cameras integrate the cameras and the isp routing into their
respective overlays.

adam
> >
> > > [1]
> > > https://lore.kernel.org/all/CAMuHMdWu4KZbBkvEofUV2wuA1g2S=3DXHHM3RUN1=
cNrcZB
> > > khsPZA@mail.gmail.com/>
> > > > +         };
> > > > + };
> > > > +};
> > > > +
> > > > +&isp_0 {
> > > > + status =3D "okay";
> > > > +
> > > > + ports {
> > > > +         port@1 {
> > > > +                 isp0_in: endpoint {
> > > > +                         bus-type =3D <MEDIA_BUS_TYPE_PARALLEL>;
> > > > +                         remote-endpoint =3D <&mipi_csi_0_out>;
> > > > +                 };
> > > > +         };
> > > > + };
> > > > +};
> > > > +
> > > > +&mipi_csi_0_out {
> > > > + remote-endpoint =3D <&isp0_in>;
> > > > +};
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-isp2.dtso
> > > > b/arch/arm64/boot/dts/freescale/imx8mp-isp2.dtso new file mode 1006=
44
> > > > index 000000000000..14e2e7b2617f
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-isp2.dtso
> > > > @@ -0,0 +1,36 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > +/*
> > > > + * Copyright 2022 Ideas on Board Oy
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +/plugin/;
> > > > +
> > > > +#include <dt-bindings/media/video-interfaces.h>
> > > > +
> > > > +&isi_0 {
> > > > + status =3D "disabled";
> > > > +
> > > > + ports {
> > > > +         port@1 {
> > > > +                 /delete-node/ endpoint;
> > > > +         };
> > > > + };
> > > > +};
> > > > +
> > > > +&isp_1 {
> > > > + status =3D "okay";
> > > > +
> > > > + ports {
> > > > +         port@1 {
> > > > +                 isp1_in: endpoint {
> > > > +                         bus-type =3D <MEDIA_BUS_TYPE_PARALLEL>;
> > > > +                         remote-endpoint =3D <&mipi_csi_1_out>;
> > > > +                 };
> > > > +         };
> > > > + };
> > > > +};
> > > > +
> > > > +&mipi_csi_1_out {
> > > > + remote-endpoint =3D <&isp1_in>;
> > > > +};
>
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
>
>
