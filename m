Return-Path: <linux-kernel+bounces-157620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A688B13B4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B411281C95
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E6613AD05;
	Wed, 24 Apr 2024 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv3gKWP4"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA901F5E6;
	Wed, 24 Apr 2024 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987728; cv=none; b=YiVHYW2HWhM6UTw9gv7C+13wbzeiolrmLTGo9vhyxGeNTQGjuri4EygBfhg9aPIXSwYzJvXCyVzgwRjJ380+a9+HjAGu5EjtURaR6XvE/6SNSsSu4R3Jsl/6lK09z9q/NrZcJkD4SLC9n2JNHQP7VjXxgW+ceFdIyv1uu8YpvJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987728; c=relaxed/simple;
	bh=z7sOPOp1qAR3yfhACEMPGB7vux0tX7s2PPpzQgENPrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svGMvmEhZWCxV0JibXF3lzxPJvStpd4D9iAt0yonLJlOr89mTFtkwrqcAtEUfXl5cPdoj8cLAXnheM7z1Xl3IOwr4LhhtXwCEbGYfvKr0j5orWtyTrYdcILPCAVbkKS2jVXND8l3lQeWgYNNY1jTrxgRy+fy//hzVS8t15BEvlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bv3gKWP4; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so198364a12.1;
        Wed, 24 Apr 2024 12:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713987725; x=1714592525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=v/q5lyCvvmX98HevXcdd/tirXlqsKIFNoXSdo7Uq0tQ=;
        b=bv3gKWP4a/Hh6NFCv2ttAw1cLCKH8jaWhS5qg2H1S+SmIzmdQL8Tv/0yg4N0VTsq/S
         0eWVEodcpcVkq8gVedMG4vAUVWd0Pmnp3WNbi4iNF8O7dmx7m9GoJx0mFUZQe3fY6xJC
         5cagFYIn36Y3IGZ+HGtgY9LfcRSDCoVNY25JYTw/gerXfqJGKnNm439Fgwv4YCSltra0
         WtjY3NKqz/J7Mx1KEfHgUTv7uVb5rqkea9C/lTZAebI7qj5Xijpgjs/l7bdVchFF/7vI
         NJwJ1mEAAglD3buAfsaecJwi1780yxJANSnDTtkv8zqOr+/3/UySvlGaSt8jnQ2w37Yf
         toJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713987725; x=1714592525;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/q5lyCvvmX98HevXcdd/tirXlqsKIFNoXSdo7Uq0tQ=;
        b=UB0hspYYeEJjoRS+5UkhFVANWWnw9KfF5HoXKF/E6ktfQcAOqMtVBYWUJyhBakJ662
         DciJcMgRYSPoJpN162R/brl42M6J7B+MB5u9jVZro728zOez0Tn03aFlfngobcAqZKlN
         +GfdSQE/kHt7l7AIyQUCYxW/zj5PlFJvZAhvTTWi4a3wSLVPQproIQjysf+dEPIRLAjB
         4ra0rUHDSv+FbGgBzfX1GTP+TE4l9WagD/ptG+qWoXy5FHTtLkrfQCeAbt0B7Taq6OiQ
         gbMegCvUMyWe+oTbhwADgrl9cPr4tNczyF7WddX4u/Mjh9b+vpA6nRpMLPbo7rzCoXV1
         vIKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBO4aTTuTWPHhXg+61i0EKbPENLIBbBTuL4EQ8h9ls40qVaWKvKB+xK2R/jcbwkD/50uf6YFeUtFhUThJDZVWuZJLQX6H6r8UZ/d9u0sseR5Zuslr1xj1E+/DlDHwemf1dux8QGEtstYVErH3jemP8eLaJepWy1cmpKSF2WIv+H0BPKcG5gS/zI1JVDYW1FMNW4gEgUN04K9Zslf4mgeE+9PWKiVmsZbbNfQ==
X-Gm-Message-State: AOJu0YwSHcK6puLueYcMbmxIUPOHfTTKGsZ6ROAMuJBYYJJsNR/dek+I
	CtUH/LMfCsQYSs2nN6NdA5Pd3wr7z4afOgDY216nEAI0zNBQCzFZ
X-Google-Smtp-Source: AGHT+IHPBbyb02wyOYlLG/xN/lKaRSGi3h+J+fWxV4Kw7+DYWkqD5G+uQW8xigQX56+5UgIhiPV9xQ==
X-Received: by 2002:a17:90a:4d83:b0:2ab:e09e:fdf6 with SMTP id m3-20020a17090a4d8300b002abe09efdf6mr3572156pjh.47.1713987725443;
        Wed, 24 Apr 2024 12:42:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o15-20020a17090ac70f00b002a2d4bf345bsm13251271pjt.55.2024.04.24.12.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 12:42:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4c4dbcf8-5c8e-4398-a17d-be5af93f2d6c@roeck-us.net>
Date: Wed, 24 Apr 2024 12:42:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] ACPI: fan: Add hwmon support
To: "Rafael J. Wysocki" <rafael@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
 jdelvare@suse.com, andy.shevchenko@gmail.com, linux@weissschuh.net,
 ilpo.jarvinen@linux.intel.com, linux-acpi@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20240422195745.5089-1-W_Armin@gmx.de>
 <CAJZ5v0gLQYOWLTmpe24epb9GzV5o2qSuaP5t25eu-OXYoE2pAQ@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAJZ5v0gLQYOWLTmpe24epb9GzV5o2qSuaP5t25eu-OXYoE2pAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/24 12:01, Rafael J. Wysocki wrote:
> On Mon, Apr 22, 2024 at 9:58 PM Armin Wolf <W_Armin@gmx.de> wrote:
>>
>> Currently, the driver does only support a custom sysfs
>> interface to allow userspace to read the fan speed.
>> Add support for the standard hwmon interface so users
>> can read the fan speed with standard tools like "sensors".
>>
>> Tested with a custom ACPI SSDT.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> 
> I need Guenter to tell me that this is fine with him.
> 

Sorry, I have no idea. Se below.

> Also please see one nit below.
> 
>> ---
>> Changes since v5:
>> - fix coding style issues
>> - replace double break with return
>> - add missing includes
>>
>> Changes since v4:
>> - fix spelling issues
>> - check power values for overflow condition too
>>
>> Changes since v3:
>> - drop fault attrs
>> - rework initialization
>>
>> Changes since v2:
>> - add support for fanX_target and power attrs
>>
>> Changes since v1:
>> - fix undefined reference error
>> - fix fan speed validation
>> - coding style fixes
>> - clarify that the changes are compile-tested only
>> - add hwmon maintainers to cc list
>> ---
>>   drivers/acpi/Makefile    |   1 +
>>   drivers/acpi/fan.h       |   9 +++
>>   drivers/acpi/fan_core.c  |   4 +
>>   drivers/acpi/fan_hwmon.c | 169 +++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 183 insertions(+)
>>   create mode 100644 drivers/acpi/fan_hwmon.c
>>
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 39ea5cfa8326..61ca4afe83dc 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -77,6 +77,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)  += tiny-power-button.o
>>   obj-$(CONFIG_ACPI_FAN)         += fan.o
>>   fan-objs                       := fan_core.o
>>   fan-objs                       += fan_attr.o
>> +fan-$(CONFIG_HWMON)            += fan_hwmon.o
>>
>>   obj-$(CONFIG_ACPI_VIDEO)       += video.o
>>   obj-$(CONFIG_ACPI_TAD)         += acpi_tad.o
>> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
>> index f89d19c922dc..db25a3898af7 100644
>> --- a/drivers/acpi/fan.h
>> +++ b/drivers/acpi/fan.h
>> @@ -10,6 +10,8 @@
>>   #ifndef _ACPI_FAN_H_
>>   #define _ACPI_FAN_H_
>>
>> +#include <linux/kconfig.h>
>> +
>>   #define ACPI_FAN_DEVICE_IDS    \
>>          {"INT3404", }, /* Fan */ \
>>          {"INTC1044", }, /* Fan for Tiger Lake generation */ \
>> @@ -57,4 +59,11 @@ struct acpi_fan {
>>   int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fst);
>>   int acpi_fan_create_attributes(struct acpi_device *device);
>>   void acpi_fan_delete_attributes(struct acpi_device *device);
>> +
>> +#if IS_REACHABLE(CONFIG_HWMON)
>> +int devm_acpi_fan_create_hwmon(struct acpi_device *device);
>> +#else
>> +static inline int devm_acpi_fan_create_hwmon(struct acpi_device *device) { return 0; };
>> +#endif
>> +
>>   #endif
>> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
>> index ff72e4ef8738..7cea4495f19b 100644
>> --- a/drivers/acpi/fan_core.c
>> +++ b/drivers/acpi/fan_core.c
>> @@ -336,6 +336,10 @@ static int acpi_fan_probe(struct platform_device *pdev)
>>                  if (result)
>>                          return result;
>>
>> +               result = devm_acpi_fan_create_hwmon(device);
>> +               if (result)
>> +                       return result;
>> +
>>                  result = acpi_fan_create_attributes(device);
>>                  if (result)
>>                          return result;
>> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
>> new file mode 100644
>> index 000000000000..34a524c285a5
>> --- /dev/null
>> +++ b/drivers/acpi/fan_hwmon.c
>> @@ -0,0 +1,169 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Hwmon interface for the ACPI Fan driver.
>> + *
>> + * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/limits.h>
>> +#include <linux/units.h>
>> +
>> +#include "fan.h"
>> +
>> +/* Returned when the ACPI fan does not support speed reporting */
>> +#define FAN_SPEED_UNAVAILABLE  U32_MAX
>> +#define FAN_POWER_UNAVAILABLE  U32_MAX
>> +
>> +static struct acpi_fan_fps *acpi_fan_get_current_fps(struct acpi_fan *fan, u64 control)
>> +{
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < fan->fps_count; i++) {
>> +               if (fan->fps[i].control == control)
>> +                       return &fan->fps[i];
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +static umode_t acpi_fan_is_visible(const void *drvdata, enum hwmon_sensor_types type, u32 attr,
>> +                                  int channel)
>> +{
>> +       const struct acpi_fan *fan = drvdata;
>> +       unsigned int i;
>> +
>> +       switch (type) {
>> +       case hwmon_fan:
>> +               switch (attr) {
>> +               case hwmon_fan_input:
>> +                       return 0444;
>> +               case hwmon_fan_target:
>> +                       /*
>> +                        * When in fine grain control mode, not every fan control value
>> +                        * has an associated fan performance state.
>> +                        */
>> +                       if (fan->fif.fine_grain_ctrl)
>> +                               return 0;
>> +
>> +                       return 0444;
>> +               default:
>> +                       return 0;
>> +               }
>> +       case hwmon_power:
>> +               switch (attr) {
>> +               case hwmon_power_input:
>> +                       /*
>> +                        * When in fine grain control mode, not every fan control value
>> +                        * has an associated fan performance state.
>> +                        */
>> +                       if (fan->fif.fine_grain_ctrl)
>> +                               return 0;
>> +
>> +                       /*
>> +                        * When all fan performance states contain no valid power data,
>> +                        * when the associated attribute should not be created.
>> +                        */
>> +                       for (i = 0; i < fan->fps_count; i++) {
>> +                               if (fan->fps[i].power != FAN_POWER_UNAVAILABLE)
>> +                                       return 0444;
>> +                       }

Is this all or nothing ? Doesn't this depend on the channel ? It looks
as if the first fan supports reporting the power, attributes are
generated for all fans even if the others don't support it

To me it looks like there are situations where individual
fans will still persistently report -ENODATA for fan speed, power,
or both. I don't know the specification well enough (not at all, really)
to be able to determine if this makes sense. Normally, -ENODATA should be
reserved for "value temporarily not available". I am not sure if that is
the case here.

Guenter

>> +
>> +                       return 0;
>> +               default:
>> +                       return 0;
>> +               }
>> +       default:
>> +               return 0;
>> +       }
>> +}
>> +
>> +static int acpi_fan_read(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
>> +                        long *val)
>> +{
>> +       struct acpi_device *adev = to_acpi_device(dev->parent);
>> +       struct acpi_fan *fan = dev_get_drvdata(dev);
>> +       struct acpi_fan_fps *fps;
>> +       struct acpi_fan_fst fst;
>> +       int ret;
>> +
>> +       ret = acpi_fan_get_fst(adev, &fst);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       switch (type) {
>> +       case hwmon_fan:
>> +               switch (attr) {
>> +               case hwmon_fan_input:
>> +                       if (fst.speed == FAN_SPEED_UNAVAILABLE)
>> +                               return -ENODATA;
>> +
>> +                       if (fst.speed > LONG_MAX)
>> +                               return -EOVERFLOW;
>> +
>> +                       *val = fst.speed;
>> +                       return 0;
>> +               case hwmon_fan_target:
>> +                       fps = acpi_fan_get_current_fps(fan, fst.control);
>> +                       if (!fps)
>> +                               return -ENODATA;
>> +
>> +                       if (fps->speed > LONG_MAX)
>> +                               return -EOVERFLOW;
>> +
>> +                       *val = fps->speed;
>> +                       return 0;
>> +               default:
>> +                       return -EOPNOTSUPP;
>> +               }
>> +       case hwmon_power:
>> +               switch (attr) {
>> +               case hwmon_power_input:
>> +                       fps = acpi_fan_get_current_fps(fan, fst.control);
>> +                       if (!fps)
>> +                               return -ENODATA;
>> +
>> +                       if (fps->power == FAN_POWER_UNAVAILABLE)
>> +                               return -ENODATA;
>> +
>> +                       if (fps->power > LONG_MAX / MICROWATT_PER_MILLIWATT)
>> +                               return -EOVERFLOW;
>> +
>> +                       *val = fps->power * MICROWATT_PER_MILLIWATT;
>> +                       return 0;
>> +               default:
>> +                       return -EOPNOTSUPP;
>> +               }
>> +       default:
>> +               return -EOPNOTSUPP;
>> +       }
>> +}
>> +
>> +static const struct hwmon_ops acpi_fan_ops = {
>> +       .is_visible = acpi_fan_is_visible,
>> +       .read = acpi_fan_read,
>> +};
> 
> I would add "hwmon" to the names of functions and variables related to
> hwmon.  Something like
> 
> +static const struct hwmon_ops acpi_fan_hwmon_ops = {
> +       .is_visible = acpi_fan_hwmon_is_visible,
> +       .read = acpi_fan_hwmon_read,
> +};
> 
> Otherwise, it looks fine to me.
> 
>> +
>> +static const struct hwmon_channel_info * const acpi_fan_info[] = {
>> +       HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_TARGET),
>> +       HWMON_CHANNEL_INFO(power, HWMON_P_INPUT),
>> +       NULL
>> +};
>> +
>> +static const struct hwmon_chip_info acpi_fan_chip_info = {
>> +       .ops = &acpi_fan_ops,
>> +       .info = acpi_fan_info,
>> +};
>> +
>> +int devm_acpi_fan_create_hwmon(struct acpi_device *device)
>> +{
>> +       struct acpi_fan *fan = acpi_driver_data(device);
>> +       struct device *hdev;
>> +
>> +       hdev = devm_hwmon_device_register_with_info(&device->dev, "acpi_fan", fan,
>> +                                                   &acpi_fan_chip_info, NULL);
>> +       return PTR_ERR_OR_ZERO(hdev);
>> +}
>> --


