Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F1275B023
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjGTNfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjGTNfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:35:00 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37AC35A5;
        Thu, 20 Jul 2023 06:34:37 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b9da57da6bso74269a34.0;
        Thu, 20 Jul 2023 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689860075; x=1690464875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDyBolWYf3ED0BNyv19nRoqpnXKiD1PO1SaR4fP4VOk=;
        b=mbF73ehvN+ZsSpUnM14a92Hd1sjbGOzyogK7qXhpdItSJuiQ2igH2fk6EtjMae6UH9
         4GOkUPqEbvOwSQC/kESAmdSXURMQ5NIet/GrniAdPpSRPUNN7kaG32GPWhNIXm5CLkrl
         iRjFA+u+ffEGbGSsaFonu13JFNfkWipEhyS8T4aYPm/lzzjWhrwFVHmwm5BWNHcvQVJf
         qKq+6vCTRuyITRO985rOOowjOZ+4Gkb49/gbwKh4X+XH73tXiLKWtVBzTeUoQwKrgR7z
         cNohYBEFsJKeLJ7nSZTbOEjHAUVcbjHMtHfoyolhKs3TAyEBW6A3WA0Yg2IMHP7QrHiS
         1R+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689860075; x=1690464875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDyBolWYf3ED0BNyv19nRoqpnXKiD1PO1SaR4fP4VOk=;
        b=fj3oZvMs0KSIwneNgb7UuyX7omAIp5uwC9pFqEW/kM5y3gEtJ2/slY3CfpAnkw1FND
         BKjX8N9cADdH2QVXFWacdHK77jp5wZj9g7eKQvZHlXY07z00JdkiMBYjnW9Vk9AeCQZi
         VXigJpGVz+xxPq628hXUALoxd0ioAIoyYG/W5Hb/ZdnPEATpMWBjUBsDRXYdABFBxeIc
         lrGgEQGZBYGtFLpJuNZV5CUofRF410BeMhUcufvmeG412i8qVkQJ5g443fggu46wdnBY
         UNkfd71DuwZhmT+PboZt5+2/CuTsx5bePEiBZuBC2M//ZTk6RY8spF/FNBDlgtkniipj
         d18Q==
X-Gm-Message-State: ABy/qLbwRni+c0CNdOzcFv02ht/dXly2/VmMSrTarZzrY6y12le0LJDm
        cE69aszQOkublZRtQt9O1bnPTNzBpkbHmqYMsMg=
X-Google-Smtp-Source: APBJJlEWbR5U74Ux+3XFBAJ2p4sv5lj1ahpJPtAvg0jQes61sPRWVQvs+XGlHMU3giWhglXyYE+BEbEiQKRf782nVbI=
X-Received: by 2002:a05:6808:2513:b0:3a4:316f:7b7d with SMTP id
 ck19-20020a056808251300b003a4316f7b7dmr2055237oib.5.1689860074009; Thu, 20
 Jul 2023 06:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230720131028.3730704-1-james.hilliard1@gmail.com> <20230720131028.3730704-4-james.hilliard1@gmail.com>
In-Reply-To: <20230720131028.3730704-4-james.hilliard1@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 20 Jul 2023 10:34:21 -0300
Message-ID: <CAOMZO5DZJNummE3fRtZpnrL-2LUWKPn6UsW8HuE_=8r9qAtMjg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: imx6q: Add Variscite MX6 Custom board support
To:     James Hilliard <james.hilliard1@gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 10:10=E2=80=AFAM James Hilliard
<james.hilliard1@gmail.com> wrote:

> +       reg_audio: regulator-audio {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "tlv320aic3x-supply";
> +               enable-active-high;

There is no gpio associated, so 'enable-active-high' should be removed.

> +       backlight_lvds: backlight-lvds {
> +               compatible =3D "pwm-backlight";
> +               pwms =3D <&pwm2 0 50000 0>;
> +               brightness-levels =3D <0 4 8 16 32 64 128 248>;
> +               default-brightness-level =3D <7>;
> +               power-supply =3D <&reg_pu>;

Is this correct? reg_pu is an internal regulator and should supply the
internal SoC peripherals.

> +       };

> +&iomuxc {
> +       pinctrl_ipu1: ipu1grp {
> +               fsl,pins =3D <
> +                       MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK      0=
x10
> +                       MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15            0=
x10
> +                       MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02             0=
x10
> +                       MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03             0=
x10
> +                       MX6QDL_PAD_DI0_PIN4__IPU1_DI0_PIN04             0=
x10
> +                       MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00        0=
x10
> +                       MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01        0=
x10
> +                       MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02        0=
x10
> +                       MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03        0=
x10
> +                       MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04        0=
x10
> +                       MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05        0=
x10
> +                       MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06        0=
x10
> +                       MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07        0=
x10
> +                       MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08        0=
x10
> +                       MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09        0=
x10
> +                       MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10       0=
x10
> +                       MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11       0=
x10
> +                       MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12       0=
x10
> +                       MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13       0=
x10
> +                       MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14       0=
x10
> +                       MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15       0=
x10
> +                       MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16       0=
x10
> +                       MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17       0=
x10
> +                       MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18       0=
x10
> +                       MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19       0=
x10
> +                       MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20       0=
x10
> +                       MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21       0=
x10
> +                       MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22       0=
x10
> +                       MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23       0=
x10
> +               >;
> +       };
> +
> +       pinctrl_ipu1: ipu1grp {

pinctrl_ipu1 appears twice. This second entry should be pinctrl_camera
or something like that.

> +       pinctrl_flexcan1: flexcan1grp {
> +               fsl,pins =3D <
> +                       MX6QDL_PAD_GPIO_7__FLEXCAN1_TX          0x1b0b0
> +                       MX6QDL_PAD_GPIO_8__FLEXCAN1_RX          0x1b0b0

Move pinctrl_flexcan1 to keep the pinctrl entries sorted.

> +
> +&ldb {
> +       status =3D "okay";
> +
> +       lvds-channel@0 {
> +               fsl,data-mapping =3D "spwg";
> +               fsl,data-width =3D <24>;
> +               status =3D "okay";

Add a new line.

> +               port@4 {
> +                       reg =3D <4>;
> +
> +                       lvds0_out: endpoint {
> +                               remote-endpoint =3D <&panel_in_lvds0>;
> +                       };
> +               };
> +       };
> +
> +       lvds-channel@1 {
> +               fsl,data-mapping =3D "spwg";
> +               fsl,data-width =3D <24>;
> +               status =3D "okay";

Add a new line.

> +               port@4 {
