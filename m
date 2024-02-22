Return-Path: <linux-kernel+bounces-76842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 083C585FD7F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61D88B261C6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA9514E2EC;
	Thu, 22 Feb 2024 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOED4nwm"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBEC14E2CB;
	Thu, 22 Feb 2024 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617795; cv=none; b=QFDx97U2sn+soUZWvg7s/z6m+g57G7AFefrA2+GAL5nrcNNUO5Wn7nMT+MhRKQg9WcOMfp0dSepOawZb/7JzEQBBtpsGpmRxC1ujageocRd+WS3pLKXqFTzGADQ879hQ7JWIcjLsqs5glKvlWWKNkLL3oD2hMdXAgLyFIQB5rTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617795; c=relaxed/simple;
	bh=ZzTjmOQds9KovKFGXLCTE8JT9BXUhegvI7WlqiNBr30=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YszcMuhOV1BMODcAPrXxdsyhLabjKeaR1zEA6QgDvsDSGaNnbzdGHdc8W44afF0hS0BK/CKgCpfExKUkdPgV8RhFD4suBhmPDCTjA+dlv85dbn2feLNCUkm9NTTSNe8EJEype6kF2Sz71IeCIRNEgqCSjQKKJapYltsMMvKfdes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOED4nwm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e471f5f1a5so2767975b3a.1;
        Thu, 22 Feb 2024 08:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708617793; x=1709222593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zmfGugikQMjXAKoK91kY7BKBKEQ6iIZOd74HOBnKvEw=;
        b=UOED4nwmnSxNGD45iov/m/UeUsRjJoJNX5/xuJnM+bnD09dRQqkedrVzmNYFFbiIQ+
         PIM0/BmWrjbB84GJwh/g7rTi8aXOz/gRKaCxvHs7s4aNnUw5avnGoxkxzJqMVVibVgb5
         WTPXOJ5XHxgoVwipj+Pqmwnf9u1GkfiRsPEWgeWNW73JSEbsy0dZfxYdiKohQjoKLIJ+
         6IafMdcNwaQ7KDkOesvukFf/PnbQMhpy+sROXKM7rW87rEzaow+vnaDxH43eEYEUINEK
         dJ8sPRRgr+J3Opa/3ce1IYIrR41WgZHzTTet8nERCZql3FWtyWMrnexngQTr2Xjc8YV4
         Wp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708617793; x=1709222593;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmfGugikQMjXAKoK91kY7BKBKEQ6iIZOd74HOBnKvEw=;
        b=UfTtQUyfmv3kXQwI5e114u7iev29wIWKxmjt52b9LCB0K8OT7LQ8WQaw5yCGviRaE/
         Z86Sb6k1GXCByN+oXnyK4fSEochjm5SRfKy+G78HhWdVQA6786Cd7eR1F6k6akBE3V4e
         3xZy6biNhgGE/nHImi09enI7xl6kDFNX6PMFYTJaBBpBAfbo/Wp08ffEGIPQr307WEdw
         ZaWleF+kLkfNp/Vjmr66qgYcHLegemlmMtxFNEEhL/PYscM8w+H4b8BChRDRd7lQoNGc
         Ihc1UAVm+sQwwOJbBaWyP2PFCkjvTi+V0m/H2NHELVBP5dwVhNGrrsqUv155WfLpJr0E
         +k3A==
X-Forwarded-Encrypted: i=1; AJvYcCXxBhVwTZSFZo8ZqY1UUAZvmK29Y+MFXQMoHFdzrAwBPMJERb7w6XJ+tnXBnsU5JwEqVvUiVJ9xE5VpMbWRqKxHtuboixh/k7a8yCymiKaT6+wdI5E344xdCa5QP1D8xj0/ZuYvUQgOyLOR795W0QOWeJhocEvYY7WcgGo1n6Lbs+FwozZ8Er7lhWPlFLE4eiV+2xeWog0naFKfv7IIsgGNHVDIIf7t19wCT3+C+23uUhCKkGEUvWUgAvJ5
X-Gm-Message-State: AOJu0Ywkm3a7PZdtjHutEs1+AViH/uYaJ8+MKa0c5odiB3fTuCihmO6H
	7OcMsgV8JuM0ZSk6sR3dh0d2j1yqfA7TS+Fq0kjRkWLmuAEf/V67
X-Google-Smtp-Source: AGHT+IGB03rRczzEqj0RkkBn0mpiVHnK3M012lR5QdmPa1yhl9Um3OgZJ4eKu61Syk6jCBDk0PMl5Q==
X-Received: by 2002:a05:6a20:6f96:b0:1a0:7f19:b2b1 with SMTP id gv22-20020a056a206f9600b001a07f19b2b1mr20747791pzb.26.1708617792716;
        Thu, 22 Feb 2024 08:03:12 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e20-20020a633714000000b005c1ce3c960bsm10802514pga.50.2024.02.22.08.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 08:03:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e610c9b6-0491-42ac-90a1-00c547741773@roeck-us.net>
Date: Thu, 22 Feb 2024 08:03:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] devm-helpers: Add resource managed version of mutex
 init
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Lucas De Marchi <lucas.demarchi@intel.com>, Oded Gabbay
 <ogabbay@kernel.org>, =?UTF-8?Q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Aleksandr Mezin <mezin.alexander@gmail.com>, Jean Delvare
 <jdelvare@suse.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones
 <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-gpio@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240222145838.12916-1-kabel@kernel.org>
 <4a545c16-7518-49d2-b158-7fcabe3508c5@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <4a545c16-7518-49d2-b158-7fcabe3508c5@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Oops, sorry for the noise. Shortened reply below.

On 2/22/24 07:24, Guenter Roeck wrote:
> On 2/22/24 06:58, Marek Behún wrote:
>> A few drivers are doing resource-managed mutex initialization by
>> implementing ad-hoc one-liner mutex dropping functions and using them
>> with devm_add_action_or_reset(). Help drivers avoid these repeated
>> one-liners by adding managed version of mutex initialization.
>>

[ ... ]

>> +static inline int devm_mutex_init(struct device *dev, struct mutex *lock)
>> +{
>> +    mutex_init(lock);
>> +
>> +    /*
>> +     * mutex_destroy() is an empty function if CONFIG_DEBUG_MUTEXES is
>> +     * disabled. No need to allocate an action in that case.
>> +     */
>> +    if (IS_ENABLED(CONFIG_DEBUG_MUTEXES))
>> +        return devm_add_action_or_reset(dev, devm_mutex_drop, lock);
>> +    else
> 
> else after return is unnecessary.
> 
>> +        return 0;
>> +}
>> +
>>   #endif
> 
> 


