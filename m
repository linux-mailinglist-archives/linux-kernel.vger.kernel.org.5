Return-Path: <linux-kernel+bounces-168175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E135A8BB4B8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4CC1F25BF4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966F6158DA1;
	Fri,  3 May 2024 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7uAo3RQ"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703B5157E62;
	Fri,  3 May 2024 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767691; cv=none; b=ah8i4c+K8OhPxZ7PvCoCMnqlrgUCwstNvA9+4C10qht/3o1XuS940dyEcCrQkjunoBQoY6wf9Hnf05b/Md2kQsfP01Fuc3KJ5GAEMbbY0ZYvRWwZEIjCNpu9eju/C+nSNxg4/kGTTNIYN3AR1zIwMdUif3nqKWGtJMCTGLUPkEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767691; c=relaxed/simple;
	bh=zagYwoQ/oOAX+wQ6LBY2V6facBBV+qCiO0lTgP9qC6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvzOoLfUjvdryXecjJHTs4Us5L0NXWnf59UCEkZw9Cd2sJHFzPqfbFyfcebRYiJQeKkvdRzMW33/zV+0DCmlW65GebW+jlF/mv1p4fO9BbPG9qDXFC7g80xKyjunFG1HRJo4TeoV5G/+N+gFIECiKaA3ZXPxJcK1cTJ3iZ2XttE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7uAo3RQ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61b68644ab4so336157b3.0;
        Fri, 03 May 2024 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714767689; x=1715372489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d18X7ZM0l6kj5GwwaRvOjC1+xsFoXnqqYPXvHkjD73M=;
        b=e7uAo3RQ70ZPwEF/ODnqBqEpMm2WWJIVBnlOnhwySNREid9mBb1c26nlc4+mDHTaB7
         xdg5u0m4TMHyI1goNA0OxjTMbdPOZzVQG/nAz/kcPorsn4CFx4FBrNmxg2MMqQhnQMxO
         Q4qQ9VjzO6gt1mgXa+3F3ZEpAdDuWlNKYOs4knAgoxCvDctdD+bxKorTZQmn+OG04Pzf
         JC7d1rOT1hZ2FfT11KPb/egVEf2FCKGDDKS63bfTr4e16OeluSMKzGRtUP7hCsGVXNa2
         ZCg9Li+DOmC0b+1ALqtrpipvsc5O1syiQK9tyPSBFNDyxfo1epkixiyLX3/iwqMgo/gS
         tZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714767689; x=1715372489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d18X7ZM0l6kj5GwwaRvOjC1+xsFoXnqqYPXvHkjD73M=;
        b=AHW6Xp00nNWTy54sxhz2z3cidlOo2GPudDNZRnMjOfJJuHGXfslV7ctWU0FihAg80/
         QnfanrHzeqL4u/76Rowo4z77b0npGgg9IcOFH1tWwkMvzMPzS91WwZUwupdW08VGh4kV
         2K3kZY9D4vYwTX+ahGZLo9yDLClVEKUG0tdfKyV+vF+EZaPvWZnrXe0VgAkEp55lceSp
         AhqhSCG3PdyA06auLazsyPd9Q/IMQZSc3+viIliLLy5Nbu9qkmk/2T5SDyRodw8SxInD
         qp5sUyOBTYHQTnK/ai0np8Q6oDNH5QeO4h/2I0VBMmXc54d6a4dHMuhJmK2gj/Lp6tQK
         fdiw==
X-Forwarded-Encrypted: i=1; AJvYcCU/VyXYiInw9Sz1EFssjvkC/N7xluKng5lw8gSwSlVpWBHhMfUc4OnReeXJpMiJbXKGFPfWlC0GQVdEHZYDKt77EicEMX++w5qQ+4XGBV3BvgGcdlA6evLZ0pWrLlt+bblK3ldAdZyCyoRWzKc4b4PAjy/zi9uHcvjyNTzgrZ5fPoTUoE4=
X-Gm-Message-State: AOJu0YyOBmU4XiKN8Ydpbz42Ors6X8sL41D32udm8U6XLOXeHJNOtKPO
	1GXWpKQ0wmZBO8hvH1PJkPRJ89oc90RrE1A8wORAAS+KU0KhN8kuGrXpIQ==
X-Google-Smtp-Source: AGHT+IGJ0cbEIDK+2nFR627oFgjwYDQME0bBTz1odCdcdH/20DIWvwb2tCXH1qw6TW0ogxYjkBugnA==
X-Received: by 2002:a05:690c:3811:b0:615:6d2c:2cf6 with SMTP id jx17-20020a05690c381100b006156d2c2cf6mr4076260ywb.47.1714767689259;
        Fri, 03 May 2024 13:21:29 -0700 (PDT)
Received: from [10.69.55.76] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id hd15-20020a05622a298f00b0043aa9ad3859sm1935388qtb.43.2024.05.03.13.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 13:21:28 -0700 (PDT)
Message-ID: <45b7742c-9cde-4238-9c2c-c75dfbe9d8f3@gmail.com>
Date: Fri, 3 May 2024 13:21:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] gpio: of: support gpio-ranges for multiple gpiochip
 devices
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Phil Elwell <phil@raspberrypi.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240424185039.1707812-1-opendmb@gmail.com>
 <20240424185039.1707812-3-opendmb@gmail.com>
 <CACRpkda4v6Nu8V3MVamDpfs4qnc89e8Vd8fSyaNsqJQ40GQqZg@mail.gmail.com>
Content-Language: en-US
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <CACRpkda4v6Nu8V3MVamDpfs4qnc89e8Vd8fSyaNsqJQ40GQqZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/3/2024 1:25 AM, Linus Walleij wrote:
> Hi Dough,
> 
> thanks for your patch!
Thanks for your review!

> 
> I'm a bit confused here:
"Communication is hard" and I may be confused about your confusion, but 
hopefully we can work it out.

> 
> On Wed, Apr 24, 2024 at 8:51 PM Doug Berger <opendmb@gmail.com> wrote:
> 
> 
>> +               /* Ignore ranges outside of this GPIO chip */
>> +               if (pinspec.args[0] >= (chip->offset + chip->ngpio))
>> +                       continue;
>> +               if (pinspec.args[0] + pinspec.args[2] <= chip->offset)
>> +                       continue;
> 
> Here pinspec.args[0] and [2] comes directly from the device tree.
> 
> The documentation in Documentation/devicetree/bindings/gpio/gpio.txt
> says:
> 
>> 2.2) Ordinary (numerical) GPIO ranges
>> -------------------------------------
>>
>> It is useful to represent which GPIOs correspond to which pins on which pin
>> controllers. The gpio-ranges property described below represents this with
>> a discrete set of ranges mapping pins from the pin controller local number space
>> to pins in the GPIO controller local number space.
>>
>> The format is: <[pin controller phandle], [GPIO controller offset],
>>                  [pin controller offset], [number of pins]>;
>>
>> The GPIO controller offset pertains to the GPIO controller node containing the
>> range definition.
I think we are in agreement here. For extra clarity, I will add that in 
my understanding pinspec.args[0] corresponds to [GPIO controller offset] 
and pinspec.args[2] corresponds to [number of pins].

> 
> So I do not understand how pinspec[0] and [2] can ever be compared
> to something involving chip->offset which is a Linux-specific offset.
> 
> It rather looks like you are trying to accomodate the Linux numberspace
> in the ranges, which it was explicitly designed to avoid.
The struct gpio_chip documentation in include/linux/gpio/driver.h says:

 > * @offset: when multiple gpio chips belong to the same device this
 > *	can be used as offset within the device so friendly names can
 > *	be properly assigned.

It is my understanding that this value represents the offset of a 
gpiochip relative to the GPIO controller device defined by the GPIO 
controller node in device tree. This puts it in the same number space as 
[GPIO controller offset]. I believe it was introduced for the specific 
purpose of translating [GPIO controller offset] values into 
Linux-specific offsets, which is why it is being reused for that purpose 
in this patch.

For GPIO Controllers that contain a single gpiochip the 'offset' member 
is 0 and the device tree node offsets can be applied directly to the 
gpiochip. However, when a GPIO Controller contains multiple gpiochips, 
the device tree node offsets must be translated to each individual gpiochip.

> 
> I just don't get it.
> 
> So NACK until I understand what is going on here.
> 
> Yours,
> Linus Walleij
I hope it makes sense now, but if not please help me understand what I 
may be missing.

Thanks,
     Doug


