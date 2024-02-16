Return-Path: <linux-kernel+bounces-68223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6C3857781
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297421F24630
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACF71BDE0;
	Fri, 16 Feb 2024 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="g7XQOp1V"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FB91BF20;
	Fri, 16 Feb 2024 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071397; cv=none; b=qIZjzk1iL20QbsAz8dPObrvQ1qot6ZMlKN/yn/c/G+r5oVKsBw/MICTBM6IBqjm3Ov6u8lrervWZHRYwfn27V9gZgNb2kZz+/TEgN3Ekj950flJ5+qQKbfJ4jgtTGekfSiRYPTM3wckN2PooZpqWMZ1YfaIXM4OOvFkRBau+xKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071397; c=relaxed/simple;
	bh=5XdTlNehqM/sgq2HTlmk7xbui8YbhbJ2Xu7diK2eQgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SKM1RB+yi/Ly183xjUu1iNPc2l74jNe8FSj6CAOnOmxaszn0F6wpoYQuf/N8ioVZzwVNeWBpHVGHC5Tz5u4ZCpqn8yMXvrEqWm5Gs5PjsEd5tcl0H60iBFawKSGAXwXapHzru2XMeh19/EFzGJ3W8yt1P7lvnhP4gVdgyvTsPZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=g7XQOp1V; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G4qAqA017067;
	Fri, 16 Feb 2024 09:15:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=G1rNROgGvt1dOvmHW2gd/e43IyoMcL9+m98W7EBpcp8=; b=g7
	XQOp1V+nIPlReI6SJT6CMuBGL7H2SuhaHJXnu9v9hpIwRFnQ5w7gLygZ0kZR4CHQ
	X6S8FImz+672szwKEBZOBm9275chzKyc3VsWdntR4AQ3LABXzR5EDAheT0gUSaQ6
	rXaO21iDo+5/NIcrlj2jV7k22rdQi9334C7IMnl9BhPTVkOZI9t2kT4988KkwLHL
	qIJ7MvdcXG0lEVEn3r7dETK7PG7tWVi3nVk6mGjG2S2u/dzAG1H5YmXnU2KOzh3B
	CVrUr0XSfPeXo85C1+ynoeJRV+rEVa5aHiDIJJL3kXzTrK8/jt+XZWFkTYVoeWV1
	60nZs6ljjf1xEQSrVXeg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wa12arjdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 09:15:55 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CD92840044;
	Fri, 16 Feb 2024 09:15:50 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 041FC2248C0;
	Fri, 16 Feb 2024 09:15:06 +0100 (CET)
Received: from [10.201.22.200] (10.201.22.200) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 16 Feb
 2024 09:15:05 +0100
Message-ID: <7d5af347-749a-43e3-8321-445569f5b78c@foss.st.com>
Date: Fri, 16 Feb 2024 09:15:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] memory: stm32-fmc2-ebi: add RIF support
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
 <20240212174822.77734-7-christophe.kerello@foss.st.com>
 <989661f0-f539-43c3-a332-13c0e99ed7b9@linaro.org>
 <edbb5e6e-44c0-426b-9c97-87ea1eee1b4c@foss.st.com>
 <1e1ae38b-7f8c-44ba-9970-0929aaaa28a8@linaro.org>
 <a1badd8b-041b-495d-81cb-b264c687de80@foss.st.com>
 <9c36b6e5-262d-48b1-971c-b03d9edf7789@linaro.org>
From: Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <9c36b6e5-262d-48b1-971c-b03d9edf7789@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_06,2024-02-14_01,2023-05-22_02



On 2/15/24 19:56, Krzysztof Kozlowski wrote:
> On 15/02/2024 10:00, Christophe Kerello wrote:
>>
>>
>> On 2/14/24 11:07, Krzysztof Kozlowski wrote:
>>> On 13/02/2024 14:15, Christophe Kerello wrote:
>>>>>> +
>>>>>> +	if (ebi->majrev < FMC2_VERR_MAJREV_2)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	if (resource >= FMC2_MAX_RESOURCES)
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>>> +	regmap_read(ebi->regmap, FMC2_SECCFGR, &seccfgr);
>>>>
>>>> Hi Krzysztof,
>>>>
>>>>>
>>>>> No checking of read value?
>>>>>
>>>>
>>>> No, it should never failed.
>>>
>>> And you tested that neither smatch, sparse nor Coverity report here
>>> warnings?
>>>
>>
>> Hi Krzysztof,
>>
>> There is a lot of driver in the Kernel that are using same
>> implementation, and I am surprised to not have had this comment 4 years
>> ago when the driver was introduced.
> 
> Really? Care to give some pointers? Heh, I don't know what to respond to
> it. Either you say that my comment is incorrect or you say that it's
> okay to sneak poor code if no one notices? We can argue on the first,
> whether my comment is reasonable or not. But if you claim that previous
> poor choice of code is argument of bringing more of such poor choices,
> then we are done here. It's the oldest argument: someone did it that
> way, so I can do the same. Nope.
> 
>>
>> So, how should I proceed? Shall I initialize all local variables used by
>> regmap_read? Or shall I check the return value of regmap_read?
>> And, as there is a lot of regmap_read call in this driver, shall I fix
>> them in a separate patch?
> 
> regmap operations, depending on the regmap used, can fail. Most of the
> errors are result of static configuration, e.g. alignment, regmap in
> cache mode etc. Then certain regmap implementations can produce errors,
> which is not a static condition but dynamic.
> 
> You have neither error checking nor value initialization. You risk here
> to have quite tricky to find, unnoticeable bugs, if there any mistake
> leading to regmap errors.
> 
> Indeed neither smatch nor sparse report this as error currently, but
> maybe that's their limitation?
> 

Hi Krzysztof,

I will check the return value of regmap_read API.

Regards,
Christophe Kerello.

> 
> Best regards,
> Krzysztof
> 

