Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2488F7B6059
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 07:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjJCFYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 01:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjJCFYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 01:24:38 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3F3AC;
        Mon,  2 Oct 2023 22:24:34 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3935OHkU003026;
        Tue, 3 Oct 2023 00:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696310657;
        bh=z13FM/FhQO9TGboXVWTOAYm2uOxotLYexsVKcrzQFBc=;
        h=Date:From:Subject:To:CC:References:In-Reply-To;
        b=d1kK7YDrDZGfmnISe3fv+NTSb8RWGQMBtTaXRwNPSokZub6Tb/83lWlye8gbXp7nk
         AUl5Mo0ERqUrMlXI5jq17b027sKuLlQOKtWxX9OxmWarJ2gnOyIFEkboSKuxmNR6oK
         Gqh8wUyQxGpE2CN6bB87HD8tG4vnygl3Kom1LloU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3935OH2a015400
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Oct 2023 00:24:17 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 00:24:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 00:24:17 -0500
Received: from [172.24.227.252] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3935OCjv094166;
        Tue, 3 Oct 2023 00:24:13 -0500
Message-ID: <1ad3087c-c9aa-9a67-46c7-4969c97041d8@ti.com>
Date:   Tue, 3 Oct 2023 10:54:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Aradhya Bhatia <a-bhatia1@ti.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: ti: k3-am62a7-sk: Drop i2c-1 to 100Khz
To:     Jai Luthra <j-luthra@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devarsht@ti.com>
References: <20230928-mcasp_am62a-v2-0-ce9f0e1ba22b@ti.com>
 <20230928-mcasp_am62a-v2-3-ce9f0e1ba22b@ti.com>
Content-Language: en-US
In-Reply-To: <20230928-mcasp_am62a-v2-3-ce9f0e1ba22b@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28-Sep-23 14:54, Jai Luthra wrote:
> The TLV320AIC3106 audio codec is interfaced on the i2c-1 bus. With the
> default rate of 400Khz the i2c register writes fail to sync:
> 
> [   36.026387] tlv320aic3x 1-001b: Unable to sync registers 0x16-0x16. -110
> [   38.101130] omap_i2c 20010000.i2c: controller timed out
> 
> Dropping the rate to 100Khz fixes the issue.
> 
> Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>

Since the codec wouldn't have worked with the 400KHz, the initial DT
configuration is wrong, which makes this patch a fix, and should be
indicated as such.

With the Fixes tag added,

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

Regards
Aradhya

> ---
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> index c689d3da2def..866b2725f775 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -261,7 +261,7 @@ &main_i2c1 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_i2c1_pins_default>;
> -	clock-frequency = <400000>;
> +	clock-frequency = <100000>;
>  
>  	exp1: gpio@22 {
>  		compatible = "ti,tca6424";
> 

