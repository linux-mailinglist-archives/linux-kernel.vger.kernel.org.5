Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1019E7D230F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 14:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjJVMFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 08:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVMFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 08:05:52 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A661114;
        Sun, 22 Oct 2023 05:05:49 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0FF6656D;
        Sun, 22 Oct 2023 14:05:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1697976337;
        bh=XLggI/OzeRShGWMvxDswWLX4tMFqVlxpAgYqh++VSV8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cqyj76xafwKS3a8bpPaw0jRVL2jJccu39i6EdnZIV8StmiiIDrfcdZCyS7XDo2XA0
         jQgltxtgjxRdq8ZGIBg/Mh6q7vZ4JiTRXdigZcK2JYPcM7qxPQMqcOMqJf9Dk8gmF/
         QZ0EEGbwE/HeEWVaJ3nQqd4l2telJkVYE/dG1Kvc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231021141802.7k6irkkgycp4hek7@pengutronix.de>
References: <20231021005250.3498664-1-kieran.bingham@ideasonboard.com> <20231021141802.7k6irkkgycp4hek7@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: freescale: debix-som-a-bmb-08: Add CSI Power Regulators
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, moderated list:
        ARM/FREESCALE IMX / MXC ARM ARCHITECTURE 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, ;
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
To:     Marco Felsch <m.felsch@pengutronix.de>
Date:   Sun, 22 Oct 2023 13:05:44 +0100
Message-ID: <169797634457.750763.12645281668685716649@ping.linuxembedded.co.uk>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marco Felsch (2023-10-21 15:18:02)
> Hi Kieran,
>=20
> thanks for your patch.
>=20
> On 23-10-21, Kieran Bingham wrote:
> > Provide the 1.8 and 3.3 volt regulators that are utilised on the Debix
> > SOM BMB-08 base board.
> >=20
> > Facilitate this by also supplying the pin control used to enable the
> > regulators on the second MIPI CSI port.
> >=20
> > Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> > ---
> >  .../freescale/imx8mp-debix-som-a-bmb-08.dts   | 56 +++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dt=
s b/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts
> > index 0b0c95432bdc..e058402f1f2e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts
> > @@ -63,6 +63,50 @@ regulator-som-vdd3v3 {
> >               regulator-always-on;
> >       };
> > =20
> > +     reg_csi1_1v8: regulator-csi1-vdd1v8 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-min-microvolt =3D <1800000>;
> > +             regulator-max-microvolt =3D <1800000>;
> > +             regulator-name =3D "CSI1_VDD1V8_SW";
>=20
> Can we drop the _SW suffix here and below? I like to align the names
> with the schematic power-rail names to make it easier to grep.


Sure that's fine with me. I think the _SW is probably a hangover from
the BSP kernel, I'm not sure why I kept it ;-)

> With that fixed feel free to add my:

Thanks

--
Kieran

>=20
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
>=20
> > +             gpio =3D <&expander0 13 GPIO_ACTIVE_HIGH>;
> > +             vin-supply =3D <&reg_baseboard_vdd3v3>;
> > +             enable-active-high;
> > +     };
> > +
> > +     reg_csi1_3v3: regulator-csi1-vdd3v3 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +             regulator-name =3D "CSI1_VDD3V3_SW";
> > +             gpio =3D <&expander0 14 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +             vin-supply =3D <&reg_vdd5v0>;
> > +     };
> > +
> > +     reg_csi2_1v8: regulator-csi2-vdd1v8 {
> > +             compatible =3D "regulator-fixed";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pinctrl_reg_csi2_1v8>;
> > +             regulator-min-microvolt =3D <1800000>;
> > +             regulator-max-microvolt =3D <1800000>;
> > +             regulator-name =3D "CSI2_VDD1V8_SW";
> > +             gpio =3D <&gpio3 21 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +             vin-supply =3D <&reg_baseboard_vdd3v3>;
> > +     };
> > +
> > +     reg_csi2_3v3: regulator-csi2-vdd3v3 {
> > +             compatible =3D "regulator-fixed";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pinctrl_reg_csi2_3v3>;
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +             regulator-name =3D "CSI2_VDD3V3_SW";
> > +             gpio =3D <&gpio4 25 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +             vin-supply =3D <&reg_vdd5v0>;
> > +     };
> > +
> >       regulator-vbus-usb20 {
> >               compatible =3D "regulator-fixed";
> >               regulator-min-microvolt =3D <5000000>;
> > @@ -413,6 +457,18 @@ MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03              0=
x41
> >               >;
> >       };
> > =20
> > +     pinctrl_reg_csi2_1v8: regcsi21v8grp {
> > +             fsl,pins =3D <
> > +                     MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21              0=
x19
> > +             >;
> > +     };
> > +
> > +     pinctrl_reg_csi2_3v3: regcsi23v3grp {
> > +             fsl,pins =3D <
> > +                     MX8MP_IOMUXC_SAI2_TXC__GPIO4_IO25               0=
x19
> > +             >;
> > +     };
> > +
> >       pinctrl_uart2: uart2grp {
> >               fsl,pins =3D <
> >                       MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX            0=
x14f
> > --=20
> > 2.34.1
> >=20
> >
