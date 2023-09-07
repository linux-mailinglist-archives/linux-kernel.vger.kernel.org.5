Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DA57977AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbjIGQbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239524AbjIGQbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:31:02 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E803783F1;
        Thu,  7 Sep 2023 09:30:17 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 387EEri6114119;
        Thu, 7 Sep 2023 09:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694096093;
        bh=qUmRYhqUi3o13Yp0ig9k9XqNy3bisRWn28iVTIPUuNk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=QX9Pg1GG3uqbcSBzJfYht3XXBH0ou/loSp/a2QoxObg8QpDtHK1PT3eZ5VLf64a6c
         47wbXldNRMxKzCU0MjDa2Ywp8L8f6E8KR/43wmWA7f5d2JcWDneaHsdeU2+pmYAGMr
         lM+0aZtYsYhBmbAQVhC6wV/TJTPoI8AoVzkLBdzc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 387EErP3027454
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Sep 2023 09:14:53 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 09:14:52 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 09:14:52 -0500
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 387EEmAB026360;
        Thu, 7 Sep 2023 09:14:49 -0500
Message-ID: <19f9895f-0975-713e-f2eb-fd5e16d6fb98@ti.com>
Date:   Thu, 7 Sep 2023 19:44:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 4/7] arm64: dts: ti: k3-j784s4-main: Add the main
 domain watchdog instances
To:     Keerthy <j-keerthy@ti.com>, <robh+dt@kernel.org>, <nm@ti.com>,
        <vigneshr@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <rzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230907115210.28082-1-j-keerthy@ti.com>
 <20230907115210.28082-5-j-keerthy@ti.com>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230907115210.28082-5-j-keerthy@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Keerthy,

On 9/7/2023 5:22 PM, Keerthy wrote:
> There are totally 19 instances of watchdog module. One each for the
> 8 A72 cores, one each for the 4 C7x cores, 1 for the GPU, 1 each
> for the 6 R5F cores in the main domain. Keeping only the A72 instances
> enabled and disabling the rest by default.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 182 +++++++++++++++++++++
>   1 file changed, 182 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index 7f7eab348520..66ab947a1081 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -1574,4 +1574,186 @@
>   		reg = <0x00 0x700000 0x00 0x1000>;
>   		ti,esm-pins = <688>, <689>;
>   	};
> +
> +	watchdog0: watchdog@2200000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2200000 0x00 0x100>;
> +		clocks = <&k3_clks 348 1>;
> +		power-domains = <&k3_pds 348 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 348 0>;
> +		assigned-clock-parents = <&k3_clks 348 4>;
> +	};

In ESM, patch I see only output of 2 watchdog in cascaded for reset.

if you want to keep enable other wdt, then IMO they should be able to 
reset the core/SOC

on timeout


> +
> +	[..]};
