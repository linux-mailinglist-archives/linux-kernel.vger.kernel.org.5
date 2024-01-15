Return-Path: <linux-kernel+bounces-25672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADBB82D474
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4EF41F21532
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC0A46BF;
	Mon, 15 Jan 2024 07:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="g/iHn9Ia"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4CE2572
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-557ad92cabbso8079498a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 23:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1705302627; x=1705907427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HuNG5aqEhsbeBERrPCFg5a3TnYCeZfKcpSHlOpM2cd0=;
        b=g/iHn9IaV3XnTR0veSuVn/29XbavKXE4mxFmVPSsK1mEsk1JBCbImaG4wBsWH+u3Ez
         ljHmSRNzxMlyA+QkFj9V0dtw/4wu1AsCrwobu8vJQqjfXTJ1Z2SGFGs8oSTmk2EtfbS5
         S8vYVi2+fTtJ+v8HRMjjsw+f2JZhmPqdxmCcKxoSS/VVreQSUcTuVxeZQ0cOLUHech0F
         1FReUti/LPm0QeBmiF9ldKO/QdJH8g1eAd+fNVRXKUbxAyLPI9jvUdYnzx5qNonOHPQU
         mI/TaEnbkynfroQ/IpeLuoN1hG3fwR3JmEniSTFrf+75iiCgVe1LAqGP0Li+JzhIbOe7
         2vUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705302627; x=1705907427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HuNG5aqEhsbeBERrPCFg5a3TnYCeZfKcpSHlOpM2cd0=;
        b=Rz4A0kaJnqugKjNEnctReM6XuG5XcZJqsmephDHIGvrP3r6xhyKpFkMKPCz3ehAn2D
         GlpL9h7oRLZap3hkq4z2us8/yyO9s8dOK2nSeNBld7WcApCl34s6Nsm8W19gkc4477Jx
         Eu8KfxU4CeYbFe2L4gmMTYNG489HJLL1CpdbmVoF16ybq4QhGFxPAc9n7c2h8LB1Sl9C
         opkBesRYd+fxOASqOfCTEBhieq8He2FOfJOBNadjxd+eZ2tJq+UEhEQILWu5hkxDfKBp
         fRXBOiLArlYRCzJoLATHlnzvvV1aPnWkWmbKQ8lCIFcjt4/trYPWUJU5QZctDa09zDgz
         YqRA==
X-Gm-Message-State: AOJu0Ywgh9942oXx32N7xTKzItD6/kbxdFCArsQ7711aYjmMLBhBASSo
	6YirBwmyK9rwk7Xz7sLYXes0o7uoU/ZMdA==
X-Google-Smtp-Source: AGHT+IEM9t3sz1PRA0cKCm8YUEhJesksYTwaieiMWCyGrTdTT139I6KZPLMrWIFJtwS9e9y3Qe2h3w==
X-Received: by 2002:aa7:c3c8:0:b0:558:8017:a1a7 with SMTP id l8-20020aa7c3c8000000b005588017a1a7mr1369492edr.56.1705302627439;
        Sun, 14 Jan 2024 23:10:27 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.46])
        by smtp.gmail.com with ESMTPSA id j9-20020a508a89000000b00554930be765sm5242041edj.97.2024.01.14.23.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jan 2024 23:10:27 -0800 (PST)
Message-ID: <db7a1de5-959c-4c62-abb9-b394727065e0@tuxon.dev>
Date: Mon, 15 Jan 2024 09:10:25 +0200
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
 <3e430f8e-b327-485f-ae19-6f1938083dd3@tuxon.dev>
 <0ef3553a-9a7d-d93a-7920-0bd4aa49e5cb@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <0ef3553a-9a7d-d93a-7920-0bd4aa49e5cb@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14.01.2024 20:07, Sergey Shtylyov wrote:
> On 1/10/24 2:55 PM, claudiu beznea wrote:
> 
> [...]
> 
>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>
>>>>>> The runtime PM implementation will disable clocks at the end of
>>>>>> ravb_probe(). As some IP variants switch to reset mode as a result of
>>>>>> setting module standby through clock disable APIs, to implement runtime PM
>>>>>> the resource parsing and requesting are moved in the probe function and IP
>>>>>> settings are moved in the open function. This is done because at the end of
>>>>>> the probe some IP variants will switch anyway to reset mode and the
>>>>>> registers content is lost. Also keeping only register specific operations
>>>>>> in the ravb_open()/ravb_close() functions will make them faster.
>>>>>>
>>>>>> Commit moves IRQ requests to ravb_probe() to have all the IRQs ready when
>>>>>> the interface is open. As now IRQs gets and requests are in a single place
>>>>>> there is no need to keep intermediary data (like ravb_rx_irqs[] and
>>>>>> ravb_tx_irqs[] arrays or IRQs in struct ravb_private).
>>>>>
>>>>>    There's one thing that you probably didn't take into account: after
>>>>> you call request_irq(), you should be able to handle your IRQ as it's
>>>>> automatically unmasked, unless you pass IRQF_NO_AUTOEN to request_irq().
>>>>> Your device may be held i reset or even powered off but if you pass
>>>>> IRQF_SHARED to request_irq() (you do in a single IRQ config), you must
>>>>> be prepared to get your device's registers read (in order to ascertain
>>>
>>>    And, at least on arm32, reading a powered off (or not clocked?) device's
>>> register causes an imprecise external abort exception -- which results in a
>>> kernel oops...
>>>
>>>>> whether it's your IRQ or not). And you can't even pass IRQF_NO_AUTOEN
>>>>> along with IRQF_SHARED, according to my reading of the IRQ code...
>>>>
>>>> Good point!
> 
>    Iff we can come up with a robust check whether the device is powered on,
> we can overcome even the IRQF_SHARED issue though...
>    I'm seeing pm_runtime_active() API and wondering whether we can use it
> from the IRQ context. Alternatively, we can add a is_opened flag, like
> sh_eth.c does...

The is_open flag should deal with this, too, AFAICT at the moment, and
should also cover your concerns about U-Boot.

Thank you,
Claudiu Beznea

> 
>>>>>> This is a preparatory change to add runtime PM support for all IP variants.
>>>>>
>>>>>   I don't readily see why this is necessary for the full-fledged RPM
>>>>> support...
>>>>
>>>> I tried to speed up the ravb_open()/ravb_close() but missed the IRQF_SHARED
>>>
>>>    I doubt that optimizing ravb_{open,close}() is worth pursuing, frankly...
> 
>    OTOH, we'll get a simpler/cleaner code if we do this...
>    Previously, I was under an impression that it's common behavior of
> the networking drivers to call request_irq() from their ndo_open() methods.
> Apparently, it's not true anymore (probably with the introduction of the
> managed device API) -- the newer drivers often call devm_request_irq()
> from their probe() methods instead...
> 
>>>> IRQ. As there is only one IRQ requested w/ IRQF_SHARED, are you OK with
>>>> still keeping the rest of IRQs handled as proposed by this patch?
>>>
>>>    I'm not, as this doesn't really seem necessary for your main goal.
>>> It's not clear in what state U-Boot leaves EtherAVB...
> 
>    This still seems an issue though... My prior experience with the R-Car
> MMC driver tells me that U-Boot may leave interrupts enabled... :-/
> 
>> Ok. One other reason I did this is, as commit message states, to keep
>> resource parsing and allocation/freeing in probe/remove and hardware
>> settings in open/close.
>>  
>> Anyway, I'll revert all the changes IRQ related.
> 
>    Now I've changed my mind -- let's retain your patch! It needs some work
> though...
> 
>> Thank you,
>> Claudiu Beznea
> 
> [...]
> 
> MBR, Sergey

