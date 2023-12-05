Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C39D805E96
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345536AbjLETYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjLETYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:24:39 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A16AB;
        Tue,  5 Dec 2023 11:24:45 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5JOdwk083628;
        Tue, 5 Dec 2023 13:24:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701804279;
        bh=CugGYjygtP3a1bjNWWM8o75AxB6ThxiwybG+v9OdGec=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=mPM9GAsfYgV5Ovng6RfrX1r9SJZ91AGS7ffpieo7vsg7LiFbmdd2pNb//JXSzqlew
         CpKhdTdLi7D0pi+A/PS6Xfdlz3N0Oj/CyIuEzfQxKTIuLF3GLP9WKs8m4Vo1sTFgda
         lYx4WpQJUkJwqWs1M3EL6uU8n8w+FXxUQrEFfyL4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5JOdr4032684
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Dec 2023 13:24:39 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 13:24:38 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 13:24:38 -0600
Received: from [128.247.81.105] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5JOcTV017496;
        Tue, 5 Dec 2023 13:24:38 -0600
Message-ID: <231e173e-2452-401a-8c11-5b555da59a2b@ti.com>
Date:   Tue, 5 Dec 2023 13:24:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j721s2-main: Add Itap Delay Value
 For DDR50 speed mode
Content-Language: en-US
To:     Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <kristo@kernel.org>, <vigneshr@ti.com>,
        <nm@ti.com>
References: <20231201082045.790478-1-b-kapoor@ti.com>
 <20231201082045.790478-3-b-kapoor@ti.com>
From:   Judith Mendez <jm@ti.com>
In-Reply-To: <20231201082045.790478-3-b-kapoor@ti.com>
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
> DDR50 speed mode is enabled for MMCSD in J721s2 but its Itap Delay
> Value is not present in the device tree. Thus, add Itap Delay Value
> for MMCSD High Speed DDR which is DDR50 speed mode for J721s2 SoC
> according to datasheet for J721s2.
> 
> [+] Refer to : section 7.10.5.17.2 MMC1/2 - SD/SDIO Interface,  in
> 	J721s2 datasheet
> - https://www.ti.com/lit/ds/symlink/tda4vl-q1.pdf
> 

LGTM

Reviewed-by: Judith Mendez <jm@ti.com>

> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index b03731b53a26..e1255956288b 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -766,6 +766,7 @@ main_sdhci1: mmc@4fb0000 {
>   		ti,itap-del-sel-sd-hs = <0x0>;
>   		ti,itap-del-sel-sdr12 = <0x0>;
>   		ti,itap-del-sel-sdr25 = <0x0>;
> +		ti,itap-del-sel-ddr50 = <0x2>;
>   		ti,clkbuf-sel = <0x7>;
>   		ti,trm-icp = <0x8>;
>   		dma-coherent;

~ Judith
