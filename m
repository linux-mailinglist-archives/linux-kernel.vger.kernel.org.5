Return-Path: <linux-kernel+bounces-118428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC6788BAB1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7878BB22840
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E6F129E6A;
	Tue, 26 Mar 2024 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bvMGDicS"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD1F80056
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711435565; cv=none; b=BGZx1L/A+csbKNjr27m5sM6xGBVsz0LkFLEuhnGNA8+8tSs9cU5RyUk7uKBKxcxhHsS9j+ExquSVg5/N0wFzGZA0xFejQNj8TIGEZ6zhCrh8/DAhIm3sw0DN9oNIHHQzIfylcm1JmP/aXVxvAAbzthN3j0bVv80A9ARDdC8q708=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711435565; c=relaxed/simple;
	bh=wy+qyXverh7nieHFb0hqrqF24NYE5GQnRrosS8PFLgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kx5DsDn5DTJZr758DQHt3rABAh6HjjuSf2xqi/ISFVR7olxhnwnIjMUDDyhR72VxJ0sebVP/KHz+EdmsDP+WX7u45qduMGk7qT9B7UDuABTZ+pDkBY86kn1h6ms7H8At0YqNgb/c7gkjiXYz4diePEkVVOgHz4slVnWcfqgMQIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bvMGDicS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56c1a520659so1605996a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711435562; x=1712040362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BqkpkBz51uO0Tg187W87yjDd9hVH6SR23SGC1N0DFeQ=;
        b=bvMGDicSJeaujqc13yGfpWUPyho1H/nawVtnNuHkcniGWVRdTLeGeX+CN/88e/AAdO
         /+7Bp6imXc9FJU74taEHRE0thHd7hwCWW12utKZJVznrEc28fRmLlo4ORjJmQSdIJg/9
         /k/0fwn50glbPnd8Ny+TYr39YQ2qmu7xBtavbRAW0m4LfykyZZBmtVPNDK/AD/uJ+883
         StWMmAE+3qYQqXVuBNj/oSdVDwhPq0fY0EUnMe359kHdenVQScUqFvTolkwjTQzQ7T1D
         BdvyunzDlMjeR0T88OcXM7XqxB2/9AninB10v6bHp587t/GdtJLsBp17QJFOh4h9eN40
         1PrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711435562; x=1712040362;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqkpkBz51uO0Tg187W87yjDd9hVH6SR23SGC1N0DFeQ=;
        b=kJHUvyUVCEYFC8D9XPWQjLYeECTtpbdpCvzgJGWfDKLlmI34Ep8sOw6yI3Yq1az4BM
         +Fcfj5myS+ZslnVJXPNPnxqjY+dnu6JwtKtzTH2ujpLJbyon0zNZyL9PmRCVC0bleYav
         ubdafJLcOuulZ1zZqn712njp5hYbx3ZgK4q1wi0d8BhwyE0WWfu/snIpCDFwktIYMXWK
         jzuv0pP3TVff8YYrNmjDBKCi+jmGKhNzjwE6Ux88mKLUU4vPWh3sD4cbOdHVQyaSgFP2
         CfdrrY+pjTdM5CeIVkOeyGk9fKJXueC8KsUPwulFi27/M8U23FA8pCnUwIQ76dONk0HV
         pQOw==
X-Forwarded-Encrypted: i=1; AJvYcCWzV/nbGSjq8zzlTaOO2bgAELazmdRFDlbSeYA/bnMkFledhWvc3wzbm3/Bp78mKVn/Uq39AZq/Ab1tPqzdrvkwRAYH2sCjWRetXKx6
X-Gm-Message-State: AOJu0YxTyH/TxqSS7g1Z4REXGHvJqjTLnrxcyCGMlgpSKOCD4axEpD0Z
	6vt6TJgf8r5w2bLyWwfoGZGtB/qoKkeZTYMBs87ThKTDHbqaPVBx/UiySq5rdKI=
X-Google-Smtp-Source: AGHT+IFYH3K+0oaZNzgvZCZBD0SnYiC/s7JItomLcijD+Xhmot7Z1YK+O39UP7P5ARcxq70+D9xC2A==
X-Received: by 2002:a17:906:1194:b0:a46:ac10:1cde with SMTP id n20-20020a170906119400b00a46ac101cdemr1114377eja.45.1711435562385;
        Mon, 25 Mar 2024 23:46:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id c22-20020a1709060fd600b00a4dacd6b8b3sm947334ejk.68.2024.03.25.23.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 23:46:01 -0700 (PDT)
Message-ID: <9b1a5100-8536-4b59-b2e7-d6ebd2ba9e66@linaro.org>
Date: Tue, 26 Mar 2024 07:46:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyIDEvMl0gQVNvQzogZHQtYmluZGlu?=
 =?UTF-8?Q?gs=3A_Add_bindings_for_Cadence_I2S-MC_controller?=
To: Xingyu Wu <xingyu.wu@starfivetech.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Claudiu Beznea <Claudiu.Beznea@microchip.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
References: <20240320090239.168743-1-xingyu.wu@starfivetech.com>
 <20240320090239.168743-2-xingyu.wu@starfivetech.com>
 <9d9efb8a-0b3c-4e7a-8673-07cd3b1f5f87@linaro.org>
 <NTZPR01MB0956BD6189974378958562D99F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <NTZPR01MB0956BD6189974378958562D99F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 07:29, Xingyu Wu wrote:
>>
>> On 20/03/2024 10:02, Xingyu Wu wrote:
>>> Add bindings for the Multi-Channel I2S controller of Cadence.

Your email app responds very weird. You bypassed all possible filters
and it is simply not visible that you answer to me. You Reply to
everyone, not to me with Cc to others. There is no standard header whom
do you quote, e.g. "On 26/03/2024 07:29, Xingyu Wu wrote:"

Please use some decent email system, otherwise I will miss all replies
from you.

>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - cdns,i2s-mc
>>
>> Why did this appear? Who asked for this? Usually these blocks are not usable on their
>> own.
> 
> I wonder if I should keep the original IP compatible. Do I not need it?

As I said, it is not usable on its own, so unless you have other
arguments then no. But my point was that no one asked for this.

> 
>>
>>> +      - starfive,jh8100-i2s
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    description:
>>> +      The interrupt line number for the I2S controller. Add this
>>> +      parameter if the I2S controller that you are using does not
>>> +      using DMA.
>>
>> That's still wrong. You already got comment on this. Either you have interrupt or not.
>> You do not add interrupts, based on your choice or not of having DMA. Drop the
>> comment.
> 
> Do I keep this property and drop this description?

Drop description. Keep property, if your hardware has interrupts.

..

>>
>>> +  - compatible
>>> +  - reg
>>> +  - clocks
>>> +  - clock-names
>>> +  - resets
>>> +
>>> +oneOf:
>>> +  - required:
>>> +      - dmas
>>> +      - dma-names
>>> +  - required:
>>> +      - interrupts
>>
>> This won't work. Provide both interrupts and dmas, and then test your DTS.
> 
> I provided both properties in the DTS and test by dtbs_check. Then it printed that:
> 'More than one condition true in one of shema: ...'

Exactly. Having both properties is a correct DTS. Interrupts do not
disappear just because you decide to describe DMA. It is OS choice what
to use if both are provided.



Best regards,
Krzysztof


