Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F517AF898
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjI0DZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjI0DXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:23:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54399D012;
        Tue, 26 Sep 2023 19:47:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99357737980so1241805666b.2;
        Tue, 26 Sep 2023 19:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1695782846; x=1696387646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P/nKjSTgtvWlgWPru9cXgw85e2YDjLMZClxSdEw5Ww4=;
        b=F/8/y5kLDXriW/XD/zA99fZHAkUYNIqFGkidSOkAHWQse59NzqsrsmAUlSuiRG9pQR
         YYa7t+MUs1l5LxLCz4jJmPZ1QkOsEJ9HYOcTgndyGXAoyy2zQJsdO9jaIPXnTb+kkLDm
         BCGkH1we1ZqNqde8IJ7cC33XLqoIdkPYAnrYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695782846; x=1696387646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/nKjSTgtvWlgWPru9cXgw85e2YDjLMZClxSdEw5Ww4=;
        b=Ju0bxxvLzQhvf02gRLEfBDAJqPFDM/uCbtCMHh5txyK18qRFmr60Io3SCxjI3eVyrM
         YXWsZGKXBNzN8LPKzVkAXVdvz5nTs/ZzKKt4LtCUmFw5mHnpKaJxZnzbaN1aUpENBzy+
         yNckg4KHim5yDazsD/j9pspKSNn7nZ5SlSbCOgE12y8nmLego4eMSSrojZFVHJeZ3I0y
         gmGGYI6fXFs1GmHVtvM7mjbYIirAY1T/vgZOm2t8ofKqgI7ZmW8IoHWWeAZaO+BHEBD1
         NV4KaXgwCxjhL6i3hgiqrbPAzx2kVFZtEr37A0ZPA7XyBVrvajLa9pdb16+kzG/pINe/
         G16w==
X-Gm-Message-State: AOJu0YyDFrp2WHBBSv8Y8BsWJC3tZ6d+uZhIph0Ean8+fkr8luJfF+EG
        /5iug0wa/kefRiWoa1ebO6z3d9j2hco9yH+THvk=
X-Google-Smtp-Source: AGHT+IEVToxmq1ck7qTT4vRlPzD2CjW8BSfcPnd/9bVjdZ4q06w6pbCASwDHmM9n1gQYtQp/Hy0zzRCrlj95HJk2tyM=
X-Received: by 2002:a17:906:f15:b0:9ae:53df:9855 with SMTP id
 z21-20020a1709060f1500b009ae53df9855mr498026eji.58.1695782845675; Tue, 26 Sep
 2023 19:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230914125648.3966519-1-yangchen.openbmc@gmail.com> <20230914125648.3966519-3-yangchen.openbmc@gmail.com>
In-Reply-To: <20230914125648.3966519-3-yangchen.openbmc@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 27 Sep 2023 02:47:14 +0000
Message-ID: <CACPK8XebBpDJ32Hqd06A+L_hw9qLOcRwg_FVFurD34DZgPwhEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: Minerva: Add Facebook Minerva
 CMC board
To:     Yang Chen <yangchen.openbmc@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@aj.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        patrick@stwcx.xyz, Jerry.Lin@quantatw.com, Eddie.Chen@quantatw.com,
        EasonChen1@quantatw.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sept 2023 at 12:59, Yang Chen <yangchen.openbmc@gmail.com> wrote:
>
> Add linux device tree entry related to the Minerva Chassis Management
> Controller (CMC) specific devices connected to the Aspeed SoC (AST2600).
>
> Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

There was one warning when building. Please double check your code
compiles cleanly before submitting:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts:91.24-94.4:
Warning (i2c_bus_reg):
/ahb/apb/bus@1e78a000/i2c-bus@100/temperature-sensor@4B: I2C bus unit
address format error, expected "4b"

I've fixed that and added your patch to the aspeed tree for 6.7.


> ---
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../aspeed-bmc-facebook-minerva-cmc.dts       | 265 ++++++++++++++++++
>  2 files changed, 266 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
>
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index 23cbc7203a8e..d3ac20e316d0 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>         aspeed-bmc-facebook-fuji.dtb \
>         aspeed-bmc-facebook-galaxy100.dtb \
>         aspeed-bmc-facebook-greatlakes.dtb \
> +       aspeed-bmc-facebook-minerva-cmc.dtb \
>         aspeed-bmc-facebook-minipack.dtb \
>         aspeed-bmc-facebook-tiogapass.dtb \
>         aspeed-bmc-facebook-wedge40.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
> new file mode 100644
> index 000000000000..3c389fdf58a5
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
> @@ -0,0 +1,265 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2023 Facebook Inc.
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/ {
> +       model = "Facebook Minerva CMC";
> +       compatible = "facebook,minerva-cmc", "aspeed,ast2600";
> +
> +       aliases {
> +               serial5 = &uart5;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial5:57600n8";
> +       };
> +
> +       memory@80000000 {
> +               device_type = "memory";
> +               reg = <0x80000000 0x80000000>;
> +       };
> +
> +       iio-hwmon {
> +               compatible = "iio-hwmon";
> +               io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +                       <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +                       <&adc1 2>;
> +       };
> +};
> +
> +&uart6 {
> +       status = "okay";
> +};
> +
> +&wdt1 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_wdtrst1_default>;
> +       aspeed,reset-type = "soc";
> +       aspeed,external-signal;
> +       aspeed,ext-push-pull;
> +       aspeed,ext-active-high;
> +       aspeed,ext-pulse-duration = <256>;
> +};
> +
> +&mac3 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii4_default>;
> +       use-ncsi;
> +       mlx,multi-host;
> +};
> +
> +&fmc {
> +       status = "okay";
> +       flash@0 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "bmc";
> +               spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-128.dtsi"
> +       };
> +       flash@1 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "alt-bmc";
> +               spi-max-frequency = <50000000>;
> +       };
> +};
> +
> +&rtc {
> +       status = "okay";
> +};
> +
> +&sgpiom1 {
> +       status = "okay";
> +       ngpios = <128>;
> +       bus-frequency = <2000000>;
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +};
> +
> +&i2c1 {
> +       status = "okay";
> +
> +       temperature-sensor@4B {
> +               compatible = "ti,tmp75";
> +               reg = <0x4B>;
> +       };
> +
> +       eeprom@51 {
> +               compatible = "atmel,24c128";
> +               reg = <0x51>;
> +       };
> +};
> +
> +&i2c2 {
> +       status = "okay";
> +
> +       i2c-mux@77 {
> +               compatible = "nxp,pca9548";
> +               reg = <0x77>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               i2c-mux-idle-disconnect;
> +
> +               i2c@0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0>;
> +
> +                       eeprom@50 {
> +                               compatible = "atmel,24c128";
> +                               reg = <0x50>;
> +                       };
> +               };
> +
> +               i2c@1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <1>;
> +
> +                       eeprom@50 {
> +                               compatible = "atmel,24c128";
> +                               reg = <0x50>;
> +                       };
> +               };
> +
> +               i2c@2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <2>;
> +
> +                       eeprom@50 {
> +                               compatible = "atmel,24c128";
> +                               reg = <0x50>;
> +                       };
> +               };
> +
> +               i2c@3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <3>;
> +
> +                       eeprom@50 {
> +                               compatible = "atmel,24c128";
> +                               reg = <0x50>;
> +                       };
> +               };
> +
> +               i2c@4 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <4>;
> +
> +                       eeprom@50 {
> +                               compatible = "atmel,24c128";
> +                               reg = <0x50>;
> +                       };
> +               };
> +
> +               i2c@5 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <5>;
> +
> +                       eeprom@50 {
> +                               compatible = "atmel,24c128";
> +                               reg = <0x50>;
> +                       };
> +               };
> +       };
> +};
> +
> +&i2c3 {
> +       status = "okay";
> +};
> +
> +&i2c4 {
> +       status = "okay";
> +};
> +
> +&i2c5 {
> +       status = "okay";
> +};
> +
> +&i2c6 {
> +       status = "okay";
> +};
> +
> +&i2c7 {
> +       status = "okay";
> +};
> +
> +&i2c8 {
> +       status = "okay";
> +};
> +
> +&i2c9 {
> +       status = "okay";
> +};
> +
> +&i2c10 {
> +       status = "okay";
> +};
> +
> +&i2c11 {
> +       status = "okay";
> +};
> +
> +&i2c12 {
> +       status = "okay";
> +};
> +
> +&i2c13 {
> +       status = "okay";
> +};
> +
> +&i2c14 {
> +       status = "okay";
> +       multi-master;
> +
> +       ipmb@10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
> +       };
> +};
> +
> +&i2c15 {
> +       status = "okay";
> +
> +       eeprom@50 {
> +               compatible = "atmel,24c128";
> +               reg = <0x50>;
> +       };
> +};
> +
> +&adc0 {
> +       aspeed,int-vref-microvolt = <2500000>;
> +       status = "okay";
> +       pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
> +               &pinctrl_adc2_default &pinctrl_adc3_default
> +               &pinctrl_adc4_default &pinctrl_adc5_default
> +               &pinctrl_adc6_default &pinctrl_adc7_default>;
> +};
> +
> +&adc1 {
> +       aspeed,int-vref-microvolt = <2500000>;
> +       status = "okay";
> +       pinctrl-0 = <&pinctrl_adc10_default>;
> +};
> +
> +&ehci1 {
> +       status = "okay";
> +};
> +
> +&uhci {
> +       status = "okay";
> +};
> --
> 2.34.1
>
