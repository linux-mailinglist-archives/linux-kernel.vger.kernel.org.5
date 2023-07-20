Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880EF75AFC9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjGTN1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjGTN1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:27:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2492D5E;
        Thu, 20 Jul 2023 06:27:25 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b9d9cbcc70so1075225ad.0;
        Thu, 20 Jul 2023 06:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689859633; x=1690464433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlAwLGhvuTr8ROLaXnMqr4ZXOd2hH6vJbKxn4BmvVKs=;
        b=huDDrITdBQpnjKy+gDaMGWTj8DruZyx+0VmbxI7pvAzYWUumkCsWPk5KSoHQUhGIUH
         kcHhw5Aegb2cJR+OCtvopNOa4kFPcmdPVw6pyOGi9s1yZZXUapjMMHcc8gk6so/WzTVE
         cEc8m05nr2de6/RdYAd6slrngsMhespqEptzgsuT1doWySDXJyjc0ul5UqwOo81m1jaP
         1Z+2A2WjGvz4hxFUnvyAXuCq1MWmpc25fKCOeF291lCorrWKegL36wLtYaULSBT76RWM
         gzzcOmXHnmwu0eWk7BlfS/G87Hb7la79NNUk0wbuMTLzcoLqG1HprfVsqDry4/1NAUPr
         Bp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859633; x=1690464433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlAwLGhvuTr8ROLaXnMqr4ZXOd2hH6vJbKxn4BmvVKs=;
        b=YBA62jlinsx0YnYVNYoy+FdLIt+gB4YDD1BEYaCNz+KSg5FWft0K8UucNzxoVE9qKx
         ijCTUtCfnWN95FnvBYCE4ZcXsEGvOT+0KOXDxUzp7Ii6Dzqp70E3fB3VzgkL+/cFLOXf
         B5GN0kZWDRg4x/TJGaacegLdzSvQBZxdW+LRY7Kmke/+bfsX4uanaXJ/Z0flbkIkLJr/
         FLy0brAU1jlZVKxp+KKH/pYbTV7GjSJHc5iBInLieRNHAYxjqLpGTUHrao+KzgG54XFT
         z/0C9hEpCS+uuWfdSsfouzgo4iqh+/7oqcMH3LGh6DRRsJyBstMFWNYYk7jXghj0eNgt
         4M8w==
X-Gm-Message-State: ABy/qLaeX1asY65yQQMUY1WiFitIpd7XwiKD1IzuERLh/oxufa/g7NJk
        XlELHbkbpNgDDDsTDgIO1iaS2W2uckA3MqxqP38=
X-Google-Smtp-Source: APBJJlHpIpx+6q4xexQorUGUZRl3XBmaiEghmv4HN9QAPhLEnB8YKY6NgvI1sBgEFzkyO/gUyYDYrDwAttqI4bmlW/M=
X-Received: by 2002:a17:902:da85:b0:1b8:9fc4:2733 with SMTP id
 j5-20020a170902da8500b001b89fc42733mr19322083plx.3.1689859632641; Thu, 20 Jul
 2023 06:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230720131028.3730704-1-james.hilliard1@gmail.com> <20230720131028.3730704-2-james.hilliard1@gmail.com>
In-Reply-To: <20230720131028.3730704-2-james.hilliard1@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 20 Jul 2023 10:27:00 -0300
Message-ID: <CAOMZO5BPadhvTux-YMRZtZS=QaQhk9z+h7COk7_5S4gaqeE2eQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ARM: dts: imx6qdl: Add Variscite VAR-SOM-MX6 SoM support
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

enable-active-high should only be used when there is a corresponding
gpio property.

> +&ecspi3 {
> +       fsl,spi-num-chipselects =3D <1>;
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_ecspi3>;
> +       cs-gpios =3D <&gpio4 24 GPIO_ACTIVE_HIGH>;

This should be ACTIVE_LOW instead.

> +       status =3D "okay";
> +};
> +
> +&fec {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_enet>;
> +       phy-mode =3D "rgmii";
> +       phy-reset-gpios =3D <&gpio1 25 GPIO_ACTIVE_LOW>;

This is a deprecated property.

The recommendation is to add a mdio node with:

reset-gpios =3D <&gpio1 25 GPIO_ACTIVE_LOW>;
reset-assert-us =3D <10000>;

Is this an Atheros AR8031 PHY. If so, please check imx6qdl-sabresd.dtsi.

> +&ssi2 {
> +       fsl,mode =3D "i2s-slave";

This is unused, drop it.

Please check commit ece1e4999 606 ("ASoC: fsl_ssi: Remove unneeded
'i2s-slave' property")

> +&usdhc3 {
> +       pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 =3D <&pinctrl_usdhc3>;
> +       pinctrl-1 =3D <&pinctrl_usdhc3_100mhz>;
> +       pinctrl-2 =3D <&pinctrl_usdhc3_200mhz>;
> +       bus-width =3D <4>;
> +       vmmc-supply =3D <&reg_wl18xx_vmmc>;
> +       non-removable;
> +       wakeup-source;
> +       keep-power-in-suspend;
> +       cap-power-off-card;
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +       status =3D "okay";
> +
> +       wifi: wifi@0 {
> +               compatible =3D "ti,wl1835";
> +               reg =3D <2>;

@0 and reg =3D <2> do not match.
