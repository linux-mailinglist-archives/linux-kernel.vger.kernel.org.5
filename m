Return-Path: <linux-kernel+bounces-158054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625AB8B1AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C6F1C221F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404473D388;
	Thu, 25 Apr 2024 06:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EVHPE1B1"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84263D0AF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025488; cv=none; b=fHOH/TYADCiVEuOa2sQp6YxLP1ugek2U5tCb+5NBGKMi3QRSafEh6Jsj5K5HOP41ShLdS7l6M2AKld0Amlanhas4E+7B0u/UNjT36FC5GHgqmgDxdp+MZCZQRQxTJJo4g4EDZT6AbemP/V2fcCTlauR5T6UagMbWj1qqHKSYCDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025488; c=relaxed/simple;
	bh=p0hpYpxGMt97VjbYVT85DiU8Lp8LED9dvYRFtoc70HM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FS5WszLHcIa/XuIAo+onnPVwJKvW3aGNNhRDQwiMukDHoLafuz69tku4uDVrULb5UUtYGayH8sXjDWSVHWT22/xv4Pkw+tk019xp5d35pH4gduewAI4SgYQiFV5ZyENT8jjUh3lx3qOjfCnYwJLSEYLqpyKkxLhxumqrfftmhzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EVHPE1B1; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 997A960003;
	Thu, 25 Apr 2024 06:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714025482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhtOqdObLMFfH2uLM0X/i9rtom0+D5PtyZSHhXmLZx8=;
	b=EVHPE1B1beL0YKPpWgRV/cKJAHS+xA4/JMdGxqFgelknOP2BelLO7etQNEl10+acPhwMyb
	ySlIfn0cxw+rxnJygM+MXJ2T96hOYO6alZWHLyUSfNpcAm32x4Rd46Ey0+68QGHEVv6p3y
	RCx7CG2Ytf5oYJojIb/C4/7Kt8y+dtMkMPMf9FWzARFtwwmKGqtfu8/FBWHyKEgh+ttIss
	M3BW8+ViHvZ5TsgbrK47CHM7nsUJoxtzFmeb+/nysA0yF9Crg9Rvse3HWxVexXf5hhBlrt
	8MbQpRVbx1VuZc+aLDG+jI7deGh0K/DYWsXeKoM6GZI984Iu7m/Ej0BMz+yEXA==
Message-ID: <d4b4fb72-79e7-4e06-a038-4645574a799b@bootlin.com>
Date: Thu, 25 Apr 2024 08:11:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] pps: clients: gpio: Bypass edge's direction check
 when not needed
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240410113502.73038-1-bastien.curutchet@bootlin.com>
 <1f7f5b2f-54d4-4dc1-90ff-b896c930faed@enneenne.com>
 <5bda0980-2373-4284-bda4-89f0c6944e76@bootlin.com>
 <eb64ec08-2ae3-48bb-9f84-3cec362280b2@enneenne.com>
 <27196117-32bc-4892-b545-d9cf43a89f0a@bootlin.com>
 <c1e93cfe-371c-4855-9a13-b4b453bb9e88@enneenne.com>
 <28c5456d-535c-4ed9-b13a-fab7f50412be@bootlin.com>
 <9255124b-958e-4ab4-a812-67ad5d36e16d@enneenne.com>
 <6f064bd8-7937-4634-8a39-13ee5bcd6193@bootlin.com>
Content-Language: en-US
In-Reply-To: <6f064bd8-7937-4634-8a39-13ee5bcd6193@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Rodolfo,


On 4/12/24 14:20, Bastien Curutchet wrote:
> Hi Rodolfo,
> 
> On 4/12/24 08:44, Rodolfo Giometti wrote:
>> On 11/04/24 14:44, Bastien Curutchet wrote:
>>>>
>>>> However we should think very well about this modification since it 
>>>> could be the case where we have a device sending both assert and 
>>>> clear events but we wish to catch just the asserts... in this case 
>>>> we will get doubled asserts!
>>>>
>>>
>>> My understanding is that clear events are to be captured only when this
>>> capture_clear boolean is set. If it is not set, the PPS_CAPTURECLEAR
>>> flag is not added to pps_source_info->mode and get_irqf_trigger_flags()
>>> will return only one edge flag (rising or falling depending on
>>> assert-falling-edge DT property).
>>
>> Yes. You are right.
>>
>>> By the way, I see that the capture_clear is never set since the legacy
>>> platform data support has been dropped (commit ee89646619ba).
>>
>> I see, but it can be re-enabled in the future... In this scenario, I 
>> think we should add a DT entry to enable this special behavior. Maybe 
>> we can also add a warning as below: >
>> static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
>> {
>>          ...
>>          if ((rising_edge && !info->assert_falling_edge) ||
>>                          (!rising_edge && info->assert_falling_edge))
>>                  pps_event(info->pps, &ts, PPS_CAPTUREASSERT, data);
>>          else if (info->capture_clear &&
>>                          ((rising_edge && info->assert_falling_edge) ||
>>                          (!rising_edge && !info->assert_falling_edge)))
>>                  pps_event(info->pps, &ts, PPS_CAPTURECLEAR, data);
>>      else
>>          dev_warn_ratelimited(dev, "no ASSERT or CAPTURE event? "
>>              "Maybe you need support-tiny-assert-pulse?");
>>
>>          return IRQ_HANDLED;
>> }
>>
> 
> I'm not sure a DT entry is needed. IMO there are two cases:
>   1) capture_clear is unset. We need to capture only assert events,
>      interrupt will be triggered by assert edge only so there is no need
>      to check GPIO state: we can use the bypass.
>   2) capture_clear is set. We need to capture assert and/or clear
>      events, interrupt will be triggered by both assert and clear edges
>      so we can't avoid the GPIO state checking to distinguish clear
>      events from assert events: we can't use the bypass.
> 
> So if we bypass the GPIO's state check when capture_clear is unset and
> leave current behavior when capture_clear is set:
>   - case 1) will be more efficient and we won't lose tiny pulses anymore
>   - case 2) is unchanged: we still might lose tiny pulses but as bypass
> can't be done here, I think that we can't do better.
> 
> I agree that adding warning when the handler is left without triggering
> a pps event can be useful, I can add it in a V3 version.
> 

Would this be OK for you ? If yes, I'll send a V3 version without DT
entry but with an additional warning.


Best regards,
Bastien

