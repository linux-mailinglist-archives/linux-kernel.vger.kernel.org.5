Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9CE77A4E7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 06:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjHMERn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Aug 2023 00:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHMERl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 00:17:41 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3A31709;
        Sat, 12 Aug 2023 21:17:43 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1bbc64f9a91so28965045ad.0;
        Sat, 12 Aug 2023 21:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691900263; x=1692505063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLMyURC53hwz5v812uK/eVgyKmTJ3lphiPgO1Kd5Ijk=;
        b=Ze0IS0a2WEEPa5yFFwg/xw1Gx3CZkKqC98q9DRtmAvB6nt5BVyeCOKRG3Rb9PZuCQG
         j4fudPePPoYXGNwSK4vZBxFqPk7sGd0xL4WtzlfbFCpnFqd8Ult2aRoF8q0HiOldVNv3
         GSf1dPXwVSMpJAaLhqQGkQP0l7pmk/OTvNjschh7jLuVkYtEzhg90sju+WQ9niZQR7zs
         4CogoSqHAg/1VBraqiWQKFD+gHkwXCEVYY7CGoLoS3VgNWNCS+e+Mpp6p7hLHWKniAfo
         /WtQcYhGpPhOvoqT5SOqzy4YPhIp155rR1GK7KY46ubhVpEYe1AlRRdCBbGuD+2t8XPB
         Im+g==
X-Gm-Message-State: AOJu0YwoKLRnZ7QunbJCHO9GBAEKnf2jrepvHKmb5ua+q40rmHY2fYxq
        m3tQRd9khyQXDif1UDH2NdoGA2FdFGIhxg==
X-Google-Smtp-Source: AGHT+IGgLaa53y/oKBPZbAc2Nor+ccqbY97Pi2b3cJGFPeCwKgtkzAIfv+mussVb5hjmM1wSAsjUYA==
X-Received: by 2002:a17:903:2ce:b0:1bc:66a3:9a4b with SMTP id s14-20020a17090302ce00b001bc66a39a4bmr7108530plk.5.1691900263046;
        Sat, 12 Aug 2023 21:17:43 -0700 (PDT)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com. [209.85.216.46])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902da8200b001bc7306d321sm6647508plx.282.2023.08.12.21.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 21:17:40 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-26b44247123so437281a91.2;
        Sat, 12 Aug 2023 21:17:39 -0700 (PDT)
X-Received: by 2002:a17:90a:8d0c:b0:263:f8e3:5a2a with SMTP id
 c12-20020a17090a8d0c00b00263f8e35a2amr5198981pjo.36.1691900259095; Sat, 12
 Aug 2023 21:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230807191952.2019208-1-contact@jookia.org>
In-Reply-To: <20230807191952.2019208-1-contact@jookia.org>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 13 Aug 2023 12:17:27 +0800
X-Gmail-Original-Message-ID: <CAGb2v66vqrNZ-ga-1O_bQ16BWXH=RmSHo2Kb+WHJyw-Nm1kWVg@mail.gmail.com>
Message-ID: <CAGb2v66vqrNZ-ga-1O_bQ16BWXH=RmSHo2Kb+WHJyw-Nm1kWVg@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: dts: allwinner: d1: Add CAN controller nodes
To:     John Watts <contact@jookia.org>
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 3:20 AM John Watts <contact@jookia.org> wrote:
>
> The Allwinner D1, T113 provide two CAN controllers that are variants
> of the R40 controller.
>
> I have tested support for these controllers on two boards:
>
> - A Lichee Panel RV 86 Panel running a D1 chip
> - A Mango Pi MQ Dual running a T113-s3 chip
>
> Both of these fully support both CAN controllers.
>
> Signed-off-by: John Watts <contact@jookia.org>
> ---
> Changes in v3:
> - Set default pinctrl for can controller
> - Moved can nodes to proper location
> - Moved can pins to proper location
>
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> index d59b4acf183a..24f2e70d5886 100644
> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> @@ -52,6 +52,18 @@ pio: pinctrl@2000000 {
>                         #gpio-cells = <3>;
>                         #interrupt-cells = <3>;
>
> +                       /omit-if-no-ref/

Just FYI this likely ends up doing nothing if you also have them
referenced through a default pinctrl setting. They end up always
referenced and always included. For the D1 series it looks like no
peripheral has default pinctrl setting given.

We can still keep it though. It would help when future chip variants
specify different pinmuxes.

> +                       can0_pins: can0-pins {
> +                               pins = "PB2", "PB3";
> +                               function = "can0";
> +                       };
> +
> +                       /omit-if-no-ref/
> +                       can1_pins: can1-pins {
> +                               pins = "PB4", "PB5";
> +                               function = "can1";
> +                       };
> +
>                         /omit-if-no-ref/
>                         clk_pg11_pin: clk-pg11-pin {
>                                 pins = "PG11";
> @@ -356,6 +368,28 @@ i2c3: i2c@2502c00 {
>                         #size-cells = <0>;
>                 };
>
> +               can0: can@2504000 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&can0_pins>;

The compatible string should be the first property. In other sunxi SoC dtsi
files, we put the pinctrl just before the "status" property if it's present
to specify a default pin muxing.

I can fix it up while applying.

ChenYu

> +                       compatible = "allwinner,sun20i-d1-can";
> +                       reg = <0x02504000 0x400>;
> +                       interrupts = <SOC_PERIPHERAL_IRQ(21) IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_CAN0>;
> +                       resets = <&ccu RST_BUS_CAN0>;
> +                       status = "disabled";
> +               };
> +
> +               can1: can@2504400 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&can1_pins>;
> +                       compatible = "allwinner,sun20i-d1-can";
> +                       reg = <0x02504400 0x400>;
> +                       interrupts = <SOC_PERIPHERAL_IRQ(22) IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_CAN1>;
> +                       resets = <&ccu RST_BUS_CAN1>;
> +                       status = "disabled";
> +               };
> +
>                 syscon: syscon@3000000 {
>                         compatible = "allwinner,sun20i-d1-system-control";
>                         reg = <0x3000000 0x1000>;
> --
> 2.41.0
>
>
