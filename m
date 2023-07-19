Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E46759E00
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjGSS5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjGSS5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:57:52 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7041BF6;
        Wed, 19 Jul 2023 11:57:50 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1b06777596cso5724644fac.2;
        Wed, 19 Jul 2023 11:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689793069; x=1692385069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dO/Ro82esZ77c8U9Ji2AYs62+OJdWI2aXZlK6bvNYHg=;
        b=U3KBhCNE+sq9QfBOgAvwnyfdnuf1HZ7C3xQesvpESjpZH9B0LlM9cnnZLbzTDg6t4W
         mCinuYgj1G3I0hZy9eKMIgVxY+vr+rURl/6iKQaZ/FRSr8KIX77HbkUJeWApXmwGX1RM
         Mh4kLMMxTcWeFHnW4SLU8gOHQ4Kq0/R5yGlI/BbcrleNr45AXtLXzAMUvwDCxf7+TnJl
         6bTHOkI9OTo3JVD0xKMdZu1pQ6K6EqhX8/Hffl9Q4Ii3qg8g9W0kcQEPIXdccUr8VMl0
         9NRJSbUeJyUzBMhjpJ+IsrZYp8yGtryiwEPcc94z1be/waXOMs+diSR7kJLkMU11qyjR
         jQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689793069; x=1692385069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dO/Ro82esZ77c8U9Ji2AYs62+OJdWI2aXZlK6bvNYHg=;
        b=SZsGyQJr6KjXHsT1ZjIrSg/ZMtl/oBRca3RCmqLuWzTGHZifpS7v/x0nesTA1e1TMN
         h6F1Jng2DVKNJ8/rRws6mOJLfpLpKeUHZgJDsj44KOU8hxxODH7eKnlkCQAV1HtiqftQ
         AwBtDC8HXAg69QvzUUXX/UKR+IBIRoUBxZFPE3DV00DYrNm9xI0y9UUCtbMXrmfuJY2e
         ljQAYWKdMVqca/2WUftt1p/9D7So3/abrKezS/MNu9I1u25ulNeS3v5jKYfdlxzQMlTh
         0ML8nAm5+AhSukFIGzE0QF5t55ixJUGywqpBUXtxXCvl1WxRDvnOgqKEvLVHFM1gwaa6
         F5NA==
X-Gm-Message-State: ABy/qLYgfCkEZmk0eidixz3ZcAE43KzwQKWAntnPadoN2n819tU/YQCj
        /54nr1CBCIuMdtIu//7HoPIxeYDntLQxAsH9oN4=
X-Google-Smtp-Source: APBJJlEYyE3r6HXrGx1zx4tohMxFwu8wFsBcEYB9ItkrjV2qOwltCGuOtZBu2WwGOrgJAqlJLxnVq6O+x6dPnc+d0r0=
X-Received: by 2002:a05:6870:b6a5:b0:1ba:b9ae:8d2c with SMTP id
 cy37-20020a056870b6a500b001bab9ae8d2cmr5670110oab.41.1689793069132; Wed, 19
 Jul 2023 11:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230719160048.2737423-1-james.hilliard1@gmail.com> <03748443-0459-c925-ce76-33ec134a303d@linaro.org>
In-Reply-To: <03748443-0459-c925-ce76-33ec134a303d@linaro.org>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Wed, 19 Jul 2023 12:57:36 -0600
Message-ID: <CADvTj4pgA_XjYZyU+D+J2QdC4NPFTxPSBCvrpK8WNjFkzkz-KQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx6qdl: Add Variscite VAR-SOM-MX6 SoM support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, Jul 19, 2023 at 11:16=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/07/2023 18:00, James Hilliard wrote:
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
> >  arch/arm/boot/dts/imx6qdl-var-som.dtsi | 547 +++++++++++++++++++++++++
> >  1 file changed, 547 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/imx6qdl-var-som.dtsi
> >
> > diff --git a/arch/arm/boot/dts/imx6qdl-var-som.dtsi b/arch/arm/boot/dts=
/imx6qdl-var-som.dtsi
> > new file mode 100644
> > index 000000000000..e93dae59624e
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6qdl-var-som.dtsi
> > @@ -0,0 +1,547 @@
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
> > +     model =3D "Variscite i.MX6 QUAD/DUAL VAR-SOM-MX6";
> > +     compatible =3D "fsl,imx6q";
>
> That's not correct compatible. It's not Imx6 soc. It's a som.

I'm confused, AFAIU the VAR-SOM-MX6 uses an imx6q SoC.

>
> > +...
> > +
> > +     sound: sound {
> > +             compatible =3D "simple-audio-card";
> > +             simple-audio-card,name =3D "var-som-audio";
> > +             simple-audio-card,format =3D "i2s";
> > +             simple-audio-card,bitclock-master =3D <&sound_codec>;
> > +             simple-audio-card,frame-master =3D <&sound_codec>;
> > +             simple-audio-card,widgets =3D "Headphone", "Headphone Jac=
k",
> > +                                         "Line", "Line In", "Microphon=
e", "Mic Jack";
> > +             simple-audio-card,routing =3D "Headphone Jack", "HPLOUT",
> > +                                         "Headphone Jack", "HPROUT",
> > +                                         "LINE1L", "Line In",
> > +                                         "LINE1R", "Line In";
> > +
> > +             sound_cpu: simple-audio-card,cpu {
> > +                     sound-dai =3D <&ssi2>;
> > +             };
> > +
> > +             sound_codec: simple-audio-card,codec {
> > +                     sound-dai =3D <&tlv320aic3106>;
> > +                     clocks =3D <&clks IMX6QDL_CLK_CKO>;
> > +             };
> > +     };
> > +
> > +     wlan_bt_rfkill {
>
> No underscores in node names.
>
> Just "rfkill"
>
>
> > +             compatible =3D "rfkill-gpio";
> > +             name =3D "wlan_bt_rfkill";
> > +             type =3D <2>;     /* bluetooth */
> > +             gpios =3D <&gpio6 18 GPIO_ACTIVE_HIGH>;
> > +     };
> > +};
> > +
>
> ...
>
> > +     tlv320aic3106: codec@1b {
> > +             compatible =3D "ti,tlv320aic3106";
> > +             reg =3D <0x1b>;
> > +             #sound-dai-cells =3D <0>;
> > +             DRVDD-supply =3D <&reg_3p3v>;
> > +             AVDD-supply =3D <&reg_3p3v>;
> > +             IOVDD-supply =3D <&reg_3p3v>;
> > +             DVDD-supply =3D <&reg_3p3v>;
> > +             ai3x-ocmv =3D <0>;
> > +             reset-gpios =3D <&gpio4 5 GPIO_ACTIVE_LOW>;
> > +             ai3x-gpio-func =3D <
> > +                     0 /* AIC3X_GPIO1_FUNC_DISABLED */
> > +                     5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
> > +             >;
> > +     };
> > +};
> > +
> > +&iomuxc {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_hog>;
> > +
> > +     imx6qdl-var-som-mx6 {
> > +             pinctrl_hog: hoggrp {
> > +                     fsl,pins =3D <
> > +                             /* CTW6120 IRQ */
> > +                             MX6QDL_PAD_EIM_DA7__GPIO3_IO07          0=
x80000000
> > +                             /* SDMMC2 CD/WP */
> > +                             MX6QDL_PAD_KEY_COL4__GPIO4_IO14         0=
x80000000
> > +                             MX6QDL_PAD_KEY_ROW4__GPIO4_IO15         0=
x80000000
> > +                     >;
> > +             };
> > +
> > +             pinctrl_audmux: audmux {
>
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sou=
rces-with-the-devicetree-schema/
> for instructions).
>
> AFAIR, all of them end with grp

Ah, that's def throwing a bunch of warnings, although quite a few look
to be existing
issues in dependent dtsi files. I'll clean up what I can there.

>
>
> ...
>
> > +
> > +&usdhc3 {
> > +     pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> > +     pinctrl-0 =3D <&pinctrl_usdhc3>;
> > +     pinctrl-1 =3D <&pinctrl_usdhc3_100mhz>;
> > +     pinctrl-2 =3D <&pinctrl_usdhc3_200mhz>;
> > +     bus-width =3D <4>;
> > +     vmmc-supply =3D <&reg_wl18xx_vmmc>;
> > +     non-removable;
> > +     wakeup-source;
> > +     keep-power-in-suspend;
> > +     cap-power-off-card;
> > +     #address-cells =3D <1>;
> > +     #size-cells =3D <0>;
> > +     status =3D "okay";
> > +
> > +     wlcore: wlcore@0 {
>
> Generic node names. Is this wifi?

I think it also supports bluetooth technically, although that might be
under a different node.

>
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation
>
> > +             compatible =3D "ti,wl1835";
> > +             reg =3D <2>;
>
>
> Best regards,
> Krzysztof
>
