Return-Path: <linux-kernel+bounces-138947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8B389FC6A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD181C216D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657F91779B4;
	Wed, 10 Apr 2024 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q+l4o94X"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963E917799E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765147; cv=none; b=iGizPqVOq4ySCDs3vJLxIlCwfwybRe3eHeF0JbTxU7J/6KUCJPHOf/IQMXSaWPe2s74hSVKVLF6xkGfn1plwUDxNK+GiQJjjwWSFQ0OCX3cQVov2r5w6MbYPm4XexkcQuYlQIcYzxfo3RMpEXGGIMsJZEIBiOPZQSDY50viFl0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765147; c=relaxed/simple;
	bh=q1OwM/lv+mNRKAhZnlp5C9erYbH16E1eoGwveTPoZSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuEEM5KzCZgNM/sZqDpTqPymiai8lKQqkGAXlL4x0loas53Jene78J6n9qvlz3Jzuzz9y14fg1fw0nMTeRkXi3IwDvLfUq7Agqp3X3DPeGMGLl2ozozIGT8mr8ZNuaGzHjoCwutKr120v7uxDEGTaqyg6nZxPkDCsgEJ2t7E+Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q+l4o94X; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 291F31C0008;
	Wed, 10 Apr 2024 16:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712765141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I215nULcXPcF0y4OSCeEiUCWZw5Ocb6jrBa8iKPsC5w=;
	b=Q+l4o94XcAvQAG2s24PmwyXjNTWY3aepzHU+T5wiG0UqEWwaiCJ2pxnEN2PMZc7M+TqsZf
	PyQNcqaPhhToFwYjwWelmdYgHxRFmBXf2lrBpI2TVlZZOCGjzJktT1O4N5ryxK+kmLBN2M
	+3gXgl4sWDnfc1/LmC29b9gTYzLpCb13alnrtlNE/pAkKVzBm6broWFrjg3loRDIUL7pjD
	8WpuJMuznSfn1GwIcad4Vt3yUvRqQk8d4furjmr6X7RuUBhdyxV8vOzuoGo+uliOQ499vX
	FfSW/mPqrRVQgyi1Yplef/1k+1rOCPu3YaeoSaUPRtqcJ+vPQJoOQPTamlZz+A==
Message-ID: <27196117-32bc-4892-b545-d9cf43a89f0a@bootlin.com>
Date: Wed, 10 Apr 2024 18:05:40 +0200
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
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <eb64ec08-2ae3-48bb-9f84-3cec362280b2@enneenne.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com



On 4/10/24 17:24, Rodolfo Giometti wrote:
> On 10/04/24 16:46, Bastien Curutchet wrote:
>> Hi Rodolfo,
>>
>> On 4/10/24 16:23, Rodolfo Giometti wrote:
>>> On 10/04/24 13:35, Bastien Curutchet wrote:
>>>> In the IRQ handler, the GPIO's state is read to verify the direction of
>>>> the edge that triggered the interruption before generating the PPS 
>>>> event.
>>>> If a pulse is too short, the GPIO line can reach back its original 
>>>> state
>>>> before this verification and the PPS event is lost.
>>>>
>>>> This check is needed when info->capture_clear is set because it needs
>>>> interruptions on both rising and falling edges. When 
>>>> info->capture_clear
>>>> is not set, interruption is triggered by one edge only so this check 
>>>> can
>>>> be omitted.
>>>>
>>>> Bypass the edge's direction verification when info->capture_clear is 
>>>> not
>>>> set.
>>>>
>>>> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
>>>> ---
>>>>   drivers/pps/clients/pps-gpio.c | 9 +++++++++
>>>>   1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/drivers/pps/clients/pps-gpio.c 
>>>> b/drivers/pps/clients/pps-gpio.c
>>>> index 2f4b11b4dfcd..c2a96e3e3836 100644
>>>> --- a/drivers/pps/clients/pps-gpio.c
>>>> +++ b/drivers/pps/clients/pps-gpio.c
>>>> @@ -52,6 +52,15 @@ static irqreturn_t pps_gpio_irq_handler(int irq, 
>>>> void *data)
>>>>       info = data;
>>>> +    if (!info->capture_clear) {
>>>> +        /*
>>>> +         * If capture_clear is unset, IRQ is triggered by one edge 
>>>> only.
>>>> +         * So the check on edge direction is not needed here
>>>> +         */
>>>> +        pps_event(info->pps, &ts, PPS_CAPTUREASSERT, data);
>>>> +        return IRQ_HANDLED;
>>>> +    }
>>>> +
>>>>       rising_edge = gpiod_get_value(info->gpio_pin);
>>>>       if ((rising_edge && !info->assert_falling_edge) ||
>>>>               (!rising_edge && info->assert_falling_edge))
>>>
>>> Apart the code duplication, which are the real benefits of doing so?
>>>
>>
>> It prevents from losing a PPS event when the pulse is so short (or the
>> kernel so busy) that the trailing edge of the pulse occurs before the
>> interrupt handler can read the state of the GPIO pin.
> 
> Have you a real case when this happens?
> 

Yes, on my use case, a GPS provides a tiny pulse (~10 us) that is
sometimes missed when CPU is very busy.

> In any cases we should avoid code duplication... so I think we should do 
> something as below:
> 
> diff --git a/drivers/pps/clients/pps-gpio.c 
> b/drivers/pps/clients/pps-gpio.c
> index 2f4b11b4dfcd..f05fb15ed7f4 100644
> --- a/drivers/pps/clients/pps-gpio.c
> +++ b/drivers/pps/clients/pps-gpio.c
> @@ -52,7 +52,9 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void 
> *data)
> 
>          info = data;
> 
> -       rising_edge = gpiod_get_value(info->gpio_pin);
> +       rising_edge = info->capture_clear ? \
> +                       gpiod_get_value(info->gpio_pin) : \
> +                       !info->assert_falling_edge;
>          if ((rising_edge && !info->assert_falling_edge) ||
>                          (!rising_edge && info->assert_falling_edge))
>                  pps_event(info->pps, &ts, PPS_CAPTUREASSERT, data);
> 
> Please, review and test it before resubmitting. :)
> 

I'll try this and send a V2 after my tests, thank you.

Best regards,
Bastien

