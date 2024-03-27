Return-Path: <linux-kernel+bounces-122046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F2888F129
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3392029DBDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D24153575;
	Wed, 27 Mar 2024 21:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwSAoO4Q"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39198152197;
	Wed, 27 Mar 2024 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575893; cv=none; b=XA1zF9kzRlS9SDzSAxzAeg5qMT9mYHndnIn9g8BJeKrxLRU9jQzyNwBNUulfCuv/OF/cwtXck90jqRCFTtqc4YyvG6k1vF8Ez5P7pDeY6K+/zUQwFyvdjKiZauiqAQWIScPR6sHUHCaPGNpdhrMlXegN2Zxwo3A6mIeUTPICF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575893; c=relaxed/simple;
	bh=k4EtKGYMAux8S3J+SduZIiv1JW1GolaXhe8Cr4D309A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEzJLl8DdEmTCZHko2/RO8wibf2WRozn9eo1q3ISnOPn9U8WbA9WXskpNejtxTIzwYtcFVhoopp1AJZDf6qFGlzcckbGHhHif0bOdBsAi1FlUUqyBoOJrJ+c0JeCgJGkUxYaZ9UlVlxASwWS/doT/XPtWOwpgOMO6z81Hg5vfHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwSAoO4Q; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e034607879so2818125ad.0;
        Wed, 27 Mar 2024 14:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711575891; x=1712180691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=atrhXG1ILWFYK9r1DZUW5SwYMljm9D2rf5G6A4Lfmno=;
        b=lwSAoO4Qw9iQTa91d7aup0xDD9YG85i0y7ZNo4VZEj7LemlYBIWsePfLqvBeOvOv7p
         lMIwYww1PeZu7jSVPUiD68blbO7d1UYmgppNskU8uQ4v4Wg5gIbktwhPwO4fBbkdr95l
         bYIEXz0IS6gYLpGjSrxJIA7pMno2R/iyTYC63CsjE7x38Nnr8XHXVJy/0Gocn7PlIVHO
         d1JYQN8QnbMWNeJcNAsm+fdLhPoU5r2S6YXasOtyn2V4oQPmGCkHWjV7V60rq27OzGDo
         dy4s/MD3Ia05zzsEGAt/B2inKnUw2HHyiZ8XzLjGR32+Yyr80cgsXM9ls91vfHLtO8c6
         NSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575891; x=1712180691;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atrhXG1ILWFYK9r1DZUW5SwYMljm9D2rf5G6A4Lfmno=;
        b=CKbacbf4cPuQ/aHrXVB/y0s7bgjZop9BTJ8an3Z4SV+r+KPpdtoJq7FRZmZHzZofr6
         Rrc3VBjJ4ITfxv3qpDbLTk5g5rHXgIoOaS35xUv8QHIbHH0UZyHXUZGEVJMmfDKSca4t
         KZVX7DLuTckdpc9+/bNkP8QTCJ30IpEwmlvBBgMY6Fni3Tz4XJtB5WcVQBrnzPvAE/5w
         nkY/G15WZ+YDYObi3dMwE9RwuIX+CdNhqvWOpRNtLw3R4FZR3Dn2Ym+W9fAc2tPsC5aI
         FQgj1wfe1zB9HfXMf77tD0M90vnhasq1Phcp5al3ghyn83ZvWQjDGRMAxdm65dhxnLYK
         qbkg==
X-Forwarded-Encrypted: i=1; AJvYcCWHnNw4wAsZ7vbDrZTKO5NcJT5wCFKzJzHd+H+wKbvjrT0L28nSszjE5y0qMOzwZBZ47iPghYgUkd/40DdynpY8LikIwbS3bYlCheNOkXKS2oE+ixcesE5+yyC+lY2/7I9VXY9I
X-Gm-Message-State: AOJu0YxDmmdyJ/FPwmGVcQXD9orVkuWX6xgA185LUMZvc9z0NyqKe+6b
	Bq0+M5afgk64DrLaTeee32aFBHbE4StR8dMXsi9ylIomp+P8RecF
X-Google-Smtp-Source: AGHT+IHVCcIj5X+/N6Un7o+ath8iuaV9b9jKaxJOj96p0wGSJNx42Xl1u7Zo0jgvkiQ8hCQzPKLpQA==
X-Received: by 2002:a17:903:32c9:b0:1e1:a74:5531 with SMTP id i9-20020a17090332c900b001e10a745531mr1201391plr.36.1711575891250;
        Wed, 27 Mar 2024 14:44:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b001e0af9928casm3909plb.55.2024.03.27.14.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 14:44:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e1cd8fc1-5aea-4242-8220-9152853f9baf@roeck-us.net>
Date: Wed, 27 Mar 2024 14:44:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/309] 5.15.153-rc2 review
Content-Language: en-US
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org,
 florian.fainelli@broadcom.com, pavel@denx.de,
 Vegard Nossum <vegard.nossum@oracle.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240325115928.1765766-1-sashal@kernel.org>
 <e114d9e5-26af-42be-9baa-72c3a6ec8fe5@oracle.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <e114d9e5-26af-42be-9baa-72c3a6ec8fe5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/27/24 01:39, Harshit Mogalapalli wrote:
> Hi Sasha,
> 
> On 25/03/24 17:29, Sasha Levin wrote:
>>
>> This is the start of the stable review cycle for the 5.15.153 release.
>> There are 309 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed Mar 27 11:59:27 AM UTC 2024.
>> Anything received after that time might be too late.
>>
> 
> We still see this: Same as what Daniel reported at [1]
> 
> drivers/cpufreq/brcmstb-avs-cpufreq.c: In function 'brcm_avs_cpufreq_get':
> drivers/cpufreq/brcmstb-avs-cpufreq.c:486:9: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
>    486 |         struct private_data *priv = policy->driver_data;
>        |         ^~~~~~
> cc1: all warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:289: drivers/cpufreq/brcmstb-avs-cpufreq.o] Error 1
> make[1]: *** [scripts/Makefile.build:552: drivers/cpufreq] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1907: drivers] Error 2
> 
> [1] https://lore.kernel.org/stable/20240327015023.GC7502@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/T/#m15bff0fe96986ef780e848b4fff362bf8ea03f08
> 
> 
> Looks like, 5.15.153 is released, so we need to work on fixing this.
> 

Same problem is seen in v5.10.214.

drivers/cpufreq/brcmstb-avs-cpufreq.c: In function 'brcm_avs_cpufreq_get':
drivers/cpufreq/brcmstb-avs-cpufreq.c:486:2: warning: ISO C90 forbids mixed declarations and code

Guenter


