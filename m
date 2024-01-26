Return-Path: <linux-kernel+bounces-40477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A4683E128
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370D41F24E24
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A587E20B3B;
	Fri, 26 Jan 2024 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bptpQq0f"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04F20B14;
	Fri, 26 Jan 2024 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293048; cv=none; b=QVX2Uybo/BdCKra3Rml9mkeQnvG7oAPPv0zLl6bhW4ILVH8sHzWtIckFbwMbgzEfMOANs7qiK/hoFCVByVyvvA91h4cXcIqqQptl5cZqcpFGnO11pNFtVzY3kW9KzLbL9DOaSoJq4BSQfg6CkOBdb9FQngL1Iv8KbORIOMDuvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293048; c=relaxed/simple;
	bh=IXlVlaNvnXBA1lTe6eAGqGsFQ/bX/5i/NUFH22pPDvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMAbwx0pNvI7nJvFUQHtjGDq+aaWWQWdemTUI8gh2satwaTOsvLqxpuLNcFiL4xY+Kcu+BCODVwbAepDo4/zMwn33785HgAfkCeJbJIDAelN5bCkM6+y5I//3Mx+LioQwSOMb7RJ5Mr17t0ppl/7SqCFJFuPfSEn/692OanAg0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bptpQq0f; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d72f71f222so4548205ad.1;
        Fri, 26 Jan 2024 10:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706293046; x=1706897846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WRe2lsh8zPJ7sQq3UNpQIdPCe7bYnRimPWRA+NTbgRQ=;
        b=bptpQq0fPor91YlFWXfwqu9llUTTB2uJ7okP93OiVja2svFCEZYqIWz9unHpwONc75
         5nyJmIa+Wc0cCMpyxi9tm4TEGEB5YuwgzwEayE9VhSUSiGaUq39DjMy+Nu5s49K3gn5O
         fvlTMiVM7C3I6Glp4YemdaTxxQysmL7t9eklx6fFvJp0c7ePTXIdVGzcZOQ0pxPrxZqD
         0amr/d61//KEm451/K0r11agkJq9PITEqr6z7vOCBNkQBjAYvnw/lTq8TsmnFY46aqR5
         zfprFMW8dnWASpDwtajYBTYqZfRBv/ZI40LrK4SYMqUgDwI+xwyFvF6mDfgH4EPLU29Z
         OXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706293046; x=1706897846;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRe2lsh8zPJ7sQq3UNpQIdPCe7bYnRimPWRA+NTbgRQ=;
        b=jIBk5+MPU8yoBiT4XM0zcQLYU0RQa0DIiru0ofhMT8hWZmKQD8nMzUMnY/x5Hv9YdZ
         kBytSAajigQcRqxc3keAvMD2sH0K8jxP9HUYLp7FYz6n9il+1FOfCYtVG4G9cRhCZE37
         JPC7ZqPT8u+YR4872+Wp1UEodJPYyiQX4J1eQPcIZ7wR0THgQhr6NBEiquMas5tTY08Z
         pxH5SWDMlKjGcJQ/g7HEsALVsQaUrKCgDswTk/F76LdwmIclQ9A/ZggmDTCeNmUBP45g
         t4albbQ3FkOsove2p7jmTI+BWtyD4S0xhCYAzD3PBfnnW9IsaLVus56bB0ld5CClgqGv
         nKvQ==
X-Gm-Message-State: AOJu0YzBd2fgHz1V0JT9N3R0nsOM8BE+qiYxChUpH7LpxNSePdc+LUXJ
	V24bBLGhy+CHCZ0gK02n2CI5eeGVW6tJa+PELbsVHFdcGUMnuMF3
X-Google-Smtp-Source: AGHT+IGsgBtGuXdUkdSdR5m02KeN5BuhBNZbFHWIb+sl9phksFawh0/jTPbXfOxc2GYwirCzg2cxGA==
X-Received: by 2002:a17:902:b787:b0:1d4:ea27:6f5b with SMTP id e7-20020a170902b78700b001d4ea276f5bmr154654pls.109.1706293046362;
        Fri, 26 Jan 2024 10:17:26 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mo14-20020a1709030a8e00b001d70c0f2f04sm1220746plb.217.2024.01.26.10.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 10:17:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2f342268-8517-4c06-8785-96a588d20c63@roeck-us.net>
Date: Fri, 26 Jan 2024 10:17:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/286] 5.10.209-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240122235732.009174833@linuxfoundation.org>
 <6b563537-b62f-428e-96d1-2a228da99077@roeck-us.net>
 <2024012636-clubbed-radial-1997@gregkh>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <2024012636-clubbed-radial-1997@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/26/24 09:51, Greg Kroah-Hartman wrote:
> On Fri, Jan 26, 2024 at 08:46:42AM -0800, Guenter Roeck wrote:
>> On 1/22/24 15:55, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.10.209 release.
>>> There are 286 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
>>> Anything received after that time might be too late.
>>>
>> [ ... ]
>>
>>> zhenwei pi <pizhenwei@bytedance.com>
>>>       virtio-crypto: implement RSA algorithm
>>>
>>
>> Curious: Why was this (and its subsequent fixes) backported to v5.10.y ?
>> It is quite beyond a bug fix. Also, unless I am really missing something,
>> the series (or at least this patch) was not applied to v5.15.y, so we now
>> have functionality in v5.10.y which is not in v5.15.y.
> 
> See the commit text, it was a dependency of a later fix and documented
> as such.
> 
> Having it in 5.10 and not 5.15 is a bit odd, I agree, so patches are
> gladly accepted :)
> 

We reverted the entire series from the merge because it results in a build
failure for us.

In file included from /home/groeck/src/linux-chromeos/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:10:
In file included from /home/groeck/src/linux-chromeos/include/linux/mpi.h:21:
In file included from /home/groeck/src/linux-chromeos/include/linux/scatterlist.h:5:
In file included from /home/groeck/src/linux-chromeos/include/linux/string.h:293:
/home/groeck/src/linux-chromeos/include/linux/fortify-string.h:512:4: error: call to __read_overflow2_field declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
                         __read_overflow2_field(q_size_field, size);

I also see that upstream (starting with 6.1) when trying to build it with clang,
so I guess it is one of those bug-for-bug compatibility things. I really have
no idea what causes it, or why we don't see the problem when building
chromeos-6.1 or chromeos-6.6, but (so far) only with chromeos-5.10 after
merging 5.10.209 into it. Making things worse, the problem isn't _always_
seen. Sometimes I can compile the file in 6.1.y without error, sometimes not.
I have no idea what triggers the problem. Of course, on top of all that,
the error message is completely useless.

Either case, we don't use that code in chromeos-5.10, so reverting the
entire series from the merge was the easiest way to proceed. But we really
don't have an incentive to apply the series to v5.15.y because we don't
need/use it there, and we might end up having to revert it from there
as well if it is applied.

Guenter


