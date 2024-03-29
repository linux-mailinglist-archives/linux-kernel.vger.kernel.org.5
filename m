Return-Path: <linux-kernel+bounces-124272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A53A8914F0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C14F1C23E09
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F4444C92;
	Fri, 29 Mar 2024 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="cvhrZWSP"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974EA3B78E;
	Fri, 29 Mar 2024 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699135; cv=none; b=MkovHR/X4byqRCurghL970pc/5M3e4bu0KzR3ZIxulps34PwYaWY96Cag10mV9Nkd7aqUe+PoBzEi91EecWEEYYFv1jt8jpHYmkxPlhLbrLuq/428y2IAfnUsPhMW9TmGMpcnh3hqkx2z44ROmNbRw++aoYvwdubZrZkh6sg6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699135; c=relaxed/simple;
	bh=yBqdFYWJ7meNuEn1L+kQXqFNRWSolH3SOPxtgfU/HK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEeliS1vbSc9qhFXoZFUH47Il+JsyRDEHvBykRLbDPawxgSQMOD9671IRIYnjycZGLsF8P7GwhRSPYZq4MHNk7Oq53/TVoxOL08uI6hHj8k4gFtTEO64aLwyiBs4IORfhZPWdL1GbwP1WwNK5Jdrjip/N5HfZd+inEtFlDrNZsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=cvhrZWSP; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VB+uYV6z1osfsY3qvVmgNrhkcULtGFhdn5kc4Qzej/U=; b=cvhrZWSPR+Yv98T3SACOGJoTbj
	/92sDiJPAIdKFqbQpQFDxMGds6Uuaeq2/bq2G7ogYz0lhvXlUFmMJYmVfB24YK2oxkIoBS7oGwP6H
	f3SuFIA1xiz8tK2pps/Xz9w3rPTyNkw2YAbbCzeQ8vOaQ7ZX10a5GJmpvcPmkmExS522ncxG91xoJ
	6ztsz0ABBW+TDQ/u4xJw9f+6TjnMnq8uEmQ87toUtLjaes0+PPk9H0of8LUj1k2xnDYqVQKh41Ojh
	ykIg9heBPjNsW++47JxBTJmOqRwi/aXWC3zLxoe10Zr/eWzPhKJuxbmCypAq/3ojpIWAypOqgLykp
	28fVe3nQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:57518 helo=[192.168.69.116])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1rq78Q-009wAj-2G;
	Fri, 29 Mar 2024 08:58:46 +0100
Message-ID: <d9a233d6-95cd-4901-9c06-d8319f2eb3b4@norik.com>
Date: Fri, 29 Mar 2024 08:58:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 0/2] i.MX93 ADC calibration settings
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Andrej Picej <andrej.picej@norik.com>, Jonathan Cameron
 <jic23@kernel.org>, devicetree@vger.kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, krzysztof.kozlowski+dt@linaro.org, imx@lists.linux.dev,
 linux-iio@vger.kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
 upstream@lists.phytec.de, linux-kernel@vger.kernel.org, haibo.chen@nxp.com,
 kernel@pengutronix.de, shawnguo@kernel.org, robh@kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240320100407.1639082-1-andrej.picej@norik.com>
 <20240324135559.1640551d@jic23-huawei>
 <3423ea96-859d-4c4b-a9a7-e0d9c3c00727@norik.com>
 <44ac8977-cf98-46a5-be15-1bec330c6a2e@norik.com>
 <20240325144555.00002d16@Huawei.com>
From: Primoz Fiser <primoz.fiser@norik.com>
Organization: Norik systems d.o.o.
In-Reply-To: <20240325144555.00002d16@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Jonathan,

On 25. 03. 24 15:45, Jonathan Cameron wrote:
> On Mon, 25 Mar 2024 09:55:23 +0100
> Primoz Fiser <primoz.fiser@norik.com> wrote:
> 
>> Hi Jonathan,
>>
>> On 25. 03. 24 09:32, Andrej Picej wrote:
>>> Hi Jonathan,
>>>
>>> On 24. 03. 24 14:55, Jonathan Cameron wrote:  
>>>> On Wed, 20 Mar 2024 11:04:04 +0100
>>>> Andrej Picej <andrej.picej@norik.com> wrote:
>>>>  
>>>>> Hi all,
>>>>>
>>>>> we had some problems with failing ADC calibration on the i.MX93 boards.
>>>>> Changing default calibration settings fixed this. The board where this
>>>>> patches are useful is not yet upstream but will be soon (hopefully).  
>>>>
>>>> Tell us more.  My initial instinct is that this shouldn't be board
>>>> specific.
>>>> What's the trade off we are making here?  Time vs precision of
>>>> calibration or
>>>> something else?  If these are set to a level by default that doesn't work
>>>> for our board, maybe we should just change them for all devices?
>>>>  
>>
>> The imx93_adc driver is quite new.
>>
>> If you look at line #162, you will find a comment by the original author:
>>
>>> 	/*
>>> 	 * TODO: we use the default TSAMP/NRSMPL/AVGEN in MCR,
>>> 	 * can add the setting of these bit if need in future.
>>> 	 */  
>>
>> URL:
>> https://github.com/torvalds/linux/blob/master/drivers/iio/adc/imx93_adc.c#L162
>>
>> So, for most use-cases the default setting should work, but why not make
>> them configurable?
>>
>> So this patch-series just implement what was missing from the beginning
>> / was planned for later.
> Hi Primoz,
> 
> I doubt anyone reviewed the comment closely enough to say if what it was
> suggesting was sensible or not, so the fact it was listed as a todo
> doesn't directly impact this discussion.

I agree.

However on the other hand, since we stumbled upon a use-case that
requires adjusting the driver provided default settings of the i.MX93
ADC, this TODO to us is and was a clear indication from the original
author that the driver needs little TLC.

Anyhow, a stance from the author/NXP would be highly welcoming in this
situation.

BR,
Primoz


> 
>>
>> BR,
>> Primoz
>>
>>
>>>
>>> So we have two different boards with the same SoC. On one, the
>>> calibration works with the default values, on the second one the
>>> calibration fails, which makes the ADC unusable. What the ADC lines
>>> measure differ between the boards though. But the implementation is
>>> nothing out of the ordinary.
>>>
>>> We tried different things but the only thing that helped is to use
>>> different calibration properties. We tried deferring the probe and
>>> calibration until later boot and after boot, but it did not help.
>>>
>>> In the Reference Manual [1] (chapter 72.5.1) it is written:
>>>   
>>>> 4. Configure desired calibration settings (default values kept for
>>>> highest accuracy maximum time).  
>>>
>>> So your assumption is correct, longer calibration time (more averaging
>>> samples) -> higher precision. The default values go for a high accuracy.
>>> And since we use a NRSMPL (Number of Averaging Samples) of 32 instead of
>>> default 512, we reduce the accuracy so the calibration values pass the
>>> internal defined limits.
> 
> Ouch.  Let me try to dig into this. Is this effectively relaxing the
> constraints? I guess because a value that is perhaps always biased one way
> is considered within bounds if those acceptable bounds are wider because
> of lower precision?
> 
> I was assuming it was the other way around and the device had fixed constraint
> limits and you needed to take more samples due to higher noise. Seems the
> opposite is true here and that worries me.
> 
> I'll definitely need input from NXP on this as a workaround and their
> strong support to consider it.
> 
>>>
>>> I'm not sure that changing default values is the right solution here. We
>>> saw default values work with one of the boards. And since the NXP kept
>>> these values adjustable I think there is a reason behind it.
> 
> I'd assume trade off between time and calibration precision, not the
> sort of use I think you are describing.
> 
>>>
>>> Note: When I say one of the boards I mean one board form. So same board
>>> version, but different HW.
> 
> Superficially I'm struggling to not see this as broken hardware that it
> is out of expected tolerances in some fashion.  Maybe I misunderstood
> the issue.
> 
> Jonathan
> 
>>>
>>> Best regards,
>>> Andrej
>>>
>>> [1] i.MX 93 Applications Processor Reference Manual, Rev. 4, 12/2023
>>> _______________________________________________
>>> upstream mailing list
>>> upstream@lists.phytec.de
>>> http://lists.phytec.de/cgi-bin/mailman/listinfo/upstream  
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Primoz Fiser                    | phone: +386-41-390-545
<tel:+386-41-390-545> |
---------------------------------------------------------|
Norik systems d.o.o.            | https://www.norik.com
<https://www.norik.com>  |
Your embedded software partner  | email: info@norik.com
<mailto:info@norik.com> |
Slovenia, EU                    | phone: +386-41-540-545
<tel:+386-41-540-545> |


