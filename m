Return-Path: <linux-kernel+bounces-103462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED9287BFAC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DFB61C21A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9825171B2F;
	Thu, 14 Mar 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="L/AKO6OV"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070F5DDD9;
	Thu, 14 Mar 2024 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429150; cv=none; b=a6QwmRGSVR12ZFA+w/lobrQGBUVDCk+f+R1Yy3TgjuNfp15BoMIT6gedVoUHB3MqfP8QV9N+iIPY8jfaNo+o/X0BmVALmbysmoIHUkK5XsW9oceAIpfSGrWohNIejzDEQInseyKo8kOpYpCYl7f4m0EfTWSkw7bdGu4VVTvE0yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429150; c=relaxed/simple;
	bh=B1mQXNTRsPqpLcniYQPNW/rV3SSq9MZssAxya0srERs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fSw/o0Q22fvFDKa0bYz5gATB8eSxsGXT8CGt3EAuuXKyYPg1rVRG30/bxJU0jR5YRq8uVdFwG3sVRfTW8O8iiWMaZg+AkLbJBbH+Xu+M6ilqPO+E2KFdPYroi0mcxmd5ahb09T66q3/tnB5aqEvbIkgTp7vuH470NpqT9nRJaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=L/AKO6OV; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42ECLgg5008484;
	Thu, 14 Mar 2024 16:11:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=bU+OuOUBiYItdSMHewTGuq8gPvvZH7JVomcCgOz8k/4=; b=L/
	AKO6OVGC2VcgKp77wKZFEqvqbBXd+hnFlWsZ/uzX83aEj7/XCW7ElSSRQo5MovQp
	xugjjJssdGB+uYxV0lsZFDgOmO5q7XfTtjzTvViOmpLYeK5n/y6jjiLBINiO2lKG
	kzIxO+F70uzG5pMyXf7NpxE+dhOvrHW1eQj9LwMhxQVEnK1IHDhEOiSD8fRLVnpP
	TfhlB0L2HQ0ZGks2zU55wwqrj1esBTkYwK3sT+N7XsiZhiGfcSWiTrclWqX5DfCh
	B3RvlvsoKdZX0oFyuBSWklXZ2hWtZ4pdH45I6rBhHSavN/zfq6gcX/Y3w5iNl1aq
	B6mOjgpl+hOydCShVwGg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wtd6255qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 16:11:47 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9C0D240044;
	Thu, 14 Mar 2024 16:11:39 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AF51526FCF7;
	Thu, 14 Mar 2024 16:10:25 +0100 (CET)
Received: from [10.201.21.128] (10.201.21.128) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Mar
 2024 16:10:24 +0100
Message-ID: <51531046-ee83-4d99-836b-af4dc5d7add9@foss.st.com>
Date: Thu, 14 Mar 2024 16:10:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: net: add new property st,ext-phyclk
 in documentation for stm32
Content-Language: en-US
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
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <e2a98098-8ccd-4b8f-9a4b-1cbc0776a9c2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_12,2024-03-13_01,2023-05-22_02

Hi,

On 3/13/24 14:06, Krzysztof Kozlowski wrote:
> On 13/03/2024 11:39, Christophe ROULLIER wrote:
>> On 3/8/24 09:28, Krzysztof Kozlowski wrote:
>>> On 07/03/2024 14:59, Christophe Roullier wrote:
>>>> Add property st,ext-phyclk to manage cases when PHY have no cristal/quartz
>>>> This property can be used with RMII phy without cristal 50Mhz and when we
>>>> want to select RCC clock instead of ETH_REF_CLK
>>>> Can be used also with RGMII phy with no cristal and we select RCC clock
>>>> instead of ETH_CLK125
>>>>
>>> Nothing improved here. You say you add new property (wrote it explicitly
>>> in the subject), but where is it? Where is the user?
>>>
>>> I think we talked about this. Rob also asked quite clear:
>>>
>>>> That is obvious from the diff. What is not obvious is why we need a new
>>>> property and what is the problem with the existing ones.
>>> How did you solve it?
>> Hi,
>>
>> I do not understand your questions.
> OK, I will clarify some questions, but are you sure that this question:
> "How did you solve it?"
> needs clarification?
>
> If so, then let me clarify:
> Rob pointed issue. How did you resolve Rob's comment? How did you
> address it? What changed in your patch, that Rob's comment should be
> considered as addressed/resolved/done?
This property was introduced in 2020 in order to simplify management of 
all STM32 platforms without Ethernet cristal/quartz PHY.
>
> Now about my other question:
> "but where is it? Where is the user?"
>
> Your subject and commit message claim you add new property. This means
> such property was not existing so far in the Linux kernel. If you add
> new property in the binding, then I expect adding the user of that
> binding, thus my question: where is the user of that binding?
>
I'm preparing glue and DTS to upstream for STM32MP13 platform, this 
platform will use with property.

Since 2020, this property is available in the driver in kernel.org, so 
it is also possible that someone who has not upstreamed their

code also uses it.

>> That I would like to do, it is property "st,ext-phyclk" was introduced
>> in driver
>>
>> "drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c" in 2020, and YAML
>> was not updated at the time.
> Are you saying you document existing property or add a new one?
Yes, existing property, since 2020 in kernel.org.
>
>> Goal of this patch it is to update YAML to avoid dtbs check issue if
>> someone use this property :
>>
>>    dtbs check issue : views/kernel/upstream/net-next/arch/arm/boot/dts/st/stm32mp157c-dk2.dtb:
>> ethernet@5800a000: Unevaluated properties are not allowed
>> ('st,ext-phyclk' was unexpected)
> So DTS uses it?
Here it was example, if someone wants to use this property, but today 
this property is not yet present in DTS in kernel.org

>
> Are my questions now clear?
Thanks Krzysztof ;-)
> BTW, I asked some of them before and you
> just sent the same patch, so looks like ignored my questions.
>
> Best regards,
> Krzysztof
>

