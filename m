Return-Path: <linux-kernel+bounces-166884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5611F8BA157
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095D6285AE1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF98180A9F;
	Thu,  2 May 2024 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTzvj6Jb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4BC180A96;
	Thu,  2 May 2024 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680350; cv=none; b=MiLpCfsMNPwEfCgqCyMvWjQWAof+bvYO/DA0YXHYcFX3iVBl6BzUJd+R116ZRxKlnThSbQgOa+40BV3K3NvisQIrcNfTIJFi9qEusrieFz9esezicn7+4nj6oqnbY3ayXTYiEj+guv32EPS6sVc7xrQsVFF05WRPjDWsOrU9RS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680350; c=relaxed/simple;
	bh=vhlNDUeZIeAKCiYPSLEh2Ii826G2fhUv3y2XiGVPsiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CL3C5zHw37K7F6osnkr9ysAUVtA/CfN9hRHS11g4NH1Yrrl4VwcTJJXbIF90Og2xXxdtKNDg4n/TnYGjeTEKxpFb7EQE13pov0XzHB726WPXPXLvU5OPI3peRP9mCJ3L7nOvVm4SIsMz1LV/xly+WAHowbFmMZJcVKtEkfcC12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTzvj6Jb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41b5e74fa83so56730535e9.0;
        Thu, 02 May 2024 13:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714680347; x=1715285147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CaQbQJW7qpDa3J1bLEylpyUDiUE+NN+Elta1I7Et/qA=;
        b=cTzvj6Jb8EMyXW7U5K2cDvdJ5HHNBJxoFYPdYZuYxPpKD1lQ7xnNfPV93/j1hDUeJm
         8MPtiFSGrNujEtHzpKD6ojJSxnHX7dJjhiTWgknqrIHlZnhoJE6umsJIkd5iwpDLk+wG
         7hydxfieTx2DPFtCRAjjdmrngkcD4tA186PVoor5bGIC/FOpmiewLN0UiLoEi/+F7mvi
         351mQgT3XzcKULWY/p5sjrRPGSEVx5MLfmUjOxjQZP/fm2jpjPSeT8n63HmJmUcFQl7Q
         2B2bbG79poDBGA8CWhPWFhmw/OWv1wokBJQIB0MSgm/2yzRnzAgzBnhMW6Fssk9K/t7e
         eafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714680347; x=1715285147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CaQbQJW7qpDa3J1bLEylpyUDiUE+NN+Elta1I7Et/qA=;
        b=WJWx0WNfVV6xiOHUrXWzGiQCJcbIrSUqzJLZomnS+fAswYjIXm5pECCam8CCLIwcx9
         nec1B4mzds3xCBD9rmnKAAOmN8CflxZ2RkIOQDcbxprfBEg034527adIl+SYLdS5t4n+
         mY9Rs6HwkaWuNRzO9F3RYdhrhTETj+12b22J+byt5eGL/JFP0fl3vzSSeKYuhn9z+olR
         o/og/o+ir5BsozyYIPCz+AiZwJnVO/NlSgKdl1M8iAhFQapcnNImKhv73WTYMxW40Jzh
         4pZMTz5HS5JsfZ/xtYtQiFdiwpgtn5swzwmImTkTcPzycBzZV7K9kFboi3iwPZG2EiMY
         oLlg==
X-Forwarded-Encrypted: i=1; AJvYcCWosNMBT03PERQWJWPLqR/n/DPN/oi1JPpwenS8zx8P5OKZtrMK9mHkXfEtg/eEh4ZgR6CaJjuTpLweeOm427KED02ArwG/MJwGuHJuXWXznkGseNYlgoL0xaOsuREAMazlEBYFqaeVtPbWuwwqCoi9OwzQhXhLt7AY6OAC5ntJlxXIC7Q1usKJCTm3nbAd
X-Gm-Message-State: AOJu0YxzAkoNBtiEKjLkIgP9ayw6fDnfXy7q25CmsnC17G3PbRJOJxoh
	4IV5lsdjrPONi/ZvPAwdxrud0IQGPcG7mkwJ2vKkkgQVVkdKyfe9
X-Google-Smtp-Source: AGHT+IERDdLSkd1KZypnKYe4Ok4q7bdJEXZCW/hz4GNoQecQXu9dDSHxZ/8mcrQyyvAGsgBB2HwrcA==
X-Received: by 2002:a05:600c:4691:b0:41a:141c:e15a with SMTP id p17-20020a05600c469100b0041a141ce15amr590276wmo.16.1714680347215;
        Thu, 02 May 2024 13:05:47 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c458c00b0041bfa2171efsm3010935wmo.40.2024.05.02.13.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 13:05:44 -0700 (PDT)
Message-ID: <b7d97b2b-8b13-4a02-9235-46ed418c3d81@gmail.com>
Date: Thu, 2 May 2024 22:05:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: surface_temp: Add support for sensor names
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Ivor Wanders <ivor@iwanders.net>,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240330112409.3402943-1-luzmaximilian@gmail.com>
 <20240330112409.3402943-3-luzmaximilian@gmail.com>
 <43908511-198f-42ee-af21-dad79bdf799a@roeck-us.net>
 <97d0f68f-63da-4f72-ae8d-89fbf9aadf62@gmail.com>
 <8d62af9d-281a-44c0-a40c-93ae76827705@roeck-us.net>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <8d62af9d-281a-44c0-a40c-93ae76827705@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 4/16/24 11:08 PM, Guenter Roeck wrote:
> On Tue, Apr 16, 2024 at 09:00:05PM +0200, Maximilian Luz wrote:
>> On 4/16/24 3:30 PM, Guenter Roeck wrote:
>>> On Sat, Mar 30, 2024 at 12:24:01PM +0100, Maximilian Luz wrote:
>>
>> [...]
>>
>>>> +static int ssam_tmp_get_name(struct ssam_device *sdev, u8 iid, char *buf, size_t buf_len)
>>>> +{
>>>> +	struct ssam_tmp_get_name_rsp name_rsp;
>>>> +	int status;
>>>> +
>>>> +	status =  __ssam_tmp_get_name(sdev->ctrl, sdev->uid.target, iid, &name_rsp);
>>>> +	if (status)
>>>> +		return status;
>>>> +
>>>> +	/*
>>>> +	 * This should not fail unless the name in the returned struct is not
>>>> +	 * null-terminated or someone changed something in the struct
>>>> +	 * definitions above, since our buffer and struct have the same
>>>> +	 * capacity by design. So if this fails blow this up with a warning.
>>>> +	 * Since the more likely cause is that the returned string isn't
>>>> +	 * null-terminated, we might have received garbage (as opposed to just
>>>> +	 * an incomplete string), so also fail the function.
>>>> +	 */
>>>> +	status = strscpy(buf, name_rsp.name, buf_len);
>>>> +	WARN_ON(status < 0);
>>>
>>> Not acceptable. From include/asm-generic/bug.h:
>>>
>>>    * Do not use these macros when checking for invalid external inputs
>>>    * (e.g. invalid system call arguments, or invalid data coming from
>>>    * network/devices), and on transient conditions like ENOMEM or EAGAIN.
>>>    * These macros should be used for recoverable kernel issues only.
>>>
>>
>> Hmm, I always interpreted that as "do not use for checking user-defined
>> input", which this is not.
>>
> 
> "invalid data coming from network/devices" is not user-defined input.
> 
>> The reason I added/requested it here was to check for "bugs" in how we
>> think the interface behaves (and our definitions related to it) as the
>> interface was reverse-engineered. Generally, when this fails I expect
>> that we made some mistake in our code (or the things we assume about the
>> interface), which likely causes us to interpret the received data as
>> "garbage" (and not the EC sending corrupted data, which it is generally
>> not due to CRC checking and validation in the SAM driver). Hence, I
>> personally would prefer if this blows up in a big warning with a trace
>> attached to it, so that an end-user can easily report this to us and
>> that we can appropriately deal with it. As opposed to some one-line
>> error message that will likely get overlooked or not taken as seriously.
>>
> 
> I have heard the "This backtrace is absolutely essential" argument before,
> including the "will be fixed" part. Chromebooks report more than 500,000
> warning backtraces _every single day_. None of them is getting fixed.
> 
>> If you still insist, I could change that to a dev_err() message. Or
>> maybe make the comment a bit clearer.
> 
> dev_err() would be acceptable. WARN() or WARN_ON() are no-go.

Sorry for the delayed response. I will change this to a dev_err() then
and try to re-spin the patches this weekend.

Best regards,
Max

