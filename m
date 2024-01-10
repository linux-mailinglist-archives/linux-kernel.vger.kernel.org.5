Return-Path: <linux-kernel+bounces-22140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C46E8299E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BC3BB219BC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B1C47F67;
	Wed, 10 Jan 2024 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="aXWv6Vmz"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76DF47F44
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d4f5d902dso42927945e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704887722; x=1705492522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p22+unadpjiuSy6RGYATC6dS70dMkUd0mDAJ61uro9I=;
        b=aXWv6VmzjH5x7RWHFSyBQC5qfCLssOfMva95/wI6S21LP0NBkVvstfZR+Gqm1V6dow
         KwsUt7hIY+F6IUPzZm1B2HAGtVmARYUMAO2Hx1Wx/i4jyWSRYgrKjr2Uq1WMbm53/Rw/
         Ro8oQlAI6R8ATShhNYSEF/LBT4CLSR3ED3A7JL1F1EcT9uYYXuCXWcN9XRRYisPH+Kxf
         sxG0vLB5BW7rfn9ddWHmAHWfLnPz2AJpm5kDjQu9Df7RbAuZNb2A3kbFjbpk/Wpuo+sw
         jFwbXWEyex7fi5dwz+eDjCQuBxUFwfg26XM1x3iRM8CL9DZfzsqTKdKt/hi8+GKJlvfj
         LelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704887722; x=1705492522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p22+unadpjiuSy6RGYATC6dS70dMkUd0mDAJ61uro9I=;
        b=MqKGKTC+IMG/ygBUGcRGn5uKzyh5tGr6akGVyxkxBmn6c9BB3BpYVb5pk6oMsauyUy
         6T8hWSrevo3z7ML3RPKGtU6A4JaXuCqWnVxGtpbzy3ssNrLc8XHJRHGr1Fkuj8p+bxZN
         KpRQx7bf21mWxjWvfWtHcBNl+Ti0RjUUMkgB3Ov6y7rdNVWkdKAU+ceTaM2rttloANHC
         jXswLn33QpQfvpDDPDtMWOdqYZzCulRsK23ZPVF6KDeNhhTXQayd0qCwJD7Ndam6yHgF
         ooJue/RsIP1/RYS2f8Sf80c+YOdAleVapuGGAXp7yw/bX2pGyvGrNy/nFkxamjgO6qIR
         C9Pg==
X-Gm-Message-State: AOJu0YxphbDpxWs6KK3gSXAiC0tDrC2Xtv6WTKE5C5jhB3gI/FB1KtMj
	c/jVNqiT+44QX1728uqmaQD7HcfyXVd1Sg==
X-Google-Smtp-Source: AGHT+IEce4ODuGwcEn2BKXeEu1OoSU3T5p4yP+WdC1xjqjakHlYuOMiREbeBunnkwWykVuXti0AI4A==
X-Received: by 2002:a05:600c:84ca:b0:40e:52ce:f05 with SMTP id er10-20020a05600c84ca00b0040e52ce0f05mr482062wmb.70.1704887721880;
        Wed, 10 Jan 2024 03:55:21 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id g4-20020adfa484000000b00336344c3c3fsm4739160wrb.90.2024.01.10.03.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 03:55:21 -0800 (PST)
Message-ID: <3e430f8e-b327-485f-ae19-6f1938083dd3@tuxon.dev>
Date: Wed, 10 Jan 2024 13:55:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/19] net: ravb: Move the IRQs get and
 request in the probe function
Content-Language: en-US
To: Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, p.zabel@pengutronix.de,
 yoshihiro.shimoda.uh@renesas.com, wsa+renesas@sang-engineering.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, geert+renesas@glider.be,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
 <20240105082339.1468817-9-claudiu.beznea.uj@bp.renesas.com>
 <02548b1b-d32c-78b1-f1b6-5fdb505d31bb@omp.ru>
 <ee783b61-95fc-44ab-a311-0ca7d058ac39@tuxon.dev>
 <dce944a1-9557-9ab0-d30d-7a51a47c6d96@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <dce944a1-9557-9ab0-d30d-7a51a47c6d96@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09.01.2024 22:47, Sergey Shtylyov wrote:
> On 1/8/24 11:58 AM, claudiu beznea wrote:
> 
> [...]
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> The runtime PM implementation will disable clocks at the end of
>>>> ravb_probe(). As some IP variants switch to reset mode as a result of
>>>> setting module standby through clock disable APIs, to implement runtime PM
>>>> the resource parsing and requesting are moved in the probe function and IP
>>>> settings are moved in the open function. This is done because at the end of
>>>> the probe some IP variants will switch anyway to reset mode and the
>>>> registers content is lost. Also keeping only register specific operations
>>>> in the ravb_open()/ravb_close() functions will make them faster.
>>>>
>>>> Commit moves IRQ requests to ravb_probe() to have all the IRQs ready when
>>>> the interface is open. As now IRQs gets and requests are in a single place
>>>> there is no need to keep intermediary data (like ravb_rx_irqs[] and
>>>> ravb_tx_irqs[] arrays or IRQs in struct ravb_private).
>>>
>>>    There's one thing that you probably didn't take into account: after
>>> you call request_irq(), you should be able to handle your IRQ as it's
>>> automatically unmasked, unless you pass IRQF_NO_AUTOEN to request_irq().
>>> Your device may be held i reset or even powered off but if you pass IRQF_SHARED to request_irq() (you do in a single IRQ config), you must
>>> be prepared to get your device's registers read (in order to ascertain
> 
>    And, at least on arm32, reading a powered off (or not clocked?) device's
> register causes an imprecise external abort exception -- which results in a
> kernel oops...
> 
>>> whether it's your IRQ or not). And you can't even pass IRQF_NO_AUTOEN
>>> along with IRQF_SHARED, according to my reading of the IRQ code...
>>
>> Good point!
>>
>>>> This is a preparatory change to add runtime PM support for all IP variants.
>>>
>>>   I don't readily see why this is necessary for the full-fledged RPM
>>> support...
>>
>> I tried to speed up the ravb_open()/ravb_close() but missed the IRQF_SHARED
> 
>    I doubt that optimizing ravb_{open,close}() is worth pursuing, frankly...
> 
>> IRQ. As there is only one IRQ requested w/ IRQF_SHARED, are you OK with
>> still keeping the rest of IRQs handled as proposed by this patch?
> 
>    I'm not, as this doesn't really seem necessary for your main goal.
> It's not clear in what state U-Boot leaves EtherAVB...

Ok. One other reason I did this is, as commit message states, to keep
resource parsing and allocation/freeing in probe/remove and hardware
settings in open/close.

Anyway, I'll revert all the changes IRQ related.

Thank you,
Claudiu Beznea

> 
> [...]
> 
> MBR, Sergey

