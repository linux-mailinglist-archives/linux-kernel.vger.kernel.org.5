Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC13875BF50
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjGUHFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjGUHF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:05:29 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B69B2D5E;
        Fri, 21 Jul 2023 00:05:27 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1b055510c9dso1064877fac.0;
        Fri, 21 Jul 2023 00:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689923126; x=1690527926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGiBUXJPYa+l+8GYQxJIryvnr+KvjRwSf83wrJAg5Is=;
        b=Fjxr/aNfHLPAMW9scqY4G2sbGFV7TorpzmMwcCd6IJdpx6xBiJC7++J3cI3/+T8EgD
         fv1MEZ6lGvQ/diZzTFVsqFEusP3sKf8cC3oMHePFy2ZzcfAESfoe2Azgb9jjeWlVU6j9
         3GCAr65gefr83R+XMSa0RiKaz38ph2vuUe2jpNNWpTlL1wXFAu8OsuNEN6TphFB0zT4H
         utE23+KXbWY8tU3aJlkVRG9m+51srOlZCxZa5fSFeg7SYy2F7Dq1bqwUutJDLet+rWwR
         t8alhs5MBjTnHrXsOzhyEEr9KP/1xcx27j1jnip6v3Vld3vgK8HIL9LWicJdrBehtbGf
         22Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689923126; x=1690527926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGiBUXJPYa+l+8GYQxJIryvnr+KvjRwSf83wrJAg5Is=;
        b=SzS8d36FC8I+hNqz9yKAvVppjY7es0Ax8sBD0m49/Fp6bwzoRspPnlXADtVG10cm69
         jB1Mv+1oQyhmLI8VjwQi0PBCj4iPnemHoV1ZAXxcQyIc8XjtX3Av/zKaET2ae1Q9pNGV
         zy0K6FVGr+ouPMmZfBC7o4IAyQk2KEedtAozxJt8RBQscUQvnpkP1B6KlypW+lmzAiYA
         tONRsGeUPP0xEh5PhauTmZdkRPrDHeLARVR64ZgC7ZnD6I9uJQZPpAIPZEjKt5tikzCM
         WAkwDdcDtfPH5tE0QM4g9bk/uyEXsiCxmfsPpKvQPicDLhf9M9YJN4BKfRYefsAGnG0j
         +MPw==
X-Gm-Message-State: ABy/qLadjCnY5kh9+a64Vbg9ohR2PiflAV8gStOe4hvT0QDbpf5LZKvH
        5QSX1Jf9EhOkAdHMt+glitDb8d3XyDpFjcTeDpw=
X-Google-Smtp-Source: APBJJlGaBkFXs/FWq49wlomxOGLilMvY+Ep6vG7Ho6jhpuwpiE65jHx00PaLpOpEBm6f1gt9YBPI4ROdg1UNlWmOrpI=
X-Received: by 2002:a05:6870:5b8a:b0:1b0:454b:1c3d with SMTP id
 em10-20020a0568705b8a00b001b0454b1c3dmr941253oab.36.1689923125767; Fri, 21
 Jul 2023 00:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230720131028.3730704-1-james.hilliard1@gmail.com>
 <20230720131028.3730704-2-james.hilliard1@gmail.com> <CAOMZO5BPadhvTux-YMRZtZS=QaQhk9z+h7COk7_5S4gaqeE2eQ@mail.gmail.com>
In-Reply-To: <CAOMZO5BPadhvTux-YMRZtZS=QaQhk9z+h7COk7_5S4gaqeE2eQ@mail.gmail.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Fri, 21 Jul 2023 01:05:13 -0600
Message-ID: <CADvTj4rrodFreH4gsYC0fW94e=+Z7m6N_2HoQDEbkc=VVKyOfw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ARM: dts: imx6qdl: Add Variscite VAR-SOM-MX6 SoM support
To:     Fabio Estevam <festevam@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

On Thu, Jul 20, 2023 at 7:27=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Thu, Jul 20, 2023 at 10:10=E2=80=AFAM James Hilliard
> <james.hilliard1@gmail.com> wrote:
>
> > +       reg_audio: regulator-audio {
> > +               compatible =3D "regulator-fixed";
> > +               regulator-name =3D "tlv320aic3x-supply";
> > +               enable-active-high;
>
> enable-active-high should only be used when there is a corresponding
> gpio property.
>
> > +&ecspi3 {
> > +       fsl,spi-num-chipselects =3D <1>;
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_ecspi3>;
> > +       cs-gpios =3D <&gpio4 24 GPIO_ACTIVE_HIGH>;
>
> This should be ACTIVE_LOW instead.
>
> > +       status =3D "okay";
> > +};
> > +
> > +&fec {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_enet>;
> > +       phy-mode =3D "rgmii";
> > +       phy-reset-gpios =3D <&gpio1 25 GPIO_ACTIVE_LOW>;
>
> This is a deprecated property.
>
> The recommendation is to add a mdio node with:
>
> reset-gpios =3D <&gpio1 25 GPIO_ACTIVE_LOW>;
> reset-assert-us =3D <10000>;
>
> Is this an Atheros AR8031 PHY. If so, please check imx6qdl-sabresd.dtsi.

Hmm, the datasheet appears to indicate it uses a KSZ9031RN ethernet phy.

Would that be a different configuration vs the Atheros AR8031 PHY?

>
> > +&ssi2 {
> > +       fsl,mode =3D "i2s-slave";
>
> This is unused, drop it.
>
> Please check commit ece1e4999 606 ("ASoC: fsl_ssi: Remove unneeded
> 'i2s-slave' property")
>
> > +&usdhc3 {
> > +       pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> > +       pinctrl-0 =3D <&pinctrl_usdhc3>;
> > +       pinctrl-1 =3D <&pinctrl_usdhc3_100mhz>;
> > +       pinctrl-2 =3D <&pinctrl_usdhc3_200mhz>;
> > +       bus-width =3D <4>;
> > +       vmmc-supply =3D <&reg_wl18xx_vmmc>;
> > +       non-removable;
> > +       wakeup-source;
> > +       keep-power-in-suspend;
> > +       cap-power-off-card;
> > +       #address-cells =3D <1>;
> > +       #size-cells =3D <0>;
> > +       status =3D "okay";
> > +
> > +       wifi: wifi@0 {
> > +               compatible =3D "ti,wl1835";
> > +               reg =3D <2>;
>
> @0 and reg =3D <2> do not match.
