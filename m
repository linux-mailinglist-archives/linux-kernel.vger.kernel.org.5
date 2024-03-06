Return-Path: <linux-kernel+bounces-93913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 185E78736D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7148284F54
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5F512C52C;
	Wed,  6 Mar 2024 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZblSekCi"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFAC8289A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728985; cv=none; b=PF/IWxETn47Oemra10/OokpB65DYl14hPe1VhkFzxv8GzssVnbB3+dMBiJQBlKCMD68luVUr0sNxaL4FIMxERYLyTeRma+KLXcd+pM2EgymCAfnagw2Ea56Rf5sVg3G/Sg3UZVOrxAOyGZkjnjxNiQnCH/4oRau51l4V0pejX78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728985; c=relaxed/simple;
	bh=AoFFsxNxs2b1QYeOyo1rzJ6JZmtqFsJq//ksRON85ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p22QoUWOQVB5G8KPnGUjLrdCSnCoWFaua2Ja/jM4gbt8oSnFYekCzndvhAPBfItJoKkdp+68OAdRbPNtwON7yYprzmrDaFp2dqQwJb93LG7JPLabqIs7ZuVppJgfph8LGxp59NXpMheEd3bZbw8FK0B5n5bDvIwQsWXNst9hAKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZblSekCi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e2774bdc7so4553120f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 04:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709728982; x=1710333782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/Pxq6YNE5VeN9FYLxBDdkxwUgy87TjbvzecOQbWEbY=;
        b=ZblSekCiQK272FL2BzrD5/m8uLICy6+xyFjg0URJhBRVXp9n3+kXjHeUzYipQmAjev
         /7mVjn9NCqSrQ+2ZVknNQqiQhM71QWCxt3HpBFcPWkX85EN8l5qGFRin3s+BiDW+8sga
         2bBNwOMMWx0cxdOaIR/PaDMma0H5iNjK37w1IoFHaHgTRWwjMx5qG/Dor5PbXerHbEGJ
         +VYXwWn6Sm038KxED3RG2HuThWpxH9aZB+PYrK/XuKOYNm7kw/ZeSRvW6f/TYGc009XD
         ot8HZY0v3rOw5wuJkDTz5koERq7W9xbG5IeRGs8XW0VzaG2Hc90fEGsTqMG1fLRu1RLv
         YLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709728982; x=1710333782;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/Pxq6YNE5VeN9FYLxBDdkxwUgy87TjbvzecOQbWEbY=;
        b=lsTC9/IMbcLlGAuLnMPigQcEKa1350VRq2IM9tCnh453Y6Zeat3ZiW85K6lb2QTpvg
         Wc4wwKoxbN+VpQDaPd4SQIhpwiQ2dZfPkU0HFSmhnSmDCFDXrrdTzNGaE/S8yOXCJMex
         Adb57V82d2NfE5uegFyxBwO4tYWIf4+rX0Tfq0JJUOsUWIykm6A+8ghU+7T4t3AYEjK8
         vXEedAYs/Zfa/J4ruBXDX2mTSa+IkS7V+N18NInytj4GJQAbApJ3VWouE4j1KNlE/ABI
         UiPkkqZ0HOQmbLc1CLm05H9fk+o/SLWXIkReua9mU4yESvWOu390IXeam9s4klYYH+2i
         jgww==
X-Forwarded-Encrypted: i=1; AJvYcCW/Va9CeakqTUmS10rJl6A4q3v3nbiru8EdtjNBhN3fhvi39uLnfINgMqWmwLxWbqOjdBACoQeB3fjosUJbK9Z19o8fKe3AZIHT2gpW
X-Gm-Message-State: AOJu0YwBwRx7BeXG8TinUigSCKnknpSEQvDtp1alecgmlhs8yMAecgwE
	tZGr6A1koXCbk30U/tNxiYgWZm01tiB/oBdbCynQ/gD7XC6BR4lzG9A7pmIIonI=
X-Google-Smtp-Source: AGHT+IF2ySjqtfkI1PQ3MbdrNUXKYUlwGx2tDc7otolcdge0Vus0SWl7qjL9/CZbIt2509kq8ZkXYQ==
X-Received: by 2002:adf:e310:0:b0:33d:b627:c3ec with SMTP id b16-20020adfe310000000b0033db627c3ecmr11586557wrj.44.1709728981970;
        Wed, 06 Mar 2024 04:43:01 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id cl5-20020a5d5f05000000b0033ce727e728sm5050782wrb.94.2024.03.06.04.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 04:43:01 -0800 (PST)
Message-ID: <14651d5b-0f67-4bff-b699-2cd1601b4fb2@linaro.org>
Date: Wed, 6 Mar 2024 13:43:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] thermal/core: Fix trip point crossing events ordering
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <20240306085428.88011-1-daniel.lezcano@linaro.org>
 <CAJZ5v0jAn2F-GH=fguX0+3bG38vyAxfufadtFiBUfg=EjTBh6Q@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jAn2F-GH=fguX0+3bG38vyAxfufadtFiBUfg=EjTBh6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/03/2024 13:02, Rafael J. Wysocki wrote:

[ ... ]

>> +#define for_each_trip_reverse(__tz, __trip)    \
>> +       for (__trip = &__tz->trips[__tz->num_trips - 1]; __trip >= __tz->trips ; __trip--)
>> +
>>   void __thermal_zone_set_trips(struct thermal_zone_device *tz);
>>   int thermal_zone_trip_id(const struct thermal_zone_device *tz,
>>                           const struct thermal_trip *trip);
>> --
> 
> Generally speaking, this is a matter of getting alignment on the
> expectations between the kernel and user space.
> 
> It looks like user space expects to get the notifications in the order
> of either growing or falling temperatures, depending on the direction
> of the temperature change.  Ordering the trips in the kernel is not
> practical, but the notifications can be ordered in principle.  Is this
> what you'd like to do?

Yes

> Or can user space be bothered with recognizing that it may get the
> notifications for different trips out of order?

IMO it is a bad information if the trip points events are coming 
unordered. The temperature signal is a time related measurements, the 
userspace should receive thermal information from this signal in the 
right order. It sounds strange to track the temperature signal in the 
kernel, then scramble the information, pass it to the userspace and 
except it to apply some kind of logic to unscramble it.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


