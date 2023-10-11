Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F5D7C4772
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344707AbjJKBtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344618AbjJKBs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:48:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BE492;
        Tue, 10 Oct 2023 18:48:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b29186e20aso1071930066b.2;
        Tue, 10 Oct 2023 18:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1696988935; x=1697593735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6blQLn2I3D+7E4kfx/VjBl3FG3wnWcWQYJiYRJd/c58=;
        b=KF89DXyuWInnVXolw6CjAes9xQpJELJ2rhIvQ+nOf4TxbO/r7oQgW/XHSCE0KzGqot
         FvLRLCOd/w1cvbTatFLU3tQL6iT593yGiXVzpGhsFjFaSE4nGBaUQOQSA3pMsdzjqhlG
         w5+JRqXGgwc3bGjgjk3Aa8IU7xLp25mbBrU7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696988935; x=1697593735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6blQLn2I3D+7E4kfx/VjBl3FG3wnWcWQYJiYRJd/c58=;
        b=X2IWMYrLE+px9kwIwtQOE8vWHgXA5Soz5qqSpjo5cSXUW32PwfQQmtpeUn1iNZb1dH
         vFBd49kT0ps49Al23kqNWUxcODjRb8DdYEY5NK+leWXBGCWbSlSyg45OuKpBOBUcY1Kv
         nBHpXURC8bA3ByChWbIs/1WOgWOdIg2oV+XBZMg8cpslgT6PSUk3qmIZSACSslSlisi0
         ihiygx/hh2owrqJR7HUpP/EVD83FRJkY1GBx5bCG8YF6Mhn4pqMDgFja1oSrVL0yhZ+n
         WCLyGFwkA2KWVjxbkSyWAsHx/imH4c7x9NpcEdql230DvSW0QA83+fSb3L8hWyFGjcx0
         GhMA==
X-Gm-Message-State: AOJu0Yzm6FN2uMHwaZRLhk5ma+4qqANg/uBc7SE1r1xk1GvAOjQ4PZd2
        rY3hgVal0ilrkYmsPe1KNX4j0q9zoszfYhefJNc=
X-Google-Smtp-Source: AGHT+IG7b/tITQaSOSHGVjLPS11JqPX4ZYJdmpfkrJEDokNKEjsIU/5znXvrSPXzCXj1BdyVDXUgsUUTnAEqW9oJgGI=
X-Received: by 2002:a17:906:10da:b0:9a9:e393:8bcd with SMTP id
 v26-20020a17090610da00b009a9e3938bcdmr16813208ejv.5.1696988935659; Tue, 10
 Oct 2023 18:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231005035525.19036-1-chanh@os.amperecomputing.com> <20231005035525.19036-3-chanh@os.amperecomputing.com>
In-Reply-To: <20231005035525.19036-3-chanh@os.amperecomputing.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 11 Oct 2023 12:18:44 +1030
Message-ID: <CACPK8XcPb_o+vVvZVeF0nqo+-4apS1TjY6o5sFPF7F24KR6ERw@mail.gmail.com>
Subject: Re: [PATCH 2/7] ARM: dts: aspeed: mtjade, mtmitchell: Add new gpio-line-names
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
> Add new gpio-line-names from the Mt.Jade and Mt.Mitchell
> HW schematic.
>
> Mt.Jade
>   GPIOB5: presence-cpu0
>   GPIOF0: ps0-pgood
>   GPIOF1: ps1-pgood
>   GPIOG2: host0-shd-ack-n
>   GPIOH0: uart1-mode1
>   GPIOH1: uart2-mode1
>   GPIOH2: uart3-mode1
>   GPIOH3: uart4-mode1
>   GPIOH7: i2c6-reset-n
>   GPIOH3: host0-reboot-ack-n
>   GPIOM4: s0-i2c9-alert-n
>   GPIOM5: s1-i2c9-alert-n
>   GPIOQ6: led-identify
>   GPIOS0: s0-vr-hot-n
>   GPIOS1: s1-vr-hot-n
>   GPIOS5: vr-pmbus-sel-n
>   GPIOY3: bmc-vga-en-n
>   GPIOZ3: s0-rtc-lock
>   GPIOAC2: spi0-program-sel
>   GPIOAC3: spi0-backup-sel
>
> Mt.Mitchell:
>   GPIOC3: bmc-debug-mode
>   GPIOE1: eth-phy-int-n
>   GPIOH0: jtag-program-sel
>   GPIOH1: fpga-program-b
>   GPIOW3: s1-pcp-pgood
>
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>

I didn't check that you had the assignments correct, but the structure
looks good.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  .../dts/aspeed/aspeed-bmc-ampere-mtjade.dts   | 42 +++++++++----------
>  .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   |  9 ++--
>  2 files changed, 26 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> index e57efcc8522a..c87be433bdd0 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> @@ -762,42 +762,42 @@
>         gpio-line-names =
>         /*A0-A7*/       "","","","host0-special-boot","","","","",
>         /*B0-B7*/       "i2c-backup-sel","","","",
> -                       "power-button","","","",
> +                       "power-button","presence-cpu0","","",
>         /*C0-C7*/       "","","","","","","","",
>         /*D0-D7*/       "","","","","","","","",
>         /*E0-E7*/       "","","","","","","","",
> -       /*F0-F7*/       "","","power-chassis-control","s0-ddr-save","power-chassis-good",
> -                       "s1-ddr-save","","",
> -       /*G0-G7*/       "host0-ready","host0-shd-req-n","","s0-overtemp-n","","",
> -                       "","",
> -       /*H0-H7*/       "","","","","ps0-vin-good","ps1-vin-good","","",
> -       /*I0-I7*/       "presence-ps0","presence-ps1","s1-special-boot",
> -                               "","","","","",
> -       /*J0-J7*/       "s0-hightemp-n","s0-fault-alert","s0-sys-auth-failure-n","",
> -                       "","","","",
> +       /*F0-F7*/       "ps0-pgood","ps1-pgood","power-chassis-control","s0-ddr-save",
> +                       "power-chassis-good", "s1-ddr-save","","",
> +       /*G0-G7*/       "host0-ready","host0-shd-req-n","host0-shd-ack-n",
> +                       "s0-overtemp-n","","","","",
> +       /*H0-H7*/       "uart1-mode1","uart2-mode1","uart3-mode1","uart4-mode1",
> +                       "ps0-vin-good","ps1-vin-good","","i2c6-reset-n",
> +       /*I0-I7*/       "presence-ps0","presence-ps1","s1-special-boot","","","","","",
> +       /*J0-J7*/       "s0-hightemp-n","s0-fault-alert","s0-sys-auth-failure-n",
> +                       "host0-reboot-ack-n","","","","",
>         /*K0-K7*/       "","","","","","","","",
>         /*L0-L7*/       "","","","host0-sysreset-n","s0-spi-auth-fail-n","","","",
> -       /*M0-M7*/       "","","","","","","","",
> +       /*M0-M7*/       "","","","","s0-i2c9-alert-n","s1-i2c9-alert-n","","",
>         /*N0-N7*/       "","","","","","","","",
>         /*O0-O7*/       "","","","","","","","",
>         /*P0-P7*/       "","","","","","","","",
> -       /*Q0-Q7*/       "","","","","","identify-button","","",
> -       /*R0-R7*/       "","","ext-hightemp-n","",
> -                       "ocp-main-pwren","reset-button","","",
> -       /*S0-S7*/       "","","","","rtc-battery-voltage-read-enable","","","",
> +       /*Q0-Q7*/       "","","","","","identify-button","led-identify","",
> +       /*R0-R7*/       "","","ext-hightemp-n","","ocp-main-pwren","reset-button","","",
> +       /*S0-S7*/       "s0-vr-hot-n","s1-vr-hot-n","","",
> +                       "rtc-battery-voltage-read-enable","vr-pmbus-sel-n","","",
>         /*T0-T7*/       "","","","","","","","",
>         /*U0-U7*/       "","","","","","","","",
>         /*V0-V7*/       "","","","","","","","",
>         /*W0-W7*/       "","","","","","","","",
>         /*X0-X7*/       "","","","","","","","",
> -       /*Y0-Y7*/       "","","","","","","","",
> -       /*Z0-Z7*/       "s0-plimit","s1-fault-alert","s1-fw-boot-ok","","",
> +       /*Y0-Y7*/       "","","","bmc-vga-en-n","","","","",
> +       /*Z0-Z7*/       "s0-plimit","s1-fault-alert","s1-fw-boot-ok","s0-rtc-lock","",
>                         "s1-sys-auth-failure-n","s1-overtemp-n","",
>         /*AA0-AA7*/     "","","","","","","","",
> -       /*AB0-AB7*/     "s1-hightemp-n","s1-plimit","s0-ddr-addr",
> -                       "s1-ddr-addr","","","","",
> -       /*AC0-AC7*/     "sys-pwr-gd","","","","","","presence-cpu1",
> -                       "ocp-pgood";
> +       /*AB0-AB7*/     "s1-hightemp-n","s1-plimit","s0-ddr-addr","s1-ddr-addr","","",
> +                       "","",
> +       /*AC0-AC7*/     "sys-pwr-gd","","spi0-program-sel","spi0-backup-sel","bmc-ok",
> +                       "","presence-cpu1","ocp-pgood";
>
>         i2c4-o-en-hog {
>                 gpio-hog;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> index 2f571b43106d..b7c4f7cfad07 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> @@ -575,16 +575,17 @@
>         gpio-line-names =
>         /*A0-A7*/       "","","","","","i2c2-reset-n","i2c6-reset-n","i2c4-reset-n",
>         /*B0-B7*/       "","","","","host0-sysreset-n","host0-pmin-n","","",
> -       /*C0-C7*/       "s0-vrd-fault-n","s1-vrd-fault-n","","",
> +       /*C0-C7*/       "s0-vrd-fault-n","s1-vrd-fault-n","bmc-debug-mode","",
>                         "irq-n","","vrd-sel","spd-sel",
>         /*D0-D7*/       "presence-ps0","presence-ps1","hsc-12vmain-alt2-n","ext-high-temp-n",
>                         "","bmc-ncsi-txen","","",
> -       /*E0-E7*/       "","","clk50m-bmc-ncsi","","","","","",
> +       /*E0-E7*/       "","eth-phy-int-n","clk50m-bmc-ncsi","","","","","",
>         /*F0-F7*/       "s0-pcp-oc-warn-n","s1-pcp-oc-warn-n","power-chassis-control",
>                         "cpu-bios-recover","s0-heartbeat","hs-csout-prochot",
>                         "s0-vr-hot-n","s1-vr-hot-n",
>         /*G0-G7*/       "","","hsc-12vmain-alt1-n","","","","","",
> -       /*H0-H7*/       "","","wd-disable-n","power-chassis-good","","","","",
> +       /*H0-H7*/       "jtag-program-sel","fpga-program-b","wd-disable-n",
> +                       "power-chassis-good","","","","",
>         /*I0-I7*/       "","","","","","adc-sw","power-button","rtc-battery-voltage-read-enable",
>         /*J0-J7*/       "","","","","","","","",
>         /*K0-K7*/       "","","","","","","","",
> @@ -605,7 +606,7 @@
>         /*V0-V7*/       "s0-hightemp-n","s0-fault-alert","s0-sys-auth-failure-n",
>                         "host0-reboot-ack-n","s0-fw-boot-ok","host0-shd-req-n",
>                         "host0-shd-ack-n","s0-overtemp-n",
> -       /*W0-W7*/       "","ocp-main-pwren","ocp-pgood","",
> +       /*W0-W7*/       "ocp-aux-pwren","ocp-main-pwren","ocp-pgood","s1-pcp-pgood",
>                         "bmc-ok","bmc-ready","spi0-program-sel","spi0-backup-sel",
>         /*X0-X7*/       "i2c-backup-sel","s1-fault-alert","s1-fw-boot-ok",
>                         "s1-hightemp-n","s0-spi-auth-fail-n","s1-sys-auth-failure-n",
> --
> 2.17.1
>
