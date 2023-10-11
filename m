Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A7C7C476A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344689AbjJKBsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344618AbjJKBsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:48:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404AC92;
        Tue, 10 Oct 2023 18:48:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso1143677366b.1;
        Tue, 10 Oct 2023 18:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1696988893; x=1697593693; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=igjlN4dO3JjcdB2G4ww8hAUFD7DZ0Fw5neZs9pJmc38=;
        b=QBUutq5Vpvc3gbVYnxPj3J9ZtWQTiMQ4/ZPQpJLbxjF0OZfy06F1Pl3XkXZw0e6DFB
         Ubi0YKI9VP0JLNLxqQFRFVuNSmcreJFSxGi5Ka8zdCx3W6mBkLkK1Wfg4VjGFpK6pT8i
         1zLWKYZlrJHggYzEeX8L5hJXYgpnHvnPjeC8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696988893; x=1697593693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igjlN4dO3JjcdB2G4ww8hAUFD7DZ0Fw5neZs9pJmc38=;
        b=T2IJCRMcJyuCHovFTPIgUQRXjWuKdIx3ZXfq8FB2104P97b/TdR01Zv082s0Bb1hDE
         qheal/xG/2LQFkcNNFdHgl0rN7EFq3k8w0J9PTip3OOIXRc9yzbjNgzHqT+JOvaALr6G
         pC3aKxXLPA4Ba1PpBDjgvEdUQGyUhwIezZH4BjTbH61cpN+LbNDhpGmJ4acswp2K5AQt
         Sxb1naARnspLSlxy8e7NqM1r4BWnZgq5/yImy2zhrQPkAS7MNMwCdcBgkK9TI09CYHsK
         bMPBBDbqaFiakgYMY4N+0H/hBOgVtZr78unA3p8HSVxYuE0e/IcnJ9lpq0xjsordSddo
         85dA==
X-Gm-Message-State: AOJu0Yxm2AUBAEySHp8eYCvl2+n8APk8k97cIrzdzSpaUA7z8sdYLfKN
        widU5NpSR0qYWo+EQp2IFzEQ7N4Lcyv1Zt6/Bx4=
X-Google-Smtp-Source: AGHT+IEuuMqEy3USpJDXR0kSSSQMnE9Vm8JFze2cJqxGftCWpvdSX0K+UCUFBZu0kfb7wHhQh1dEjjpMVzNhVPs+EdA=
X-Received: by 2002:a17:907:7890:b0:9ae:711d:7e03 with SMTP id
 ku16-20020a170907789000b009ae711d7e03mr17862404ejc.15.1696988892477; Tue, 10
 Oct 2023 18:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231005035525.19036-1-chanh@os.amperecomputing.com> <20231005035525.19036-2-chanh@os.amperecomputing.com>
In-Reply-To: <20231005035525.19036-2-chanh@os.amperecomputing.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 11 Oct 2023 12:18:01 +1030
Message-ID: <CACPK8XdpUpg0vDG7UwO-o=dYD-88evizSUb-yKm9qdUP2rjzdg@mail.gmail.com>
Subject: Re: [PATCH 1/7] ARM: dts: aspeed: mtjade, mtmitchell: Update gpio-line-names
To:     Chanh Nguyen <chanh@os.amperecomputing.com>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED,WEIRD_QUOTING autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2023 at 14:26, Chanh Nguyen <chanh@os.amperecomputing.com> wrote:
>
> Update GPIO line-name to follow naming convention specified at
> github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md
>
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  .../dts/aspeed/aspeed-bmc-ampere-mtjade.dts   | 42 +++++++++----------
>  .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   |  6 +--
>  2 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> index 0a51d2e32fab..e57efcc8522a 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> @@ -760,30 +760,30 @@
>
>  &gpio {
>         gpio-line-names =
> -       /*A0-A7*/       "","","","S0_BMC_SPECIAL_BOOT","","","","",
> -       /*B0-B7*/       "BMC_SELECT_EEPROM","","","",
> -                       "POWER_BUTTON","","","",
> +       /*A0-A7*/       "","","","host0-special-boot","","","","",
> +       /*B0-B7*/       "i2c-backup-sel","","","",
> +                       "power-button","","","",
>         /*C0-C7*/       "","","","","","","","",
>         /*D0-D7*/       "","","","","","","","",
>         /*E0-E7*/       "","","","","","","","",
> -       /*F0-F7*/       "","","BMC_SYS_PSON_L","S0_DDR_SAVE","PGOOD",
> -                       "S1_DDR_SAVE","","",
> -       /*G0-G7*/       "host0-ready","SHD_REQ_L","","S0_OVERTEMP_L","","",
> +       /*F0-F7*/       "","","power-chassis-control","s0-ddr-save","power-chassis-good",
> +                       "s1-ddr-save","","",
> +       /*G0-G7*/       "host0-ready","host0-shd-req-n","","s0-overtemp-n","","",
>                         "","",
> -       /*H0-H7*/       "","","","","PSU1_VIN_GOOD","PSU2_VIN_GOOD","","",
> -       /*I0-I7*/       "PSU1_PRESENT","PSU2_PRESENT","S1_BMC_SPECIAL_BOOT",
> -                       "","","","","",
> -       /*J0-J7*/       "S0_HIGHTEMP_L","S0_FAULT_L","S0_SCP_AUTH_FAIL_L","",
> +       /*H0-H7*/       "","","","","ps0-vin-good","ps1-vin-good","","",
> +       /*I0-I7*/       "presence-ps0","presence-ps1","s1-special-boot",
> +                               "","","","","",
> +       /*J0-J7*/       "s0-hightemp-n","s0-fault-alert","s0-sys-auth-failure-n","",
>                         "","","","",
>         /*K0-K7*/       "","","","","","","","",
> -       /*L0-L7*/       "","","","BMC_SYSRESET_L","SPI_AUTH_FAIL_L","","","",
> +       /*L0-L7*/       "","","","host0-sysreset-n","s0-spi-auth-fail-n","","","",
>         /*M0-M7*/       "","","","","","","","",
>         /*N0-N7*/       "","","","","","","","",
>         /*O0-O7*/       "","","","","","","","",
>         /*P0-P7*/       "","","","","","","","",
> -       /*Q0-Q7*/       "","","","","","UID_BUTTON","","",
> -       /*R0-R7*/       "","","BMC_EXT_HIGHTEMP_L","OCP_AUX_PWREN",
> -                       "OCP_MAIN_PWREN","RESET_BUTTON","","",
> +       /*Q0-Q7*/       "","","","","","identify-button","","",
> +       /*R0-R7*/       "","","ext-hightemp-n","",
> +                       "ocp-main-pwren","reset-button","","",
>         /*S0-S7*/       "","","","","rtc-battery-voltage-read-enable","","","",
>         /*T0-T7*/       "","","","","","","","",
>         /*U0-U7*/       "","","","","","","","",
> @@ -791,18 +791,18 @@
>         /*W0-W7*/       "","","","","","","","",
>         /*X0-X7*/       "","","","","","","","",
>         /*Y0-Y7*/       "","","","","","","","",
> -       /*Z0-Z7*/       "S0_BMC_PLIMIT","S1_FAULT_L","S1_FW_BOOT_OK","","",
> -                       "S1_SCP_AUTH_FAIL_L","S1_OVERTEMP_L","",
> +       /*Z0-Z7*/       "s0-plimit","s1-fault-alert","s1-fw-boot-ok","","",
> +                       "s1-sys-auth-failure-n","s1-overtemp-n","",
>         /*AA0-AA7*/     "","","","","","","","",
> -       /*AB0-AB7*/     "S1_HIGHTEMP_L","S1_BMC_PLIMIT","S0_BMC_DDR_ADDR",
> -                       "S1_BMC_DDR_ADR","","","","",
> -       /*AC0-AC7*/     "SYS_PWR_GD","","","","","BMC_READY","SLAVE_PRESENT_L",
> -                       "BMC_OCP_PG";
> +       /*AB0-AB7*/     "s1-hightemp-n","s1-plimit","s0-ddr-addr",
> +                       "s1-ddr-addr","","","","",
> +       /*AC0-AC7*/     "sys-pwr-gd","","","","","","presence-cpu1",
> +                       "ocp-pgood";
>
>         i2c4-o-en-hog {
>                 gpio-hog;
>                 gpios = <ASPEED_GPIO(Y, 2) GPIO_ACTIVE_HIGH>;
>                 output-high;
> -               line-name = "BMC_I2C4_O_EN";
> +               line-name = "i2c4-o-en";
>         };
>  };
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> index 0715cb9ab30c..2f571b43106d 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> @@ -599,17 +599,17 @@
>         /*Q0-Q7*/       "","","","","","","","",
>         /*R0-R7*/       "","","","","","","","",
>         /*S0-S7*/       "","","identify-button","led-identify",
> -                       "s1-ddr-save","spi-nor-access","sys-pgood","presence-cpu1",
> +                       "s1-ddr-save","spi-nor-access","host0-ready","presence-cpu1",
>         /*T0-T7*/       "","","","","","","","",
>         /*U0-U7*/       "","","","","","","","",
>         /*V0-V7*/       "s0-hightemp-n","s0-fault-alert","s0-sys-auth-failure-n",
> -                       "host0-reboot-ack-n","host0-ready","host0-shd-req-n",
> +                       "host0-reboot-ack-n","s0-fw-boot-ok","host0-shd-req-n",
>                         "host0-shd-ack-n","s0-overtemp-n",
>         /*W0-W7*/       "","ocp-main-pwren","ocp-pgood","",
>                         "bmc-ok","bmc-ready","spi0-program-sel","spi0-backup-sel",
>         /*X0-X7*/       "i2c-backup-sel","s1-fault-alert","s1-fw-boot-ok",
>                         "s1-hightemp-n","s0-spi-auth-fail-n","s1-sys-auth-failure-n",
> -                       "s1-overtemp-n","s1-spi-auth-fail-n",
> +                       "s1-overtemp-n","cpld-s1-spi-auth-fail-n",
>         /*Y0-Y7*/       "","","","","","","","host0-special-boot",
>         /*Z0-Z7*/       "reset-button","ps0-pgood","ps1-pgood","","","","","";
>
> --
> 2.17.1
>
