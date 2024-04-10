Return-Path: <linux-kernel+bounces-138747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9AE89F9DB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C362828825D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9CE15EFD6;
	Wed, 10 Apr 2024 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="Y+7V8yXU"
Received: from smtpcmd12132.aruba.it (smtpcmd12132.aruba.it [62.149.156.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D83F15DBC4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759220; cv=none; b=d7RQcF/cH+F9SMk9bIeEHg65q+iWmiMv3nMfCmU9ss8ubW6eeWC9b8pgScER0LD21xZ2Zv+UjGyOlIp89PqkjYOBbwL9xK0kYdshcGcm8VKYgC2waQgPqictshQSwGav/U9ijqge44OEqqZeXSoZOTpX82DUHDf8mzo/ONHSeNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759220; c=relaxed/simple;
	bh=Difdx3BxJzhOX2o/HP/f9EELdU+sT92qxGG5u7354ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DN9WJfm9u5BPTEGhlAlmj6RktiJ+QtGEEJr81Iuczg31VDbk0saAK+iWtxhZg/GQCfYDRHnUbdbZxCc1oZNEIV2TtfHlWRWXmmfXbyBcgYmriIORbQlNteT39KQAi1bZaUn9L8Op4Of++i2kMO48leuWpSsXlBj8kxgkrrmcBms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=Y+7V8yXU; arc=none smtp.client-ip=62.149.156.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.57] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id uYrYrEorFJV7NuYrZrfvGW; Wed, 10 Apr 2024 16:23:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712759026; bh=Difdx3BxJzhOX2o/HP/f9EELdU+sT92qxGG5u7354ag=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=Y+7V8yXUtqdQtu2Z/l8rYtvo3mPL/BNMXv0I8klhh9G18iCNp4L0E3m+dy0i/DDi3
	 xyLOsm0jbjXmWYFNugKPIhC9UsZ3PTaUfB8VkINryrVuWSUG3VUfKIZux/mcL54l/z
	 KIZ2ZLkbTHAWcIBX60RD3FuhniTkWIHLHbBNrtVxZSMpPpkBEwApL23Vbe1UpX1LeV
	 Y0rgCKVgMZMV5XYlBY8rLqbJSuzBCIdw8UuTNmp/NoBhFvQu7XOo+1Ad4lse82qUtN
	 lq3DSVl0zQcCLUzsWzPTPg3zmJATF2fQxz1y5hpt7x7T9HjhVjSdSi9aHtRU8CXm41
	 iPm9JvfnR14sw==
Message-ID: <1f7f5b2f-54d4-4dc1-90ff-b896c930faed@enneenne.com>
Date: Wed, 10 Apr 2024 16:23:43 +0200
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
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <20240410113502.73038-1-bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOxo2hSIHH3+mH6g5ecaL9iBtmekxHFOjZJTmXbuXn5INXrXLdqGfv9jutC7tQVGJuMuPq3HLONPulaE+u1hA2Na4g7zRQjP9+6rq2NEwQFZ4HidDc9P
 bWqJw8WkGCecm/U5//v/uW9r5lTTs7SwgOophfyXigDAcUWtOcOJx6GPma9vWD5FWiuDRxKrrDsbOzGQQMmBBacDFIfNKNgTwpsmfMyNa2wbg5oxctxXkWYl
 iJq/EBp3zQWC8nFMt355Lk6mUoJ9S2/maBahsw4VZsr8MCZMJODQAAHpMQfUioJ0EJ/MwOvZaQz0U3/o3z/JvHkl/Tq7+tJimKmq4UG/9Vfna1EXp6k1zru1
 A/WoHWS624jThbbZOv+qFkMSmXQgQA==

On 10/04/24 13:35, Bastien Curutchet wrote:
> In the IRQ handler, the GPIO's state is read to verify the direction of
> the edge that triggered the interruption before generating the PPS event.
> If a pulse is too short, the GPIO line can reach back its original state
> before this verification and the PPS event is lost.
> 
> This check is needed when info->capture_clear is set because it needs
> interruptions on both rising and falling edges. When info->capture_clear
> is not set, interruption is triggered by one edge only so this check can
> be omitted.
> 
> Bypass the edge's direction verification when info->capture_clear is not
> set.
> 
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> ---
>   drivers/pps/clients/pps-gpio.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
> index 2f4b11b4dfcd..c2a96e3e3836 100644
> --- a/drivers/pps/clients/pps-gpio.c
> +++ b/drivers/pps/clients/pps-gpio.c
> @@ -52,6 +52,15 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
>   
>   	info = data;
>   
> +	if (!info->capture_clear) {
> +		/*
> +		 * If capture_clear is unset, IRQ is triggered by one edge only.
> +		 * So the check on edge direction is not needed here
> +		 */
> +		pps_event(info->pps, &ts, PPS_CAPTUREASSERT, data);
> +		return IRQ_HANDLED;
> +	}
> +
>   	rising_edge = gpiod_get_value(info->gpio_pin);
>   	if ((rising_edge && !info->assert_falling_edge) ||
>   			(!rising_edge && info->assert_falling_edge))

Apart the code duplication, which are the real benefits of doing so?

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


