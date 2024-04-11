Return-Path: <linux-kernel+bounces-140453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E638A8A14DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F5AB232A7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B62E38DD2;
	Thu, 11 Apr 2024 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HJaJJOT/"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5E52F52
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839490; cv=none; b=LmnNXqj92uN4lufQi3Tc1sD7/UD9TdqltDHd3BVedPFMv63Sin88Yh3RfBoa7qk2ZOy52U+/qior83gNYkzDj6gUgsh1p9/dNT2m5RxxIqdeJjpCwYJU+sbCFa8EcTMSi4RUnkGh4P9/IjweG2BbWs6J8dX4QE/hnBZ8EhmKd50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839490; c=relaxed/simple;
	bh=n9fFBXBQAgifB3t3+VC8PhRW9M9fgwbirEbgI6pHZR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WM3HODaWNP31FkMZR0TUL0NKBiAB7qNIWeQ3ywBfaKZsZrgssTxiTdSItsLPmi0bCM7CW8y3O6Dv4fsi8XqWQpDwRsn4ZFWRyVqRW9zkg6h2yzuoGDxqzSzFq+fX754mCVsn6XOfhM53FI8DSoila2C3wX/s3GI3Fo6LosOMgYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HJaJJOT/; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A66AC0003;
	Thu, 11 Apr 2024 12:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712839485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3oApABSdXJ3YBKN4Jik+XKbzpXTsTk/02nUEhDiAzw=;
	b=HJaJJOT/50lTpXAqToIrbS0RY2IheRCaOGvc6ZwcEpe1N/b6aLb86Fi+CmGVREd9XpgtMr
	QCnYyS/H/zmph7I+X3YH4OmSLfTesYbyyykTSMTAI63USd44kxkVVKKo9Wq+HcCru2yYP3
	jjm9di5fQwzc6lD+qf/pZVFb6uC05Eu4R1RbS47c37XMg7ywdCpPr9UYAjqV2pkeFGrhwh
	Dd2EYWtCCpLZlCS51L7ExfMBCs6Do5E7Pfd3bCzj9LyG0DqX7kgsGFzaGNrXmpuA1hI93J
	8B6Ds2EPQ3fswaGDN80ai+eIXljuqM5Q93FRb41Al/6rB0LuVrjREoE3+xdpSQ==
Message-ID: <28c5456d-535c-4ed9-b13a-fab7f50412be@bootlin.com>
Date: Thu, 11 Apr 2024 14:44:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] pps: clients: gpio: Bypass edge's direction check
 when not needed
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
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <c1e93cfe-371c-4855-9a13-b4b453bb9e88@enneenne.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Rodolfo

>>> diff --git a/drivers/pps/clients/pps-gpio.c 
>>> b/drivers/pps/clients/pps-gpio.c
>>> index 2f4b11b4dfcd..f05fb15ed7f4 100644
>>> --- a/drivers/pps/clients/pps-gpio.c
>>> +++ b/drivers/pps/clients/pps-gpio.c
>>> @@ -52,7 +52,9 @@ static irqreturn_t pps_gpio_irq_handler(int irq, 
>>> void *data)
>>>
>>>          info = data;
>>>
>>> -       rising_edge = gpiod_get_value(info->gpio_pin);
>>> +       rising_edge = info->capture_clear ? \
>>> +                       gpiod_get_value(info->gpio_pin) : \
>>> +                       !info->assert_falling_edge;
>>>          if ((rising_edge && !info->assert_falling_edge) ||
>>>                          (!rising_edge && info->assert_falling_edge))
>>>                  pps_event(info->pps, &ts, PPS_CAPTUREASSERT, data);
>>>
>>> Please, review and test it before resubmitting. :)
>>>
>>
>> I'll try this and send a V2 after my tests, thank you.
> 
> OK, thanks.
> 
> However we should think very well about this modification since it could 
> be the case where we have a device sending both assert and clear events 
> but we wish to catch just the asserts... in this case we will get 
> doubled asserts!
> 

My understanding is that clear events are to be captured only when this
capture_clear boolean is set. If it is not set, the PPS_CAPTURECLEAR
flag is not added to pps_source_info->mode and get_irqf_trigger_flags()
will return only one edge flag (rising or falling depending on
assert-falling-edge DT property).

By the way, I see that the capture_clear is never set since the legacy
platform data support has been dropped (commit ee89646619ba).


Best regards,
Bastien


