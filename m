Return-Path: <linux-kernel+bounces-139960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD328A099F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790B8282814
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C25C13DBB1;
	Thu, 11 Apr 2024 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="YdjJJIXh"
Received: from smtpdh20-2.aruba.it (smtpdh20-2.aruba.it [62.149.155.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417B713E04E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820239; cv=none; b=Z0rlk7zCImtJpDMqCV1jJlDAaTDCra9T2oMf1AVyJbRcWYwyLDuXwU1cctlubU5QpQrkEVA3iP63j2ERr348GKDkSXk9qeHza2iy3mzIFrbHHyACMFF1NwDoZCeFEOxONU7i9OQSV3jO78+dnV+mWRtqjQZWBiYVUpXjtUAhlug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820239; c=relaxed/simple;
	bh=VrywK8vMaYwbpYQvPGENaJzZBcgxgNbgsuu98ieZ/uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSoYTPkH8PTUAu5PPQtdQPJRxMbu2REUcv2HAMzB4DlEdhVSjaMROckZFYC+UqSTO8QtT/7wKh/N7tm0yXN8L/7DGQh4vve+5HJosgfsyw0pUJqjpwn/8hfzhh44s5QkZhrDNhHuSthcuOUnQrG57d2J08GALxf96i6t1PEAAfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=YdjJJIXh; arc=none smtp.client-ip=62.149.155.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.57] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id uojkr2Vp5wWj2uojkrpbFz; Thu, 11 Apr 2024 09:20:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712820044; bh=VrywK8vMaYwbpYQvPGENaJzZBcgxgNbgsuu98ieZ/uY=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=YdjJJIXh1cK5BvSTukjoSQKDooRx+BYrFek0vN76Jt3TMYpfj1itK/TpSJeoFSJqv
	 LNC4BpDNQSnbL1hsF7VeA7oGA19fZA8ywxSnjsNBXFovquZHuRG3jqOjlmHTkEQyse
	 9I3KkEBp7B5L3YbgKR5qmNwbV6+bKqJeBKIkiO3gEMHyawoI0eHy3ORCSmV7SRW71H
	 mJno+gpx6Q6Y9pvOfRXT0nyYv36vl/9M+dawWdEzrsxLWrj3CEdlvNNvyas5aBFhhi
	 P+Zul0G5HgsJoBuQKn6dRmb8ANQubk0pwdwNqzSDFqPVyo3pq2gGk+wv+14zItsprA
	 p+Au9rAjEHEew==
Message-ID: <c1e93cfe-371c-4855-9a13-b4b453bb9e88@enneenne.com>
Date: Thu, 11 Apr 2024 09:20:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] pps: clients: gpio: Bypass edge's direction check
 when not needed
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240410113502.73038-1-bastien.curutchet@bootlin.com>
 <1f7f5b2f-54d4-4dc1-90ff-b896c930faed@enneenne.com>
 <5bda0980-2373-4284-bda4-89f0c6944e76@bootlin.com>
 <eb64ec08-2ae3-48bb-9f84-3cec362280b2@enneenne.com>
 <27196117-32bc-4892-b545-d9cf43a89f0a@bootlin.com>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US, it, it-IT
In-Reply-To: <27196117-32bc-4892-b545-d9cf43a89f0a@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBf9SqngBaJytq1bLc3vrKUnXV0CQmAOXvhbl7fWYAFO/AjP4ml1SU80jtwuVs0tJRK373tBTDsfiFAwyN5nmxp3T0/Gp7MD0gavFm5Q5SFNG5A4YYhu
 5qsu3ysZHBRyaNYHZ6B7M+GL4KRYhqohZvccjruHY8YVI4vjiE9Aq5Si5QAitheYH30YnCkreEIrvYy6bcXVCyqQ1em0UpkvfvmoubPjUEjQ6pks1EH8DH0C
 E8tF8lI3/dNh+v27OTWrOtRLoF2iv+9gOGM+vINdF5XceCnx+/XgM2PeZf59ojyhjb/IG2Vn2F8C6F1Jx84nHLlOzqWT4K/0+eyutd3k/RkiMe81OyL1TGzw
 tgyzuOdnZrx444WCKwLgaf67SoaQGw==

On 10/04/24 18:05, Bastien Curutchet wrote:
> 
> 
> On 4/10/24 17:24, Rodolfo Giometti wrote:
>> On 10/04/24 16:46, Bastien Curutchet wrote:
>>> Hi Rodolfo,
>>>
>>> On 4/10/24 16:23, Rodolfo Giometti wrote:
>>>> On 10/04/24 13:35, Bastien Curutchet wrote:
>>>>> In the IRQ handler, the GPIO's state is read to verify the direction of
>>>>> the edge that triggered the interruption before generating the PPS event.
>>>>> If a pulse is too short, the GPIO line can reach back its original state
>>>>> before this verification and the PPS event is lost.
>>>>>
>>>>> This check is needed when info->capture_clear is set because it needs
>>>>> interruptions on both rising and falling edges. When info->capture_clear
>>>>> is not set, interruption is triggered by one edge only so this check can
>>>>> be omitted.
>>>>>
>>>>> Bypass the edge's direction verification when info->capture_clear is not
>>>>> set.
>>>>>
>>>>> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
>>>>> ---
>>>>>   drivers/pps/clients/pps-gpio.c | 9 +++++++++
>>>>>   1 file changed, 9 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
>>>>> index 2f4b11b4dfcd..c2a96e3e3836 100644
>>>>> --- a/drivers/pps/clients/pps-gpio.c
>>>>> +++ b/drivers/pps/clients/pps-gpio.c
>>>>> @@ -52,6 +52,15 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void 
>>>>> *data)
>>>>>       info = data;
>>>>> +    if (!info->capture_clear) {
>>>>> +        /*
>>>>> +         * If capture_clear is unset, IRQ is triggered by one edge only.
>>>>> +         * So the check on edge direction is not needed here
>>>>> +         */
>>>>> +        pps_event(info->pps, &ts, PPS_CAPTUREASSERT, data);
>>>>> +        return IRQ_HANDLED;
>>>>> +    }
>>>>> +
>>>>>       rising_edge = gpiod_get_value(info->gpio_pin);
>>>>>       if ((rising_edge && !info->assert_falling_edge) ||
>>>>>               (!rising_edge && info->assert_falling_edge))
>>>>
>>>> Apart the code duplication, which are the real benefits of doing so?
>>>>
>>>
>>> It prevents from losing a PPS event when the pulse is so short (or the
>>> kernel so busy) that the trailing edge of the pulse occurs before the
>>> interrupt handler can read the state of the GPIO pin.
>>
>> Have you a real case when this happens?
>>
> 
> Yes, on my use case, a GPS provides a tiny pulse (~10 us) that is
> sometimes missed when CPU is very busy.

I see...

>> In any cases we should avoid code duplication... so I think we should do 
>> something as below:
>>
>> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
>> index 2f4b11b4dfcd..f05fb15ed7f4 100644
>> --- a/drivers/pps/clients/pps-gpio.c
>> +++ b/drivers/pps/clients/pps-gpio.c
>> @@ -52,7 +52,9 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
>>
>>          info = data;
>>
>> -       rising_edge = gpiod_get_value(info->gpio_pin);
>> +       rising_edge = info->capture_clear ? \
>> +                       gpiod_get_value(info->gpio_pin) : \
>> +                       !info->assert_falling_edge;
>>          if ((rising_edge && !info->assert_falling_edge) ||
>>                          (!rising_edge && info->assert_falling_edge))
>>                  pps_event(info->pps, &ts, PPS_CAPTUREASSERT, data);
>>
>> Please, review and test it before resubmitting. :)
>>
> 
> I'll try this and send a V2 after my tests, thank you.

OK, thanks.

However we should think very well about this modification since it could be the 
case where we have a device sending both assert and clear events but we wish to 
catch just the asserts... in this case we will get doubled asserts!

Maybe, can we add a special flag within the DTS (something as 
"support-tiny-pulses" or something like that) to specify that we are in this 
special condition and then checking this setting against capture_clear flag?

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


