Return-Path: <linux-kernel+bounces-118461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB19A88BB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D4B1C30252
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD6A133983;
	Tue, 26 Mar 2024 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="LLqnhuP8"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13325130A79;
	Tue, 26 Mar 2024 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438222; cv=none; b=d84EDGJnPY4JU0bux1yAzz+gtC/fJW4ILkJ16yuwM5/Dj8pitiyiWw0uIhwRP/1WeO0thFrDr0P9kiaQ1Go5nmFRHSn4XgH7YEYWLAyBM/Ph7ELVfe2x/CaMvpIDvZ24UsHZeCvCyrrWnX35+7jkz7iPPseOmWWot8LiSYQYir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438222; c=relaxed/simple;
	bh=MrNA5GOPFRjUuKQr1bV73BfqWKQvah060lP6DSiTJ7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XIYKATVQXh2TWq8T+ft/kLtNrQFaOLRG25Gn/c6TH/pzg00fppsScZ+MbcLQeXOjieZLWqhxEfflR1iFIo9Tc2TYL4N4wdXZitrWupT5gA6bdqcwvSpY2Jm0Xp/SfnyZN6R8kkTObc5+y6lmn9X8IltCfqPk4/Z/EoHlqjyK1Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=LLqnhuP8; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q79Pm6011448;
	Tue, 26 Mar 2024 08:30:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=0WDDhMfK04BGhm+sON+hhZFXc0haOioDJHTQDJRto/c=; b=LL
	qnhuP8rttv5Zz8/tCnLSgztTQfdR5lZXUj4BLM0tW1IesTdizO4d5uttN35N87/0
	TsufReXr587OYhyG+YfEVSAUqlHLpeG4VudaGR3SggE52g4G1xxrHVZUz6mPt2Sm
	qEzL8koo2zJ+jGkcv20OqrZ4bCWeH1UVOvDmoJGSuYijKfCfuML2oeU5x94Ogr5N
	5Kz1oagCO0EmpWMCiBTIXh0L9MdgW1C1i4GBmUPXrtuBFLL3mD+iRrRDywvkMxio
	tUhl6e0zexwjO8qmQp9mRvah9pDe/oCVAAX8sdDVn/dEq/7EiU6s5evbi5X+pxa2
	JccRKYvQOmlEYoxl9yWg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x29h5s7rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 08:30:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BDB394002D;
	Tue, 26 Mar 2024 08:30:03 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 412E921039B;
	Tue, 26 Mar 2024 08:29:35 +0100 (CET)
Received: from [10.201.20.71] (10.201.20.71) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Mar
 2024 08:29:34 +0100
Message-ID: <59b8f5f4-40a0-410d-9a42-f064de80edfb@foss.st.com>
Date: Tue, 26 Mar 2024 08:29:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: add heartbeat led for stm32mp157c-ed1
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20240325170656.2829600-1-patrice.chotard@foss.st.com>
 <dc4251d1-8cbb-4a0c-834c-26f16f3f9484@linaro.org>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <dc4251d1-8cbb-4a0c-834c-26f16f3f9484@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02



On 3/25/24 19:29, Krzysztof Kozlowski wrote:
> On 25/03/2024 18:06, patrice.chotard@foss.st.com wrote:
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> Add heartbeat led for stm32mp157c-ed1.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>  arch/arm/boot/dts/st/stm32mp157c-ed1.dts | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/st/stm32mp157c-ed1.dts b/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
>> index 66ed5f9921ba..bd727455a7e4 100644
>> --- a/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
>> +++ b/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
>> @@ -24,6 +24,15 @@ chosen {
>>  		stdout-path = "serial0:115200n8";
>>  	};
>>  
>> +	led {
>> +		compatible = "gpio-leds";
>> +		led-blue {
>> +			gpios = <&gpiod 9 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "heartbeat";
>> +			default-state = "off";
> 
> Please add function and color properties.
Hi Krzysztof

OK i will send a v2

Thanks
Patrice

> 
> Best regards,
> Krzysztof
> 

