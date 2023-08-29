Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8B478C715
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbjH2OO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236883AbjH2OO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:14:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569F9C0;
        Tue, 29 Aug 2023 07:14:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D97B865A9A;
        Tue, 29 Aug 2023 14:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104EDC433CD;
        Tue, 29 Aug 2023 14:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693318462;
        bh=YesSUKL10rxav1vM00LQmHJcdtQsxeVm8jbns6Hd2Y4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DJmUBh2x7jhQYWeh/ZCbPik06ez07pv+9W1pMXodVnBIqtF4yrrzCP/AfvzvtwA0d
         eoLHcLLp2+VK5dWP/xjhdj02EcQrA4uncedyoowPHv15y6eaqv3Vs8/erx7bbnzE7G
         IsnBKaYWdvgjUNCFbDShabuO2agvP3VGNPzeLC7AlGBLLo6zBw9CsQpYfjyX4/XDH4
         tFkPsdeDxlFEFzX8m4h8U9/+gC/1thLpHGnw3xwZ/7rFXm+grewuBfi+p+nE5rFHpy
         HAdarmaIN4efe231yXZoJ6orxbDn8HLHsMn/ejALu4e2CFmpT2aoRqNLcihXlmHjpz
         8AT/6/j1bnSlw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so65911301fa.3;
        Tue, 29 Aug 2023 07:14:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YwJGYeYTi3ic8bfL0C1QsnkmqankcNuQVKJUoqT7vyRxNyX07NY
        sa0JGrvusFzCAgnBDN1o+X9qkm3qVdWgoWKdwQ==
X-Google-Smtp-Source: AGHT+IF5hqZns5MhjgglhLnAmqNK6PSIJxJhmxhwnEUQbXWqMiTURlrac8MQufEes7uZ+PBLIzrZgNAd5m9jeFL72bs=
X-Received: by 2002:a05:651c:168d:b0:2bd:d31:95e7 with SMTP id
 bd13-20020a05651c168d00b002bd0d3195e7mr4627284ljb.18.1693318459918; Tue, 29
 Aug 2023 07:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230828065137.2332953-1-Delphine_CC_Chiu@wiwynn.com> <20230828065137.2332953-3-Delphine_CC_Chiu@wiwynn.com>
In-Reply-To: <20230828065137.2332953-3-Delphine_CC_Chiu@wiwynn.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 29 Aug 2023 09:14:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKvZPSp3cHkxTq6Dq_djSoPSs6AueM2VF_UPz_gG8tVVA@mail.gmail.com>
Message-ID: <CAL_JsqKvZPSp3cHkxTq6Dq_djSoPSs6AueM2VF_UPz_gG8tVVA@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] ARM: dts: aspeed: yosemite4: add Facebook
 Yosemite 4 BMC
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc:     patrick@stwcx.xyz,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 1:52=E2=80=AFAM Delphine CC Chiu
<Delphine_CC_Chiu@wiwynn.com> wrote:
>
> Add linux device tree entry for Yosemite 4 devices connected to BMC.
> The Yosemite 4 is a Meta multi-node server platform, based on AST2600 SoC=
.

This was already applied and sent upstream on Aug 10 by Joel. You'll
need incremental patches.

>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
> Changelog:
> v12 - Add spi gpio config
> v11 - Add imux configs for i2c-mux
>     - Add gpio and eeprom devices
>     - Remove temperature-sensor 11-004a and 11-004b
>     - Change power-sensor ina230 to ina233
> v10 - Change to 128MB flash layout from 64MB
>  v9 - Remove mac2/mac3 duplicated setting about no-hw-checksum
>  v8 - Add description of Yosemite 4
>     - Remove unsupported ncsi config
>     - Revise i2c-mux config
>     - Correct power sensor i2c address
>     - Restore i2c 11 bus-frequency to default
>  v7 - Revise changelog format
>  v6 - Change project name from yosemitev4 to yosemite4
>  v5 - Revise rtc setting
>     - Remove duplicated multi-master setting
>  v3 - Revise the bootargs to stdout-path
>     - Revise i2c devices
>  v2 - Revise the DTS node name
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |    1 +
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 1102 +++++++++++++++++
>  2 files changed, 1103 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite=
4.dts
>
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed=
/Makefile
> index c68984322a86..5b9264b823f3 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -26,6 +26,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
>         aspeed-bmc-facebook-wedge400.dtb \
>         aspeed-bmc-facebook-yamp.dtb \
>         aspeed-bmc-facebook-yosemitev2.dtb \
> +       aspeed-bmc-facebook-yosemite4.dtb \
>         aspeed-bmc-ibm-bonnell.dtb \
>         aspeed-bmc-ibm-everest.dtb \
>         aspeed-bmc-ibm-rainier.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> new file mode 100644
> index 000000000000..851091a512dd
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -0,0 +1,1102 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2022 Facebook Inc.
> +
> +/dts-v1/;
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/leds/leds-pca955x.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/ {
> +       model =3D "Facebook Yosemite 4 BMC";
> +       compatible =3D "facebook,yosemite4-bmc", "aspeed,ast2600";
> +
> +       aliases {
> +               serial4 =3D &uart5;
> +               serial5 =3D &uart6;
> +               serial6 =3D &uart7;
> +               serial7 =3D &uart8;
> +               serial8 =3D &uart9;
> +
> +               i2c16 =3D &imux16;
> +               i2c17 =3D &imux17;
> +               i2c18 =3D &imux18;
> +               i2c19 =3D &imux19;
> +               i2c20 =3D &imux20;
> +               i2c21 =3D &imux21;
> +               i2c22 =3D &imux22;
> +               i2c23 =3D &imux23;
> +               i2c24 =3D &imux24;
> +               i2c25 =3D &imux25;
> +               i2c26 =3D &imux26;
> +               i2c27 =3D &imux27;
> +               i2c28 =3D &imux28;
> +               i2c29 =3D &imux29;
> +               i2c30 =3D &imux30;
> +               i2c31 =3D &imux31;
> +               i2c32 =3D &imux32;
> +               i2c33 =3D &imux33;
> +       };
> +
> +       chosen {
> +               stdout-path =3D "serial4:57600n8";
> +       };
> +
> +       memory@80000000 {
> +               device_type =3D "memory";
> +               reg =3D <0x80000000 0x80000000>;
> +       };
> +
> +       iio-hwmon {
> +               compatible =3D "iio-hwmon";
> +               io-channels =3D <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3=
>,
> +                               <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7=
>,
> +                               <&adc1 0>, <&adc1 1>;
> +       };
> +
> +       spi_gpio: spi-gpio {
> +               status =3D "okay";
> +               compatible =3D "spi-gpio";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               gpio-sck =3D <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
> +               gpio-mosi =3D <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>=
;
> +               gpio-miso =3D <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>=
;
> +               num-chipselects =3D <1>;
> +               cs-gpios =3D <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
> +
> +               tpmdev@0 {
> +                       compatible =3D "tcg,tpm_tis-spi";
> +                       spi-max-frequency =3D <33000000>;
> +                       reg =3D <0>;
> +               };
> +       };
> +};
> +
> +&uart1 {
> +       status =3D "okay";
> +};
> +
> +&uart2 {
> +       status =3D "okay";
> +};
> +
> +&uart3 {
> +       status =3D "okay";
> +};
> +
> +&uart4 {
> +       status =3D "okay";
> +};
> +
> +&uart5 {
> +       status =3D "okay";
> +};
> +
> +&uart6 {
> +       status =3D "okay";
> +};
> +
> +&uart7 {
> +       status =3D "okay";
> +};
> +
> +&uart8 {
> +       status =3D "okay";
> +};
> +
> +&uart9 {
> +       status =3D "okay";
> +};
> +
> +&wdt1 {
> +       status =3D "okay";
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_wdtrst1_default>;
> +       aspeed,reset-type =3D "soc";
> +       aspeed,external-signal;
> +       aspeed,ext-push-pull;
> +       aspeed,ext-active-high;
> +       aspeed,ext-pulse-duration =3D <256>;
> +};
> +
> +&mac2 {
> +       status =3D "okay";
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_rmii3_default>;
> +       use-ncsi;
> +       mlx,multi-host;
> +};
> +
> +&mac3 {
> +       status =3D "okay";
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_rmii4_default>;
> +       use-ncsi;
> +       mlx,multi-host;
> +};
> +
> +&fmc {
> +       status =3D "okay";
> +       flash@0 {
> +               status =3D "okay";
> +               m25p,fast-read;
> +               label =3D "bmc";
> +               spi-rx-bus-width =3D <4>;
> +               spi-max-frequency =3D <50000000>;
> +#include "openbmc-flash-layout-128.dtsi"
> +       };
> +       flash@1 {
> +               status =3D "okay";
> +               m25p,fast-read;
> +               label =3D "bmc2";
> +               spi-rx-bus-width =3D <4>;
> +               spi-max-frequency =3D <50000000>;
> +       };
> +};
> +
> +&i2c0 {
> +       status =3D "okay";
> +       mctp-controller;
> +       bus-frequency =3D <400000>;
> +       multi-master;
> +
> +       mctp@10 {
> +               compatible =3D "mctp-i2c-controller";
> +               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
> +
> +       power-sensor@40 {
> +               compatible =3D "adi,adm1278";
> +               reg =3D <0x40>;
> +       };
> +};
> +
> +&i2c1 {
> +       status =3D "okay";
> +       mctp-controller;
> +       bus-frequency =3D <400000>;
> +       multi-master;
> +
> +       mctp@10 {
> +               compatible =3D "mctp-i2c-controller";
> +               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
> +
> +       power-sensor@40 {
> +               compatible =3D "adi,adm1278";
> +               reg =3D <0x40>;
> +       };
> +};
> +
> +&i2c2 {
> +       status =3D "okay";
> +       mctp-controller;
> +       bus-frequency =3D <400000>;
> +       multi-master;
> +
> +       mctp@10 {
> +               compatible =3D "mctp-i2c-controller";
> +               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
> +
> +       power-sensor@40 {
> +               compatible =3D "adi,adm1278";
> +               reg =3D <0x40>;
> +       };
> +};
> +
> +&i2c3 {
> +       status =3D "okay";
> +       mctp-controller;
> +       bus-frequency =3D <400000>;
> +       multi-master;
> +
> +       mctp@10 {
> +               compatible =3D "mctp-i2c-controller";
> +               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
> +
> +       power-sensor@40 {
> +               compatible =3D "adi,adm1278";
> +               reg =3D <0x40>;
> +       };
> +};
> +
> +&i2c4 {
> +       status =3D "okay";
> +       mctp-controller;
> +       bus-frequency =3D <400000>;
> +       multi-master;
> +
> +       mctp@10 {
> +               compatible =3D "mctp-i2c-controller";
> +               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
> +
> +       power-sensor@40 {
> +               compatible =3D "adi,adm1278";
> +               reg =3D <0x40>;
> +       };
> +};
> +
> +&i2c5 {
> +       status =3D "okay";
> +       mctp-controller;
> +       bus-frequency =3D <400000>;
> +       multi-master;
> +
> +       mctp@10 {
> +               compatible =3D "mctp-i2c-controller";
> +               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
> +
> +       power-sensor@40 {
> +               compatible =3D "adi,adm1278";
> +               reg =3D <0x40>;
> +       };
> +};
> +
> +&i2c6 {
> +       status =3D "okay";
> +       mctp-controller;
> +       bus-frequency =3D <400000>;
> +       multi-master;
> +
> +       mctp@10 {
> +               compatible =3D "mctp-i2c-controller";
> +               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
> +
> +       power-sensor@40 {
> +               compatible =3D "adi,adm1278";
> +               reg =3D <0x40>;
> +       };
> +};
> +
> +&i2c7 {
> +       status =3D "okay";
> +       mctp-controller;
> +       bus-frequency =3D <400000>;
> +       multi-master;
> +
> +       mctp@10 {
> +               compatible =3D "mctp-i2c-controller";
> +               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +       };
> +
> +       power-sensor@40 {
> +               compatible =3D "adi,adm1278";
> +               reg =3D <0x40>;
> +       };
> +};
> +
> +&i2c8 {
> +       status =3D "okay";
> +       bus-frequency =3D <400000>;
> +       i2c-mux@70 {
> +               compatible =3D "nxp,pca9544";
> +               idle-state =3D <0>;
> +               i2c-mux-idle-disconnect;
> +               reg =3D <0x70>;
> +
> +               imux16: i2c@0 {
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       reg =3D <0>;
> +                       gpio@20 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x20>;
> +                       };
> +
> +                       gpio@21 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x21>;
> +                       };
> +
> +                       gpio@22 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x22>;
> +                       };
> +
> +                       gpio@23 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x23>;
> +                       };
> +
> +                       gpio@49 {
> +                               compatible =3D "nxp,pca9537";
> +                               reg =3D <0x49>;
> +                       };
> +
> +                       eeprom@50 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x50>;
> +                       };
> +
> +                       eeprom@51 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x51>;
> +                       };
> +
> +                       eeprom@54 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x54>;
> +                       };
> +               };
> +
> +               imux17: i2c@1 {
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       reg =3D <1>;
> +                       gpio@20 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x20>;
> +                       };
> +
> +                       gpio@21 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x21>;
> +                       };
> +
> +                       gpio@22 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x22>;
> +                       };
> +
> +                       gpio@23 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x23>;
> +                       };
> +
> +                       gpio@49 {
> +                               compatible =3D "nxp,pca9537";
> +                               reg =3D <0x49>;
> +                       };
> +
> +                       eeprom@50 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x50>;
> +                       };
> +
> +                       eeprom@51 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x51>;
> +                       };
> +
> +                       eeprom@54 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x54>;
> +                       };
> +               };
> +
> +               imux18: i2c@2 {
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       reg =3D <2>;
> +                       gpio@20 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x20>;
> +                       };
> +
> +                       gpio@21 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x21>;
> +                       };
> +
> +                       gpio@22 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x22>;
> +                       };
> +
> +                       gpio@23 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x23>;
> +                       };
> +
> +                       gpio@49 {
> +                               compatible =3D "nxp,pca9537";
> +                               reg =3D <0x49>;
> +                       };
> +
> +                       eeprom@50 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x50>;
> +                       };
> +
> +                       eeprom@51 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x51>;
> +                       };
> +
> +                       eeprom@54 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x54>;
> +                       };
> +               };
> +
> +               imux19: i2c@3 {
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       reg =3D <3>;
> +                       gpio@20 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x20>;
> +                       };
> +
> +                       gpio@21 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x21>;
> +                       };
> +
> +                       gpio@22 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x22>;
> +                       };
> +
> +                       gpio@23 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x23>;
> +                       };
> +
> +                       gpio@49 {
> +                               compatible =3D "nxp,pca9537";
> +                               reg =3D <0x49>;
> +                       };
> +
> +                       eeprom@50 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x50>;
> +                       };
> +
> +                       eeprom@51 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x51>;
> +                       };
> +
> +                       eeprom@54 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x54>;
> +                       };
> +               };
> +       };
> +};
> +
> +&i2c9 {
> +       status =3D "okay";
> +       bus-frequency =3D <400000>;
> +       i2c-mux@71 {
> +               compatible =3D "nxp,pca9544";
> +               idle-state =3D <0>;
> +               i2c-mux-idle-disconnect;
> +               reg =3D <0x71>;
> +
> +               imux20: i2c@0 {
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       reg =3D <0>;
> +                       gpio@20 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x20>;
> +                       };
> +
> +                       gpio@21 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x21>;
> +                       };
> +
> +                       gpio@22 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x22>;
> +                       };
> +
> +                       gpio@23 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x23>;
> +                       };
> +
> +                       gpio@49 {
> +                               compatible =3D "nxp,pca9537";
> +                               reg =3D <0x49>;
> +                       };
> +
> +                       eeprom@50 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x50>;
> +                       };
> +
> +                       eeprom@51 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x51>;
> +                       };
> +
> +                       eeprom@54 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x54>;
> +                       };
> +               };
> +
> +               imux21: i2c@1 {
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       reg =3D <1>;
> +                       gpio@20 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x20>;
> +                       };
> +
> +                       gpio@21 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x21>;
> +                       };
> +
> +                       gpio@22 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x22>;
> +                       };
> +
> +                       gpio@23 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x23>;
> +                       };
> +
> +                       gpio@49 {
> +                               compatible =3D "nxp,pca9537";
> +                               reg =3D <0x49>;
> +                       };
> +
> +                       eeprom@50 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x50>;
> +                       };
> +
> +                       eeprom@51 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x51>;
> +                       };
> +
> +                       eeprom@54 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x54>;
> +                       };
> +               };
> +
> +               imux22: i2c@2 {
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       reg =3D <2>;
> +                       gpio@20 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x20>;
> +                       };
> +
> +                       gpio@21 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x21>;
> +                       };
> +
> +                       gpio@22 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x22>;
> +                       };
> +
> +                       gpio@23 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x23>;
> +                       };
> +
> +                       gpio@49 {
> +                               compatible =3D "nxp,pca9537";
> +                               reg =3D <0x49>;
> +                       };
> +
> +                       eeprom@50 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x50>;
> +                       };
> +
> +                       eeprom@51 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x51>;
> +                       };
> +
> +                       eeprom@54 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x54>;
> +                       };
> +               };
> +
> +               imux23: i2c@3 {
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       reg =3D <3>;
> +                       gpio@20 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x20>;
> +                       };
> +
> +                       gpio@21 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x21>;
> +                       };
> +
> +                       gpio@22 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x22>;
> +                       };
> +
> +                       gpio@23 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x23>;
> +                       };
> +
> +                       gpio@49 {
> +                               compatible =3D "nxp,pca9537";
> +                               reg =3D <0x49>;
> +                       };
> +
> +                       eeprom@50 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x50>;
> +                       };
> +
> +                       eeprom@51 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x51>;
> +                       };
> +
> +                       eeprom@54 {
> +                               compatible =3D "atmel,24c128";
> +                               reg =3D <0x54>;
> +                       };
> +               };
> +       };
> +};
> +
> +&i2c10 {
> +       status =3D "okay";
> +       bus-frequency =3D <400000>;
> +       i2c-mux@74 {
> +               compatible =3D "nxp,pca9544";
> +               idle-state =3D <0>;
> +               i2c-mux-idle-disconnect;
> +               reg =3D <0x74>;
> +
> +               imux28: i2c@0 {
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       reg =3D <0>;
> +               };
> +
> +               imux29: i2c@1 {
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       reg =3D <1>;
> +                       gpio@20 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x20>;
> +                       };
> +
> +                       gpio@21 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x21>;
> +                       };
> +
> +                       gpio@22 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x22>;
> +                       };
> +
> +                       gpio@23 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x23>;
> +                       };
> +
> +                       gpio@24 {
> +                               compatible =3D "nxp,pca9506";
> +                               reg =3D <0x24>;
> +                       };
> +               };
> +       };
> +};
> +
> +&i2c11 {
> +       status =3D "okay";
> +       power-sensor@10 {
> +               compatible =3D "adi, adm1272";
> +               reg =3D <0x10>;
> +       };
> +
> +       power-sensor@12 {
> +               compatible =3D "adi, adm1272";
> +               reg =3D <0x12>;
> +       };
> +
> +       gpio@20 {
> +               compatible =3D "nxp,pca9555";
> +               reg =3D <0x20>;
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +       };
> +
> +       gpio@21 {
> +               compatible =3D "nxp,pca9555";
> +               reg =3D <0x21>;
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +       };
> +
> +       gpio@22 {
> +               compatible =3D "nxp,pca9555";
> +               reg =3D <0x22>;
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +       };
> +
> +       gpio@23 {
> +               compatible =3D "nxp,pca9555";
> +               reg =3D <0x23>;
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +       };
> +
> +       temperature-sensor@48 {
> +               compatible =3D "ti,tmp75";
> +               reg =3D <0x48>;
> +       };
> +
> +       temperature-sensor@49 {
> +               compatible =3D "ti,tmp75";
> +               reg =3D <0x49>;
> +       };
> +
> +       eeprom@54 {
> +               compatible =3D "atmel,24c256";
> +               reg =3D <0x54>;
> +       };
> +};
> +
> +&i2c12 {
> +       status =3D "okay";
> +       bus-frequency =3D <400000>;
> +
> +       temperature-sensor@48 {
> +               compatible =3D "ti,tmp75";
> +               reg =3D <0x48>;
> +       };
> +
> +       eeprom@50 {
> +               compatible =3D "atmel,24c128";
> +               reg =3D <0x50>;
> +       };
> +
> +       eeprom@54 {
> +               compatible =3D "atmel,24c64";
> +               reg =3D <0x54>;
> +       };
> +
> +       rtc@6f {
> +               compatible =3D "nuvoton,nct3018y";
> +               reg =3D <0x6f>;
> +       };
> +};
> +
> +&i2c13 {
> +       status =3D "okay";
> +       bus-frequency =3D <400000>;
> +       gpio@20 {
> +               compatible =3D "nxp,pca9506";
> +               reg =3D <0x20>;
> +       };
> +
> +       gpio@21 {
> +               compatible =3D "nxp,pca9506";
> +               reg =3D <0x21>;
> +       };
> +
> +       gpio@22 {
> +               compatible =3D "nxp,pca9506";
> +               reg =3D <0x22>;
> +       };
> +
> +       gpio@23 {
> +               compatible =3D "nxp,pca9506";
> +               reg =3D <0x23>;
> +       };
> +};
> +
> +&i2c14 {
> +       status =3D "okay";
> +       bus-frequency =3D <400000>;
> +       adc@1d {
> +               compatible =3D "ti,adc128d818";
> +               reg =3D <0x1d>;
> +               ti,mode =3D /bits/ 8 <2>;
> +       };
> +
> +       adc@35 {
> +               compatible =3D "ti,adc128d818";
> +               reg =3D <0x35>;
> +               ti,mode =3D /bits/ 8 <2>;
> +       };
> +
> +       adc@37 {
> +               compatible =3D "ti,adc128d818";
> +               reg =3D <0x37>;
> +               ti,mode =3D /bits/ 8 <2>;
> +       };
> +
> +       power-sensor@40 {
> +               compatible =3D "ti,ina233";
> +               reg =3D <0x40>;
> +       };
> +
> +       power-sensor@41 {
> +               compatible =3D "ti,ina233";
> +               reg =3D <0x41>;
> +       };
> +
> +       power-sensor@42 {
> +               compatible =3D "ti,ina233";
> +               reg =3D <0x42>;
> +       };
> +
> +       power-sensor@43 {
> +               compatible =3D "ti,ina233";
> +               reg =3D <0x43>;
> +       };
> +
> +       power-sensor@44 {
> +               compatible =3D "ti,ina233";
> +               reg =3D <0x44>;
> +       };
> +
> +       temperature-sensor@4e {
> +               compatible =3D "ti,tmp75";
> +               reg =3D <0x4e>;
> +       };
> +
> +       temperature-sensor@4f {
> +               compatible =3D "ti,tmp75";
> +               reg =3D <0x4f>;
> +       };
> +
> +       eeprom@51 {
> +               compatible =3D "atmel,24c128";
> +               reg =3D <0x51>;
> +       };
> +
> +       i2c-mux@71 {
> +               compatible =3D "nxp,pca9846";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               idle-state =3D <0>;
> +               i2c-mux-idle-disconnect;
> +               reg =3D <0x71>;
> +
> +               imux30: i2c@0 {
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       reg =3D <0>;
> +
> +                       adc@1f {
> +                               compatible =3D "ti,adc128d818";
> +                               reg =3D <0x1f>;
> +                               ti,mode =3D /bits/ 8 <2>;
> +                       };
> +
> +                       pwm@20{
> +                               compatible =3D "max31790";

This is not documented. It also needs a vendor prefix.

> +                               reg =3D <0x20>;
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;

These 2 are for child nodes, but you don't have any. And a PWM
probably never will.

Rob
