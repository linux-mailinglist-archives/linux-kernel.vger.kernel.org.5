Return-Path: <linux-kernel+bounces-163361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82308B69DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FAC8281A82
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40A7175BD;
	Tue, 30 Apr 2024 05:22:59 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C9E5256;
	Tue, 30 Apr 2024 05:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714454579; cv=none; b=SAAXeF4wX9kHa9GEvOv02PQ57CC6ltYuluzLp/yArdXircUQJxbAYFld22ryJYOoq4nvpR2VhTIcLZ7APJD1HK07rhSVJKyhuztc5t9jLvtvN6gE8fCc90/KMJHxHc1exxsOaH5UvmVoLZVev6JLqLm75Zn7PYE62SjHCMTgO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714454579; c=relaxed/simple;
	bh=Kz8gaoGkFIuxrMaQK6fWNTWX0CdyB9VvlppbwWz6Y2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvDhJC58z8HOJMI9SAcb1MwbEHlLDDjfRhORhIgWy7XbV8DLadM2iuN9QvbanPEIZ67dEroYW5Y8ky43TECrQQ2lwwCPIGwX6Pn00fIN5tQGIMQAV1OFHVF0yZCcLnQykR6JqpeDNMKN0GyVvkZogF8YbqFUpaNRFl7e+uKm1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so5195151a12.0;
        Mon, 29 Apr 2024 22:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714454576; x=1715059376;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5xXiqJPcQvnAdhsKYWwY5ng2w3w/qDQxjxYllnlVz8=;
        b=GCCP3s/VbGgp9l8EWVK21nmIMDq4UCD5xrU1Ueo8+AtB00PwD1XbZTxvDI3gerUcfH
         WCpR9ieIhhkK2fOM21aYSAGWX8njbQQRJWt+hn+B1OYIswJtlLOv45vgYg7d+2B8BbPt
         iRO2/3Vziktwx/kR1Sr6hKAFJad2ZUZM23IaEIDV/LCmXxSV9JPfVnLJZ65zIgm6oq0X
         vLnwbjyiHfFBljXTDUvOch51O2TK6JUuLXhQp1A+g+tFJltonKdIUjXrcHIgtXqYxke0
         OJIH1Itq80Nja30bpYPxxEJxC9rovfb3R3ygTKJxizjmyiY1tnBFZxz6hCBRkCSyQ6il
         PJTw==
X-Forwarded-Encrypted: i=1; AJvYcCXVfp/XqsI8ulzlA+BywW6bOi3olTz35IfAW9qQ1DWGut++27Ao1QrozPKTy7S8U/dAbHi0LKyb2mPVkQKXYN+d8/0/AdAX6vXBZZovfEzDiJ4hhX/TvebnptKxwl7mAq9HxQa6bY94+skZ1lC18xroKdevAI2G5GwlDP9dzyGyO9SX
X-Gm-Message-State: AOJu0YwCbPuMNdVAZPw4tQE21wfqs8Sl4tXNzBtNBNRyiegnsxG+oBg8
	wRwxBX6YgNKojooX04OPbaA28s26z4gbzIQAQU+BAVFb0svXPGa6
X-Google-Smtp-Source: AGHT+IEfECgT5zX5BqcJpLqgjqzM0jA2MNPef0kmlgJwM9HWop66uHyT3nLossOXgbPT+PnC7sG1qg==
X-Received: by 2002:a17:906:7110:b0:a52:225a:2ebe with SMTP id x16-20020a170906711000b00a52225a2ebemr977474ejj.71.1714454575512;
        Mon, 29 Apr 2024 22:22:55 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id ak1-20020a170906888100b00a5906b4e417sm1572741ejc.98.2024.04.29.22.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 22:22:55 -0700 (PDT)
Message-ID: <af116cb5-41d8-4a33-97ba-0c7cc821add1@kernel.org>
Date: Tue, 30 Apr 2024 07:22:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: sc16is7xx: fix bug in sc16is7xx_set_baud() when
 using prescaler
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jon Ringle <jringle@gridpoint.com>, ria.freelander@gmail.com,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240426135937.3810959-1-hugo@hugovil.com>
 <17d2cc58-cf68-430d-9248-25abe4c5b0f0@kernel.org>
 <20240429094717.de45ad35814e3c618e08c36b@hugovil.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240429094717.de45ad35814e3c618e08c36b@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29. 04. 24, 15:47, Hugo Villeneuve wrote:
> On Mon, 29 Apr 2024 08:39:22 +0200
> Jiri Slaby <jirislaby@kernel.org> wrote:
> 
>> On 26. 04. 24, 15:59, Hugo Villeneuve wrote:
>>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>>
>>> When using a high speed clock with a low baud rate, the 4x prescaler is
>>> automatically selected if required. In that case, sc16is7xx_set_baud()
>>> properly configures the chip registers, but returns an incorrect baud
>>> rate by not taking into account the prescaler value. This incorrect baud
>>> rate is then fed to uart_update_timeout().
>>>
>>> For example, with an input clock of 80MHz, and a selected baud rate of 50,
>>> sc16is7xx_set_baud() will return 200 instead of 50.
>>>
>>> Fix this by first changing the prescaler variable to hold the selected
>>> prescaler value instead of the MCR bitfield. Then properly take into
>>> account the selected prescaler value in the return value computation.
>>>
>>> Also add better documentation about the divisor value computation.
>>>
>>> Fixes: dfeae619d781 ("serial: sc16is7xx")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>> ---
>>>    drivers/tty/serial/sc16is7xx.c | 23 ++++++++++++++++++-----
>>>    1 file changed, 18 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
>>> index 03cf30e20b75..dcd6c5615401 100644
>>> --- a/drivers/tty/serial/sc16is7xx.c
>>> +++ b/drivers/tty/serial/sc16is7xx.c
>>> @@ -555,16 +555,28 @@ static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
>>>    	return reg == SC16IS7XX_RHR_REG;
>>>    }
>>>    
>>> +/*
>>> + * Configure programmable baud rate generator (divisor) according to the
>>> + * desired baud rate.
>>> + *
>>> + * From the datasheet, the divisor is computed according to:
>>> + *
>>> + *              XTAL1 input frequency
>>> + *             -----------------------
>>> + *                    prescaler
>>> + * divisor = ---------------------------
>>> + *            baud-rate x sampling-rate
>>> + */
>>>    static int sc16is7xx_set_baud(struct uart_port *port, int baud)
>>>    {
>>>    	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
>>>    	u8 lcr;
>>> -	u8 prescaler = 0;
>>> +	int prescaler = 1;
>>
>> Ugh, why do you move to signed arithmetics?
> 
> Hi Jiri,
> before this patch, the variable prescaler was used to store an 8 bit
> bitfield. Now the variable meaning is changed to be used as the
> prescaler value, which can be 1 or 4 in this case. Leaving
> it as u8 would still be ok, or making it "unsigned int" maybe?

Both :). What you prefer -- uint matches more IMO, given it's now a 
value and not a register...

thanks,
-- 
js
suse labs


