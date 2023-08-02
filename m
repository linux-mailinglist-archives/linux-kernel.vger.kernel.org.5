Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D3676C735
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjHBHmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjHBHmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:42:01 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF71558E;
        Wed,  2 Aug 2023 00:39:40 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3727dHAK050279;
        Wed, 2 Aug 2023 02:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690961957;
        bh=bDP2kNyEjVxzxNmAU+q69n/PULmGyk1CUDNcqUuOaUk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=M2AdgddxJGw1zP9WJVAI7gQGU3JHJPYt++mqZWoV9rkpisPMIIBXQjFESEYUSGmk+
         F/sVCPpCAVGWI2qz+JSdwBG+fh8V8prdrNd4JMRx/yS8N3IIC8546eZjqCvZG80xUP
         dI10gfBRIHK6ZvtyufebkSkpnUTEyYt3blDWg9FM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3727dHDB005081
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 02:39:17 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 02:39:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 02:39:16 -0500
Received: from [172.24.227.6] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3727dDYp124009;
        Wed, 2 Aug 2023 02:39:13 -0500
Message-ID: <ee725687-1b1a-3fdb-8aee-5ca49f59a874@ti.com>
Date:   Wed, 2 Aug 2023 13:09:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/5] arm64: dts: ti: k3-am62a7-sk: Drop i2c-1 to 100Khz
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230731-mcasp_am62a-v1-0-8bd137ffa8f1@ti.com>
 <20230731-mcasp_am62a-v1-3-8bd137ffa8f1@ti.com>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20230731-mcasp_am62a-v1-3-8bd137ffa8f1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/07/23 18:14, Jai Luthra wrote:
> The TLV320AIC3106 audio codec is interfaced on the i2c-1 bus. With the
> default rate of 400Khz the i2c register writes fail to sync:
> 
> [   36.026387] tlv320aic3x 1-001b: Unable to sync registers 0x16-0x16. -110
> [   38.101130] omap_i2c 20010000.i2c: controller timed out
> 
> Dropping the rate to 100Khz fixes the issue.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

> ---
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> index 9d34b8fe4ecb..752c2f640f63 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -338,7 +338,7 @@ &main_i2c1 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_i2c1_pins_default>;
> -	clock-frequency = <400000>;
> +	clock-frequency = <100000>;
>  
>  	exp1: gpio@22 {
>  		compatible = "ti,tca6424";
