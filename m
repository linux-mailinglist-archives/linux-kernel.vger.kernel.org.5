Return-Path: <linux-kernel+bounces-151139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C768AA99E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E14284FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A06D4C63D;
	Fri, 19 Apr 2024 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gBW0EeNi"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C983E485
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513657; cv=none; b=W0yAMJU2m2cvns/Ak5BZGFTPA5oz89Ryfqu9R+U7oxQkPNtNCs0qW0uagOXxH51O43QAMUQRGq//6esQ/wk59RHrTQjePv4UMkEouU0NcUcdrJ0QrgqiravWkiAY484EhaSyYei1oMjbJ0ZC5KDf2Jfj5kFSYkVT3nTSlGf0qhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513657; c=relaxed/simple;
	bh=AgrdqcfcVenz/u2x8vvoZSIcULG4CY5K/v+Edvos+bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=M2lRJxB0KT4dsoOzdPGtSDVK0CtSnu9tsoHZYHcCXoUKEoSnDv9JPpdkNSClEBcSaJWyiPs/dyc8IuLqba63bRkeeee7q7OeI0TA+l/lHlLpB9qwuxRMdPxCOb5ARmwrrg5ouqiG659Ubk9KRUTUtiR5Ctsl3ZZsv92L5j8iIPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gBW0EeNi; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240419080048euoutp01eb15e156885f5f0ec3fe9cb106e4bf94~Hn5WxhkxF1076610766euoutp01K
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:00:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240419080048euoutp01eb15e156885f5f0ec3fe9cb106e4bf94~Hn5WxhkxF1076610766euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713513648;
	bh=J9bihqNNeBouBSVdYnB6FnDBnwZNOKQIvLcjL9JmkYw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=gBW0EeNiw1nnZA5YaD7ATlgFadq/boYP+dQhquA3i4syUWnxNENtPHg4aovQSzg0I
	 qaMVUZmAZIRtuuWz/u2mUPL7dinx3KF+IscS8Y/8AXX5dhL7Si976oZ+5bqa6CTs35
	 SJjtKRu19SjF2GyjxbmmmnZrk7JJ0L8ZSR55gBCg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240419080048eucas1p19edea2062fc38a56d38e09d4fdc612bb~Hn5WbO-MQ2067220672eucas1p1u;
	Fri, 19 Apr 2024 08:00:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 5E.95.09875.0B422266; Fri, 19
	Apr 2024 09:00:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240419080047eucas1p2c8bf21f4654b592ec250f04c76eee380~Hn5WIvRYQ2267722677eucas1p2b;
	Fri, 19 Apr 2024 08:00:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240419080047eusmtrp20f97472dc91695be666a2963f1cac9d7~Hn5WIH6_s2364823648eusmtrp2r;
	Fri, 19 Apr 2024 08:00:47 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-9c-662224b0da16
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 5A.E1.08810.FA422266; Fri, 19
	Apr 2024 09:00:47 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240419080047eusmtip28a71cb280150640c6b7b24ddda1a9e4a~Hn5VnrEMi0746207462eusmtip29;
	Fri, 19 Apr 2024 08:00:47 +0000 (GMT)
Message-ID: <cbf77a8b-b37c-41d8-a7b5-a1c935571a1d@samsung.com>
Date: Fri, 19 Apr 2024 10:00:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] tty: msm_serial: use dmaengine_prep_slave_sg()
To: Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn
	Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <cbf6d34a-663c-440d-84e2-86054c605c8e@kernel.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djPc7obVJTSDM6sZLW4NeU3k8W2DhuL
	5sXr2SzezZWx6Ji8ncVi4v6z7BaXd81hszizuJfdgcNj06pONo871/aweeyfu4bd4/MmuQCW
	KC6blNSczLLUIn27BK6MA3/3MBc84a/oWHqRsYFxAm8XIyeHhICJRMeEs+wgtpDACkaJE1c0
	uhi5gOwvjBJ/+6ayQDifGSVerr/ACNPR3raGFSKxnFHizuKdUFUfGSWe3rgBlOHg4BWwk/jX
	Eg3SwCKgKvH2yHSwFbwCghInZz5hAbFFBeQl7t+aARYXFvCUeNpymxmkVUTAUaL1bzXISGaB
	u4wSM3ZvZQOpYRYQl7j1ZD4TiM0mYCjR9bYLLM4JtGrdxbvMEDXyEs1bZzODNEsI3OGQWHNo
	PjvE1S4Sv+euZYKwhSVeHd8CFZeR+L8TZChIQzujxILf96GcCYwSDc9vQf1sLXHn3C82kPOY
	BTQl1u/Shwg7SszZcQvsYQkBPokbbwUhjuCTmLRtOjNEmFeio00IolpNYtbxdXBrD164xDyB
	UWkWUrDMQvLmLCTvzELYu4CRZRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZg+jn97/iX
	HYzLX33UO8TIxMF4iFGCg1lJhNeMQzFNiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6
	YklqdmpqQWoRTJaJg1OqgSm779TvgKj1lcV9jNcalhue/7r0yTaxe4vTtEX3TbslNFnzbYhS
	zT39JK7py3J8g+f2nE44r70htGZCqpzgrtrPOi/qnXaWrLu7a+n5J8Yq9mdKv9UFzf8QxaK2
	/arEnOuv5p+4svrt6bMCpztW3plXF83J6B+w++nf8IiVv8OfJLlmtmcfi9rf+Drs62X21ffN
	LoZui11jX+FQ/Um231HL3yjLue2uxh5nxUfvCzhOFdYJLyxev/KKw+qEgqdWnPu2HTt0SXsL
	y+p5LpkB1vnLn/8XiVmZ2Lmm0/nW5zu7Tv65vJX3/uz91s/2rMlaYM62iWmpvTpTh9njraqJ
	CVuu/w5Wm1/dfHzO3dvLggzjlViKMxINtZiLihMBShR3aK4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xe7rrVZTSDK5e0bO4NeU3k8W2DhuL
	5sXr2SzezZWx6Ji8ncVi4v6z7BaXd81hszizuJfdgcNj06pONo871/aweeyfu4bd4/MmuQCW
	KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MA3/3
	MBc84a/oWHqRsYFxAm8XIyeHhICJRHvbGtYuRi4OIYGljBI9kx6xQyRkJE5Oa2CFsIUl/lzr
	YoMoes8ocWHFWyCHg4NXwE7iX0s0SA2LgKrE2yPTwXp5BQQlTs58wgJiiwrIS9y/NQMsLizg
	KfG05TYzSKuIgKNE699qkJHMAvcZJSa+PMsMMX81i8TvlplgDcwC4hK3nsxnArHZBAwlut6C
	HMHJwQm0d93Fu8wQNWYSXVu7GCFseYnmrbOZJzAKzUJyxywko2YhaZmFpGUBI8sqRpHU0uLc
	9NxiQ73ixNzi0rx0veT83E2MwIjbduzn5h2M81591DvEyMTBeIhRgoNZSYTXjEMxTYg3JbGy
	KrUoP76oNCe1+BCjKTAwJjJLiSbnA2M+ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7
	NbUgtQimj4mDU6qBSfwDl3PcTr8lKz5XHPi9rmlK//slITLGwt/LlzQZN0xlbyg85t/EsfBj
	kkDIuSznexsieyMr7i37+/B23uevfO2C3xjMMndVefy2WvrperPcnCb3I6cv5AfmnzxccuTa
	Ks6XO3dl3XnPEX9ZWWuX8C3bVtW22kABxd0dgavd9rktfVO64e+WKoY5Gw4d/LMv95CIg3Hu
	U9X5f3kfKz/tnBv597Ea1+b1EzdOWW10W8itUbnAZOE2QT9n/yhhk6KU16bp/UzFzY0VxScv
	X3p6O3ndkiQf94Ajka8jv4nxrt+yP3teA0/exNwCs2UGoc92p0+0Ynmxocj0nXONW72eYlu4
	T4xn/VqNyH9FHJNXK7EUZyQaajEXFScCAICzG1BBAwAA
X-CMS-MailID: 20240419080047eucas1p2c8bf21f4654b592ec250f04c76eee380
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240415211716eucas1p10050cc8d4024707dd6f6331111cd3ce1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240415211716eucas1p10050cc8d4024707dd6f6331111cd3ce1
References: <20240405060826.2521-1-jirislaby@kernel.org>
	<20240405060826.2521-12-jirislaby@kernel.org>
	<CGME20240415211716eucas1p10050cc8d4024707dd6f6331111cd3ce1@eucas1p1.samsung.com>
	<d3eb9f21-f3e1-43ec-bf41-984c6aa5cfc8@samsung.com>
	<54679d54-3957-489d-a8b5-b98ea1c8a93c@kernel.org>
	<0335b679-da36-42c1-a1ba-8affb7a98d44@samsung.com>
	<783c05cd-0cd2-4b0e-9dce-2a9fdfee7c74@kernel.org>
	<c26a049c-07ef-4837-9c1f-ac19b1251c3b@samsung.com>
	<8947962f-e39e-4e96-9d1e-691e40d49349@kernel.org>
	<cbf6d34a-663c-440d-84e2-86054c605c8e@kernel.org>

On 19.04.2024 09:53, Jiri Slaby wrote:
> On 19. 04. 24, 9:43, Jiri Slaby wrote:
>> On 17. 04. 24, 14:45, Marek Szyprowski wrote:
>>> I alse tried to change the "if (dma->mapped)" check in 
>>> msm_start_tx() to:
>>>
>>> 1. if (dma->tx_sg.length)
>>>
>>> 2. if (dma->tx_sg.page_link & ~SG_PAGE_LINK_MASK)
>>>
>>> but none of the above worked what is really strange and 
>>> incomprehensible
>>> for me.
>>>
>>
>> Aaaah, nevermind, what about this?
>>
>> Two bugs:
>> 1) dma_map_sg() returns the number of mapped entries. Not zero!
>> 2) And I forgot to zero tx_sg in case of error.
>>
>> --- a/drivers/tty/serial/msm_serial.c
>> +++ b/drivers/tty/serial/msm_serial.c
>> @@ -506,8 +506,8 @@ static int msm_handle_tx_dma(struct msm_port 
>> *msm_port, unsigned int count)
>>          kfifo_dma_out_prepare(&tport->xmit_fifo, &dma->tx_sg, 1, 
>> count);
>>
>>          ret = dma_map_sg(port->dev, &dma->tx_sg, 1, dma->dir);
>> -       if (ret)
>> -               return ret;
>> +       if (!ret)
>
> Still wrong, ret = -EIO missing in here.

"if (ret <= 0)" seems to be better here.

Indeed this fixed the issue. I checked the code many times, but I missed 
this dma_map_sg() return value issue.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

>
>> +               goto zero_out;
>>
>>          dma->desc = dmaengine_prep_slave_sg(dma->chan, &dma->tx_sg, 1,
>>                                                  DMA_MEM_TO_DEV,
>> @@ -548,6 +548,7 @@ static int msm_handle_tx_dma(struct msm_port 
>> *msm_port, unsigned int count)
>>          return 0;
>>   unmap:
>>          dma_unmap_sg(port->dev, &dma->tx_sg, 1, dma->dir);
>> +zero_out:
>>          sg_init_table(&dma->tx_sg, 1);
>>          return ret;
>>   }
>>
>>
>> thanks,
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


