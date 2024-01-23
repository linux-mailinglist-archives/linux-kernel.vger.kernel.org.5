Return-Path: <linux-kernel+bounces-35135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D48838CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244132832C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EB85C910;
	Tue, 23 Jan 2024 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFkKkEQ0"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4965D734;
	Tue, 23 Jan 2024 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007373; cv=none; b=EqYwWxzjAUu0mDKhdX96Ef5A/5K6FjQl2m0z5eIB89/ecCPihi23md9Qp1YmqUw71bAwUgAFMrnriVlPDc3t8sPyXW30AmK0PFqPUXPPB02jFFbrGQup4zit72yfC9RmMi+xBUhQWktY/0efv2zrIkaVe8zJhaYa1O13Cd/JxyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007373; c=relaxed/simple;
	bh=ceNZyQnw5MfNKY7ol+8loKL6T7W+qmaLFSAoNYuZb/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiWqed/DYB7b9HSNwZpxfbvOsEJaaMZw5NDDVJM6P9v/ffSTRp2jzgbvkKT9h9HJzKX+NTd0pzzWqGKRNvhW+D55cURQnj1HS4GOccJSmlb+JIttszxtP9H7qjLj65jPLoDNaYvCqkat+/9SIgGRN7znESWQbJDg71QmEuVqRDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFkKkEQ0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3046221b0eso181540166b.1;
        Tue, 23 Jan 2024 02:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706007370; x=1706612170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6tlLSS4uHxJanusoNf1Dgdn3rrBHfEaOAbo9C0XDTag=;
        b=HFkKkEQ0p6EJPKIk1/bw3GdlBxeXzIdXSrdyYBOoDyITHqutiRyS1Uxe8UTFyjo82x
         aHML/qXsAPxqkgVqeOgPpT3b02znD9gckFB9SOfG+tMVJTlwfhC85ohiG7ZPllvmS6Gs
         xpMouAE2TpeuPGYn1oShd/zcY8m2mh21cAm1+cLRg3PmSNOnxRDwGm3OrT2ssIfrYgT1
         TfuEJlLj8rJcf9IBw1PBuYd3e2jb7sJtX6o7kCEdZslkjHhj844l3+XH+9fbeVHx+iZf
         XWp5lYEcpsuQtpkFmsV1kqXyrn5QrEdjK+RR6L775AQ1THj5YV0M5ZAFu2tM/+lCRz+s
         SdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706007370; x=1706612170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6tlLSS4uHxJanusoNf1Dgdn3rrBHfEaOAbo9C0XDTag=;
        b=k7x1FEkK1xA5Va4ymrjlwIAz3EugyadhLCIXGrZLbZoeXFY5UNQlik7Y/SPXwg/sS7
         PtMMQVnxSZzZ9Elx/g8y/54NMzQl4qoB2Vu2bKvfxvCd1mMAM1mIauhZV5KIXVXh/4xK
         EKaby8g/Or+pz+b11nLvsUO/7lpiiLf/4Ms7/4s31eRDih9pUA4QHRK2A+TExZ3BmOL8
         Bm2N07KLN9iD/8cVVWPiovBOBGZCo7vJhhW+b/K6C5owITAsfvFpAJ2B5RYjvTiw/rky
         U4cMgsAH9MWi8SXa5OA/QPF2Cp9KbpWV07w0kjXoGJsd3xgV5+Ra4QRc3ein4gJQA3zS
         08og==
X-Gm-Message-State: AOJu0Yyv6evkPd7MNqiOeNf9u6NPdLUGC8XtPl0rws4iUiY3T0uYiSKz
	6d9SkE/8hRP1TzjLIQM+GXlGHym3Y58tuL842sXREq6w9Uh0PRTU
X-Google-Smtp-Source: AGHT+IFsyvYoZeGb9rFcrlOPx+vcyDFERpKpiYZiZFjQO1K1vvj568spOVwIv8n2IVqSFIADL87xGg==
X-Received: by 2002:a17:906:3c4b:b0:a30:dc63:a617 with SMTP id i11-20020a1709063c4b00b00a30dc63a617mr207832ejg.105.1706007369619;
        Tue, 23 Jan 2024 02:56:09 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:b1db:193d:1c75:4008? (2a02-8389-41cf-e200-b1db-193d-1c75-4008.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b1db:193d:1c75:4008])
        by smtp.gmail.com with ESMTPSA id ti8-20020a170907c20800b00a2da4738882sm10809376ejc.131.2024.01.23.02.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 02:56:09 -0800 (PST)
Message-ID: <efdfb611-5ba4-4cd6-a7f0-bd96259cf1a6@gmail.com>
Date: Tue, 23 Jan 2024 11:56:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "iio: add modifiers for A and B ultraviolet light"
Content-Language: en-US
To: Paul Cercueil <paul@crapouillou.net>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240123104305.10881-1-paul@crapouillou.net>
 <0bd3319f-7d63-485b-9b44-d6858c045b37@gmail.com>
 <a6f79ec0025e1862ba170c6a535447dd09e7dfad.camel@crapouillou.net>
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <a6f79ec0025e1862ba170c6a535447dd09e7dfad.camel@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 23.01.24 11:55, Paul Cercueil wrote:
> Hi Javier,
> 
> Le mardi 23 janvier 2024 à 11:51 +0100, Javier Carrasco a écrit :
>> On 23.01.24 11:43, Paul Cercueil wrote:
>>> This reverts
>>> b89710bd215e ("iio: add modifiers for A and B ultraviolet light")
>>>
>>> Enum iio_modifer is *ABI*, you can't just decide to change all the
>>> values from one version to another, otherwise you break userspace.
>>> The new entries should have been added to the end of the enum.
>>>
>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>> ---
>>>  Documentation/ABI/testing/sysfs-bus-iio | 7 ++-----
>>>  drivers/iio/industrialio-core.c         | 2 --
>>>  include/uapi/linux/iio/types.h          | 2 --
>>>  tools/iio/iio_event_monitor.c           | 2 --
>>>  4 files changed, 2 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio
>>> b/Documentation/ABI/testing/sysfs-bus-iio
>>> index 2e6d5ebfd3c7..7937bb4a4a68 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>>> @@ -1587,8 +1587,6 @@
>>> What:		/sys/.../iio:deviceX/in_intensityY_raw
>>>  What:		/sys/.../iio:deviceX/in_intensityY_ir_raw
>>>  What:		/sys/.../iio:deviceX/in_intensityY_both_raw
>>>  What:		/sys/.../iio:deviceX/in_intensityY_uv_raw
>>> -What:		/sys/.../iio:deviceX/in_intensityY_uva_raw
>>> -What:		/sys/.../iio:deviceX/in_intensityY_uvb_raw
>>>  What:		/sys/.../iio:deviceX/in_intensityY_duv_raw
>>>  KernelVersion:	3.4
>>>  Contact:	linux-iio@vger.kernel.org
>>> @@ -1597,9 +1595,8 @@ Description:
>>>  		that measurements contain visible and infrared
>>> light
>>>  		components or just infrared light, respectively.
>>> Modifier
>>>  		uv indicates that measurements contain ultraviolet
>>> light
>>> -		components. Modifiers uva, uvb and duv indicate
>>> that
>>> -		measurements contain A, B or deep (C) ultraviolet
>>> light
>>> -		components respectively.
>>> +		components. Modifier duv indicates that
>>> measurements
>>> +		contain deep ultraviolet light components.
>>>  
>>>  What:		/sys/.../iio:deviceX/in_uvindex_input
>>>  KernelVersion:	4.6
>>> diff --git a/drivers/iio/industrialio-core.c
>>> b/drivers/iio/industrialio-core.c
>>> index 9a85752124dd..bce09d325142 100644
>>> --- a/drivers/iio/industrialio-core.c
>>> +++ b/drivers/iio/industrialio-core.c
>>> @@ -117,8 +117,6 @@ static const char * const iio_modifier_names[]
>>> = {
>>>  	[IIO_MOD_LIGHT_GREEN] = "green",
>>>  	[IIO_MOD_LIGHT_BLUE] = "blue",
>>>  	[IIO_MOD_LIGHT_UV] = "uv",
>>> -	[IIO_MOD_LIGHT_UVA] = "uva",
>>> -	[IIO_MOD_LIGHT_UVB] = "uvb",
>>>  	[IIO_MOD_LIGHT_DUV] = "duv",
>>>  	[IIO_MOD_QUATERNION] = "quaternion",
>>>  	[IIO_MOD_TEMP_AMBIENT] = "ambient",
>>> diff --git a/include/uapi/linux/iio/types.h
>>> b/include/uapi/linux/iio/types.h
>>> index 5060963707b1..9c2ffdcd6623 100644
>>> --- a/include/uapi/linux/iio/types.h
>>> +++ b/include/uapi/linux/iio/types.h
>>> @@ -91,8 +91,6 @@ enum iio_modifier {
>>>  	IIO_MOD_CO2,
>>>  	IIO_MOD_VOC,
>>>  	IIO_MOD_LIGHT_UV,
>>> -	IIO_MOD_LIGHT_UVA,
>>> -	IIO_MOD_LIGHT_UVB,
>>>  	IIO_MOD_LIGHT_DUV,
>>>  	IIO_MOD_PM1,
>>>  	IIO_MOD_PM2P5,
>>> diff --git a/tools/iio/iio_event_monitor.c
>>> b/tools/iio/iio_event_monitor.c
>>> index 8073c9e4fe46..2eaaa7123b04 100644
>>> --- a/tools/iio/iio_event_monitor.c
>>> +++ b/tools/iio/iio_event_monitor.c
>>> @@ -105,8 +105,6 @@ static const char * const iio_modifier_names[]
>>> = {
>>>  	[IIO_MOD_LIGHT_GREEN] = "green",
>>>  	[IIO_MOD_LIGHT_BLUE] = "blue",
>>>  	[IIO_MOD_LIGHT_UV] = "uv",
>>> -	[IIO_MOD_LIGHT_UVA] = "uva",
>>> -	[IIO_MOD_LIGHT_UVB] = "uvb",
>>>  	[IIO_MOD_LIGHT_DUV] = "duv",
>>>  	[IIO_MOD_QUATERNION] = "quaternion",
>>>  	[IIO_MOD_TEMP_AMBIENT] = "ambient",
>> Oops, sorry about that. You are right, I will send a new patch with
>> the
>> new elements at the end of the enum. This patch should be applied to
>> get
>> things right again, though.
> 
> Np.
> 
> I notice now that we can't really apply the revert as the veml6075
> driver is already using these enum values - so applying it would result
> in build errors.
> 
> Can you just move these entries to the end of the enum in your new
> patch?
> 
>>
>> Thanks and best regards,
>> Javier Carrasco
> 
> Cheers,
> -Paul
Sure, I will do it right now.

Thank you again and best regards,
Javier Carrasco

