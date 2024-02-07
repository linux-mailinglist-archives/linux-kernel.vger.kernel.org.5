Return-Path: <linux-kernel+bounces-55927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5617284C37D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FDE1F25B7E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F461173C;
	Wed,  7 Feb 2024 04:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GDcWF9+U"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147C912E47;
	Wed,  7 Feb 2024 04:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707279704; cv=none; b=aZQgkhAj5belEOLUKVukxfOh9jUHNSeOUnI85z3NjNBSH7//N4CJKtrCw+cOpC4AAPmlC3YMXjlgATL6RME1Ea40Qnpd1SBcI6aaRc3HE4rL2gf4AVEwBoxL+4Nqpe02ibQojNL9QzjBl2OY6xYE0E4jpYnUG4l28IIp8qdEiKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707279704; c=relaxed/simple;
	bh=JlMYUCEGbfNjg9V4RzOWmQF7tZQ6hk2ya5k40YzeHkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQS+TJmUJMyDEMp7my8ldg7Wmkgs47Az83REDCDXzLc2eyH473xer/fJqkDB0KPFWBfKlVUa39ivqpO4Vp5oOnlccuqA3wNTL5SYsCbFYvCG+9/ErtxtfJgVudrX2gKo2fjwyUwkjAYFniPHG09iNPLvtK543j4Ii1vip+7YiAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=GDcWF9+U; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.106] (unknown [103.251.226.118])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 31FC8975;
	Wed,  7 Feb 2024 05:20:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1707279616;
	bh=JlMYUCEGbfNjg9V4RzOWmQF7tZQ6hk2ya5k40YzeHkw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GDcWF9+U2EWc9jjaaqwvKt958k1WsKqHwrzJQlkCc4GdRVRipYlxm2e8lc2ArdJCq
	 M79+HuXymzEInzm0P9Gsr1dbRdGoOGtWtHARZGFvQ3wB42FDzYLctuO688s922cR6k
	 Sq7o8ROgd2lkIJlGBsb0TrutXzj5C4cwMxGBQHyo=
Message-ID: <8bc8bf66-cde9-16c4-e8bd-389940ceeeb6@ideasonboard.com>
Date: Wed, 7 Feb 2024 09:51:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/5] media: i2c: imx335: Drop setting of 0x3a00
 register
To: Matthias Fend <matthias.fend@emfend.at>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20240131055208.170934-1-umang.jain@ideasonboard.com>
 <20240131055208.170934-2-umang.jain@ideasonboard.com>
 <170669477439.1011926.18210850208916698098@ping.linuxembedded.co.uk>
 <d3abce5f-5e99-4a8b-a45b-29b706bc8481@emfend.at>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <d3abce5f-5e99-4a8b-a45b-29b706bc8481@emfend.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 1/31/24 4:02 PM, Matthias Fend wrote:
> Hi Kieran,
>
> Am 31.01.2024 um 10:52 schrieb Kieran Bingham:
>> Hi Umang,
>>
>> + Cc: Matthias
>>
>> Quoting Umang Jain (2024-01-31 05:52:04)
>>> Register 0x3a00 is a reserved field as per the IMX335 datasheet,
>>> hence shouldn't be set by the driver.
>>
>> We still need to explain more about why we're dropping this register
>> write, and what effects it causes.
>>
>> Matthias - I believe this stemmed from the work you did, and I think I
>> recall that you stated this register write broke the CSI2 configuration?
>>
>> Can you clarify anything here for us please?
>
> yes, that's correct.
>
> Since this driver originally did not work in my setup, I came across 
> this register while searching for differences to my working reference 
> configuration.
> With the default value of this register (0x00), the driver works 
> perfectly. With the value previously written to it by the driver 
> (0x01), I cannot receive any frames.
> The problem may depend on the link frequency used.
> I can only use and test a frequency of 445.5MHz on my hardware. Since 
> only link frequencies of 594MHz were supported so far, this may not 
> have been a problem.
>
> Unfortunately I do not have a description of this register, so I can 
> only speculate about the exact cause.

Is it worth to frame the commit message around this speculation ?

My setup has no effect with this register being set or not.
>
> ~Matthias
>
>>
>> -- 
>> Kieran
>>
>>
>>>
>>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>>> ---
>>>   drivers/media/i2c/imx335.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
>>> index 7a37eb327ff4..927b4806a5d7 100644
>>> --- a/drivers/media/i2c/imx335.c
>>> +++ b/drivers/media/i2c/imx335.c
>>> @@ -249,7 +249,6 @@ static const struct imx335_reg 
>>> mode_2592x1940_regs[] = {
>>>          {0x3794, 0x7a},
>>>          {0x3796, 0xa1},
>>>          {0x37b0, 0x36},
>>> -       {0x3a00, 0x01},
>>>   };
>>>     static const struct imx335_reg raw10_framefmt_regs[] = {
>>> -- 
>>> 2.41.0
>>>


