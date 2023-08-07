Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0340A772805
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjHGOj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbjHGOjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:39:54 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AFC10DC;
        Mon,  7 Aug 2023 07:39:53 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377EdjbC103320;
        Mon, 7 Aug 2023 09:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691419185;
        bh=Pdscr+L8AXKSfRRQhEG+qdRFZK3xiYzM0aAgIqYRUpE=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=Ostj3Ijg2bZf/IdmFcCrnRItGEmRX5ivYpVWtmJrgZAKXsa8tjUwY7O48L0Zus1yL
         /Z4AtfaqYh0UlEzne2K8pAQ+dX6394WcVcy6maKa71BfMRA6/fzYCM8i33M3OQqixa
         50/4qlhFxGXA4TsYPlv5W2bA8/f2dk5FEeLukFKg=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377EdjDZ073109
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 09:39:45 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 09:39:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 09:39:45 -0500
Received: from [10.24.69.141] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377EdfrR111634;
        Mon, 7 Aug 2023 09:39:42 -0500
Message-ID: <0d311099-a93e-4270-e78f-a464b7fcaa34@ti.com>
Date:   Mon, 7 Aug 2023 20:09:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j784s4-evm: Correct Pin mux offset
 for ospi
Content-Language: en-US
To:     Udit Kumar <u-kumar1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <t-konduru@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230802114126.162445-1-u-kumar1@ti.com>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20230802114126.162445-1-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Udit,

On 02/08/23 17:11, Udit Kumar wrote:
> After splitting wkup_pmx pin mux for J784S4 into four regions.
> Pin mux offset for OSPI nodes were not updated to align with new
> regions, due to this while setting ospi pin muxes out of range
> error was seen.
> 
> Pin mux offsets for OSPI nodes are corrected in this patch.
> 
> Fixes: 14462bd0b247 ("arm64: dts: ti: k3-j784s4: Fix wakeup pinmux range and pinctrl node offsets")
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Logs
> https://gist.github.com/uditkumarti/f3b1a5402f7202931a4b905f7d331502
> 
> Please apply patch https://lore.kernel.org/all/20230721082654.27036-1-tony@atomide.com/
> before this
> 
> Change log:
> 
> Change in v2
>   Changed name of pin mux to align with
>   https://lore.kernel.org/all/20230721082654.27036-1-tony@atomide.com/ patch
>   
> 
> v1: https://lore.kernel.org/all/20230801141920.3317697-1-u-kumar1@ti.com/
>  
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 29 +++++++++++++++---------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index 7ad152a1b90f..d594d233af87 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -379,21 +379,28 @@ J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D34) MCU_OSPI0_D5 */
>  			J784S4_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (E34) MCU_OSPI0_D6 */
>  			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (E33) MCU_OSPI0_D7 */
>  			J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
> -			J784S4_WKUP_IOPAD(0x03c, PIN_OUTPUT, 6) /* (C32) MCU_OSPI0_CSn3.MCU_OSPI0_ECC_FAIL */
> -			J784S4_WKUP_IOPAD(0x038, PIN_OUTPUT, 6) /* (B34) MCU_OSPI0_CSn2.MCU_OSPI0_RESET_OUT0 */
> +		>;
> +	};
> +};
> +
> +&wkup_pmx1 {
> +	mcu_fss0_ospi0_1_pins_default: mcu-fss0-ospi0-1-default-pins {
> +		pinctrl-single,pins = <
> +			J784S4_WKUP_IOPAD(0x004, PIN_OUTPUT, 6) /* (C32) MCU_OSPI0_ECC_FAIL */
> +			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 6) /* (B34) MCU_OSPI0_RESET_OUT0 */
>  		>;
>  	};
>  
>  	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-default-pins {
>  		pinctrl-single,pins = <
> -			J784S4_WKUP_IOPAD(0x040, PIN_OUTPUT, 0) /* (F32) MCU_OSPI1_CLK */
> -			J784S4_WKUP_IOPAD(0x05c, PIN_OUTPUT, 0) /* (G32) MCU_OSPI1_CSn0 */
> -			J784S4_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (E35) MCU_OSPI1_D0 */
> -			J784S4_WKUP_IOPAD(0x050, PIN_INPUT, 0) /* (D31) MCU_OSPI1_D1 */
> -			J784S4_WKUP_IOPAD(0x054, PIN_INPUT, 0) /* (G31) MCU_OSPI1_D2 */
> -			J784S4_WKUP_IOPAD(0x058, PIN_INPUT, 0) /* (F33) MCU_OSPI1_D3 */
> -			J784S4_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (F31) MCU_OSPI1_DQS */
> -			J784S4_WKUP_IOPAD(0x044, PIN_INPUT, 0) /* (C31) MCU_OSPI1_LBCLKO */
> +			J784S4_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (F32) MCU_OSPI1_CLK */
> +			J784S4_WKUP_IOPAD(0x024, PIN_OUTPUT, 0) /* (G32) MCU_OSPI1_CSn0 */
> +			J784S4_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (E35) MCU_OSPI1_D0 */
> +			J784S4_WKUP_IOPAD(0x018, PIN_INPUT, 0) /* (D31) MCU_OSPI1_D1 */
> +			J784S4_WKUP_IOPAD(0x01C, PIN_INPUT, 0) /* (G31) MCU_OSPI1_D2 */
> +			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (F33) MCU_OSPI1_D3 */
> +			J784S4_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (F31) MCU_OSPI1_DQS */
> +			J784S4_WKUP_IOPAD(0x00C, PIN_INPUT, 0) /* (C31) MCU_OSPI1_LBCLKO */

Thank you for the patch,

For OSPI functionality:

Tested-by: Vaishnav Achath <vaishnav.a@ti.com>

before: https://gist.github.com/vaishnavachath/c87275e53f6ae38bacc44c65ed09c733
(QSPI probe fails due to wrong pinmux)
after: https://gist.github.com/vaishnavachath/b5f6147cfae5218815aca94ec0dfd991
(both QSPI, OSPI is functional)

heads-up :
I see the following warnings for ADC:

```
 pinctrl-single 4301c068.pinctrl: mux offset out of range: 0x134 (0x120)
 pinctrl-single 4301c068.pinctrl: could not add functions for
mcu-adc0-default-pins 308x
pinctrl-single 4301c068.pinctrl: mux offset out of range: 0x154 (0x120)
pinctrl-single 4301c068.pinctrl: could not add functions for
mcu-adc1-default-pins 340x
```

mcu_adc0_pins_default and mcu_adc1_pins_default entries needs to have the
wkup_pmx2 base (0x68) subtracted to get the appropriate offsets, not sure if
there is already a patch addressing the same or should be part of this patch.

Thanks and Regards,
Vaishnav

>  		>;
>  	};
>  };
> @@ -437,7 +444,7 @@ &fss {
>  &ospi0 {
>  	status = "okay";
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
> +	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>, <&mcu_fss0_ospi0_1_pins_default>;
>  
>  	flash@0 {
>  		compatible = "jedec,spi-nor";
