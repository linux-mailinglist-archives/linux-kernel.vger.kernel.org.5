Return-Path: <linux-kernel+bounces-138867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F6989FB71
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55BFA1F226B5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC0116E878;
	Wed, 10 Apr 2024 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="HF2iuE8O"
Received: from smtpcmd12132.aruba.it (smtpcmd12132.aruba.it [62.149.156.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C4215EFBF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762684; cv=none; b=Q2GnfU72OeRIBffkLclsm3rh9YiNKKLCLrCOiod5TvjpkfVBAOVmHPxxiVelKcHwszPpU7KpDY+/cDr8ZnLl8IXb+WLfnvdeMJrKMbcfgLbFIb6TxU4qZybX9+k5p58NPmOweS5jveTcflqu4lwNWTolObdevmhIR5oYv4RXtLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762684; c=relaxed/simple;
	bh=CRX2sZFoterpLExGp9AhHbUNfoi2I3/L4o/bxWL2LEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRYf5+b6SwmCQb7tvDGcxTGAdCyJESgoltbH2aK1rGI+da1uJOXSygJH1Nrf5y5dGUunxK273s+CkYvIoQZv551lA9Cr+3RKvUboYOZTK5tHr0TZdF+uOW5tTtPfGvyhWiC1GLdsTw6MPjf7Srz/RgQAfVv5+hHteu62Ie8xCiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=HF2iuE8O; arc=none smtp.client-ip=62.149.156.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.57] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id uZoRrFlyJJV7NuZoSrgLvF; Wed, 10 Apr 2024 17:24:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712762676; bh=CRX2sZFoterpLExGp9AhHbUNfoi2I3/L4o/bxWL2LEQ=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=HF2iuE8O2H10jzz4Y/xkCXrB+SayUesQ0s0SlGSE9FujIYQbA3sj28CmBubzHhbCc
	 0yRJCMr4gWXW1VwloLwVnZ6EIPpIyPLQfan8ycrsdBgV1sbCW4NWQ5R7HCFsUD8XlA
	 cQ8X8cxcAJz4qYRVjQUz4Lw/jr2p6jK2l5gcNwYZKfSCCZvn1oj4IcJv1sqNtBe1Jo
	 98IoX3fReDDlQhcczpPmVQNDxEVSfLn4FUSt0fRefW9cVyTVx/latNWIN4ClXoSfJw
	 by6YOfaJ1F046UkMwXIsPnrmySTYyXjZ3P8hklKOMrRCtiqrrx2v/ymurnRUchuUbH
	 iEZIY/NA6xarA==
Message-ID: <eb64ec08-2ae3-48bb-9f84-3cec362280b2@enneenne.com>
Date: Wed, 10 Apr 2024 17:24:36 +0200
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
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US, it, it-IT
In-Reply-To: <5bda0980-2373-4284-bda4-89f0c6944e76@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDBmX1GrQrYn1+T+7wJZoy7SDZ1SVG3J5LAE9pxcFI2RdP0AkGKyaYYUm7DGea7kx8LGMBVVXq1u2RdBcAyZEasbrO7y4FX/nK/NiXUeDkO8IkaHNTY/
 n2BJ+QPMiSps1ws4tTJQGhM8WP0TQ+JuE+Hy5i1u9Pzt/AxCGHxAJTFPkB/HmitOJbZjw2tIAaVYgpJ+BLDgtc7AIwIR2TLJYfy0NXEg8dweCNuQOEo3zp2f
 zXrH7aJHsuExGUn0LGZfi5BAmq23Xt/fK9b0S0uguGVVWjyqMgs4PnzNVwFAIFU2tAnrFAgVQpcmlMApdffFYVn0e48qdhgvcstXLqQhX+UWY2LpA3T1xS9M
 OxJQqe8Ab3YwFzeAOODSUauMHu17vQ==

On 10/04/24 16:46, Bastien Curutchet wrote:
> Hi Rodolfo,
> 
> On 4/10/24 16:23, Rodolfo Giometti wrote:
>> On 10/04/24 13:35, Bastien Curutchet wrote:
>>> In the IRQ handler, the GPIO's state is read to verify the direction of
>>> the edge that triggered the interruption before generating the PPS event.
>>> If a pulse is too short, the GPIO line can reach back its original state
>>> before this verification and the PPS event is lost.
>>>
>>> This check is needed when info->capture_clear is set because it needs
>>> interruptions on both rising and falling edges. When info->capture_clear
>>> is not set, interruption is triggered by one edge only so this check can
>>> be omitted.
>>>
>>> Bypass the edge's direction verification when info->capture_clear is not
>>> set.
>>>
>>> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
>>> ---
>>>   drivers/pps/clients/pps-gpio.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
>>> index 2f4b11b4dfcd..c2a96e3e3836 100644
>>> --- a/drivers/pps/clients/pps-gpio.c
>>> +++ b/drivers/pps/clients/pps-gpio.c
>>> @@ -52,6 +52,15 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
>>>       info = data;
>>> +    if (!info->capture_clear) {
>>> +        /*
>>> +         * If capture_clear is unset, IRQ is triggered by one edge only.
>>> +         * So the check on edge direction is not needed here
>>> +         */
>>> +        pps_event(info->pps, &ts, PPS_CAPTUREASSERT, data);
>>> +        return IRQ_HANDLED;
>>> +    }
>>> +
>>>       rising_edge = gpiod_get_value(info->gpio_pin);
>>>       if ((rising_edge && !info->assert_falling_edge) ||
>>>               (!rising_edge && info->assert_falling_edge))
>>
>> Apart the code duplication, which are the real benefits of doing so?
>>
> 
> It prevents from losing a PPS event when the pulse is so short (or the
> kernel so busy) that the trailing edge of the pulse occurs before the
> interrupt handler can read the state of the GPIO pin.

Have you a real case when this happens?

In any cases we should avoid code duplication... so I think we should do 
something as below:

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 2f4b11b4dfcd..f05fb15ed7f4 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -52,7 +52,9 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)

         info = data;

-       rising_edge = gpiod_get_value(info->gpio_pin);
+       rising_edge = info->capture_clear ? \
+                       gpiod_get_value(info->gpio_pin) : \
+                       !info->assert_falling_edge;
         if ((rising_edge && !info->assert_falling_edge) ||
                         (!rising_edge && info->assert_falling_edge))
                 pps_event(info->pps, &ts, PPS_CAPTUREASSERT, data);

Please, review and test it before resubmitting. :)

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


