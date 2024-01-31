Return-Path: <linux-kernel+bounces-45839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B16F8436E8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171111F2A484
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F403E48E;
	Wed, 31 Jan 2024 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqdPm6+X"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22F36B08;
	Wed, 31 Jan 2024 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706683075; cv=none; b=ja+z6oyPFnB95k/4ujrzklE6SnOMGDYJoxBVrSHi18GDi+P1bNT0hDATpZqGDFpCNcpV1ukTBqPw6F7KQGY4Ko667O9fxfm/J4RNff/8KB9PE83hAlTN+Xv2SFd8WBayioXgZV228yUPCdmN5gmXwzMfpSeTBzjYRsFqexWXSl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706683075; c=relaxed/simple;
	bh=XiWCT2+1WeTGJCqJCMdukZXFIkkpn03DWfgeCLshmL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tArlOoZDk6XhkqWKPol4GqJCIzg31GmCuocFtVavdfZDhLqYR4BDjq51EkQ7a7Bnwn9oROiruc0H1JcnUEEi2JbvRN9wNer1Fa0UqTKU9grghproV+d1qKcEUt/YyNZXS+Mc2E3xIEnAPXVNQJ5/BR1lldTTT2W2D49GCaQN3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqdPm6+X; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ddfb0dac4dso3430169b3a.1;
        Tue, 30 Jan 2024 22:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706683073; x=1707287873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GM6uBHoDxgNzauu5ZyOmhvBDZClfH0t/dJxtRq9cGjA=;
        b=mqdPm6+XwdQZhQ9eH8FAsMmNUV9gUF30co4H5Vz6TNbWtBGzgrE/zuClMjwUildF/Q
         9BWXO/Mdi1mamu+K4ojntqAkk77sWRS0faDILBgc82Nosxxsqqt/XBG+caZHHkfSEIO+
         I43ODkOmmuXzRIkJ1uRcOvwp2QYojNrk7tShkgR6hmxo34yoxT1997ZQKYHcJsV8L0NZ
         T47KF9PYQcA+yASa361f1MllrKT9TeH456lxEeydsKYh4v3Nv4oSSpoKtwzUet6mEG9a
         8ILl5wHEM4gQRakFoqJIZQfUP8RrZUYTSMjVzVY6pBjpTKD3U0decH8OYzgJKRw8Rctg
         ECRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706683073; x=1707287873;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GM6uBHoDxgNzauu5ZyOmhvBDZClfH0t/dJxtRq9cGjA=;
        b=ieI6bealrdJ1YTWVk/K+FBkg2XHyNPFuWCJOWQLokbFUrJBsmqmQ2BGBa2YbEK20Dj
         QxchKN0TEJdSrhOfeEw+aC9cnF39NrTrMmJ0RBZUMTrkoWqx6ePE022jHX6ayp4YsTRO
         1YQCUwk9HGxfFB14KA9ceBPPaT4o4Viw41BSV+gWdG88T5uEr/PbybKH4d5JGJKJ1GIn
         0ULz09kpXcqBoZkPKliOoMAuSRk1h44xFHKorgzxLpYPJju5T4f+WMX8uXu8VTAHOYBJ
         3VANCZz4cHwduhU9LVSapnfc8k7G1WHmeriNBF1sLqhKN/p2RALiGSWgsb7lzodsSk+U
         T4Aw==
X-Gm-Message-State: AOJu0YyIBHgq6hZq2NUYPlezR2owSoHgeuyJKCAzfA3ZREacbhH3zm29
	wsd7XijJvFVbecLSDCvzW1I/69Pyrch0LQtlcQW2JJ0b86++mBWl
X-Google-Smtp-Source: AGHT+IFYAV4FbkdICGK42XD7z6/Nx7sBof37ReT0CHiBwriOc4zXorQDefP/ncF9JAo34wVfeJGKmw==
X-Received: by 2002:aa7:8298:0:b0:6db:cdfd:af6 with SMTP id s24-20020aa78298000000b006dbcdfd0af6mr836437pfm.31.1706683072624;
        Tue, 30 Jan 2024 22:37:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q21-20020a62ae15000000b006d97f80c4absm9021585pff.41.2024.01.30.22.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 22:37:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a908d04b-8068-4831-87ef-44175250c226@roeck-us.net>
Date: Tue, 30 Jan 2024 22:37:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: qcom: Start the watchdog in probe
Content-Language: en-US
To: Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, linux-arm-msm@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mukesh Ojha <quic_mojha@quicinc.com>
References: <20240131-qcom-wdt-start-probe-v1-1-bee0a86e2bba@quicinc.com>
 <1a996038-bcc7-4c0f-8f27-ca36a2eb9d3d@roeck-us.net>
 <cfaaed23-8f59-4447-af0b-b94b35ce68ba@quicinc.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <cfaaed23-8f59-4447-af0b-b94b35ce68ba@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/24 22:16, Pavan Kondeti wrote:
> On Tue, Jan 30, 2024 at 10:01:15PM -0800, Guenter Roeck wrote:
>> On 1/30/24 20:15, Pavankumar Kondeti wrote:
>>> When CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is enabled, kernel can pet the
>>> watchdog until user space takes over. Make use of this feature and
>>> start the watchdog in probe.
>>>
>>> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
>>> ---
>>>    drivers/watchdog/qcom-wdt.c | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
>>> index 9e790f0c2096..4fb5dbf5faee 100644
>>> --- a/drivers/watchdog/qcom-wdt.c
>>> +++ b/drivers/watchdog/qcom-wdt.c
>>> @@ -276,12 +276,16 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>>>    	watchdog_init_timeout(&wdt->wdd, 0, dev);
>>>    	/*
>>> +	 * Kernel can pet the watchdog until user space takes over.
>>> +	 * Start the watchdog here to make use of this feature.
>>> +	
>>
>> No, that is not what CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is about.
>> Please see its description.
>>
>> NACK.
>>
> Thanks for taking a look Guenter. I thought of using
> WATCHDOG_HANDLE_BOOT_ENABLED and infiniite open timeout as a hint to start
> the watchdog in probe. After seeing your NACK for this patch, I guess
> that would also would have been rejected.
> 
WATCHDOG_HANDLE_BOOT_ENABLED is not supposed to be used in drivers.
It is a flag for the watchdog core. Before you bring it up, stm32_iwdg.c
is a corner case because (presumably) the driver can not determine
if the watchdog is running.

> Do you think we can revive this [1] to add support for watchdog pet from
> the kernel? It would be helpful in cases where the user space has no
> support for watchdog pet (say minimal ramdisk).
> 

If done properly, sure. Looking at the exchange, the patch still had issues
which I don't think were ever resolved.

Personally I would not want to rely on this, though. It won't address situations
where userspace hangs but low level kernel interrupts still work. I think
it is mostly useful to cover the time from loading the watchdog driver
to starting the watchdog daemon, but even that would better be solved by
starting the watchdog in the ROM monitor or BIOS. A minimal watchdog daemon
would not consume that much memory, so I don't think "user space has no
support for watchdog pet (say minimal ramdisk)" would ever be a real problem.
Such a minimal system would probably (hopefully) be based on busybox which
does support a watchdog.

Guenter


