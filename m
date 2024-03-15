Return-Path: <linux-kernel+bounces-104565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B0C87D000
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278A21F23CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEA43D38C;
	Fri, 15 Mar 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="O43SCO9M"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010013E48E;
	Fri, 15 Mar 2024 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515783; cv=none; b=LVdNaVMmFTWRY9vqY8L14M1kwqjXsDAVpb+wo/01Yq/xF0zCIMibsOkUYVvmi0TwOxIHT8pPGb9U1CYBeLQxsdq/YA22txCgLaDTQ5eXRjRCQFMUqr4mBbdGUB8pfMW8JKLS5lrYxLQE5NCXpU0zuFySlijF1VtodBnDpdi44dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515783; c=relaxed/simple;
	bh=IHIPLZE3idlw2cVAcFI6y49qart4V2n1jZXMAHDIMxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lq2Qm0B/iSkhv9HW6XbGDzChrPhlJkNucuyWM7cn4xatHFEB0DeHIkyOyNw3VD7+TmPDP7NXr+7oq+kElfZFcq2ZogUMbEVD0RwWocz0EDFKiJtw+wCYyKoz/+8EhSf2SgUPsoQkun6UwNDwdevApYxo+qBbsMUBtA0iPrVudSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=O43SCO9M; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42FEcweV009640;
	Fri, 15 Mar 2024 16:15:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=mN5YOoII/OjhboOJve/4NynjPrKGyVn2gyMyB0ukmK8=; b=O4
	3SCO9MyJtYSOKQdCylCRvSDcHHxssv5BfVPLBubd9+Szkv5WcxgLnXtQAUfWgSpU
	I/ziY/map1ZTLqOZb8ZAnHsdyX60bH1ck19Gasjv4xwvTDWB7UoL00peD7ZiCStO
	KeaFREhRryPVNq8JlIigO7sTODYdN74knfTf/64YaI2cECSnOQXA2TDg2oVnyhxf
	P1Ith7hPfjfZF1sCPg9eLz3nYzbimwXYUPLzLHoxToQw0oCvidRmtD+dA3IjzbcF
	g9O/JaNlPfLQ71HLGwZi21RHHQpgGpDVpk7byycaRUQ1xcUN6bn0PdAJMuuQbsMe
	cbrKU5yedbA9yalQymXg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wv9yckf3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 16:15:46 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A126D4002D;
	Fri, 15 Mar 2024 16:15:30 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8AEB827564A;
	Fri, 15 Mar 2024 16:14:16 +0100 (CET)
Received: from [10.252.28.102] (10.252.28.102) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Mar
 2024 16:14:15 +0100
Message-ID: <ac696442-0513-48cc-86b1-8647b9bd8e91@foss.st.com>
Date: Fri, 15 Mar 2024 16:14:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: net: add new property st,ext-phyclk
 in documentation for stm32
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240307135957.303481-1-christophe.roullier@foss.st.com>
 <20240307135957.303481-3-christophe.roullier@foss.st.com>
 <578f421c-ca06-45d4-8380-8b2b423d4d47@linaro.org>
 <50ee6122-b160-48ea-8c44-1046b5907d7c@foss.st.com>
 <e2a98098-8ccd-4b8f-9a4b-1cbc0776a9c2@linaro.org>
 <51531046-ee83-4d99-836b-af4dc5d7add9@foss.st.com>
 <cf122942-c0fd-457f-a753-366cae39d5f8@linaro.org>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <cf122942-c0fd-457f-a753-366cae39d5f8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_02,2024-03-13_01,2023-05-22_02

Hi

On 3/14/24 16:25, Krzysztof Kozlowski wrote:
> On 14/03/2024 16:10, Christophe ROULLIER wrote:
>> Hi,
>>
>> On 3/13/24 14:06, Krzysztof Kozlowski wrote:
>>> On 13/03/2024 11:39, Christophe ROULLIER wrote:
>>>> On 3/8/24 09:28, Krzysztof Kozlowski wrote:
>>>>> On 07/03/2024 14:59, Christophe Roullier wrote:
>>>>>> Add property st,ext-phyclk to manage cases when PHY have no cristal/quartz
>>>>>> This property can be used with RMII phy without cristal 50Mhz and when we
>>>>>> want to select RCC clock instead of ETH_REF_CLK
>>>>>> Can be used also with RGMII phy with no cristal and we select RCC clock
>>>>>> instead of ETH_CLK125
>>>>>>
>>>>> Nothing improved here. You say you add new property (wrote it explicitly
>>>>> in the subject), but where is it? Where is the user?
>>>>>
>>>>> I think we talked about this. Rob also asked quite clear:
>>>>>
>>>>>> That is obvious from the diff. What is not obvious is why we need a new
>>>>>> property and what is the problem with the existing ones.
>>>>> How did you solve it?
>>>> Hi,
>>>>
>>>> I do not understand your questions.
>>> OK, I will clarify some questions, but are you sure that this question:
>>> "How did you solve it?"
>>> needs clarification?
>>>
>>> If so, then let me clarify:
>>> Rob pointed issue. How did you resolve Rob's comment? How did you
>>> address it? What changed in your patch, that Rob's comment should be
>>> considered as addressed/resolved/done?
>> This property was introduced in 2020 in order to simplify management of
>> all STM32 platforms without Ethernet cristal/quartz PHY.
> I fail to see how this answers how did you resolve the comment. You now
> described some sort of history, but I am asking: what did you change in
> your patches, so Rob's comment is considered resolved?

Concerning Rob's comment, in V2 I finally remove deprecated fields put 
in V1 to keep existing properties, which have no pb and can be used.

And I explained the meaning to add existing property in yaml.

>>> Now about my other question:
>>> "but where is it? Where is the user?"
>>>
>>> Your subject and commit message claim you add new property. This means
>>> such property was not existing so far in the Linux kernel. If you add
>>> new property in the binding, then I expect adding the user of that
>>> binding, thus my question: where is the user of that binding?
>>>
>> I'm preparing glue and DTS to upstream for STM32MP13 platform, this
>> platform will use with property.
>>
>> Since 2020, this property is available in the driver in kernel.org, so
>> it is also possible that someone who has not upstreamed their
> This should be explained in commit msg (although not kernel.org, website
> does not matter here).
ok I will add this in V3.
>
>> code also uses it.
>>
>>>> That I would like to do, it is property "st,ext-phyclk" was introduced
>>>> in driver
>>>>
>>>> "drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c" in 2020, and YAML
>>>> was not updated at the time.
>>> Are you saying you document existing property or add a new one?
>> Yes, existing property, since 2020 in kernel.org.
> Drop the website. We talk here about Linux kernel.
>
> Commit msg fails to explain it in a clear way.

ok I will add this in V3.

Thanks

>
>>>> Goal of this patch it is to update YAML to avoid dtbs check issue if
>>>> someone use this property :
>>>>
>>>>     dtbs check issue : views/kernel/upstream/net-next/arch/arm/boot/dts/st/stm32mp157c-dk2.dtb:
>>>> ethernet@5800a000: Unevaluated properties are not allowed
>>>> ('st,ext-phyclk' was unexpected)
>>> So DTS uses it?
>> Here it was example, if someone wants to use this property, but today
>> this property is not yet present in DTS in kernel.org
>
> Best regards,
> Krzysztof
>

