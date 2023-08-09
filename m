Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E5A776631
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjHIROE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHIROC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:14:02 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C171C1FFA;
        Wed,  9 Aug 2023 10:14:01 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379HDsa4110392;
        Wed, 9 Aug 2023 12:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691601234;
        bh=w6glHYm10JaDlR9DAR+uL65bVLB/pv8hB6bKGREf9eY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Vi5jnn+8reFP9YuirXyyfEESN5meEhl2EpdS1TcfsRCZVW8wMXPYLt0LDIOrlC+Rz
         r4bk9AIF9CeJYpqQPh/6Geei1ciUQpO7BJNFC+FUfqLhfMa7hpT7RYdK4YbTAGW9HP
         rM471TaC/EBqQQ83m0hfUri4jrGQvCvr3ouspb7w=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379HDsJa113751
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 12:13:54 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 12:13:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 12:13:54 -0500
Received: from [10.24.69.141] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379HDosS008249;
        Wed, 9 Aug 2023 12:13:51 -0500
Message-ID: <46594a4d-d61f-b374-9ea5-78022d99c3db@ti.com>
Date:   Wed, 9 Aug 2023 22:43:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-evm: Correct Pin mux offset for
 ADC
Content-Language: en-US
To:     Udit Kumar <u-kumar1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <t-konduru@ti.com>, <b-kapoor@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230809050108.751164-1-u-kumar1@ti.com>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20230809050108.751164-1-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Udit,

On 09/08/23 10:31, Udit Kumar wrote:
> After splitting wkup_pmx pin mux for J784S4 into four regions.
> Pin mux offset for ADC nodes were not updated to align with new
> regions, due to this while probing ADC driver out of range
> error was seen.
> 
> Pin mux offsets for ADC nodes are corrected in this patch.
> 
> Fixes: 14462bd0b247 ("arm64: dts: ti: k3-j784s4: Fix wakeup pinmux range and pinctrl node offsets")
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Reviewed pin mux for J784S4-EVM, AM69, J721S2-EVM and AM68
> ADC seems to be last one to be fixed.
> 
> In order to test this patch
> following drivers were built in as part of kernel
> CONFIG_MFD_TI_AM335X_TSCADC=y
> CONFIG_TI_AM335X_ADC=y
> 
> dtbs_check is done after applying
> https://lore.kernel.org/all/20230721082654.27036-1-tony@atomide.com/
> 
> logs with patch
> https://gist.github.com/uditkumarti/54db4d5e49467442e1698e5af82d787b#file-with_patch
> (line 1128 and 1130)
> 
> Original logs
> https://gist.github.com/uditkumarti/54db4d5e49467442e1698e5af82d787b#file-original_logs
> (line 942 and 946)
> 
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 32 ++++++++++++------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index edc1009b2d1e..b4ffa720209c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -340,27 +340,27 @@ J784S4_WKUP_IOPAD(0x030, PIN_INPUT, 0) /* (B35) MCU_MDIO0_MDIO */
>  
>  	mcu_adc0_pins_default: mcu-adc0-default-pins {
>  		pinctrl-single,pins = <
> -			J784S4_WKUP_IOPAD(0x134, PIN_INPUT, 0) /* (P36) MCU_ADC0_AIN0 */
> -			J784S4_WKUP_IOPAD(0x138, PIN_INPUT, 0) /* (V36) MCU_ADC0_AIN1 */
> -			J784S4_WKUP_IOPAD(0x13c, PIN_INPUT, 0) /* (T34) MCU_ADC0_AIN2 */
> -			J784S4_WKUP_IOPAD(0x140, PIN_INPUT, 0) /* (T36) MCU_ADC0_AIN3 */
> -			J784S4_WKUP_IOPAD(0x144, PIN_INPUT, 0) /* (P34) MCU_ADC0_AIN4 */
> -			J784S4_WKUP_IOPAD(0x148, PIN_INPUT, 0) /* (R37) MCU_ADC0_AIN5 */
> -			J784S4_WKUP_IOPAD(0x14c, PIN_INPUT, 0) /* (R33) MCU_ADC0_AIN6 */
> -			J784S4_WKUP_IOPAD(0x150, PIN_INPUT, 0) /* (V38) MCU_ADC0_AIN7 */
> +			J784S4_WKUP_IOPAD(0x0cc, PIN_INPUT, 0) /* (P36) MCU_ADC0_AIN0 */
> +			J784S4_WKUP_IOPAD(0x0d0, PIN_INPUT, 0) /* (V36) MCU_ADC0_AIN1 */
> +			J784S4_WKUP_IOPAD(0x0d4, PIN_INPUT, 0) /* (T34) MCU_ADC0_AIN2 */
> +			J784S4_WKUP_IOPAD(0x0d8, PIN_INPUT, 0) /* (T36) MCU_ADC0_AIN3 */
> +			J784S4_WKUP_IOPAD(0x0dc, PIN_INPUT, 0) /* (P34) MCU_ADC0_AIN4 */
> +			J784S4_WKUP_IOPAD(0x0e0, PIN_INPUT, 0) /* (R37) MCU_ADC0_AIN5 */
> +			J784S4_WKUP_IOPAD(0x0e4, PIN_INPUT, 0) /* (R33) MCU_ADC0_AIN6 */
> +			J784S4_WKUP_IOPAD(0x0e8, PIN_INPUT, 0) /* (V38) MCU_ADC0_AIN7 */
>  		>;
>  	};
>  
>  	mcu_adc1_pins_default: mcu-adc1-default-pins {
>  		pinctrl-single,pins = <
> -			J784S4_WKUP_IOPAD(0x154, PIN_INPUT, 0) /* (Y38) MCU_ADC1_AIN0 */
> -			J784S4_WKUP_IOPAD(0x158, PIN_INPUT, 0) /* (Y34) MCU_ADC1_AIN1 */
> -			J784S4_WKUP_IOPAD(0x15c, PIN_INPUT, 0) /* (V34) MCU_ADC1_AIN2 */
> -			J784S4_WKUP_IOPAD(0x160, PIN_INPUT, 0) /* (W37) MCU_ADC1_AIN3 */
> -			J784S4_WKUP_IOPAD(0x164, PIN_INPUT, 0) /* (AA37) MCU_ADC1_AIN4 */
> -			J784S4_WKUP_IOPAD(0x168, PIN_INPUT, 0) /* (W33) MCU_ADC1_AIN5 */
> -			J784S4_WKUP_IOPAD(0x16c, PIN_INPUT, 0) /* (U33) MCU_ADC1_AIN6 */
> -			J784S4_WKUP_IOPAD(0x170, PIN_INPUT, 0) /* (Y36) MCU_ADC1_AIN7 */
> +			J784S4_WKUP_IOPAD(0x0ec, PIN_INPUT, 0) /* (Y38) MCU_ADC1_AIN0 */
> +			J784S4_WKUP_IOPAD(0x0f0, PIN_INPUT, 0) /* (Y34) MCU_ADC1_AIN1 */
> +			J784S4_WKUP_IOPAD(0x0f4, PIN_INPUT, 0) /* (V34) MCU_ADC1_AIN2 */
> +			J784S4_WKUP_IOPAD(0x0f8, PIN_INPUT, 0) /* (W37) MCU_ADC1_AIN3 */
> +			J784S4_WKUP_IOPAD(0x0fc, PIN_INPUT, 0) /* (AA37) MCU_ADC1_AIN4 */
> +			J784S4_WKUP_IOPAD(0x100, PIN_INPUT, 0) /* (W33) MCU_ADC1_AIN5 */
> +			J784S4_WKUP_IOPAD(0x104, PIN_INPUT, 0) /* (U33) MCU_ADC1_AIN6 */
> +			J784S4_WKUP_IOPAD(0x108, PIN_INPUT, 0) /* (Y36) MCU_ADC1_AIN7 */

Thank you for the fix,

Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>

Thanks and Regards,
Vaishnav


>  		>;
>  	};
>  };
