Return-Path: <linux-kernel+bounces-93963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAEB87378E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B4DEB23250
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FBC131734;
	Wed,  6 Mar 2024 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJrVSAl1"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BF7130E57
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730986; cv=none; b=B9yUflFW9DxISlcicL67G01Mgpj05Iwfn5CK4HHIzASySmh/rb6S0fn6UjVL2tIXxa72AYC1H8T8LxMhzEk49Sk0FEMzNWirBbSm7vE8TGP3w6tU5P1q0CTn2qWQpaWM47hyE3LV++KBubFkYVUGttnQa8lSTNWXzVkh4SUH/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730986; c=relaxed/simple;
	bh=4KnoU94TnfwFDb1O7Z/od2GBF5TkOczm5tUXOhwWFjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6kseeEL6wxZ7CDe30YPAJ0tJmsgb9n3fDPokDR7HZ0ifDeSsQs1jfyH2WW2B/2/EeQ1e9IQRycMrw5ZrJA2o0Gi485VDH0TKYfrzDtXOwvaMbwsa2VZJxt0fBPFhhkZMqQvOU4G2mNjFS27WXM5xGQwy0ihBi19LRutJILt6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LJrVSAl1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412a9e9c776so5147515e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 05:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709730983; x=1710335783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iNWCmGU0euBopVepxGM3Nd7XayHAv0ZdAnMZWAHMpN0=;
        b=LJrVSAl1UaRDlHR/wdbxToX8j/xxO/zwtnMZUYnTGF53ngw7mAtajymYN8UG8AbbHn
         HYGOpAWkTGBCe+F+nRFGlp5NmtV+lBlBu5nLwOxZ7KKFLGKZid3a93K8pE4BsO7gbVym
         3xk1ex1c8RqtUP+PBPS28Mne+MHaSpsnFHptuaaPxqs0LeEuQjJJb2ascbXJZcdxd2dX
         agPMSY/Si1YGgA210bvIhO5aQ/xIVgckUwltALNBkKcd03zAD3o+4jUJ5qxb2Egn+nKu
         sDpdJYLcQhOmFL12GuAYoFKz5onLdIK0MXuPrsRj6+FHn0EO9YK64X4UWJezDV8neA2Z
         +KZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730983; x=1710335783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNWCmGU0euBopVepxGM3Nd7XayHAv0ZdAnMZWAHMpN0=;
        b=ksQUtLZqWAaxFTb7utiD4p+r6gylJ39OBgc6kZjBmVrjJdufvIfTS8B9yeYhLDs30x
         E4UUxKppIix8ocj82BdqymL5gGhASQwEE/9GzVnVs2Z4i4wgJHddR6iy4QZUH+HX6ZXy
         GyuaF+5Zuiz+KDWiNGpG9WAYEhEIw09wX0pASGD1KHKqF+pAZTytvCvqbC7pq+a6Oifi
         cGMrKvqx8ui+v0Zo+NkK6uP0srWT34orqgom8y2wUr4aoe1HZ4U6Txh81uQDBELeXfRu
         +VSkqnCH2oMMiYcFOu7cqzCkYXEQyFZk1kfDegIEv9TN3qxReNI9/OQZ71sP0QqZLhjj
         C4OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS2lqK7UKMo6yIStf1BxyFWMW12t3yhHB0cQsoB54o0ikPk0tDLT7N0OpGebpoMZ6k4vO4cEkGy82+oIBFqTZg4/LRgwQZN0R0uXFl
X-Gm-Message-State: AOJu0YxGnTfsV7xIYChlYtXG/bVixqUXNqcOuCOFDpaG+alXiEse2I/l
	Wi900t6kvueGyJrrBncfx1/FyDi7Xn+cZ4SFGfGRAHMynyDbdK1Lw/YfzUXw4PE=
X-Google-Smtp-Source: AGHT+IFUmR2cPTKEVyoLCm5s9d0JeSzjzUdeCnOHv9dFLTph1+f/7ipkDOjdXEL7DbWwMvmNNiqxJQ==
X-Received: by 2002:a05:600c:4ec9:b0:412:ee33:db93 with SMTP id g9-20020a05600c4ec900b00412ee33db93mr4354403wmq.3.1709730982876;
        Wed, 06 Mar 2024 05:16:22 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id t16-20020a05600c451000b00412ee12d4absm4669691wmo.31.2024.03.06.05.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 05:16:22 -0800 (PST)
Message-ID: <0e7f32aa-b2c3-43d0-8ebe-7118cb6e0edf@linaro.org>
Date: Wed, 6 Mar 2024 14:16:21 +0100
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
 <14651d5b-0f67-4bff-b699-2cd1601b4fb2@linaro.org>
 <CAJZ5v0j6At1DuQYjjbA-fw9Z-jJPhXSVSz=_uLa3KfNMJowYbA@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0j6At1DuQYjjbA-fw9Z-jJPhXSVSz=_uLa3KfNMJowYbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/03/2024 13:53, Rafael J. Wysocki wrote:
> On Wed, Mar 6, 2024 at 1:43 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 06/03/2024 13:02, Rafael J. Wysocki wrote:
>>
>> [ ... ]
>>
>>>> +#define for_each_trip_reverse(__tz, __trip)    \
>>>> +       for (__trip = &__tz->trips[__tz->num_trips - 1]; __trip >= __tz->trips ; __trip--)
>>>> +
>>>>    void __thermal_zone_set_trips(struct thermal_zone_device *tz);
>>>>    int thermal_zone_trip_id(const struct thermal_zone_device *tz,
>>>>                            const struct thermal_trip *trip);
>>>> --
>>>
>>> Generally speaking, this is a matter of getting alignment on the
>>> expectations between the kernel and user space.
>>>
>>> It looks like user space expects to get the notifications in the order
>>> of either growing or falling temperatures, depending on the direction
>>> of the temperature change.  Ordering the trips in the kernel is not
>>> practical, but the notifications can be ordered in principle.  Is this
>>> what you'd like to do?
>>
>> Yes
>>
>>> Or can user space be bothered with recognizing that it may get the
>>> notifications for different trips out of order?
>>
>> IMO it is a bad information if the trip points events are coming
>> unordered. The temperature signal is a time related measurements, the
>> userspace should receive thermal information from this signal in the
>> right order. It sounds strange to track the temperature signal in the
>> kernel, then scramble the information, pass it to the userspace and
>> except it to apply some kind of logic to unscramble it.
> 
> So the notifications can be ordered before sending them out, as long
> as they are produced by a single __thermal_zone_device_update() call.
> 
> I guess you also would like the thermal_debug_tz_trip_up/down() calls
> to be ordered, wouldn't you?

Right

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


