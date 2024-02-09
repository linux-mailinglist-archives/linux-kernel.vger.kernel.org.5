Return-Path: <linux-kernel+bounces-59171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD2684F285
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B318C1C2389D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C9E67C5D;
	Fri,  9 Feb 2024 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="fdDaI7Bf"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31CF679E7;
	Fri,  9 Feb 2024 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472007; cv=none; b=inhanYsFVdBqxYGQ8YknIW0hOZJD6kdk1gueauqhudzkvxJH39NofTiGu5Mj9/NooV5LZ5IGZJ1b9GZ8rZKyFVoI3tkD5At7zYUTTOIX5qYTZWlX74cU7/FcvzedQ8vWHB4A4Ja0PpboOMb09UOypmxGYifqdZzH862zDU7dz0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472007; c=relaxed/simple;
	bh=Y1NNtOEea2F9mEe6191S9r97fu+8MTLOdLidkuCPM5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nxJgqsiThiZlcLp5l5qS68weSmYLoHAYa3ZLYdVGxMcJ4k8n/pLcivtqiRUMDL0VaZqVtAvJMdgYOiVLAiYxNoGPf+Uuk59W7kwoToNZMSERDef0XYL5wmQ+Glt2k89/j8f6KEFE/8Y+KydJD4Ok6AONmhhAaHNmUnOO4m2LTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=fdDaI7Bf; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4198i5TK029722;
	Fri, 9 Feb 2024 10:46:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=w8LWT/qBmxX1Xcu7w38iP03HHsbcA0KH+NTBwTe85H8=; b=fd
	DaI7Bf6ZnToCoFI7sD8Pg3AOvTWhrUCCeqpB3YZyNAF9r4DLBzCGXQDlRzd1KebT
	EKqxe8WvEwkB/fVWvF/BV/b0io6MZyNfMqDi1fOwAYNebyQHuJZG3lMAw21ttiv9
	hqcsgDUFuT9U/2YxE8VW2CleCCpvt4ldzGultC2hC5IVkI6nS9zCVCLT+YHVU7qH
	8q2BNoxo//iPWhW6sJhDF0ZCe7VVpDeFjw5cIccMbkJVe0UN0Oypsf0xnodaz6H2
	eKWju3I0MMlQ5Dc+t5+Xq2yo908PuMqJtUZwLgtrgZavEuBqdxmdZDX3FjJnXu5z
	L+Im5KTPuVl3xi0+kTtQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w1ewpgfjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 10:46:18 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B959610005E;
	Fri,  9 Feb 2024 10:46:15 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ACAC220F54D;
	Fri,  9 Feb 2024 10:46:15 +0100 (CET)
Received: from [10.252.24.106] (10.252.24.106) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 9 Feb
 2024 10:46:14 +0100
Message-ID: <768067ff-cd69-4a55-aa5a-fc1eae5c1116@foss.st.com>
Date: Fri, 9 Feb 2024 10:46:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/4] dt-bindings: stm32: update DT bingding for
 stm32mp25
To: Conor Dooley <conor@kernel.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240208142301.155698-1-gabriel.fernandez@foss.st.com>
 <20240208142301.155698-3-gabriel.fernandez@foss.st.com>
 <20240208-syndrome-storeroom-5cc8bdd07c05@spud>
Content-Language: en-US
From: Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <20240208-syndrome-storeroom-5cc8bdd07c05@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_07,2024-02-08_01,2023-05-22_02

Hi Conor,

Thank's for your review.

Yes, I have checked that point. I have also written the RCC driver for 
TFA/OPTE/UBOOT and once

I receive Ack in the Kernel, I will upstream the other components.

Best Regards

Gabriel


On 2/8/24 19:06, Conor Dooley wrote:

> On Thu, Feb 08, 2024 at 03:22:59PM +0100, gabriel.fernandez@foss.st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>
>> Now RCC driver use '.index' of clk_parent_data struct to define a parent.
> The RCC driver in linux might have stopped using the names, but they
> were a required property that could be replied upon by other software
> too. Have you checked U-Boot or *BSD etc to make sure clock-names are
> not used there?
>
> Thanks,
> Conor.
>
>> The majority of parents are SCMI clocks, then dt-bindings must be fixed.
>>
>> Fixes: b5be49db3d47 ("dt-bindings: stm32: add clocks and reset binding for stm32mp25 platform")
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>> ---
>>   .../bindings/clock/st,stm32mp25-rcc.yaml      | 171 ++++++++++++++++--
>>   1 file changed, 155 insertions(+), 16 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
>> index 7732e79a42b9..57bd4e7157bd 100644
>> --- a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
>> @@ -38,22 +38,87 @@ properties:
>>         - description: CK_SCMI_MSI Low Power Internal oscillator (~ 4 MHz or ~ 16 MHz)
>>         - description: CK_SCMI_LSE Low Speed External oscillator (32 KHz)
>>         - description: CK_SCMI_LSI Low Speed Internal oscillator (~ 32 KHz)
>> -
>> -  clock-names:
>> -    items:
>> -      - const: hse
>> -      - const: hsi
>> -      - const: msi
>> -      - const: lse
>> -      - const: lsi
>> -
>> +      - description: CK_SCMI_HSE_DIV2 CK_SCMI_HSE divided by 2 (coud be gated)
>> +      - description: CK_SCMI_ICN_HS_MCU High Speed interconnect bus clock
>> +      - description: CK_SCMI_ICN_LS_MCU Low Speed interconnect bus clock
>> +      - description: CK_SCMI_ICN_SDMMC SDMMC interconnect bus clock
>> +      - description: CK_SCMI_ICN_DDR DDR interconnect bus clock
>> +      - description: CK_SCMI_ICN_DISPLAY Display interconnect bus clock
>> +      - description: CK_SCMI_ICN_HSL HSL interconnect bus clock
>> +      - description: CK_SCMI_ICN_NIC NIC interconnect bus clock
>> +      - description: CK_SCMI_ICN_VID Video interconnect bus clock
>> +      - description: CK_SCMI_FLEXGEN_07 flexgen clock 7
>> +      - description: CK_SCMI_FLEXGEN_08 flexgen clock 8
>> +      - description: CK_SCMI_FLEXGEN_09 flexgen clock 9
>> +      - description: CK_SCMI_FLEXGEN_10 flexgen clock 10
>> +      - description: CK_SCMI_FLEXGEN_11 flexgen clock 11
>> +      - description: CK_SCMI_FLEXGEN_12 flexgen clock 12
>> +      - description: CK_SCMI_FLEXGEN_13 flexgen clock 13
>> +      - description: CK_SCMI_FLEXGEN_14 flexgen clock 14
>> +      - description: CK_SCMI_FLEXGEN_15 flexgen clock 15
>> +      - description: CK_SCMI_FLEXGEN_16 flexgen clock 16
>> +      - description: CK_SCMI_FLEXGEN_17 flexgen clock 17
>> +      - description: CK_SCMI_FLEXGEN_18 flexgen clock 18
>> +      - description: CK_SCMI_FLEXGEN_19 flexgen clock 19
>> +      - description: CK_SCMI_FLEXGEN_20 flexgen clock 20
>> +      - description: CK_SCMI_FLEXGEN_21 flexgen clock 21
>> +      - description: CK_SCMI_FLEXGEN_22 flexgen clock 22
>> +      - description: CK_SCMI_FLEXGEN_23 flexgen clock 23
>> +      - description: CK_SCMI_FLEXGEN_24 flexgen clock 24
>> +      - description: CK_SCMI_FLEXGEN_25 flexgen clock 25
>> +      - description: CK_SCMI_FLEXGEN_26 flexgen clock 26
>> +      - description: CK_SCMI_FLEXGEN_27 flexgen clock 27
>> +      - description: CK_SCMI_FLEXGEN_28 flexgen clock 28
>> +      - description: CK_SCMI_FLEXGEN_29 flexgen clock 29
>> +      - description: CK_SCMI_FLEXGEN_30 flexgen clock 30
>> +      - description: CK_SCMI_FLEXGEN_31 flexgen clock 31
>> +      - description: CK_SCMI_FLEXGEN_32 flexgen clock 32
>> +      - description: CK_SCMI_FLEXGEN_33 flexgen clock 33
>> +      - description: CK_SCMI_FLEXGEN_34 flexgen clock 34
>> +      - description: CK_SCMI_FLEXGEN_35 flexgen clock 35
>> +      - description: CK_SCMI_FLEXGEN_36 flexgen clock 36
>> +      - description: CK_SCMI_FLEXGEN_37 flexgen clock 37
>> +      - description: CK_SCMI_FLEXGEN_38 flexgen clock 38
>> +      - description: CK_SCMI_FLEXGEN_39 flexgen clock 39
>> +      - description: CK_SCMI_FLEXGEN_40 flexgen clock 40
>> +      - description: CK_SCMI_FLEXGEN_41 flexgen clock 41
>> +      - description: CK_SCMI_FLEXGEN_42 flexgen clock 42
>> +      - description: CK_SCMI_FLEXGEN_43 flexgen clock 43
>> +      - description: CK_SCMI_FLEXGEN_44 flexgen clock 44
>> +      - description: CK_SCMI_FLEXGEN_45 flexgen clock 45
>> +      - description: CK_SCMI_FLEXGEN_46 flexgen clock 46
>> +      - description: CK_SCMI_FLEXGEN_47 flexgen clock 47
>> +      - description: CK_SCMI_FLEXGEN_48 flexgen clock 48
>> +      - description: CK_SCMI_FLEXGEN_49 flexgen clock 49
>> +      - description: CK_SCMI_FLEXGEN_50 flexgen clock 50
>> +      - description: CK_SCMI_FLEXGEN_51 flexgen clock 51
>> +      - description: CK_SCMI_FLEXGEN_52 flexgen clock 52
>> +      - description: CK_SCMI_FLEXGEN_53 flexgen clock 53
>> +      - description: CK_SCMI_FLEXGEN_54 flexgen clock 54
>> +      - description: CK_SCMI_FLEXGEN_55 flexgen clock 55
>> +      - description: CK_SCMI_FLEXGEN_56 flexgen clock 56
>> +      - description: CK_SCMI_FLEXGEN_57 flexgen clock 57
>> +      - description: CK_SCMI_FLEXGEN_58 flexgen clock 58
>> +      - description: CK_SCMI_FLEXGEN_59 flexgen clock 59
>> +      - description: CK_SCMI_FLEXGEN_60 flexgen clock 60
>> +      - description: CK_SCMI_FLEXGEN_61 flexgen clock 61
>> +      - description: CK_SCMI_FLEXGEN_62 flexgen clock 62
>> +      - description: CK_SCMI_FLEXGEN_63 flexgen clock 63
>> +      - description: CK_SCMI_ICN_APB1 Peripheral bridge 1
>> +      - description: CK_SCMI_ICN_APB2 Peripheral bridge 2
>> +      - description: CK_SCMI_ICN_APB3 Peripheral bridge 3
>> +      - description: CK_SCMI_ICN_APB4 Peripheral bridge 4
>> +      - description: CK_SCMI_ICN_APBDBG Peripheral bridge for degub
>> +      - description: CK_SCMI_TIMG1 Peripheral bridge for timer1
>> +      - description: CK_SCMI_TIMG2 Peripheral bridge for timer2
>> +      - description: CK_SCMI_PLL3 PLL3 clock
>> +      - description: clk_dsi_txbyte DSI byte clock
>>   required:
>>     - compatible
>>     - reg
>>     - '#clock-cells'
>>     - '#reset-cells'
>>     - clocks
>> -  - clock-names
>>   
>>   additionalProperties: false
>>   
>> @@ -66,11 +131,85 @@ examples:
>>           reg = <0x44200000 0x10000>;
>>           #clock-cells = <1>;
>>           #reset-cells = <1>;
>> -        clock-names = "hse", "hsi", "msi", "lse", "lsi";
>> -        clocks = <&scmi_clk CK_SCMI_HSE>,
>> -                 <&scmi_clk CK_SCMI_HSI>,
>> -                 <&scmi_clk CK_SCMI_MSI>,
>> -                 <&scmi_clk CK_SCMI_LSE>,
>> -                 <&scmi_clk CK_SCMI_LSI>;
>> +        clocks =  <&scmi_clk CK_SCMI_HSE>,
>> +                  <&scmi_clk CK_SCMI_HSI>,
>> +                  <&scmi_clk CK_SCMI_MSI>,
>> +                  <&scmi_clk CK_SCMI_LSE>,
>> +                  <&scmi_clk CK_SCMI_LSI>,
>> +                  <&scmi_clk CK_SCMI_HSE_DIV2>,
>> +                  <&scmi_clk CK_SCMI_ICN_HS_MCU>,
>> +                  <&scmi_clk CK_SCMI_ICN_LS_MCU>,
>> +                  <&scmi_clk CK_SCMI_ICN_SDMMC>,
>> +                  <&scmi_clk CK_SCMI_ICN_DDR>,
>> +                  <&scmi_clk CK_SCMI_ICN_DISPLAY>,
>> +                  <&scmi_clk CK_SCMI_ICN_HSL>,
>> +                  <&scmi_clk CK_SCMI_ICN_NIC>,
>> +                  <&scmi_clk CK_SCMI_ICN_VID>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_07>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_08>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_09>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_10>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_11>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_12>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_13>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_14>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_15>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_16>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_17>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_18>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_19>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_20>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_21>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_22>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_23>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_24>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_25>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_26>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_27>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_28>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_29>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_30>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_31>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_32>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_33>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_34>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_35>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_36>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_37>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_38>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_39>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_40>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_41>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_42>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_43>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_44>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_45>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_46>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_47>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_48>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_49>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_50>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_51>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_52>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_53>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_54>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_55>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_56>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_57>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_58>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_59>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_60>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_61>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_62>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_63>,
>> +                  <&scmi_clk CK_SCMI_ICN_APB1>,
>> +                  <&scmi_clk CK_SCMI_ICN_APB2>,
>> +                  <&scmi_clk CK_SCMI_ICN_APB3>,
>> +                  <&scmi_clk CK_SCMI_ICN_APB4>,
>> +                  <&scmi_clk CK_SCMI_ICN_APBDBG>,
>> +                  <&scmi_clk CK_SCMI_TIMG1>,
>> +                  <&scmi_clk CK_SCMI_TIMG2>,
>> +                  <&scmi_clk CK_SCMI_PLL3>,
>> +                  <&clk_dsi_txbyte>;
>>       };
>>   ...
>> -- 
>> 2.25.1
>>

