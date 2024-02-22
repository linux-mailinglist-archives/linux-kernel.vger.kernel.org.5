Return-Path: <linux-kernel+bounces-76783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8180E85FC84
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ABFA2851BD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388AB14D458;
	Thu, 22 Feb 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SN8JBdHC"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A8D14C5B0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616205; cv=none; b=hv3TIz68AiWuaQRimWyGXeU11rlw4+BaEjymFljvlHaKwCpd7fZcqZGtr+SU1M/5UXw7QrMOF5xqjhAE6UasPxY3eBJ82fxDZZT8piyggGKRTB7gLaF1lytShneVLLdtrHuIGLi6k9+cKOewQ9DQ6WJsWVjfV6xDR7p0Af54M8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616205; c=relaxed/simple;
	bh=nWluQmQSxTtCEtML6EbHWkhsqKBWuwPsQCaDpck1C+Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=InhxVyHULEhUR6ulQ5Y2m+dd1xAd81IIdNS+Nu+fAN/5wEovoIhWPXs6Mbd7sUCZygx1OqPkjESYBfw/6N6QqcL0nYJPAZAF9Ie27u9TY2cAcruSiFSHoEgPIRdqPzNQJyVInhwn1v3RdJGMPoID5DQiyiveSQXmD7atrROBfIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SN8JBdHC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41279488d3cso11666685e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708616202; x=1709221002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rG6qiCLfCPQEkL7kZtcdTc5M6/ygLvFUYyUXsw8H8Iw=;
        b=SN8JBdHCgDQQxrbmJ3nO1/SEdn11RkIx4NMUeIoK5duVgWpH744v3Ow8tqH8N7v+sS
         tUJGwYIfr8kreKCU4e9CRTB8CRJCZdcU0al9F552/WZanlHXGwwR7KLdZN/SxLVTrmau
         DzLCkBY4cxgHTT1R+oYhDDkbREMtkRxosTWQA3E3pjVTRLpiE7M4yLpO/28hlHq/1ELc
         5lCjk/GuSNJZwKV6dhcfPdIz3BZw6SRThKklVf5b2wAPxA7jyMR3U2AgAGs+syEMRUCF
         bT6PrbbPEvb4KxGJn2JRx504ztfX+PlML4mcuTyUt6FOnDPOQjip4gbBrKWi9SRWaARC
         8Iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708616202; x=1709221002;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rG6qiCLfCPQEkL7kZtcdTc5M6/ygLvFUYyUXsw8H8Iw=;
        b=q1rLSPQBpP5lKxPC31hriTod/uTMbTD+BLwjW0Ay6scO95Ag1lemmqeS/SB9B3YlqK
         gHdHsNMirClSuG7s/xA73xyB84Qi1J3rUdD80wK1OA3o6e4MnMPVpn4drlI2uOu06d/8
         /tYO/1IF8n1dOIYca0wnRl9PDhjTMVEZLJT6N9blREKtIhmdTV3vukUENaHcuTxZuUYI
         1Bsahj499NDQ02VgKLcqlk+zx9ZcXz8Fxme/S+PWVBKhz8aCUB8RyBicKpvKf8+yYK0a
         zQNa63c42SGnB55Z1Co2O0NkJqFY1fS8qlTenvaBo11vTX74Xg9Z+UCp4UA7ZjxmGZjX
         DXPg==
X-Forwarded-Encrypted: i=1; AJvYcCUVHOSlFMqjB9A5hIkwwVNj9jwyDsFuKlSnEJ3OCDFUiZAhDH6NMQ5pVEYHLrzTfIZ9RLDPiGl4/oqJ0qETVpMlnBB9SyL/E0WNFdQQ
X-Gm-Message-State: AOJu0Yw4W3nTgsIrisbdvo8Zz6FKPJ63MJkwhLe/ma9CSfikeNUeNnLE
	jUUuTpn+2XzbK9/znIIJNHQFCOtg3GnDcLYGlOGwEGGvnypkjx4WVn5lZtsyMA0=
X-Google-Smtp-Source: AGHT+IFHbETJ2129o/mnz9ZnTgSGCEXTNSuh9KppLAt7VStuR79XrDMNMALrvv6J1CYjR2CbD0dmig==
X-Received: by 2002:a05:600c:a39d:b0:410:ed31:9e96 with SMTP id hn29-20020a05600ca39d00b00410ed319e96mr15929865wmb.11.1708616201864;
        Thu, 22 Feb 2024 07:36:41 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ba24-20020a0560001c1800b0033d9ee09b7asm315655wrb.107.2024.02.22.07.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:36:41 -0800 (PST)
Message-ID: <ad3bc3e4-bff8-43be-b853-3d1ca0b5d0de@linaro.org>
Date: Thu, 22 Feb 2024 16:36:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] thermal: core: Add flags to struct thermal_trip
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <6017196.lOV4Wx5bFT@kreacher> <2173914.irdbgypaU6@kreacher>
 <59e8fd70-5ba6-4256-9127-bd5e76e6bc99@linaro.org>
In-Reply-To: <59e8fd70-5ba6-4256-9127-bd5e76e6bc99@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/02/2024 15:36, Daniel Lezcano wrote:
> On 12/02/2024 19:31, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> In order to allow thermal zone creators to specify the writability of
>> trip point temperature and hysteresis on a per-trip basis, add a flags
>> field to struct thermal_trip and define flags to represent the desired
>> trip properties.
>>
>> Also make thermal_zone_device_register_with_trips() set the
>> THERMAL_TRIP_FLAG_RW_TEMP flag for all trips covered by the writable
>> trips mask passed to it and modify the thermal sysfs code to look at
>> the trip flags instead of using the writable trips mask directly or
>> checking the presence of the .set_trip_hyst() zone callback.
>>
>> Additionally, make trip_point_temp_store() and trip_point_hyst_store()
>> fail with an error code if the trip passed to one of them has
>> THERMAL_TRIP_FLAG_RW_TEMP or THERMAL_TRIP_FLAG_RW_HYST,
>> respectively, clear in its flags.
>>
>> No intentional functional impact.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---

>> ===================================================================
>> --- linux-pm.orig/drivers/thermal/thermal_core.c
>> +++ linux-pm/drivers/thermal/thermal_core.c
>> @@ -1356,13 +1356,23 @@ thermal_zone_device_register_with_trips(
>>       tz->devdata = devdata;
>>       tz->trips = trips;
>>       tz->num_trips = num_trips;

[ ... ]

>> +    if (num_trips > 0) {
> 
> Is this check really necessary? for_each_trip() should exit immediately 
> if there is no trip points.

Given that is removed in patch 9/9, please ignore this comment

>> +        struct thermal_trip *trip;
>> +
>> +        for_each_trip(tz, trip) {
>> +            if (mask & 1)
>> +                trip->flags |= THERMAL_TRIP_FLAG_RW_TEMP;
>> +
>> +            mask >>= 1;
>> +        }
>> +    }

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


