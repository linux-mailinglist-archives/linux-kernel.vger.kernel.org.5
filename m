Return-Path: <linux-kernel+bounces-80756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA22866C22
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2893280D80
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670E21CAB1;
	Mon, 26 Feb 2024 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="eSYuuTHo"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1A81CA91;
	Mon, 26 Feb 2024 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936032; cv=none; b=u6SHYpaJrBlowXPAGqtTpTIJfUk8d5FQv4meM1ZWG47kY0s+CgFikau4diXetBHQBlaeL0R8OUZA/Jmx5TrilqOjuhTYbMQjsBjW7UtFeua5/3Y0UiGdsU3plBXQ+DiOHimSwov11HOPHkAuYyvuxRqU6xl/6rcG7bPuOXg97kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936032; c=relaxed/simple;
	bh=opGkT1SPK5IIzhy5L61IRDO4fs/Se1zLuTjvPJtOAos=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ObZop8PBzhA+wPDNiW+KQDdjDhUFwD5F4zuhoRHJvFGlkG7XNKzuq6u4zoaGj3m4q+6vczGpndpGc4A3RG4JsTStUdg5HuL4315VMlDhbaPSzUgiZJfmWf5Na2j1F/NPoyGCbwlYl7mjVMS+Xj33/R//O/ihV2+PEeoki2HAeaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=eSYuuTHo; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q7U9S0026021;
	Mon, 26 Feb 2024 09:27:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=+LqaC1k2A/CeSV89OpDz4o3lBGabPbXT8Ayn3ozZF+E=; b=eS
	YuuTHoml5z4VcKgqoFxayaUxIXvZSZB5J9MSNBejh+kYnNzSshlK2EiAPBI8DJe2
	MCNR+59y/W9S+eQXxCokj1fFMX+uSHTgnUt8hqFAuQJRdMF+6HbFCTrt5SM+7vq0
	t9gLrO9z36cI62RYxzuqB8qfS5IDP0GYIw42pVMC/zqEokI4RS2waTulWb7zBIx/
	DFOVgq1A4BKKUjaR6UFwpMyrVcELCxAl1Oq9XHZBwv9zfJ+bWyrhnnFyjWblaWo1
	G8+AheIRSbOKpbNKX+UK6U7/wRs+ejgX9goH80q1Obauw1HD22z1IFtV5CghkE28
	GEoj3u7rKgOgS+qveTtw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wftw4kys9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 09:27:04 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 54A3840047;
	Mon, 26 Feb 2024 09:27:01 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B2CC424DFE9;
	Mon, 26 Feb 2024 09:26:32 +0100 (CET)
Received: from [10.201.21.177] (10.201.21.177) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 26 Feb
 2024 09:26:31 +0100
Message-ID: <9fb17963-8942-4810-ae86-508fd7b3466a@foss.st.com>
Date: Mon, 26 Feb 2024 09:26:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] memory: stm32-fmc2-ebi: add MP25 support
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <20240219140202.85680-1-christophe.kerello@foss.st.com>
 <20240219140202.85680-4-christophe.kerello@foss.st.com>
 <21ad2752-ad25-451a-b892-6b3b31c1031a@linaro.org>
From: Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <21ad2752-ad25-451a-b892-6b3b31c1031a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_05,2024-02-23_01,2023-05-22_02

Hi Krzysztof,

On 2/21/24 09:32, Krzysztof Kozlowski wrote:
> On 19/02/2024 15:02, Christophe Kerello wrote:
>> Add the support of the revision 2 of FMC2 IP.
>>       - PCSCNTR register has been removed,
>>       - CFGR register has been added,
>>       - the bit used to enable the IP has moved from BCR1 to CFGR,
>>       - the timeout for CEx deassertion has moved from PCSCNTR to BCRx,
>>       - the continuous clock enable has moved from BCR1 to CFGR,
>>       - the clk divide ratio has moved from BCR1 to CFGR.
>>
>> The MP1 SoCs have only one signal to manage all the controllers (NWAIT).
>> The MP25 SOC has one RNB signal for the NAND controller and one NWAIT
>> signal for the memory controller.
>>
>> Let's use a platform data structure for parameters that will differ
>> between MP1 and MP25.
> 
> 
> ...
> 
>> +
>>   	ebi->regmap = device_node_to_regmap(dev->of_node);
>>   	if (IS_ERR(ebi->regmap))
>>   		return PTR_ERR(ebi->regmap);
>> @@ -1190,9 +1502,11 @@ static int stm32_fmc2_ebi_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto err_release;
>>   
>> -	ret = stm32_fmc2_ebi_save_setup(ebi);
>> -	if (ret)
>> -		goto err_release;
>> +	if (ebi->data->save_setup) {
> 
> This cannot be NULL.

Ok, it will be done in V3.

Regards,
Christophe Kerello.

> 
>> +		ret = ebi->data->save_setup(ebi);
>> +		if (ret)
>> +			goto err_release;
>> +	}
>>   
>>   	platform_set_drvdata(pdev, ebi);
>>   
>> @@ -1238,7 +1552,9 @@ static int __maybe_unused stm32_fmc2_ebi_resume(struct device *dev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	stm32_fmc2_ebi_set_setup(ebi);
>> +	if (ebi->data->set_setup)
> 
> This cannot be NULL.
> 
> 
> 
> Best regards,
> Krzysztof
> 

