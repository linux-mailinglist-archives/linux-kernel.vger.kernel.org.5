Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153B57B9981
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244298AbjJEBQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjJEBQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:16:21 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCAEC1;
        Wed,  4 Oct 2023 18:16:18 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3951G4QN086516;
        Wed, 4 Oct 2023 20:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696468564;
        bh=hW3Dg2bx6YNATnw4Obawt6fVr9h1jB+mZx/L564nxWI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=L0su/mu2OOwFeW6L15A1jUWAqU0WJ97V4f+RGDx2RajdVelxAtZ0fgXXM9pK9ObVJ
         idbiXwZXSdi79Ps7Ejyn5e4CEAesxEtSAv+pjBNP/V+Yl//5SQ/Sm9USU9o4qZWQNz
         KaOtQGhWm0gXj5dza3GgYlWCMWy3rlDCG3+TWmHY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3951G4QE107757
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Oct 2023 20:16:04 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Oct 2023 20:16:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Oct 2023 20:16:03 -0500
Received: from [10.249.131.134] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3951FQMb058551;
        Wed, 4 Oct 2023 20:16:00 -0500
Message-ID: <7d0ac872-96fd-440e-a16f-e0aa142b18cd@ti.com>
Date:   Thu, 5 Oct 2023 06:45:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] arm64: dts: ti: k3-j721s2: Add ESM instances
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <u-kumar1@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230927023357.9883-1-j-keerthy@ti.com>
 <20230927023357.9883-2-j-keerthy@ti.com>
 <4b89a45e-d68d-f1f7-4681-63be972c52cf@ti.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <4b89a45e-d68d-f1f7-4681-63be972c52cf@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/2023 12:20 PM, Vignesh Raghavendra wrote:
> 
> 
> On 27/09/23 08:03, Keerthy wrote:
>> Patch adds the ESM instances for j721s2. It has 3 instances.
>> One in the main domain and two in the mcu-wakeup domian.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi       |  7 +++++++
>>   arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 14 ++++++++++++++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> index 084f8f5b6699..8a717b592238 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> @@ -1695,4 +1695,11 @@
>>   		dss_ports: ports {
>>   		};
>>   	};
>> +
>> +	main_esm: esm@700000 {
>> +		compatible = "ti,j721e-esm";
>> +		reg = <0x00 0x700000 0x00 0x1000>;
>> +		ti,esm-pins = <688>, <689>;
>> +		bootph-pre-ram;
> 
> 
> Similar to other k3-*.dts here and elsewhere
> 		bootph-all
> 
> 
> Better drop them altogether, and lets have a single patch for the j721s2
> platform to add bootph* flags as necessary.

Okay.

> 
> 
>> +	};
>>   };
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>> index 2ddad9318554..4b29418a6076 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>> @@ -655,4 +655,18 @@
>>   		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
>>   		#thermal-sensor-cells = <1>;
>>   	};
>> +
>> +	mcu_esm: esm@40800000 {
>> +		compatible = "ti,j721e-esm";
>> +		reg = <0x00 0x40800000 0x00 0x1000>;
>> +		ti,esm-pins = <95>;
>> +		bootph-pre-ram;
>> +	};
>> +
>> +	wkup_esm: esm@42080000 {
>> +		compatible = "ti,j721e-esm";
>> +		reg = <0x00 0x42080000 0x00 0x1000>;
>> +		ti,esm-pins = <63>;
>> +		bootph-pre-ram;
>> +	};
>>   };
> 
