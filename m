Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAD37B8588
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243478AbjJDQmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243471AbjJDQmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:42:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F6CBF;
        Wed,  4 Oct 2023 09:42:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ADAC433C8;
        Wed,  4 Oct 2023 16:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696437723;
        bh=cOSQJWllP4aYeJX1DUlmEFmmDtebjoyE+Tqkf1v/0ew=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qIkNqKjZ3ne+OHobmRB/I8FfEChqXmF9xIpUVdFROOgZMIDEk9QlH2SaJIcJSNDO7
         T4RKr6q9FmT0pC7oZVx9rI2qCyvB/O1WxKtX3RTZGqzu6EzORJiYaHlyIdZVrFYPxP
         XK7PzK9JsOuQQ74iGRUTZP9LOf1LOKgvfWhU4Gmw95/OT1gzuqMhayD7i5HF44f1iE
         HLfRrufLeGGhNEi+hoYUyUeaHlHNfa4dyP5gL0jmK8W5wqYaIO134lPv1V9u8icsZb
         7Cb5oXOKU+fv9A87QLn7oOjV11gDMgYO1dd4qXEDfS4nRoicBMfH+zZASrIo0mlUxM
         /QCTu4fpRUibg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-502e7d66c1eso37965e87.1;
        Wed, 04 Oct 2023 09:42:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YxLQw0FMCaVENycSR60qFyoAV0CTszJ68s7E9xgoUM2qF9sYVvh
        h+jv1dxLzSvTeQtBuKuINiRrLiy9LED/2/Yh6Q==
X-Google-Smtp-Source: AGHT+IF2TARL1jD5V/rUrVVE0E0RQH01x3eWrJhLlB24MSAvXT9vdGIheK7aaMZgUlf14HUt5HFHpPI2FCp7VCWhPTg=
X-Received: by 2002:a19:7114:0:b0:503:9eb:47f0 with SMTP id
 m20-20020a197114000000b0050309eb47f0mr2427204lfc.59.1696437721782; Wed, 04
 Oct 2023 09:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231004161038.2818327-1-gregory.clement@bootlin.com> <20231004161038.2818327-9-gregory.clement@bootlin.com>
In-Reply-To: <20231004161038.2818327-9-gregory.clement@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 4 Oct 2023 11:41:48 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Pn=kWFL32Cit-vnyJg2pnap2TMn4LPVr9nTmyK-FrZw@mail.gmail.com>
Message-ID: <CAL_Jsq+Pn=kWFL32Cit-vnyJg2pnap2TMn4LPVr9nTmyK-FrZw@mail.gmail.com>
Subject: Re: [PATCH 08/11] MIPS: mobileye: Add EyeQ5 dtsi
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 11:11=E2=80=AFAM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
>
> Add a device tree include file for the Mobileye EyeQ5 SoC.
>
> Based on the work of Slava Samsonov <stanislav.samsonov@intel.com>
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  arch/mips/boot/dts/Makefile                   |   1 +
>  arch/mips/boot/dts/mobileye/Makefile          |   4 +
>  .../boot/dts/mobileye/eyeq5-fixed-clocks.dtsi | 315 ++++++++++++++++++
>  arch/mips/boot/dts/mobileye/eyeq5.dtsi        | 138 ++++++++
>  4 files changed, 458 insertions(+)
>  create mode 100644 arch/mips/boot/dts/mobileye/Makefile
>  create mode 100644 arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
>  create mode 100644 arch/mips/boot/dts/mobileye/eyeq5.dtsi
>
> diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
> index 928f38a79dff..edb8e8dee758 100644
> --- a/arch/mips/boot/dts/Makefile
> +++ b/arch/mips/boot/dts/Makefile
> @@ -8,6 +8,7 @@ subdir-$(CONFIG_LANTIQ)                 +=3D lantiq
>  subdir-$(CONFIG_MACH_LOONGSON64)       +=3D loongson
>  subdir-$(CONFIG_SOC_VCOREIII)          +=3D mscc
>  subdir-$(CONFIG_MIPS_MALTA)            +=3D mti
> +subdir-$(CONFIG_SOC_EYEQ5)             +=3D mobileye
>  subdir-$(CONFIG_LEGACY_BOARD_SEAD3)    +=3D mti
>  subdir-$(CONFIG_FIT_IMAGE_FDT_NI169445)        +=3D ni
>  subdir-$(CONFIG_MACH_PIC32)            +=3D pic32
> diff --git a/arch/mips/boot/dts/mobileye/Makefile b/arch/mips/boot/dts/mo=
bileye/Makefile
> new file mode 100644
> index 000000000000..99c4124fd4c0
> --- /dev/null
> +++ b/arch/mips/boot/dts/mobileye/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Copyright 2023 Mobileye Vision Technologies Ltd.
> +
> +obj-$(CONFIG_BUILTIN_DTB)      +=3D $(addsuffix .o, $(dtb-y))

You didn't add anything to 'dtb-y'. Did you test this?

Also, CONFIG_BUILTIN_DTB is supposed to be for legacy bootloaders
which don't understand DT. For a new SoC, fix the bootloader.

> diff --git a/arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi b/arch/m=
ips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
> new file mode 100644
> index 000000000000..a0066465ac8b
> --- /dev/null
> +++ b/arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
> @@ -0,0 +1,315 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Copyright 2023 Mobileye Vision Technologies Ltd.
> + */

I assume these aren't all really fixed, but just 'I don't have a clock
driver yet'. That creates an ABI issue when you add the clock
driver(s). Just FYI.

> +
> +/ {
> +       /* Fixed clock */
> +       pll_cpu: pll_cpu {

Don't use _ in node names.

> +               compatible =3D "fixed-clock";
> +               #clock-cells =3D <0>;
> +               clock-frequency =3D <1500000000>;
> +       };
> +
> +       pll_vdi: pll_vdi {
> +               compatible =3D "fixed-clock";
> +               #clock-cells =3D <0>;
> +               clock-frequency =3D <1280000000>;
> +       };
> +
> +       pll_per: pll_per {
> +               compatible =3D "fixed-clock";
> +               #clock-cells =3D <0>;
> +               clock-frequency =3D <2000000000>;
> +       };
> +
> +       pll_ddr0: pll_ddr0 {
> +               compatible =3D "fixed-clock";
> +               #clock-cells =3D <0>;
> +               clock-frequency =3D <1857210000>;
> +       };
> +
> +       pll_ddr1: pll_ddr1 {
> +               compatible =3D "fixed-clock";
> +               #clock-cells =3D <0>;
> +               clock-frequency =3D <1857210000>;
> +       };
> +
> +/* PLL_CPU derivatives */
> +       occ_cpu: occ_cpu {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&pll_cpu>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "occ_cpu";

Isn't the default name the node name? Drop these unless you really
have a need and they aren't redundant.

> +       };
> +       si_css0_ref_clk: si_css0_ref_clk { /* gate ClkRstGen_si_css0_ref =
*/
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&occ_cpu>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "si_css0_ref_clk";
> +       };
> +       cpc_clk: cpc_clk {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&si_css0_ref_clk>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "cpc_clk";
> +       };
> +       core0_clk: core0_clk {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&si_css0_ref_clk>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "core0_clk";
> +       };
> +       core1_clk: core1_clk {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&si_css0_ref_clk>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "core1_clk";
> +       };
> +       core2_clk: core2_clk {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&si_css0_ref_clk>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "core2_clk";
> +       };
> +       core3_clk: core3_clk {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&si_css0_ref_clk>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "core3_clk";
> +       };
> +       cm_clk: cm_clk {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&si_css0_ref_clk>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "cm_clk";
> +       };
> +       mem_clk: mem_clk {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&si_css0_ref_clk>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "mem_clk";
> +       };
> +       occ_isram: occ_isram {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&pll_cpu>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <2>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "occ_isram";
> +       };
> +       isram_clk: isram_clk { /* gate ClkRstGen_isram */
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&occ_isram>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "isram_clk";
> +       };
> +       occ_dbu: occ_dbu {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&pll_cpu>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <10>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "occ_dbu";
> +       };
> +       si_dbu_tp_pclk: si_dbu_tp_pclk { /* gate ClkRstGen_dbu */
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&occ_dbu>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "si_dbu_tp_pclk";
> +       };
> +/* PLL_VDI derivatives */
> +       occ_vdi: occ_vdi {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&pll_vdi>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <2>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "occ_vdi";
> +       };
> +       vdi_clk: vdi_clk { /* gate ClkRstGen_vdi */
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&occ_vdi>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "vdi_clk";
> +       };
> +       occ_can_ser: occ_can_ser {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&pll_vdi>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <16>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "occ_can_ser";
> +       };
> +       can_ser_clk: can_ser_clk { /* gate ClkRstGen_can_ser */
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&occ_can_ser>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "can_ser_clk";
> +       };
> +       i2c_ser_clk: i2c_ser_clk {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&pll_vdi>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <20>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "i2c_ser_clk";
> +       };
> +/* PLL_PER derivatives */
> +       occ_periph: occ_periph {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&pll_per>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <16>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "occ_periph";
> +       };
> +       periph_clk: periph_clk {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&occ_periph>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "periph_clk";
> +       };
> +       can_clk: can_clk {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&occ_periph>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "can_clk";
> +       };
> +       spi_clk: spi_clk {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&occ_periph>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "spi_clk";
> +       };
> +       uart_clk: uart_clk {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&occ_periph>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "uart_clk";
> +       };
> +       i2c_clk: i2c_clk {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&occ_periph>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "i2c_clk";
> +       };
> +       timer_clk: timer_clk {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&occ_periph>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "timer_clk";
> +       };
> +       gpio_clk: gpio_clk {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&occ_periph>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "gpio_clk";
> +       };
> +       emmc_sys_clk: emmc_sys_clk {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&pll_per>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <10>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "emmc_sys_clk";
> +       };
> +       ccf_ctrl_clk: ccf_ctrl_clk {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&pll_per>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <4>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "ccf_ctrl_clk";
> +       };
> +       occ_mjpeg_core: occ_mjpeg_core {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&pll_per>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <2>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "occ_mjpeg_core";
> +       };
> +       hsm_clk: hsm_clk { /* gate ClkRstGen_hsm */
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&occ_mjpeg_core>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "hsm_clk";
> +       };
> +       mjpeg_core_clk: mjpeg_core_clk { /* gate ClkRstGen_mjpeg_gen */
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&occ_mjpeg_core>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <1>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "mjpeg_core_clk";
> +       };
> +       fcmu_a_clk: fcmu_a_clk {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&pll_per>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <20>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "fcmu_a_clk";
> +       };
> +       occ_pci_sys: occ_pci_sys {
> +               compatible =3D "fixed-factor-clock";
> +               clocks =3D <&pll_per>;
> +               #clock-cells =3D <0>;
> +               clock-div =3D <8>;
> +               clock-mult =3D <1>;
> +               clock-output-names =3D "occ_pci_sys";
> +       };
> +       pclk: pclk {
> +               compatible =3D "fixed-clock";
> +               #clock-cells =3D <0>;
> +               clock-frequency =3D <250000000>;  /* 250MHz */
> +       };
> +       tsu_clk: tsu_clk {
> +               compatible =3D "fixed-clock";
> +               #clock-cells =3D <0>;
> +               clock-frequency =3D <125000000>;  /* 125MHz */
> +       };
> +};
> diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/=
mobileye/eyeq5.dtsi
> new file mode 100644
> index 000000000000..0504c2fb3ad5
> --- /dev/null
> +++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0

Doesn't match eyeq5-fixed-clocks.dtsi

> +/*
> + * Copyright 2023 Mobileye Vision Technologies Ltd.
> + */
> +
> +#include <dt-bindings/interrupt-controller/mips-gic.h>
> +#include <dt-bindings/soc/mobileye,eyeq5.h>
> +
> +/memreserve/ 0x40000000 0xc0000000; /* DDR32 */
> +/memreserve/ 0x08000000 0x08000000; /* DDR_LOW */
> +
> +#include "eyeq5-fixed-clocks.dtsi"
> +
> +/* almost all GIC IRQs has the same characteristics. provide short form =
*/

Maybe so, but I prefer not having 2 levels of lookup to figure out values.

> +#define GIC_IRQ(x) GIC_SHARED (x) IRQ_TYPE_LEVEL_HIGH
> +
> +/ {
> +       #address-cells =3D <2>;
> +       #size-cells =3D <2>;
> +       cpus {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +               cpu@0 {
> +                       device_type =3D "cpu";
> +                       compatible =3D "mti,i6500";
> +                       reg =3D <0>;
> +                       clocks =3D <&core0_clk>;
> +               };
> +       };
> +
> +       reserved-memory {
> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;
> +               ranges;
> +
> +/* These reserved memory regions are also defined in bootmanager
> + * for configuring inbound translation for BARS, don't change
> + * these without syncing with bootmanager
> + */

Indent with the rest of the node.

> +               shmem0_reserved: shmem@804000000 {
> +                       reg =3D <0x8 0x04000000 0x0 0x1000000>;
> +               };
> +               shmem1_reserved: shmem@805000000 {
> +                       reg =3D <0x8 0x05000000 0x0 0x1000000>;
> +               };
> +               pci0_msi_reserved: pci0_msi@806000000 {
> +                       reg =3D <0x8 0x06000000 0x0 0x100000>;
> +               };
> +               pci1_msi_reserved: pci1_msi@806100000 {
> +                       reg =3D <0x8 0x06100000 0x0 0x100000>;
> +               };
> +
> +               mini_coredump0_reserved: mini_coredump0@806200000 {
> +                       reg =3D <0x8 0x06200000 0x0 0x100000>;
> +               };
> +               mhm_reserved_0: the_mhm_reserved_0@0 {
> +                       reg =3D <0x8 0x00000000 0x0 0x0000800>;
> +               };
> +       };
> +
> +       aliases {
> +               serial0 =3D &uart0;
> +               serial1 =3D &uart1;
> +               serial2 =3D &uart2;
> +       };
> +
> +       cpu_intc: interrupt-controller {
> +               compatible =3D "mti,cpu-interrupt-controller";
> +               interrupt-controller;
> +               #address-cells =3D <0>;
> +               #interrupt-cells =3D <1>;
> +       };
> +
> +       gic: interrupt-controller@140000 {
> +               compatible =3D "mti,gic";
> +               reg =3D <0x0 0x140000 0x0 0x20000>;
> +               interrupt-controller;
> +               #interrupt-cells =3D <3>;
> +
> +               /*
> +                * Declare the interrupt-parent even though the mti,gic
> +                * binding doesn't require it, such that the kernel can
> +                * figure out that cpu_intc is the root interrupt
> +                * controller & should be probed first.
> +                */
> +               interrupt-parent =3D <&cpu_intc>;
> +
> +               timer {
> +                       compatible =3D "mti,gic-timer";
> +                       interrupts =3D <GIC_LOCAL 1 IRQ_TYPE_NONE>;
> +                       clocks =3D <&core0_clk>;
> +               };
> +       };
> +
> +       soc: soc {
> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;
> +               ranges;
> +               compatible =3D "simple-bus";
> +
> +               uart0: serial@800000 {
> +                       compatible =3D "arm,pl011", "arm,primecell";
> +                       reg =3D <0 0x800000 0x0 0x1000>;
> +                       reg-io-width =3D <4>;
> +                       interrupt-parent =3D <&gic>;
> +                       interrupts =3D <GIC_IRQ(NUM_INT_UART)>;
> +                       clocks  =3D <&uart_clk>, <&occ_periph>;
> +                       clock-names =3D "uartclk", "apb_pclk";
> +               };
> +
> +               uart1: serial@900000 {
> +                       compatible =3D "arm,pl011", "arm,primecell";
> +                       reg =3D <0 0x900000 0x0 0x1000>;
> +                       reg-io-width =3D <4>;
> +                       interrupt-parent =3D <&gic>;
> +                       interrupts =3D <GIC_IRQ(NUM_INT_UART)>;
> +                       clocks  =3D <&uart_clk>, <&occ_periph>;
> +                       clock-names =3D "uartclk", "apb_pclk";
> +               };
> +
> +               uart2: serial@a00000 {
> +                       compatible =3D "arm,pl011", "arm,primecell";
> +                       reg =3D <0 0xa00000 0x0 0x1000>;
> +                       reg-io-width =3D <4>;
> +                       interrupt-parent =3D <&gic>;
> +                       interrupts =3D <GIC_IRQ(NUM_INT_UART)>;
> +                       clocks  =3D <&uart_clk>, <&occ_periph>;
> +                       clock-names =3D "uartclk", "apb_pclk";
> +               };
> +
> +               olb: olb@e00000 {
> +                       compatible =3D "mobileye,eyeq5-olb", "syscon", "s=
imple-mfd";
> +                       reg =3D <0 0xe00000 0x0 0x400>;
> +                       reg-io-width =3D <4>;
> +               };
> +
> +       };
> +};
> --
> 2.40.1
>
