Return-Path: <linux-kernel+bounces-123135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B468902A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801251C29B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D83512EBC7;
	Thu, 28 Mar 2024 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="zpu+15rj"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEAA81AB1;
	Thu, 28 Mar 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638541; cv=none; b=FUin7t3z822Ow0QrNIlnxzw+JRrKeZXSnsCQY6dPy7DQfsHBgofs4QCAKkzCfw+b8OJjs7R0g5x7SbXrI4M/rwq/6EF4y+8qePFFOnyzsLQR1UHlFpEwLNvvUY7jzdCcu73IMMzNFP1KyGORY+KGUT16E7I9nXm4w98R8Iy2G3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638541; c=relaxed/simple;
	bh=4RMpfFVGWhEWafnefWiakyA1PM0ClZPXcn1uGjIvT/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MLBBokwIL1FQmsP40qxK5ehJI+JErHI6gW0qj5RpschzRVL9KrylHGpw2Eo42lv/Hwr+3jN2O3Od+GFHpj/5FOD6uDiZyYAEHBP5Er/IrgXf83paPB6Fx6ZBKVD60AzkFc2ZYROjyj/Qao1IjwwM5PsHgPrC/RjzhAzOuPP7+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=zpu+15rj; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SENT78017636;
	Thu, 28 Mar 2024 16:08:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=iLOweYbCsmn698CJ46dWyC3tf2LxrlF3WpWQb+3oxRE=; b=zp
	u+15rjkBN0yym8/YKQUXKM7KkDrPXNb9xjRmvtVUWcwUoAA7fwTn2+GqQbrvk1fD
	07bu7tF8IK1QJaSKPiZDfuu6HSMjHkn9NObrsultisKGcOfQHHseo1zme7sMk3BY
	8wiGfR4FwPkyXwXQeSRWiDPDWABG7RXz85nwtKpB4IurCvxQNxyA5dvJIRbxhqWM
	LiMrXzMQAO0SnLYOJwIlt4zg0lvvFdZ8rjPlEQSv6RHauyNw34Uz/jU59xwIN4W9
	vDg32W4tGw5vo06quCrMLd3mr4pOquc8b5ELSfyQmv8EvWnt6FnnPnGXV0tMLuPK
	7cx7o3DgklHKP0reBu0g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x1n39tw26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 16:08:23 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7EC9B40044;
	Thu, 28 Mar 2024 16:08:19 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BFE3F2248BB;
	Thu, 28 Mar 2024 16:07:03 +0100 (CET)
Received: from [10.201.21.128] (10.201.21.128) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Mar
 2024 16:07:02 +0100
Message-ID: <6df41c81-0aa4-48a5-a069-d8a742f412ef@foss.st.com>
Date: Thu, 28 Mar 2024 16:07:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] dt-bindings: net: dwmac: Document STM32 property
 st,ext-phyclk
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240328140803.324141-1-christophe.roullier@foss.st.com>
 <20240328140803.324141-2-christophe.roullier@foss.st.com>
 <480d4064-b553-4005-ad98-499a862703ff@denx.de>
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <480d4064-b553-4005-ad98-499a862703ff@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_15,2024-03-27_01,2023-05-22_02


On 3/28/24 15:19, Marek Vasut wrote:
> On 3/28/24 3:08 PM, Christophe Roullier wrote:
>
> [...]
>
>> | RMII    |    -   |     eth-ck    | eth-ck        |       n/a        |
>> |         |        | st,ext-phyclk | st,eth-ref-clk-sel 
>> |                  |
>> |         |        |               | or st,ext-phyclk 
>> |                  |
>>
>> --------------------------------------------------------------------------- 
>>
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>> ---
>>   Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml 
>> b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>> index fc8c96b08d7dc..b35eae80ed6ac 100644
>> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>> @@ -82,6 +82,13 @@ properties:
>>         Should be phandle/offset pair. The phandle to the syscon node 
>> which
>>         encompases the glue register, and the offset of the control 
>> register
>>   +st,ext-phyclk:
>
> Don't you need two spaces in front of the 'st,' here ?
Sorry, that's right.
>
>> +    description:
>> +      set this property in RMII mode when you have PHY without 
>> crystal 50MHz and want to
>> +      select RCC clock instead of ETH_REF_CLK. OR in RGMII mode when 
>> you want to select
>> +      RCC clock instead of ETH_CLK125.
>> +    type: boolean
>> +
>
> With that fixed:
>
> Reviewed-by: Marek Vasut <marex@denx.de>

