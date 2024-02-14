Return-Path: <linux-kernel+bounces-65035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CEB8546FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C178F1F21660
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2312417552;
	Wed, 14 Feb 2024 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCVnLR+2"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5D914ABC;
	Wed, 14 Feb 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707905956; cv=none; b=jZunKASwtoRTICN0DoototlDcQL6NqmjSjAOnvY9qun6N+3jKbhtK6hdHBRB000/DI0lbXMhhXryXcJIa+KSbfdHQOQPvQ+eEKDz/zWFpyAXmnyLgmSSnTuz8LesBk5IOBVC23LoQnpeRuOw1iWRZdsqoJN3LcqnP1llv7tfCjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707905956; c=relaxed/simple;
	bh=dXM4ltp9m0nlbbTajOk7i5VsfwfQ7oRilD4YzJbboQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRU//azmS2g17vDFU1rTtJL0WTioqRUizU0VeCus+7158IdxL6zpO+WPpXaJwjr0wt3k0t9M0v7c+pUbjHxoRVx6UhGs4iGbzOsPMVlmhzhKDRx0mLlCkaqMeNCGFuJ2q1xUoB7b2DwF89Eq60vX+f40yhMYALeZq3ooerTzzcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCVnLR+2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3d2cce1126so112323866b.2;
        Wed, 14 Feb 2024 02:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707905953; x=1708510753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OLRj1mFJpl+9yLnpvglaJFB5v6n1ThidnnLPgjLs0yo=;
        b=WCVnLR+2sS3d6FzMgTflTqFZwaB+QSyrWmmzmu+hVLXAlJwmcaK+b4eVigowanU6Rv
         LWvtss9ftURJ2+p9c85KCuLqTf6YoqrVsIlTuoV/rLpGp4ctHaMxE0Sp/D7MhdxTShxg
         7ySO8r0zuRZZKIG3rvvaIFEVaKZxQOZpeC1GM35yKIgBG3oADGZWIlIxF18mR1Dp6HrS
         OrU5YtmFmSU73mzgrmzvvhQ83zFmHDwSF9shoNS4E8ECuCuQgGqbzUKWNbka+EIuRxW6
         YZj7+N+yy3ZIT/+mqfyLIlzEDCzLojQr46c27olpwpslA46qDYp6PE7cVrZ8P1FIhg4B
         udYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707905953; x=1708510753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLRj1mFJpl+9yLnpvglaJFB5v6n1ThidnnLPgjLs0yo=;
        b=LuNO5sLagB64QHQ5oTkzbsu8rTfyd+VLrbdYR88EAg2f1bb+ihD61U1Wt5EJvZJGwT
         Mx9gLxp5k1DuBjEmJy4Z/ybQSaL1tXa1lfRB5Ruk39sADjLydKUAHAjpTsCjr+1K3WWE
         Bb6j/Zkioft8sTjO0N3wEs2FCUyDkZLdkX/nWzT6HnzMuZYJH/0JVrsupM/V2eQJshGI
         NvHlZRz2gXqmObgY3E/jPgZ8eIOQkCBjAiRhQtlze42AmKj/YxZcJ2bA4+rJdMfTHLXg
         hYKOUmEfw+1InzmJHuihibY99C3qBMUBoiPOc9y0lkQsu+6zklLMTPm95Oj8cfvd5CyJ
         Ht7w==
X-Forwarded-Encrypted: i=1; AJvYcCWjYH1WxGoCn1SjCMjkgXAI7z2BQ259A/6z/JpPyXBiyqjtYp8+DzjMX7cdOrblIS4g/hLtFgT6WxcmW0rP22w5DoIg/46e6dE488PWS3BLE4WAYtUC2yQmQNvy4bLn81+uNU4vgy9A4vokLiy7csUi+4ijDsQQhmqwR7OiyKnbRZ3YtA==
X-Gm-Message-State: AOJu0YxOI7TvhBYPcyEtyDwlQ0dqprZCNdDHRyz01WbzwfvVKsFbbKq6
	Wxta5mgRxICWzg0QQteewc+AS/innGmpQTwh41rdi3w+8+AVx3DG
X-Google-Smtp-Source: AGHT+IEl2Ag3bYgP/Z3P3BT488BPaO2IYQUkRcodC6FMIdU8fXJSacH/fwANZYS9xUDvQUcknqsHSw==
X-Received: by 2002:a17:906:4f0a:b0:a3d:607b:a280 with SMTP id t10-20020a1709064f0a00b00a3d607ba280mr349986eju.59.1707905952758;
        Wed, 14 Feb 2024 02:19:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOAx91eFcQOTulUqIbqfn4LyXCdEoTcC5Pncl3OX9Nh3Y4eCJSvYtv4fepI/t678chIot8cgWsOLyFXrLQqAOPHDpxX9Q/nqSucOiEXT7CQKSy9KVdZwTjtiSTBdA2puJ9YkN8pBi3EorRj/RBhLKdvQd8kvz+VSNzweM93AqP22Mv8Gz84kGcz/YfhKS2bWfYr13nQTskzh6dlIyq6HlMLvC/3KZDfE6rQ6hRInA2DUOBjUkAW+F4HVTPHb14OxJb0MBD2M80EendauhuZgrosIyicqRZDtL/f5eBVFVJMzqNAoNcH9/a55tMn/fh+0V+apL6py8P0xZKZSXz7Nn1eQf+0HlIC1PrjuFnViUzZh70KdJcgz1T8G2nW0goknTQQ4U9lCGW5Gcb0edyC1RcOSbiZeM/0XWmlVRijqqh9nAH3y5v086utpkgcKpnG6uVV/wbaneG4v+iCYsib1NRjBrkYcNaYUDw5W0prtE=
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id hw20-20020a170907a0d400b00a3cf243de37sm1738164ejc.111.2024.02.14.02.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 02:19:12 -0800 (PST)
Message-ID: <eb97a068-4de6-4500-993b-86737844de70@gmail.com>
Date: Wed, 14 Feb 2024 11:19:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pwm: mediatek,mt2712: add compatible for
 MT7988
To: Conor Dooley <conor@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240213164633.25447-1-zajec5@gmail.com>
 <20240213-resource-evaluator-0754cfd5882d@spud>
 <d4391868-ddcd-4f66-b539-28d245fa83df@gmail.com>
 <e957b044-fe84-4b72-bdf1-cbc40c722019@collabora.com>
 <20240214-reversion-arguably-37bbee9caf78@spud>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20240214-reversion-arguably-37bbee9caf78@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.02.2024 11:06, Conor Dooley wrote:
> On Wed, Feb 14, 2024 at 10:27:54AM +0100, AngeloGioacchino Del Regno wrote:
>> Il 14/02/24 07:34, Rafał Miłecki ha scritto:
>>> On 13.02.2024 19:18, Conor Dooley wrote:
>>>> On Tue, Feb 13, 2024 at 05:46:32PM +0100, Rafał Miłecki wrote:
>>>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>>>
>>>>> MT7988 has on-SoC controller that can control up to 8 PWMs.
>>>>
>>>> I see a binding and a dts patch, but no driver patch, how come?
>>>
>>> I believe that to avoid cross-trees patchsets (which are sometimes
>>> tricky for maintainers) there are two ways of submiting such changes:
>>> 1. dt-binding + driver; then (separately) DTS
>>> 2. dt-binding + DTS; then (separately) driver
>>>
>>> I chose later in this case as my personal priority right now is to deal
>>> with all MediaTek DTS files.
>>>
>>> Is that wrong or unacceptable?
>>>
>>
>> It's not wrong but it's partially unacceptable, at least on my side.
> 
>> I want to put emphasis on sending the binding with the driver, as this allows
>> for a better review on everyone's side because we do see the full picture and
>> we can give better advices: in this case, I'm not sure whether adding a new
>> compatible for MT7988 in an enum is a good idea, as the compatible string may
>> be shared with one of the *eleven* SoCs that are supported in the PWM driver,
>> meaning that (hardware speaking!) the PWM controller in 7988 might be the same
>> as the one in mt1234.
> 
> Re-ordering to make my reply make more sense...
> 
>> In my opinion (and I believe many do agree with me), sending the binding along
>> with the driver is the right choice, and if you also want to include the dts
>> that is also appreciated: series can go through multiple maintainers applying
>> subsets - it's ok to do.
> 
> Ye, either of those two makes my life a lot easier. I can then at least
> go and check the driver patch to see if things match up. In this case, I
> would want to check that the driver requires changes to support this
> device, given the commit message mentions nothing about the difference
> between this device and others. I'd still probably request that the
> commit message be improved to explain the lack of a fallback, but at
> least I would be clear about what I want and could provide a conditional
> Ack.
> 
> If you're not sending the bindings patch with the driver, there's an
> extra onus on you to explain exactly what makes this device incompatible
> with the other devices in the enum, although in an ideal world it'd make
> no difference and every bindings patch would contain that information.

I understand, thanks guys for discussing this with me.

I'll send V2 with Linux driver part.


>>>
>>>> Also, what makes this incompatibly different with the other devices in
>>>> the binding, like the 8183?
>>>
>>> It can control 8 PWMs unlike any other SoC block except for MT2712.
>>> It uses different registers than MT2712 thought.
> 
> Put this information in your commit message next time :)
> 
> Cheers,
> Conor.


