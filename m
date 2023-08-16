Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D980677DB07
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242365AbjHPHRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242358AbjHPHQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:16:53 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3A02110;
        Wed, 16 Aug 2023 00:16:52 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G4gKwn026201;
        Wed, 16 Aug 2023 09:16:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:from:to:cc:references
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=HlmgaWyxJNv1eOUDcddDRTGv1jsl8rlsOwf40teCamc=; b=XH
        of36KraDylIx3qIOOkHOpuN47xi3/qEF8OxKs1t3ys1dE6hNd6ipS/g9uEX6VD97
        7uHdfZ19ivQiR2Ncyzx1xLtl1u1rWrqQspFiWuEguENFqisiTHfeDoB0VdD8gHGS
        bWoH005UiT7CxCjAvBIdCKXAnOFcNZ0Chtg7UluNtHOr8mucp/UgMZ8yIfxM60jk
        UdDww2YMK4R6+4nOslto4bFka0isGUMLgb8pcwLJqocwMQJTBi1h8HwDWgvWyssZ
        vi8Knqap+e/rzApDipqDrQTgyjcQ7c/mnAVKqB+2E0oVVPDSYj/czeF5+eSLDMN8
        r6mfur50exbtZvWZuSgA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sgqnt8q5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 09:16:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 711FA10005D;
        Wed, 16 Aug 2023 09:16:36 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 67E4F217B6B;
        Wed, 16 Aug 2023 09:16:36 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 16 Aug
 2023 09:16:35 +0200
Message-ID: <35b63303-07ee-9c8c-6e33-f970fc244441@foss.st.com>
Date:   Wed, 16 Aug 2023 09:16:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] ARM: dts: st: move leds out of soc in
 stih418-b2264.dts
Content-Language: en-US
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230702161936.134429-1-avolmat@me.com>
 <20230702161936.134429-3-avolmat@me.com>
 <a5f5c64d-672d-2d1b-5243-af0e2a7186f5@foss.st.com>
In-Reply-To: <a5f5c64d-672d-2d1b-5243-af0e2a7186f5@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_05,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/23 09:16, Patrice CHOTARD wrote:
> 
> 
> On 7/2/23 18:19, Alain Volmat wrote:
>> Move the leds node out of the soc section
>> and correct the following warning:
>> Warning (simple_bus_reg): /soc/leds: missing or empty reg/ranges property
>>
>> Signed-off-by: Alain Volmat <avolmat@me.com>
>> ---
>>  arch/arm/boot/dts/st/stih418-b2264.dts | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/st/stih418-b2264.dts b/arch/arm/boot/dts/st/stih418-b2264.dts
>> index f496ca28850d..d4874282cfba 100644
>> --- a/arch/arm/boot/dts/st/stih418-b2264.dts
>> +++ b/arch/arm/boot/dts/st/stih418-b2264.dts
>> @@ -73,15 +73,15 @@ aliases {
>>  		ethernet0 = &ethernet0;
>>  	};
>>  
>> -	soc {
>> -		leds {
>> -			compatible = "gpio-leds";
>> -			led-green {
>> -				gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
>> -				default-state = "off";
>> -			};
>> +	leds {
>> +		compatible = "gpio-leds";
>> +		led-green {
>> +			gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
>> +			default-state = "off";
>>  		};
>> +	};
>>  
>> +	soc {
>>  		pin-controller-sbc@961f080 {
>>  			gmac1 {
>>  				rgmii1-0 {
> Applied on sti-next
> 
> Thanks
> Patrice
Applied on sti-next

Thanks
Patrice
