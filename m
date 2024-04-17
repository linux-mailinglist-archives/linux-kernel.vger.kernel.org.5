Return-Path: <linux-kernel+bounces-148488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327AF8A8355
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBDCB282950
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D782213D24E;
	Wed, 17 Apr 2024 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V4duwP1a"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF112C80B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357963; cv=none; b=nxVqi4oIqwLlG8zbTh1WZbmQogngHMkVkyHbDUZmsrI7xWVR5GHm2+WxlPHv4qhowxe71b4XwW8GtnZzlyD4pr3N7Kt4c/zIMl4fwUeaRYkjiAd1CQ3OHXT8TnFInmo2Lb+lGkBTYwQURPQe4nTZGZ5xC6neks700KncDYrnqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357963; c=relaxed/simple;
	bh=BpDfj6K6uOzWGFxwYpcorDN3dmeqwSPWjsSyiakgnNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=DRJSpHxRLISgj6+AdcLKfr1/sOVoVcZtLylUAPBlmaxKWIXJgtKTWpES0Ei4ETBjhFEqxHnXQ5txp00o6Kd+iu9AYhPp+gcSrTLsobtKgN32XM2QWTTCAA+7qYnrpkSPvjryAa/Udjr+gmCjdSCaa5jggdQJPn2XwrSl2sQ/Dpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=V4duwP1a; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240417124557euoutp0234ab9683769c83986d59f21f0f8a5011~HEfwfhNJk1802118021euoutp02p
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:45:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240417124557euoutp0234ab9683769c83986d59f21f0f8a5011~HEfwfhNJk1802118021euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713357957;
	bh=jMsyPeaSfZB3Bp5BiMNyNkxY5JdlO/Ls0SekL1wNeFw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=V4duwP1aQ4eIN+MQvsGAy2kgyB5SKs9tiKIUCM1+SdQM1ssQCVcyLlR8Z5BfLnCPq
	 ZRcrhcLDUs6u8idT3n4v5ghyGEv8CCC4P3oA9V5rGe02drgBenuSzG/LGpV0MDQe4W
	 6vmJIviP5M5uqFYkRfbUSJAV0j2PKSE5WKuqc6H4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240417124557eucas1p1ed8ea22922afdca179d62737fd85fa23~HEfwSoywx1924719247eucas1p1Z;
	Wed, 17 Apr 2024 12:45:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id BE.F6.09875.584CF166; Wed, 17
	Apr 2024 13:45:57 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240417124557eucas1p2ba44b1c8081ba8c5926375606f837920~HEfv44kPf2304723047eucas1p2Z;
	Wed, 17 Apr 2024 12:45:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240417124557eusmtrp1c3ab13585dc407bfb19978d43a8ac5ca~HEfv4SNlt2359923599eusmtrp1N;
	Wed, 17 Apr 2024 12:45:57 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-13-661fc48585ba
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A1.AD.09010.484CF166; Wed, 17
	Apr 2024 13:45:57 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240417124556eusmtip16aa5e430bee4b8dbea9d2ad9e8547d8d~HEfva4Gkw1821218212eusmtip1q;
	Wed, 17 Apr 2024 12:45:56 +0000 (GMT)
Message-ID: <c26a049c-07ef-4837-9c1f-ac19b1251c3b@samsung.com>
Date: Wed, 17 Apr 2024 14:45:56 +0200
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
In-Reply-To: <783c05cd-0cd2-4b0e-9dce-2a9fdfee7c74@kernel.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djPc7qtR+TTDH6clLW4NeU3k8W2DhuL
	5sXr2SzezZWx6Ji8ncVi4v6z7BaXd81hszizuJfdgcNj06pONo871/aweeyfu4bd4/MmuQCW
	KC6blNSczLLUIn27BK6MHdf3sxU0ilRc3XiYqYFxmUAXIyeHhICJxOVVT5m6GLk4hARWMEqc
	nPuNEcL5wihx88cuVgjnM6PEwwWHmWFa3v9cB5VYziixZOo1qP6PjBITv29kAaniFbCTeHb5
	FJDNwcEioCqx51AgRFhQ4uTMJ2AlogLyEvdvzWAHsYUFPCWettxmBikXEXCUaP1bDTKSWeAu
	o8SM3VvZQGqYBcQlbj2ZzwRiswkYSnS97QKLcwKt+rpgOTtEjbxE89bZzCDNEgJ3OCRuzrnA
	DnG1i8S+u59ZIWxhiVfHt0DFZSROT+5hgWhoZ5RY8Ps+E4QzgVGi4fktRogqa4k7536xgZzH
	LKApsX6XPkTYUWLOjlusIGEJAT6JG28FIY7gk5i0bTozRJhXoqNNCKJaTWLW8XVwaw9euMQ8
	gVFpFlKwzELy5iwk78xC2LuAkWUVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYAI6/e/4
	lx2My1991DvEyMTBeIhRgoNZSYS3RVg2TYg3JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBA
	emJJanZqakFqEUyWiYNTqoGpYgnDczGR9MqO1/uc2ryuXp7yp2E5a2PbqkUixuHSi4/d/SL5
	r2uKXY71we9li2y/5S+u//0+94D24bMWi97I2L6ezZbY/WD/3pPC6555H2XRddZZIHCt0s8h
	69Qslde+yyxPb9M8+t353tvw6MK59+X4+3mldl2rOBnD8uEwD//+/+vunOQyu/Jkyvcpi65l
	z3kQ7/zhz+6GqTPWtBtpTFk/2e2ufAFHyNxy5ea1Ez5MyTu3I0p1UdrdsqRAlY1ZDVsyzlVF
	nHmc9bWFZXqOwQPRSQ2JvwKKFZcGMFuc+KHln922Y6/rrJ4/eyz/8j+XPKj3dGZL8Zqncc9S
	ombvFTj5IWfux5/idXK3xHZs36DEUpyRaKjFXFScCADYO4M0rwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t/xu7qtR+TTDB7vYLK4NeU3k8W2DhuL
	5sXr2SzezZWx6Ji8ncVi4v6z7BaXd81hszizuJfdgcNj06pONo871/aweeyfu4bd4/MmuQCW
	KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MHdf3
	sxU0ilRc3XiYqYFxmUAXIyeHhICJxPuf61hBbCGBpYwSC796QsRlJE5Oa2CFsIUl/lzrYuti
	5AKqec8ocezoJkaQBK+AncSzy6dYuhg5OFgEVCX2HAqECAtKnJz5hAXEFhWQl7h/awY7iC0s
	4CnxtOU2M0i5iICjROvfapCRzAL3GSUmvjzLDDG/j1li/6kdTCANzALiEreezAez2QQMJbre
	ghzBycEJtPfrguXsEDVmEl1buxghbHmJ5q2zmScwCs1CcscsJKNmIWmZhaRlASPLKkaR1NLi
	3PTcYiO94sTc4tK8dL3k/NxNjMB423bs55YdjCtffdQ7xMjEwXiIUYKDWUmEt0VYNk2INyWx
	siq1KD++qDQntfgQoykwLCYyS4km5wMjPq8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1
	OzW1ILUIpo+Jg1OqgUnxekcE56WfFfteX2wqd+BmO8olOtMjJOOOh6qYxeT4/CuLN4j1HCwS
	1ZXYqnRTybHN5DhbifCFuKTo8ms8RhFaGd+7FtUYfTt0pKxp58oZZt4elW6rHHTW+nXXrnc9
	d+FXpdESfm/udb5+hw+KeZxfJ6ATeHqnDbeq+0L1JL30Nuefs//4vu4Sy5q36F5zYEPc+19z
	7CXvvjwUUs+wf6U253+uExvrfnbm7FwbvD/ovMmt3d/OvTluo8yxLWLduzKmD/MuXsnet/h6
	7fklc9dLMp8RyHtkaMF72ObW/bBp+eZ6aelCDj/YkiYeczk/I2DZsu1nV9W6V6f1r95u//dx
	r8uJxi7TkEAzE2l5PyWW4oxEQy3mouJEAMY9OdNAAwAA
X-CMS-MailID: 20240417124557eucas1p2ba44b1c8081ba8c5926375606f837920
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

On 17.04.2024 12:50, Jiri Slaby wrote:
> On 17. 04. 24, 12:15, Marek Szyprowski wrote:
>> On 16.04.2024 12:23, Jiri Slaby wrote:
>>> On 15. 04. 24, 23:17, Marek Szyprowski wrote:
>>>> On 05.04.2024 08:08, Jiri Slaby (SUSE) wrote:
>>>>> This is a preparatory for the serial-to-kfifo switch. kfifo 
>>>>> understands
>>>>> only scatter-gatter approach, so switch to that.
>>>>>
>>>>> No functional change intended, it's just 
>>>>> dmaengine_prep_slave_single()
>>>>> inline expanded.
>>>>>
>>>>> And in this case, switch from dma_map_single() to dma_map_sg() too.
>>>>> This
>>>>> needs struct msm_dma changes. I split the rx and tx parts into an
>>>>> union.
>>>>> TX is now struct scatterlist, RX remains the old good phys-virt-count
>>>>> triple.
>>>>>
>>>>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>>>>> Cc: Bjorn Andersson <andersson@kernel.org>
>>>>> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>> Cc: linux-arm-msm@vger.kernel.org
>>>>
>>>> I've just found that this patch broke UART operation on DragonBoard
>>>> 410c. I briefly checked and didn't notice anything obviously wrong 
>>>> here,
>>>> but the board stops transmitting any data from its serial port 
>>>> after the
>>>> first message. I will try to analyze this issue a bit more tomorrow.
>>>
>>> I double checked, but I see no immediate issues in the patch too. So
>>> please, if you can analyze this more…
>>
>> I've spent some time digging into this issue and frankly speaking I
>> still have no idea WHY it doesn't work (or I seriously mixed something
>> in the scatterlist principles). However I found a workaround to make it
>> working. Maybe it will help a bit guessing what happens there.
> ...
>> @@ -434,7 +436,7 @@ static void msm_start_tx(struct uart_port *port)
>>           struct msm_dma *dma = &msm_port->tx_dma;
>>
>>           /* Already started in DMA mode */
>> -       if (sg_dma_len(&dma->tx_sg))
>> +       if (dma->mapped)
>
> Thanks for looking into this.
>
> I was hesitant if I should use a flag. I should have, apparently.
>
> Quick question:
> What's value of CONFIG_NEED_SG_DMA_LENGTH in your .config?


CONFIG_NEED_SG_DMA_LENGTH=y


I alse tried to change the "if (dma->mapped)" check in msm_start_tx() to:

1. if (dma->tx_sg.length)

2. if (dma->tx_sg.page_link & ~SG_PAGE_LINK_MASK)

but none of the above worked what is really strange and incomprehensible 
for me.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


