Return-Path: <linux-kernel+bounces-68309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B110985788B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54E21C20D38
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D5D12E78;
	Fri, 16 Feb 2024 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="utrj9bXM"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5711B974
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708074491; cv=none; b=sxdzi8EV8+SepgGWOzUoiqKGIz30S+XtFGUUu7GoHisH4CdQuNtHtbFU8SRMbaH+6J2cnjggcAsdsywWUIqg9ebnB+2u400H6CHuSwCo4D/l0NOF1kvvtULChZ8HWHL1iv7J041/bfkbwW0mQK/JfSFHjlU5tFoENmHu6wmWwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708074491; c=relaxed/simple;
	bh=oERm1l0ziZ/kArGwE/f98QL6u0Kyjehs1eDEGtkoX7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/0gd/ZjZHX5AvfZeaxOFrv53HEKka+/M0vso9T50I0/BYY0ZV+vB/0B/d+AwQQr9MWN19GZpcDWwqNClsm25udNqhaT546YyrelxZHGao5X9AEODDBWxCcabd9uovcCGOgaqk5yvycaGiR0KK2gKS+FMXMDtdn280RQqnVrWFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=utrj9bXM; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51147d0abd1so2036532e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 01:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708074487; x=1708679287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vA2DFFOFzcRyvxqcYVpsnM/x9YtF8fmooWYl5oGtBh0=;
        b=utrj9bXMWNTLmIHcWDp4HIIw5cG8kY06kJr2XYOXj+cCQZSaqIjzqNJS7wEiunOOXX
         LmPtqaVzBkAxwk3Z3LjiihgJ9YN1kItnHOob2Zl66XNYoRe2gq4TZ5IL4r5xCEAZY6/9
         0IPmNvdANqW5mYYVCV9qJL4TA0jxo727u0qxT980HOJ54t98PPxdRjcla7TdiKdmaNmr
         +vySs4pDylfG8wfscXJm0Gu9Z8HM2UN0lmBap/SGbWRfy1uoOkMBqgX18h9en+9bTzbw
         h7sCMLziSvc1yhmNwko25+anmLK07i2ZBPNiQlOBtjWMV5se24jomPuHn5sUJ9O/xLW2
         kB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708074487; x=1708679287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vA2DFFOFzcRyvxqcYVpsnM/x9YtF8fmooWYl5oGtBh0=;
        b=wIB0OvHIWl6KjKExh987QZfPd6/T3ptkg11uchUu3cdmxGEB69w2pRtZPg6Z0ZN5oz
         vQM1fKWrFy9PiSn61KbbNyZNf2qlU5AQJwURipMW6weaQyfqUvXf93nQ0mbAl/dyUe5Q
         /nVLMPnpWlf1tVlBf1uBzHS9KZum0dKF5S6p8jT9Tt1p6ur35XnPQ33njTP9gsOssVPF
         1jCvG8Bk2566LRPG4sv2j7dsRlriViAlndgsid6/epVvOFlP36r4xazM4Kyxp7kBVEoF
         OjS53ZFMGdMyqDtguskzEWmTiCWXC7OWoiFEXrpBPEKJA1LE2eSNc4LogUhvtXxn44Jh
         CR1w==
X-Forwarded-Encrypted: i=1; AJvYcCXzdrBhA7dgMH5ERW1RN/KwEy8wGUs7XlmWashTcuzcIQiL2U/BJ400FKlirqY+dkdfNgpk6wX5NIQ3DNXbNz426NI1Vtc3y35vGydp
X-Gm-Message-State: AOJu0Yx3ixiXqQ/vOxEHs7HbTPHg9sL0IQ5ZSVrw3/2gDFy1E1xfC4r2
	l/vKy7uXcy4X6hiAm8/ZUDh25y8ZHc+/HeAO431aPuVDitMpIQR4J+nNPaEOlh0=
X-Google-Smtp-Source: AGHT+IGi+3vhNJtCp1mYtRx80UFnIA/8ta458vq75nKmQ6whOzZbmMoMt+v97FMnmJ6t/dByVPfZDw==
X-Received: by 2002:a05:6512:124f:b0:512:8d8f:db7a with SMTP id fb15-20020a056512124f00b005128d8fdb7amr2294792lfb.65.1708074487376;
        Fri, 16 Feb 2024 01:08:07 -0800 (PST)
Received: from [192.168.1.70] ([84.102.31.43])
        by smtp.gmail.com with ESMTPSA id f11-20020a0565123b0b00b005128ae41781sm462170lfv.253.2024.02.16.01.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 01:08:06 -0800 (PST)
Message-ID: <e13627e2-9d8f-437d-afe4-d8bfcade2f6a@baylibre.com>
Date: Fri, 16 Feb 2024 10:08:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v1 03/13] dt-bindings: mfd: ti,tps6594: Add TI
 TPS65224 PMIC
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, Kevin Hilman <khilman@kernel.org>
Cc: Bhargav Raviprakash <bhargav.r@ltts.com>, arnd@arndb.de,
 broonie@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, kristo@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, lee@kernel.org, lgirdwood@gmail.com,
 linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 m.nirmaladevi@ltts.com, nm@ti.com, robh+dt@kernel.org, vigneshr@ti.com
References: <20240209-blitz-fidgety-78469aa80d6d@spud>
 <20240214093106.86483-1-bhargav.r@ltts.com>
 <20240214-galley-dweller-1e9872229d80@spud> <7hil2r5556.fsf@baylibre.com>
 <20240214-depraved-unfunded-3f0b3d6bf3e2@spud>
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20240214-depraved-unfunded-3f0b3d6bf3e2@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/14/24 18:45, Conor Dooley wrote:
> On Wed, Feb 14, 2024 at 09:26:13AM -0800, Kevin Hilman wrote:
>> Conor Dooley <conor@kernel.org> writes:
>>> On Wed, Feb 14, 2024 at 03:01:06PM +0530, Bhargav Raviprakash wrote:
>>>> On Fri 2/9/2024 10:41 PM, Conor Dooley wrote:
>>>>> On Thu, Feb 08, 2024 at 04:23:33PM +0530, Bhargav Raviprakash wrote:
>>>>>> TPS65224 is a Power Management IC with 4 Buck regulators and 3 LDO
>>>>>> regulators, it includes additional features like GPIOs, watchdog, ESMs
>>>>>> (Error Signal Monitor), and PFSM (Pre-configurable Finite State Machine)
>>>>>> managing the state of the device.
>>>>>> TPS6594 and TPS65224 have significant functional overlap.
>>>>> What does "significant functional overlap" mean? Does one implement a
>>>>> compatible subset of the other? I assume the answer is no, given there
>>>>> seems to be some core looking registers at different addresses.
>>>> The intention behind “significant functional overlap” was meant to
>>>> indicate a lot of the features between TPS6594 and TPS65224 overlap,
>>>> while there are some features specific to TPS65224.
>>>> There is compatibility between the PMIC register maps, I2C, PFSM,
>>>> and other drivers even though there are some core registers at
>>>> different addresses.
>>>>
>>>> Would it be more appropriate to say the 2 devices are compatible and have
>>>> sufficient feature overlap rather than significant functional overlap?
>>> If core registers are at different addresses, then it is unlikely that
>>> these devices are compatible.
>> That's not necessarily true.  Hardware designers can sometimes be
>> creative. :)
> Hence "unlikely" in my mail :)

For tps6594 and tps65224, some core registers are at different adresses
indeed, but the code is the same for both MFD I2C/SPI entry points. As an
example, the way CRC is enabled is exactly the same, even if the bit that
must be set belongs to different registers. tps65224 has more resources and
it's as if HW designers had had to re-organize the way bits are distributed
among the registers (due to a lack of space, so to speak).

That said, if we consider that these devices are not compatible, what does it
imply concretely for the next version ? Does that mean that:
1) Only a new binding must be created, even if MFD drivers and most of child
drivers will be re-used ? (then the binding would simply be duplicated, but
the drivers would not)
2) A new binding and new MFD drivers must be created, even if most of child
drivers will be re-used ? (then the binding and MFD drivers would simply be
duplicated, but the child drivers would not)
3) A new binding and new drivers (MFD and child devices) must be created ?
4) Anything else ?

@Conor: I understand that it's not your problem. Anybody can answer, I just
try to make things clear for the next version. :)

Julien

>
>>> In this context, compatible means that existing software intended for
>>> the 6594 would run without modification on the 65224, although maybe
>>> only supporting a subset of features.  If that's not the case, then
>>> the devices are not compatible.
>> Compatible is a fuzzy term... so we need to get into the gray area.
>>
>> What's going on here is that this new part is derivative in many
>> signifcant (but not all) ways from an existing similar part.  When
>> writing drivers for new, derivative parts, there's always a choice
>> between 1) extending the existing driver (using a new compatible string
>> & match table for the diffs) or 2) creating a new driver which will have
>> a bunch of duplicated code.
>>
>> The first verion of this series[1] took the 2nd approach, but due to the
>> significant functional (and feature) overlap, the recommendation was
>> instead to take the "reuse" path to avoid signficant amounts of
>> duplicated code.
>>
>> Of course, it's possible that while going down the "reuse" path, there
>> may be a point where creating a separate driver for some aspects might
>> make sense, but that needs to be justified.  Based on a quick glance of
>> what I see in this series so far (I have not done a detailed review),
>> the differences with the new device look to me like they can be handled
>> with chip-specific data in a match table.
> This is all nice information, but not really relevant here - this is a
> binding patch, not a driver one & the conversation stemmed from me
> making sure that a fallback compatible was not suitable. Whether or not
> there are multiple drivers or not is someone else's problem!
>
> Thanks,
> Conor.


