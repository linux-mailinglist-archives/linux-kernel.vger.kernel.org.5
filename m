Return-Path: <linux-kernel+bounces-155732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1839A8AF64D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31121F244E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C065F13E05F;
	Tue, 23 Apr 2024 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hs/z0vmp"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3713666F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895786; cv=none; b=niNiBW40Y09L0DWALr3B21EWPjLWznC+oaXBs0Ggsmy5ye4rFc7Ossk+/PI/yDjop6ErQarvd/GoJC6DpRLXwkiy6yV4+dCE/kKgFaBtIQhzY/dbOTKh2mFZkxQrzC+Ass/ceOa+OdT3NfYnPINbRW+pp0W+a9jPeCC2dT/w47U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895786; c=relaxed/simple;
	bh=FF7iWnaWE+9ecuoFHYzt6Gxh4VQLPipcHvypjs7PkEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNKfykzs/xa6iEJVy/0dUVk1QqQIRFVczOKn3SHjWLoWQQc+WlhIE0ud2R4axfaF6+qmS2bADvhVY7BN/USkwSPfjQSNjDX4vlBaawEDw0NFbzaknotND+wAF9SUNWjDrTOZlr+LpT3QWsMzNl4DrM9dkMY0Ya803NT0jDdBISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hs/z0vmp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41a442c9dcbso20533075e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713895782; x=1714500582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49AEZ8yLm4WjNc+IjD5cDuG0qOxIOXTYKsg3bQTJ5pE=;
        b=Hs/z0vmp6DirfxhbJseZPfOsEpjMiZvVHKBcKPuolqxIxlcDGiNXUYu9OM46VFPxhy
         prC6puy+T8Ut7RCBatedR6D+kI9FPioJu9t0mSdySRAcsTsUUhtG6RoE9i6QKK+5hKWy
         ga4937LFA3AKC182X+878unhtgIMGtDo18EbPDO2LDq3o2bHLfITWuRltVf9A3nOvm+7
         owSPoN0mX/ZdOpMfc5SUDeFbYY8RLhfS6RieKOs58YxijYcnk3BuRLjRrFdLbnoZFSFp
         5LWtStbI/zc1U3tFyiiSrIAdR8bQz7UPhJO/tQvaqdQPW0EpUtS6eWt8/6jzT+Ys90Ow
         SKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895782; x=1714500582;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49AEZ8yLm4WjNc+IjD5cDuG0qOxIOXTYKsg3bQTJ5pE=;
        b=oDEfvQpBGlqopwcXPqcVV4WXXTqPKYZ+8EE99yQk2KbQs77RUU2ED3io+JfXkX80IT
         EjvuI49crEfsJIX5lylgANcnxeW8/XVwABPzErbj5bOTZd4OLPJGTfxPIaQkSgR7FlxM
         lGQCuOTFUHuZJkWut6zk41RwI4MbjoVGBLordRtalvkQPSVnxRfe6MRCGP7KVKyuOslO
         1fTVTAFUPxqvfznVE4M6dzz30LOdHCNoEW3J+SG1RenXr6YjKx93ws41U3eh/UctjBHV
         /z6BKzze4jxKbobXAfoXqrYh0cczHYKPosrNIewgEnpsJ7NAck7EFshdLIkMuET/wugv
         BF8g==
X-Forwarded-Encrypted: i=1; AJvYcCV5KE+FC/V0blzrHsmWodp8pP3vxKS2ioUEVnopyMRnU6yZW3edcPo18uuqzoEEiZBBXbZWlG4RE/plse8ffsAbgbfuUjS4djM3Pags
X-Gm-Message-State: AOJu0YxcPK2dwtHVbF1xdoIUjme4WEyFtSU3aBYZmS17N7pjf/GfpYFU
	e6SO6+4mWFjQfCMem1gW/QJOxrHNrXTeTzrF4m+wqqY+IXsBAellHd17y+oqKbk=
X-Google-Smtp-Source: AGHT+IGsQSohpAha/LsPn9O8PrE8OTf9iZxKAOzgt6KZdJrEzjYJHiG+lRT+Cc410bAZPw8KyTCb2Q==
X-Received: by 2002:adf:e542:0:b0:34a:4d1:b913 with SMTP id z2-20020adfe542000000b0034a04d1b913mr10130089wrm.52.1713895782586;
        Tue, 23 Apr 2024 11:09:42 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id a3-20020adffb83000000b0034b32e5e9ccsm4726273wrr.64.2024.04.23.11.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 11:09:42 -0700 (PDT)
Message-ID: <61560bc6-d453-4b0c-a4ea-b375d547b143@linaro.org>
Date: Tue, 23 Apr 2024 20:09:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/16] thermal: gov_power_allocator: Eliminate a
 redundant variable
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <1913649.CQOukoFCf9@kreacher>
 <8e26c3cb-1283-4561-95aa-30432f1d13ee@linaro.org>
 <CAJZ5v0h=15LYhukPWmHPK5hvD=2u75rTEiC8oJMVBFziMkB5gQ@mail.gmail.com>
 <33cafcb3-af9c-4058-b6b6-4e5aab6e21cb@linaro.org>
 <CAJZ5v0hR-fN08g-g_S261e+U=2Enfza3b9NZpmp4yhzAa=426A@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hR-fN08g-g_S261e+U=2Enfza3b9NZpmp4yhzAa=426A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/04/2024 20:05, Rafael J. Wysocki wrote:
> On Tue, Apr 23, 2024 at 8:00 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 23/04/2024 19:54, Rafael J. Wysocki wrote:
>>> On Tue, Apr 23, 2024 at 7:35 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 10/04/2024 18:12, Rafael J. Wysocki wrote:
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> Notice that the passive field in struct thermal_zone_device is not
>>>>> used by the Power Allocator governor itself and so the ordering of
>>>>> its updates with respect to allow_maximum_power() or allocate_power()
>>>>> does not matter.
>>>>>
>>>>> Accordingly, make power_allocator_manage() update that field right
>>>>> before returning, which allows the current value of it to be passed
>>>>> directly to allow_maximum_power() without using the additional update
>>>>> variable that can be dropped.
>>>>>
>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>> ---
>>>>
>>>> The step_wise and the power allocator are changing the tz->passive
>>>> values, so telling the core to start and stop the passive mitigation timer.
>>>>
>>>> It looks strange that a plugin controls the core internal and not the
>>>> opposite.
>>>>
>>>> I'm wondering if it would not make sense to have the following ops:
>>>>
>>>>           .start
>>>>           .stop
>>>>
>>>> .start is called when the first trip point is crossed the way up
>>>> .stop is called when the first trip point is crossed the way down
>>>>
>>>>     - The core is responsible to start and stop the passive mitigation timer.
>>>>
>>>>     - the governors do no longer us tz->passive
>>>>
>>>> The reset of the governor can happen at start or stop, as well as the
>>>> device cooling states.
>>>
>>> I have a patch that simply increments tz->passive when a passive trip
>>> point is passed on the way up and decrements it when a passive trip
>>> point is crossed on the way down.  It appears to work reasonably well.
>>
>> Does it make the governors getting ride of it ? Or at least not changing
>> its value ?
> 
> Not yet, but I'm going to update it this way.  The governors should
> not mess up with tz->passive IMV.

+1

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


