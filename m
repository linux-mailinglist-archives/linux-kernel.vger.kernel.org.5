Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644A2805E93
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345880AbjLETXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345672AbjLETWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:22:50 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A6AD5B;
        Tue,  5 Dec 2023 11:22:53 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5JMjX3083391;
        Tue, 5 Dec 2023 13:22:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701804165;
        bh=tvDBIfqu8X2U8ro+9hqf91GBD7e6ox+0s2U0ZTC9ybY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=BhHr4aeYUxRM44ESh5Y0aidkdflorv4taWO3iI79Jsd0uly0dSaZPQLwrIqYHZIqR
         /Jqg9NjznWJ56vfOpDGsMSdI8rGaBN7nys3RhRTVl5HkCarmJHt3CV8eTkaWFr62yW
         9L4baQ/gKuPLbPf8q66ALSrg0DHdCnHhedWIFbyw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5JMjuI031625
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Dec 2023 13:22:45 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 13:22:45 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 13:22:45 -0600
Received: from [128.247.81.105] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5JMiZY015799;
        Tue, 5 Dec 2023 13:22:45 -0600
Message-ID: <f3b5cc05-9a68-4319-a7fe-963123ae82c5@ti.com>
Date:   Tue, 5 Dec 2023 13:22:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j7200-main: Add Itap Delay Value
 For DDR52 speed mode
Content-Language: en-US
To:     Bhavya Kapoor <b-kapoor@ti.com>, <devicetree@vger.kernel.org>
CC:     <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <kristo@kernel.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20231201082045.790478-1-b-kapoor@ti.com>
 <20231201082045.790478-2-b-kapoor@ti.com>
From:   Judith Mendez <jm@ti.com>
In-Reply-To: <20231201082045.790478-2-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhavya,

On 12/1/23 2:20 AM, Bhavya Kapoor wrote:
> DDR52 speed mode is enabled for eMMC in J7200 but its Itap Delay Value
> is not present in the device tree. Thus, add Itap Delay Value for eMMC
> High Speed DDR which is DDR52 speed mode for J7200 SoC according to
> datasheet for J7200.
> 
> [+] Refer to : section 7.9.5.16.1 MMCSD0 - eMMC Interface,  in
> 	J7200 datasheet
> - https://www.ti.com/lit/ds/symlink/dra821u-q1.pdf
> 

LGTM

Reviewed-by: Judith Mendez <jm@ti.com>

> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 264913f83287..39ce465c8e00 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -647,6 +647,7 @@ main_sdhci0: mmc@4f80000 {
>   		ti,otap-del-sel-hs400 = <0x5>;
>   		ti,itap-del-sel-legacy = <0x10>;
>   		ti,itap-del-sel-mmc-hs = <0xa>;
> +		ti,itap-del-sel-ddr52 = <0x3>;
>   		ti,strobe-sel = <0x77>;
>   		ti,clkbuf-sel = <0x7>;
>   		ti,trm-icp = <0x8>;

~ Judith
