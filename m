Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFFA79FFF3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbjINJ06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbjINJ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:26:57 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBA3BB;
        Thu, 14 Sep 2023 02:26:52 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38E9QY3g018173;
        Thu, 14 Sep 2023 04:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694683594;
        bh=eEIP6g3WUf3TQBj8ApjPXdEEcx+uvs6CLOZcEbUAbH4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=mM32chzzVnpSjGBceymyRQrMtkQW6PJ3CXh537DKY3Lkt9I62dOSYoGcT7RJzi68+
         cLlcH5Gzg7wgWXZh8pkewuY5gMaI9NezCHzVsmkD36MJaC1957o3NcxVAs/RcOIKbj
         IYXDHMRrqoKioodVzwCKZweovtXl/GuZ3FyDDMYQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38E9QY1r091700
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Sep 2023 04:26:34 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Sep 2023 04:26:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Sep 2023 04:26:34 -0500
Received: from [10.24.69.29] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38E9QT3s117455;
        Thu, 14 Sep 2023 04:26:30 -0500
Message-ID: <f7bebc22-d494-f54d-5543-db75f5714a52@ti.com>
Date:   Thu, 14 Sep 2023 14:56:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] arm64: dts: ti: Add GPMC NAND support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <nm@ti.com>,
        <vigneshr@ti.com>, <rogerq@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230913114711.2937844-1-n-yadav@ti.com>
 <20230913114711.2937844-2-n-yadav@ti.com>
 <32c82fa2-f8b9-d22d-f0ac-f8d6e48df39d@linaro.org>
From:   Nitin Yadav <n-yadav@ti.com>
In-Reply-To: <32c82fa2-f8b9-d22d-f0ac-f8d6e48df39d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 14/09/23 11:57, Krzysztof Kozlowski wrote:
> On 13/09/2023 13:47, Nitin Yadav wrote:
>> Add support for AM62Q NAND card: X8 NAND EXPANSION
>> BOARD card (PROC143E1) for AM62x LP SK board.
>>
>> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 29 ++++++++++++++++++++++++
>>  arch/arm64/boot/dts/ti/k3-am62.dtsi      |  2 ++
>>  2 files changed, 31 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> index 284b90c94da8..e93e79d8083f 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> @@ -955,4 +955,33 @@ mcasp2: audio-controller@2b20000 {
>>  		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
>>  		status = "disabled";
>>  	};
>> +	gpmc0: memory-controller@3b000000 {
>> +		status = "disabled";
> 
> status is never first in DTSI. Really, where did you see such code?
Thank for pointing out, Will send a revised version.
> 
>> +		compatible = "ti,am64-gpmc";
>> +		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
> 
> First is compatible, second is reg/reg-names/ranges.
> 
> 
> Best regards,
> Krzysztof
> 

-- 
Regards,
Nitin
