Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F92781CC3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 09:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjHTHBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 03:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjHTHAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 03:00:54 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F274AD13;
        Sat, 19 Aug 2023 23:37:52 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37K6bbf2055129;
        Sun, 20 Aug 2023 01:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692513457;
        bh=4FxO5OiLuFuHbomK4Axh4ZRSnQjdFwdTtS5KY7rEKrY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=HLNs1l/4BoHy2RWOGz78lZ2S3Te3q0iiDsRdnbyF0mJVBeYJLUnL8m8WKxnTu4rrY
         8VPl81uShWkXLyvIJQbXcKBMhOljjA6kDRDffiRJVFcnPkmQELrGSiyPDnk9n69pPJ
         XfLiX9cJtjMikyRRmiDYlZsloH5yzdA+UigELdJ4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37K6bbIT009510
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 20 Aug 2023 01:37:37 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 20
 Aug 2023 01:37:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 20 Aug 2023 01:37:37 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37K6bXuw095373;
        Sun, 20 Aug 2023 01:37:34 -0500
Message-ID: <d08b4f70-7bc1-df4b-349c-34b166c433ec@ti.com>
Date:   Sun, 20 Aug 2023 12:07:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j784s4-evm: Add support for MCAN
 interfaces
To:     Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20230817084936.31020-1-b-kapoor@ti.com>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230817084936.31020-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for patch

On 8/17/2023 2:19 PM, Bhavya Kapoor wrote:
> There are 2 MCAN instances in the mcu domain and 4 MCAN instances in the
> main domain. Add support for both MCAN nodes present in the mcu domain
> and MCAN16 that is present in the main domain and isn't muxed.

Could you add  description in commit message, why only 3 MCAN are 
enabled in this patch

despite of 6 available.

>
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
>
> Changelog v1->v2:
>   - Fixed issue with referencing mcu_mcan0 node that was causeing errors
>
> Link to v1 : https://lore.kernel.org/all/20230816193533.25722-1-b-kapoor@ti.com/
>
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 87 ++++++++++++++++++++++++
>   1 file changed, 87 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index 430b8a2c5df5..9fce3ce89507 100644
> [...]
> +	mcu_mcan1_pins_default: mcu-mcan1-default-pins {
> +		pinctrl-single,pins = <
> +			J784S4_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (H35) WKUP_GPIO0_4.MCU_MCAN1_TX */
> +			J784S4_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (K36) WKUP_GPIO0_5.MCU_MCAN1_RX */
> +		>;

You can consider to drop pre-fix in GPIO details through out the patch

eg WKUP_GPIO0_5.MCU_MCAN1_RX to MCU_MCAN1_RX


> +	};
> +
> +	mcu_mcan0_gpio_pins_default: mcu-mcan0-gpio-default-pins {
> +		pinctrl-single,pins = <
> +			J784S4_WKUP_IOPAD(0x040, PIN_INPUT, 7) /* (J38) MCU_SPI0_D1.WKUP_GPIO0_69 */
> +		>;
> +	};
> +
> +	mcu_mcan1_gpio_pins_default: mcu-mcan1-gpio-default-pins {
> +		pinctrl-single,pins = <
> +			J784S4_WKUP_IOPAD(0x060, PIN_INPUT, 7) /* (J35) WKUP_GPIO0_2 */
> +		>;
> +	};
>   };
>   
>   &wkup_pmx0 {
> @@ -827,3 +885,32 @@ adc {
>   		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>   	};
>   };
> +
> +&wkup_gpio_intr {
> +	status = "okay";
> +};
> +
> +&wkup_gpio0 {
> +	status = "okay";
> +};
> +
> +&mcu_mcan0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_mcan0_pins_default>;
> +	phys = <&transceiver1>;
> +};
> +
> +&mcu_mcan1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_mcan1_pins_default>;
> +	phys = <&transceiver2>;
> +};
> +
> +&main_mcan16 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan16_pins_default>;
> +	phys = <&transceiver3>;
> +};
