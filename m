Return-Path: <linux-kernel+bounces-20701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3708283B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1034B1C246B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1930836084;
	Tue,  9 Jan 2024 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOWF/7Pk"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C9335F18;
	Tue,  9 Jan 2024 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5542a7f1f3cso3110923a12.2;
        Tue, 09 Jan 2024 02:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704795009; x=1705399809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=li8wtv11pYdgoNeEu9fSAYSfT2EiVS4SAirIke9Z5lU=;
        b=gOWF/7PkVTBVphxY7c1eD26+88adUqAdnONwxkAL3LyQU3CRjqgtTMO2n1rzd4jMsF
         uIEtDdpWCZ7iPeK2fXx1+8icRCgmx7k/ZgRGIT25ebqXi6Is91IDeEsgjzJ0PncsKHqy
         yAn387i3y6KPfcGjG3pbl1PXh+a678idMYiKwYmrvHAXEH8fVqn48x7VzOO9njHUSsAD
         UYW1QqHRTZHpRALeL//eufxNyuVGdTdXDNZIboBL/DUMgyunwODKwWLIwU2oPVEt37Up
         Sdnve4tgcuJVYbLUBi5Z1HHyRyiyHcf/b8y0zTe6QTPTDC/OuQFXiAHakShyZFXQ4Tbu
         jXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704795009; x=1705399809;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=li8wtv11pYdgoNeEu9fSAYSfT2EiVS4SAirIke9Z5lU=;
        b=m5d1mZB6OL/Yf6s0Fj4lsyKWiwPJZKIca0oxTVkae7+m8NmIszXA0cLbmZVYuy8mix
         1KJFvUZaTNOPZZExkh17pP0b5Ps5hM2jxXclkxV3jiswd/7moi+A0tq76ySVOUxpOtsz
         fJCoAE2d7s7ddVM+cgcjxj4E5d7xZWCXUv/ddHqg+cF+vQmUF0eKQA/SGoJe8inCdoqv
         lTm1cEProrqz60HKm13J7dfKX2wYVv55gJqussQw5mvCppgjQ0R4UcUFfD5uNLbUB70r
         iazjeo3C3SmSNd+FtY+LH9ECN2Nr/FAPoleW0NPRnxcGE+PzSXqIi9eWsLsg+V1YZ7/V
         TA2g==
X-Gm-Message-State: AOJu0YynvlNUnVyuDeBg6FTqp4pq5iBp85i5Mc2sMFly/MPAcwffExxP
	UfQDzA+O7n0YpiMYBYGQ5FE=
X-Google-Smtp-Source: AGHT+IF+wvco4c3a9JoKIfiuZdpUuewrOoNQlzsrO4I9Zw6OP+eI1EdOE0IFwkOLZ0jCTzW72mh8CA==
X-Received: by 2002:a05:6402:b27:b0:557:bcf0:b5db with SMTP id bo7-20020a0564020b2700b00557bcf0b5dbmr1310333edb.67.1704795008736;
        Tue, 09 Jan 2024 02:10:08 -0800 (PST)
Received: from ?IPV6:2a01:c22:6ec5:5b00:b85e:554d:d507:dda6? (dynamic-2a01-0c22-6ec5-5b00-b85e-554d-d507-dda6.c22.pool.telefonica.de. [2a01:c22:6ec5:5b00:b85e:554d:d507:dda6])
        by smtp.googlemail.com with ESMTPSA id cb25-20020a0564020b7900b00552d03a17acsm779582edb.61.2024.01.09.02.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 02:10:08 -0800 (PST)
Message-ID: <4c859da1-9551-4d0b-a19c-f20f1133acac@gmail.com>
Date: Tue, 9 Jan 2024 11:10:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] leds: remove led_init_default_state_get() and
 devm_led_classdev_register_ext() stubs
To: Arnd Bergmann <arnd@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
 Hans de Goede <hdegoede@redhat.com>,
 Jean-Jacques Hiblot <jjhiblot@traphandler.com>, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240109090715.982332-1-arnd@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240109090715.982332-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09.01.2024 10:06, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> These two functions have stub implementations that are called when
> NEW_LEDS and/or LEDS_CLASS are disabled, theorerically allowing drivers
> to optionally use the LED subsystem.
> 
> However, this has never really worked because a built-in driver is
> unable to link against these functions if the LED class is in a loadable
> module. Heiner ran into this problem with a driver that newly gained
> a LEDS_CLASS dependency and suggested using an IS_REACHABLE() check.
> 
> This is the reverse approach, removing the stub entirely to acknowledge
> that it is pointless in its current form, and that not having it avoids
> misleading developers into thinking that they can rely on it.
> 
> This survived around 1000 randconfig builds to validate that any callers
> of the interface already have the correct Kconfig dependency already,
> with the exception of the one that Heiner just added.
> 
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Link: https://lore.kernel.org/linux-leds/0f6f432b-c650-4bb8-a1b5-fe3372804d52@gmail.com/T/#u
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

For r8169 we have a Kconfig-based solution now, right. I had a brief look
at other drivers using LED functionality, and already the first one I looked
at seems to suffer from the same problem. input/keyboard/qt2160.c has the
following what should result in the same link error if qt2160 is built-in
and CONFIG_LEDS_CLASS=m. qt2160 has a Kconfig dependency only on I2C.

#ifdef CONFIG_LEDS_CLASS
static int qt2160_register_leds(struct qt2160_data *qt2160)
{
[...]
	error = devm_led_classdev_register(&client->dev, &led->cdev);
[...]		
}
#else

Personally I don't have a strong opinion pro/con IS_REACHABLE.
I see two options for now:
1. If outcome should be that stubs are a good thing, then the condition
   for the stub should make sure that the stub is chosen when needed.
   This would result in using IS_REACHABLE.
2. If stubs are removed (but also in the current situation, see example),
   then it seems some drivers need adding proper build dependencies.


