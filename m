Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF70A805E9B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjLETZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjLETZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:25:55 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40F9A5;
        Tue,  5 Dec 2023 11:26:01 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5JPtWY047762;
        Tue, 5 Dec 2023 13:25:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701804355;
        bh=bYlpE9HnP+gA/nrT4c4wdCH6uG+lhxZDxBMWwHHaxZI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=u6Ec/AWdrmqlcVOKUn+yUohENuhng15L8VVdmgo3mAW4ATtuxPK5MmVEO4oMsNhSC
         Xb4SLLbOFyQj5/0Rnv7bf3nR71sYFVWjlciNCB/mKlee+F7cp6y5fATXy0inCqFMLg
         OmgQjU1OlkXT0jvQNERpFZXvAg7rBhhSYZzkD9Sk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5JPtTi033771
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Dec 2023 13:25:55 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 13:25:55 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 13:25:55 -0600
Received: from [128.247.81.105] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5JOcTW017496;
        Tue, 5 Dec 2023 13:25:55 -0600
Message-ID: <7291a4a5-9e8e-4d9f-9aea-f40e1fccc5f7@ti.com>
Date:   Tue, 5 Dec 2023 13:25:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j784s4-main: Add Itap Delay Value
 For DDR50 speed mode
Content-Language: en-US
To:     Bhavya Kapoor <b-kapoor@ti.com>, <devicetree@vger.kernel.org>
CC:     <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <kristo@kernel.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20231201082045.790478-1-b-kapoor@ti.com>
 <20231201082045.790478-4-b-kapoor@ti.com>
From:   Judith Mendez <jm@ti.com>
In-Reply-To: <20231201082045.790478-4-b-kapoor@ti.com>
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

Hi Bhavya,

On 12/1/23 2:20 AM, Bhavya Kapoor wrote:
> DDR50 speed mode is enabled for MMCSD in J784s4 but its Itap Delay
> Value is not present in the device tree. Thus, add Itap Delay Value
> for MMCSD High Speed DDR which is DDR50 speed mode for J784s4 SoC
> according to datasheet for J784s4.
> 
> [+] Refer to : section 7.10.5.17.2 MMC1/2 - SD/SDIO Interface, in
> 	J784s4 datasheet
> - https://www.ti.com/lit/ds/symlink/tda4vh-q1.pdf
> 

Also looks good. (:

Reviewed-by: Judith Mendez <jm@ti.com>

> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index d89bcddcfe3d..b9a2358b1459 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -712,6 +712,7 @@ main_sdhci1: mmc@4fb0000 {
>   		ti,itap-del-sel-sd-hs = <0x0>;
>   		ti,itap-del-sel-sdr12 = <0x0>;
>   		ti,itap-del-sel-sdr25 = <0x0>;
> +		ti,itap-del-sel-ddr50 = <0x2>;
>   		ti,clkbuf-sel = <0x7>;
>   		ti,trm-icp = <0x8>;
>   		dma-coherent;

~ Judith
