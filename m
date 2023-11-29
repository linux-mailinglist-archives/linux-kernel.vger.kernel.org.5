Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3131D7FCB53
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 01:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376671AbjK2A3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 19:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjK2A3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 19:29:32 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5B219A6;
        Tue, 28 Nov 2023 16:29:38 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AT0TTVd097584;
        Tue, 28 Nov 2023 18:29:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701217769;
        bh=HZosp7dUjaD8MSCFnG545oHLY5nwo3YleaoBTIo+AbE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=jY1U8+LoZWXeMTa96nUz7xDJ5Ol8TS1KYqCI9ctIII4jCxBRMX3Yr4ZB3liNIzW67
         x1phhyjMjFnWSi72WUiosVNTeA+N//IiME2e6cG0lYn9f4yVY5awA4F1D5R8YNgdv9
         IlmmtJBr3UqTRFHv3ombKyc6e+i8n6WxBXaCi9dY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AT0TTrZ014511
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Nov 2023 18:29:29 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 18:29:28 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 18:29:28 -0600
Received: from [128.247.81.105] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AT0TS46011708;
        Tue, 28 Nov 2023 18:29:28 -0600
Message-ID: <17c8fc07-78cd-4fea-ba76-bcfdd5d830b9@ti.com>
Date:   Tue, 28 Nov 2023 18:29:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-am62a7-sk: Enable eMMC support
To:     Nitin Yadav <n-yadav@ti.com>, <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
References: <20231030063108.1242981-1-n-yadav@ti.com>
 <20231030063108.1242981-3-n-yadav@ti.com>
Content-Language: en-US
From:   Judith Mendez <jm@ti.com>
In-Reply-To: <20231030063108.1242981-3-n-yadav@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/23 1:31 AM, Nitin Yadav wrote:
> Add support for 32GB eMMC card on AM62A7 SK. Includes adding mmc0
> pins settings. Add mmc0 alias for sdhci0 in k3-am62a7-sk.dts.
> 

This looks good to me. Although should it be explained why we are 
including pinmux for MMC0?

Reviewed-by: Judith Mendez <jm@ti.com>

> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> index cff283c75f8e..c6f144d91734 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -20,6 +20,7 @@ aliases {
>   		serial0 = &wkup_uart0;
>   		serial2 = &main_uart0;
>   		serial3 = &main_uart1;
> +		mmc0 = &sdhci0;
>   		mmc1 = &sdhci1;
>   	};
>   
> @@ -172,6 +173,22 @@ AM62AX_IOPAD(0x0b4, PIN_INPUT_PULLUP, 1) /* (K24) GPMC0_CSn3.I2C2_SDA */
>   		>;
>   	};
>   
> +	main_mmc0_pins_default: main-mmc0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62AX_IOPAD(0x220, PIN_INPUT, 0) /* (Y3) MMC0_CMD */
> +			AM62AX_IOPAD(0x218, PIN_INPUT, 0) /* (AB1) MMC0_CLKLB */
> +			AM62AX_IOPAD(0x21c, PIN_INPUT, 0) /* (AB1) MMC0_CLK */
> +			AM62AX_IOPAD(0x214, PIN_INPUT, 0) /* (AA2) MMC0_DAT0 */
> +			AM62AX_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (AA1) MMC0_DAT1 */
> +			AM62AX_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (AA3) MMC0_DAT2 */
> +			AM62AX_IOPAD(0x208, PIN_INPUT_PULLUP, 0) /* (Y4) MMC0_DAT3 */
> +			AM62AX_IOPAD(0x204, PIN_INPUT_PULLUP, 0) /* (AB2) MMC0_DAT4 */
> +			AM62AX_IOPAD(0x200, PIN_INPUT_PULLUP, 0) /* (AC1) MMC0_DAT5 */
> +			AM62AX_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (AD2) MMC0_DAT6 */
> +			AM62AX_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AC2) MMC0_DAT7 */
> +		>;
> +	};
> +
>   	main_mmc1_pins_default: main-mmc1-default-pins {
>   		pinctrl-single,pins = <
>   			AM62AX_IOPAD(0x23c, PIN_INPUT, 0) /* (A21) MMC1_CMD */
> @@ -361,3 +378,11 @@ cpsw3g_phy0: ethernet-phy@0 {
>   		ti,min-output-impedance;
>   	};
>   };
> +
> +&sdhci0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mmc0_pins_default>;
> +	ti,driver-strength-ohm = <50>;
> +	disable-wp;
> +};

