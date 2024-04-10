Return-Path: <linux-kernel+bounces-138804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94B089FA8E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FFFA1F305DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCA617554B;
	Wed, 10 Apr 2024 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dWURWtYX"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7089916C85A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760386; cv=none; b=c61NRS90be7KcDw5GfL0EWByfk+QVk57VBVHgpOhs2ItE/+elZcNC2T6MFLuVG9/u2Z4o1X3MPShEy1oFot1m+tDF9TODmgZDtn+V0A47in/s0Cq1Xm21CC5apz+QzX7FkSJ63i4CyvHEJLz2R0A9Q040G8Ddz/epuA4Hpqmnq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760386; c=relaxed/simple;
	bh=7V6t7G9R/j8SfQ17SSxxvRlFWUnNIt2VQiFHcCwuQlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2JxU1YT/sP+UT/jdwVrxeK08LnAKzJhLvXACS2vIWK/smtMc0A8BjabNv2tcxd9sSE1Tia9WZ6QA22/4kphkFvVhaCKcHfTqUdw5tz8LFBEBWbeTyODbAHSQF5yeSCjOo7l31Xf4yclHYobXsQKHtGMFeFKQAz/kNj+FLFhsGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dWURWtYX; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0311B1BF20A;
	Wed, 10 Apr 2024 14:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712760376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j65IjvQWYnnx1L9dvrx1w/98kN+MLSREHb32zvuuNKg=;
	b=dWURWtYX8/wsDFDFtmJkcNR7t7zwKiKybpsZHUrUN8gTZzaiupwJBL/GU0OL5WxFp2uJpJ
	QDd/NKp/FS2qtTMIKSezO3WFWzjOT89GxNdgCG670xnKmn/MAB4Nek/tn3y0DkuEn6bhIS
	C3VVmS6YJ6iQAK5GE5KV4PVbS72DO/M2SSoOp/Wselq6QVqPya7JDnUM7qgWuO9GclX5QQ
	H4D1lHaPQpF1bP6e7qV4xsf0atNsCKQDQzFQf5Q0y7BvhvbQu23KlsVKsydxnqJb4Yi2ah
	JKU76pu5wpg/iz28FOvFEXz6WIaXKCamXfMtu8R7vimcx9GwTcwlfrUeCApgZQ==
Message-ID: <5bda0980-2373-4284-bda4-89f0c6944e76@bootlin.com>
Date: Wed, 10 Apr 2024 16:46:15 +0200
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
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <1f7f5b2f-54d4-4dc1-90ff-b896c930faed@enneenne.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Rodolfo,

On 4/10/24 16:23, Rodolfo Giometti wrote:
> On 10/04/24 13:35, Bastien Curutchet wrote:
>> In the IRQ handler, the GPIO's state is read to verify the direction of
>> the edge that triggered the interruption before generating the PPS event.
>> If a pulse is too short, the GPIO line can reach back its original state
>> before this verification and the PPS event is lost.
>>
>> This check is needed when info->capture_clear is set because it needs
>> interruptions on both rising and falling edges. When info->capture_clear
>> is not set, interruption is triggered by one edge only so this check can
>> be omitted.
>>
>> Bypass the edge's direction verification when info->capture_clear is not
>> set.
>>
>> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
>> ---
>>   drivers/pps/clients/pps-gpio.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/pps/clients/pps-gpio.c 
>> b/drivers/pps/clients/pps-gpio.c
>> index 2f4b11b4dfcd..c2a96e3e3836 100644
>> --- a/drivers/pps/clients/pps-gpio.c
>> +++ b/drivers/pps/clients/pps-gpio.c
>> @@ -52,6 +52,15 @@ static irqreturn_t pps_gpio_irq_handler(int irq, 
>> void *data)
>>       info = data;
>> +    if (!info->capture_clear) {
>> +        /*
>> +         * If capture_clear is unset, IRQ is triggered by one edge only.
>> +         * So the check on edge direction is not needed here
>> +         */
>> +        pps_event(info->pps, &ts, PPS_CAPTUREASSERT, data);
>> +        return IRQ_HANDLED;
>> +    }
>> +
>>       rising_edge = gpiod_get_value(info->gpio_pin);
>>       if ((rising_edge && !info->assert_falling_edge) ||
>>               (!rising_edge && info->assert_falling_edge))
> 
> Apart the code duplication, which are the real benefits of doing so?
> 

It prevents from losing a PPS event when the pulse is so short (or the
kernel so busy) that the trailing edge of the pulse occurs before the
interrupt handler can read the state of the GPIO pin.


Best regards,
Bastien

