Return-Path: <linux-kernel+bounces-153338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590248ACCD0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C509D1F21B30
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C9F146D6C;
	Mon, 22 Apr 2024 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ7yfvth"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEB63D3B3;
	Mon, 22 Apr 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789435; cv=none; b=uCnNOZHzZwpemY0+JfoQAL7w6NeB6t+v5Q2QHqdJXElKW6QHHps3ndE5oP/hYMtT57+Zj6qj9/C22d8gbSgbXWJjxdJFNFMzakQxJkUSLuHZfYznQSHqVMo7iru1Vv2LRFmXU7Jps44l94XW1iwM/AK6z7/Hh9xsBl3IrOZZh20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789435; c=relaxed/simple;
	bh=7E3gSo7pIjoMRl40zwRt+RVyO8TeMZSg6HYAs92474o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHdwIOEqAkF2POzjQy3g070fr6Toj1KJMldpEYsRxdSK+95k+bDqeNQssIfXt/YJasCgtmDiWg9nRjUeZSrw8AGEWU95H57KxfWPA5ARo7NJcCLLZq+iEiBc3HcdgzFp4epiEI9tpO9WjTkxqNkN9EGTlc4C7j8XMTFIvTLPOMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQ7yfvth; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f0b9f943cbso2688469b3a.0;
        Mon, 22 Apr 2024 05:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713789433; x=1714394233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RFyjnIv2yXGwk2NGYzo7HMQjMlwXHh1RqaWcgv/O+Bg=;
        b=TQ7yfvth+oeUc+6cyf6JvwBQZFSfcAWH5ozd5vW+vpOQ7cFFEsYQ1bluWF1Eu7EEY7
         QkfXGh6OCFGn1QVu2XAiBAy3O7YSH4RAngjUDzbQA+SK8TQTSP6EqvIvl0iq5fAxSYf8
         kk2odbddQ0jU4zpdqB/Zog6lYfJCHifVRgb4E/QBiDqMKxg1yTcnTqSxrox2/o5FAvZ8
         Ch84i1IzrcsRhquaqQcofWgVyAvZ2RrdaSq/e82Vo01SNJRayWh+jFRHH3EOU+tRJsFU
         /Ttq3TJ7+EpxzM2D1I90gBcO+D1J9yQqbAIUxOxZHHY1n8v+J5VPEKaH6h7fOJk9s1pz
         mYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713789433; x=1714394233;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFyjnIv2yXGwk2NGYzo7HMQjMlwXHh1RqaWcgv/O+Bg=;
        b=ncNVU1JP29WRze3hC09V0/Zc1x0XcKV3EzD4i+aQ3NIIwdA10BSIm7YwVNiiTqWwgT
         fEsMQl/B/XYiAp8a5T403ixznKKuLORU9ByF4n5TS++okX7LIaN5GTT1gR3oywPmQ5IF
         WI2mTqiCmotxYHSM9SXhB7+GRGvQMyrzgPoQ8JU7rUXmyTcGzd6+kfdG+3M9LWYITeJ1
         V/hilAh/Pz1HjHQDSTHFAq9Sloe+JQWJuP+WK3xEz7NqrL1JTEGxdsBgPrtEPCe+m59+
         A3AV/I58vY7F/V2GBTP4B6rp2c1jQNNVc/9/jgz9hCi4FeOT266dXsjBipTj2cSLHvVh
         Uo8w==
X-Forwarded-Encrypted: i=1; AJvYcCWvs478gT2AnxeuT4IcEOYO+WNLWx7QDMP88I+xR/raG8ifJCNx+wYxP8hoT/a9/ghtxss/rxmAQbQx2SCky2UfKaQR/g9oYKU6A60TGecCpeiLwITSpRjeW3/WJ5E7pJU0foxnSTzxPRQFQXp1cH36Kh34HdkbX5CRVGSTWKhoiquXVqQ=
X-Gm-Message-State: AOJu0YyoJictR+TlAHjFPu6bysFaXvsEOR38m11JufrS47sgXsn/24B2
	Au76xaOK3fiebX3WrvwVJYWeY1u9ySBok7aHrmp14iL3bnSsC6kd
X-Google-Smtp-Source: AGHT+IFjYvR4M0+R39xZdANVBKAJ/Fo8WFl4Q2T/wAoBK/cwe98XP6yaLpp44ODXhofMwLEED5P4VA==
X-Received: by 2002:a05:6a21:3a44:b0:1ac:48a9:8a42 with SMTP id zu4-20020a056a213a4400b001ac48a98a42mr10928542pzb.14.1713789433388;
        Mon, 22 Apr 2024 05:37:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g11-20020aa7818b000000b006ecfd0bf326sm6325968pfi.99.2024.04.22.05.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 05:37:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1294114a-4509-4c8a-a0a2-39f6e5f83227@roeck-us.net>
Date: Mon, 22 Apr 2024 05:37:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hwmon: (max6639) : Utilise pwm subsystem
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: krzysztof.kozlowski+dt@linaro.org, u.kleine-koenig@pengutronix.de,
 Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20240416171720.2875916-1-naresh.solanki@9elements.com>
 <20240416171720.2875916-2-naresh.solanki@9elements.com>
 <ecddd7f3-fc25-4021-9758-b00893ac9622@roeck-us.net>
 <CABqG17hebvkpvxwGVfp0nT_YMrvgdkEqU2_XjijCpdtgU6C+1A@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CABqG17hebvkpvxwGVfp0nT_YMrvgdkEqU2_XjijCpdtgU6C+1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/24 03:39, Naresh Solanki wrote:
> Hi Guenter,
> 
> On Wed, 17 Apr 2024 at 02:52, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Tue, Apr 16, 2024 at 10:47:15PM +0530, Naresh Solanki wrote:
>>> Utilise pwm subsystem for fan pwm handling
>>>
>>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>>
>> That adds a lot of complexity to the driver. I am missing the benefits.
>> You are supposed to explain why you are making changes, not just that
>> you are making them.
>>
>> Why are you making those changes ?
> Sure.
> This is to align with fan-common.yml wherein chip pwm is exposed.
> I'll update commit message
> 

Adding lots of complexity to a driver just to have it match a yaml file ?
I'll want to see a use case. Explain why you need the pwm exposed.
"because the yaml file demands it" is not a use case.

Guenter


