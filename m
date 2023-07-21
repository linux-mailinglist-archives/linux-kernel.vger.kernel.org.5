Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F11F75C57F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjGULJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjGULI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:08:26 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF5249E2;
        Fri, 21 Jul 2023 04:06:04 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1b055510c9dso1168884fac.0;
        Fri, 21 Jul 2023 04:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689937563; x=1690542363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhS2+KfGo09BPkweFjLOuPprkb1GFRM1vGhZw1v04ns=;
        b=Cmhx4p03jqUeD2B5hTIOC8IjvPDshK96Dw/0V6SganboefUPIDrCkOquyqIBOpZMMv
         hcUJ8j4dJ2v+wG2cAHg7nNkrAzlujXUwPxchNMvNRaz5vi1PnVCNx+P3a+eeWotAT+c1
         sTJz679r0DqIzgGBjyrOTCF4BKmgXvknhwsdVL5ImPaP7xyOK3x3An3b2iihiH18y4vu
         bV8+19R8lrx1qow48xd49whC2GcR1yHNJ7zw32oIwjqAtJrV1m5LsqmKo/g4Oz1hin/G
         xq+CxCH6j6oAVpDPIuI8kv0y1VseEuNrr1d0m6DrqTMNTzS9zk1BK9w4QtGe0tjLIlGr
         tpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689937563; x=1690542363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhS2+KfGo09BPkweFjLOuPprkb1GFRM1vGhZw1v04ns=;
        b=Eb6570SPGh0w4YtvIuJdLDh4twcAOB8V8ZLPSgDt0QFOBHY6Mn9ki0mQBgeIrNjnhY
         2EG1LVHAevVs1E6bt8nlX68cDcFFneV0C09bwGnE4rG0dwMgRHTpQN+TfHCSlhPhJk0/
         7pxLDZMBEJRSEPbu2QRSeabjvvNzOchkk8SWTiAthecnuS/2K+ee4rcDhKT1rCaP9GkQ
         1tCUPzIPFNTFtP4hILnMmDPgx/6WF0auXiOvXlvaxkopIONHk/QEsnLdU78Ue9dzgc2G
         p9PylBBB1ELbb3xBHnxQalxrH5QhrZ7N5VxxXS6z+XN/USP76IXeEe4ee4wot/dFWP2D
         LFwQ==
X-Gm-Message-State: ABy/qLaRXmwEEwp3g3H0ayC3y0BwFADjScBKWQb6SX/aYIltXUb3EPJd
        blmiTV+FSyD3+K7nZQ+r+Mj5cvvq//mvsS4jCdM=
X-Google-Smtp-Source: APBJJlFDSr2+5M0Jr/mF+iAS/xZSwsEA4Nj1cqYct9xEgRregaJJduZdvOq6058XaqSqQwulzY123va5IGhSgWghxyk=
X-Received: by 2002:a05:6870:c1ce:b0:1b3:dd9a:47d5 with SMTP id
 i14-20020a056870c1ce00b001b3dd9a47d5mr1639072oad.40.1689937563245; Fri, 21
 Jul 2023 04:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230721103350.3684483-1-james.hilliard1@gmail.com>
 <20230721103350.3684483-2-james.hilliard1@gmail.com> <3492152a-d668-54ba-7cb4-4db8bfec6f03@linaro.org>
In-Reply-To: <3492152a-d668-54ba-7cb4-4db8bfec6f03@linaro.org>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Fri, 21 Jul 2023 05:05:51 -0600
Message-ID: <CADvTj4r8oVyghXN_4ONMBfhMqHGNPJN517kB6X1FfwUmB16OFQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] ARM: dts: imx6qdl: Add Variscite VAR-SOM-MX6 SoM support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 4:43=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/07/2023 12:33, James Hilliard wrote:
> > This patch adds support for the Variscite VAR_SOM-MX6 SoM with :
> > - i.MX6 Quad or Dual Lite SoC
> > - 256 =E2=80=93 4096 MB DDR3
> > - 4-64 GB eMMC
> > - 128 =E2=80=93 1024 MB SLC NAND
> > - Camera Interface
> > - HDMI+CEC interface
> > - LVDS / DSI / Parallel RGB interfaces
> > - Ethernet RGMII interface
> > - On-SoM Wi-Fi/Bluetooth with WiLink wl183x SDIO Module
> > - SD/MMC/SDIO interface
> > - USB Host + USB OTG interface
> > - I2C interfaces
> > - SPI interfaces
> > - PCI-Express 2.0 interface
> > - on-SoM Audio Codec with HP/Line-In interfaces + DMIC interface
> > - Digital Audio interface
> > - S/PDIF interface
> >
> > Product website : https://www.variscite.com/product/system-on-module-so=
m/cortex-a9/var-som-mx6-cpu-freescale-imx6/
> >
> > Support is handled with a SoM-centric dtsi exporting the default interf=
aces
> > along the default pinmuxing to be enabled by the board dts file.
> >
> > This file is based on the one provided by Variscite on their own
> > kernel, but adapted for mainline.
> >
> > Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  .../arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi | 544 ++++++++++++++++++
> >  1 file changed, 544 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
> >
> > diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi b/arch/arm/=
boot/dts/nxp/imx/imx6qdl-var-som.dtsi
> > new file mode 100644
> > index 000000000000..a7d2aecd83fe
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
> > @@ -0,0 +1,544 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Support for Variscite VAR-SOM-MX6 Module
> > + *
> > + * Copyright 2011 Linaro Ltd.
> > + * Copyright 2012 Freescale Semiconductor, Inc.
> > + * Copyright (C) 2014-2016 Variscite, Ltd.
> > + * Author: Donio Ron <ron.d@variscite.com>
> > + * Copyright 2022 Bootlin
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "imx6q.dtsi"
> > +#include <dt-bindings/clock/imx6qdl-clock.h>
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/sound/fsl-imx-audmux.h>
> > +
> > +/ {
> > +     model =3D "Variscite VAR-SOM-MX6 module";
> > +     compatible =3D "variscite,var-som-imx6q", "fsl,imx6q";
> > +
> > +     chosen {
> > +             stdout-path =3D &uart1;
> > +     };
> > +
> > +     memory@10000000 {
> > +             device_type =3D "memory";
> > +             reg =3D <0x10000000 0x40000000>;
> > +     };
> > +
> > +     reg_3p3v: regulator-3p3v {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "3P3V";
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +             regulator-always-on;
> > +     };
> > +
> > +     reg_3v3_touch: reg-3v3-touch {
>
> The prefix is still different than all others. You used "regulator" in
> other places, but here it is "reg". Keep your code consistent.

Ok, I'll change it to this when I send my v7:
reg_3v3_touch: regulator-3v3-touch

>
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "touch_3v3_supply";
> > +             regulator-always-on;
>
> Also, missing constraints.

Hmm, what's the correct way to determine the constraint values?

I'm guessing they should just be set to this based on the name?:
regulator-min-microvolt =3D <3300000>;
regulator-max-microvolt =3D <3300000>;

>
>
> Best regards,
> Krzysztof
>
