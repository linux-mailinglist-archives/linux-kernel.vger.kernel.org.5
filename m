Return-Path: <linux-kernel+bounces-13521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124D282079D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 18:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD28A282049
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C81BA34;
	Sat, 30 Dec 2023 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CozxAllm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD92BA31;
	Sat, 30 Dec 2023 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3367f8f8cb0so7803163f8f.2;
        Sat, 30 Dec 2023 09:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703956761; x=1704561561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ou0z5S9NAcwFbUMBfuwYV1ryYnkMhf0pRQ3zZkqnDuU=;
        b=CozxAllmAgzfcPkztLRhBwUlBolCaDMOd2yT7SqYcghICbAKDNNebFYd5v0bMOlOdP
         tefXwq4nwD0gogZiQck5Xomt2CxUiv7GXY1v05G7qh4oo8X/sAliYLazsXAIgAkLWCAC
         QqhiHqWaxvzbNY8aoWG48Pcl9Nha7Dp575O3C22DW7JPLLao1WZ+SRSS4bdr69Tmnzqe
         7ZpVGKuvN5p51GmS1/2TZiUYqA+O6RmAL97u0eGzvHR257TJgQrLj30TLDqPD6uX/OnL
         uKAat4yKJGeRvL9Qjq6KcsvBeVf5MN1uOPXOEXLtNG23uS3Kc2UXpyB+bvEqfi0Ha1qO
         Svkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703956761; x=1704561561;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ou0z5S9NAcwFbUMBfuwYV1ryYnkMhf0pRQ3zZkqnDuU=;
        b=EUhOe3i0oPZU1pAXW/orM0PKjy1cTk0DUUEsF8SBQZX3ZtTKdT3TXqhEVLDOjs+cQV
         /OzPEjHjqdO+YMmz/IoKCgY9rCTpykq3TSoX/vC9OAzl8llFjwb8uM1JPKSuObY5G/wb
         F4jheGlrQRmTbIOlQnMM6O1ECdbS/CnwXXNQcQ2qycheNJ4uwAdMgTuH2Vi/JZg9GGpF
         6EvsKgiwz2zmSHK2dgEOhjaPnDlGNGmSfCV30aL0qR5SwOT6lHySyrIN0Ig+WPwNvBFt
         CZ13FL+Jlv6Dt24syVOMmBS0k6hyN+UlOMymUoPnEz/tKeLjPPv8voYoYxBx/tnb7Gj7
         +jSw==
X-Gm-Message-State: AOJu0YyYLueBSSb+nEgF0ne5u/IY9XbHqC93YC4kzEVFA1KWjMQW655D
	3BZ0yIsj6nM3yoNhH4v57/g=
X-Google-Smtp-Source: AGHT+IG+zdPW5EPaLa8LsWgHGlRfcvpvT2yB8xtwXLK5irt/1BIfSLWfMauVJqWTuxVcB3cp8qEe6Q==
X-Received: by 2002:a05:600c:a48:b0:40d:779c:d2b0 with SMTP id c8-20020a05600c0a4800b0040d779cd2b0mr1536597wmq.152.1703956760990;
        Sat, 30 Dec 2023 09:19:20 -0800 (PST)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c451400b0040d839de5c2sm2411814wmo.33.2023.12.30.09.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 09:19:20 -0800 (PST)
Message-ID: <224b0db9-4fab-4a7e-b240-a2b60f06c52d@gmail.com>
Date: Sat, 30 Dec 2023 18:19:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] platform/surface: aggregator_registry: add entry
 for fan speed
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Ivor Wanders <ivor@iwanders.net>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20231228003444.5580-1-ivor@iwanders.net>
 <20231228003444.5580-3-ivor@iwanders.net>
 <33a556e3-a7ac-47a3-a621-4db12dbac208@gmail.com>
Content-Language: en-US
In-Reply-To: <33a556e3-a7ac-47a3-a621-4db12dbac208@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/29/23 23:42, Maximilian Luz wrote:
> On 12/28/23 01:34, Ivor Wanders wrote:
>> Add an entry for the fan speed function.
>> Add this new entry to the Surface Pro 9 group.
>>
>> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
>> Link: https://github.com/linux-surface/kernel/pull/144
>> ---
>> Changes in v2:
>>    - No changes in this patch.
>> ---
>>   drivers/platform/surface/surface_aggregator_registry.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
>> index 530db4db7..b0db25886 100644
>> --- a/drivers/platform/surface/surface_aggregator_registry.c
>> +++ b/drivers/platform/surface/surface_aggregator_registry.c
>> @@ -74,6 +74,12 @@ static const struct software_node ssam_node_tmp_pprof = {
>>       .parent = &ssam_node_root,
>>   };
>> +/* Fan speed function. */
>> +static const struct software_node ssam_node_fan_speed = {
>> +    .name = "ssam:01:05:01:01:01",
>> +    .parent = &ssam_node_root,
>> +};
> 
> I would prefer if we could keep the subsystem prefix for node names. So
> something like `ssam_node_tmp_fan_speed`.

Please disregard that comment. Somehow I thought it's part of the TMP
subsystem, but it's in its own FAN subsystem. So all is good.

> Otherwise, this looks good to me. With that changed:
> 
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
> 
>> +
>>   /* Tablet-mode switch via KIP subsystem. */
>>   static const struct software_node ssam_node_kip_tablet_switch = {
>>       .name = "ssam:01:0e:01:00:01",
>> @@ -319,6 +325,7 @@ static const struct software_node *ssam_node_group_sp9[] = {
>>       &ssam_node_bat_ac,
>>       &ssam_node_bat_main,
>>       &ssam_node_tmp_pprof,
>> +    &ssam_node_fan_speed,
>>       &ssam_node_pos_tablet_switch,
>>       &ssam_node_hid_kip_keyboard,
>>       &ssam_node_hid_kip_penstash,

