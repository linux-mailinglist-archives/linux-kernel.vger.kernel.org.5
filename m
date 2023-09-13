Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FE279E138
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238737AbjIMHxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjIMHw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:52:58 -0400
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1981729;
        Wed, 13 Sep 2023 00:52:54 -0700 (PDT)
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38D7M02F014523;
        Wed, 13 Sep 2023 09:52:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=2qj6oZC/xalnXYn+xtZs64KlT9SJyMmoe1KmvotRn5o=; b=32
        D9Wfvwm3arFY07+aI+zYDT3vMuUa+0UIVD3OIwDNHKOI3bCj6o8WlkzrSgxuhNI8
        EySQi7akkow2fD98pOtvSWcsKf0ZoTHlvafKN/tbytZofjyEre67Mr4xfXSHnBCx
        P4wro3Cv2VFj/AmPiUwjaD51ee4kI6umGRP29Q/QWoKdyZpyv0vDZbYnLZN4eYg0
        yR3CtbCcAQRkndY22bNnWjIy2ihf/vtxVBooy8RU/w4Gg8p895Wx68ccTES/jqf+
        fBJHKtS/AStBv+eRS0Tjyxljnl/N+1tndxAIzLgo8R7JieU0PS/QcXMle41uaxPO
        KiIP9a5NhXEh/kXtoLBg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t2y7m9yqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 09:52:38 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 80497100057;
        Wed, 13 Sep 2023 09:52:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 78A22226FD3;
        Wed, 13 Sep 2023 09:52:37 +0200 (CEST)
Received: from [10.201.20.32] (10.201.20.32) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 09:52:36 +0200
Message-ID: <abd1db1b-7cdb-177b-7995-23f500597155@foss.st.com>
Date:   Wed, 13 Sep 2023 09:52:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 10/10] ARM: dts: stm32: add RNG node for STM32MP13x
 platforms
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Lionel Debieve <lionel.debieve@foss.st.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911120203.774632-1-gatien.chevallier@foss.st.com>
 <20230911120203.774632-11-gatien.chevallier@foss.st.com>
 <327ff0b3-21c9-1452-af1b-e9b6ece52924@linaro.org>
From:   Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <327ff0b3-21c9-1452-af1b-e9b6ece52924@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.32]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_24,2023-09-05_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/23 16:38, Krzysztof Kozlowski wrote:
> On 11/09/2023 14:02, Gatien Chevallier wrote:
>> The RNG on STM32MP13 offers upgrades like customization of its
>> configuration and the conditional reset.
>>
>> The hardware RNG should be managed in the secure world for but it
>> is supported on Linux. Therefore, is it not default enabled.
>>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>> ---
>>   arch/arm/boot/dts/st/stm32mp131.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
>> index ac90fcbf0c09..39db82b782eb 100644
>> --- a/arch/arm/boot/dts/st/stm32mp131.dtsi
>> +++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
>> @@ -1220,6 +1220,14 @@ mdma: dma-controller@58000000 {
>>   			dma-requests = <48>;
>>   		};
>>   
>> +		rng: rng@54004000 {
>> +			compatible = "st,stm32mp13-rng";
>> +			reg = <0x54004000 0x400>;
>> +			clocks = <&rcc RNG1_K>;
>> +			resets = <&rcc RNG1_R>;
>> +			status = "disabled";
> 
> Why? What other resources are missing?
> 
> Best regards,
> Krzysztof
> 

Hello Krzysztof,

Our default implementation is to handle the RNG in OP-TEE for
these platforms. Therefore, it goes through optee-rng driver.
The RNG services are exposed by a PTA (Pseudo Trusted Application)
in OP-TEE. In this case, there's no need to enable the RNG node
in the Linux Kernel.

Best regards,
Gatien
