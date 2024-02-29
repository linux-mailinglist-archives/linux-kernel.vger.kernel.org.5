Return-Path: <linux-kernel+bounces-87320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED7486D2B0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069B81F21EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40796134437;
	Thu, 29 Feb 2024 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/ixMo8a"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA695134408;
	Thu, 29 Feb 2024 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233001; cv=none; b=Km1/BXEmaNKPsifgRnF9mNBCj7sCw2Mc+UMpd63oVNd/OA5YkKjgGk1FBD5lvLIVhgYKxJz8KfnxDc6mS+k4u3l+hxTUE29o2duwQUwcDjwlqHj5FwO/+J706Zq2pUf4tuTSAahXBzCAcVxu4Jv2nTgccG+aIIB7aO5YX/CiVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233001; c=relaxed/simple;
	bh=c7QUbsnLS3Hwv9ba8SiSypRTJNtt/BH0Vsl168gS9+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DH2WNxa5Od7nTF2izh0EXUA2hiIXLES1wXKOc7mGcrQ3Ex0KxwspSjR3P/mPluo3vgiJ4YOhwr/eiTsnfZ4638f9IAFTm4lRWJdyy+gqbIV7CdyH2TqzNd5fOcHyb6k3rvZW0XXNWSf2w7FFiGN6CPNyiTCs+YgQVkCJGKDQr28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/ixMo8a; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-365c96e2605so4083135ab.0;
        Thu, 29 Feb 2024 10:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709232999; x=1709837799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Fwlnga9jC0GlKMrPnUdJoZf4vfuXiyMJ0SZ1grnbPDQ=;
        b=F/ixMo8aj3HsnXJKWMiitDwJgQYVVYVGiArLf2wspgI6QtBDVpVQxTUvW5t80tzmJ4
         mSWkx9f4ec/Wa09q5zBlqAjTUbbSt52pozaea+YzSNz+LnP5/COOCeh9PU+YfcNEWKv5
         0WiVzQXmSftiUXxixwnk0EGbZuwL3YjUqw5kGta697tXqBjR547M3sqTr84LTB6D28t+
         6IHZ5dJruYWIt5EnWp3pINnwZ0qy31uEhOawaJvrIyB65DsRCvxenMny8ZBbdcBzq4xV
         7pwHphqFFms21tWE04qTONjBQqumpGatOSjMeCiJI0JwWcwdyBFzL6NuY1q5A+q8amv6
         eUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709232999; x=1709837799;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fwlnga9jC0GlKMrPnUdJoZf4vfuXiyMJ0SZ1grnbPDQ=;
        b=mOn/CN2KMQ1YKhbJBeTMi0Vzaq1/oP9EPyOo4x6zRr6QU6IDfo8EiVow03djx5dLnO
         WGdeeCZKttlKhd+HaB5feJ/NxfyziKBUihQMkUc/fO/HxMTZvahYRUJ50hmwBvqAU5dh
         1FTL9Ij9zpG6rRLDGeE81n8lfaA96Ipl+dziu+qsdHEkwPqyelFq/FnhWS0j0FkyrfpZ
         S/yyZRsdhB9sH6KM/VxwqJebicFQYi4m3XAvmrS+7BxA2WYDhjk/sg5/ozH2IvhJNggY
         9ArtfFevO49vt5kGT8kCqDPGMOAjSX2ivCjMfEIaUMO97gHz09l/SQGTdhqI1VcUxlip
         PQ2g==
X-Forwarded-Encrypted: i=1; AJvYcCXsrZpL5X5666Jw7dD6+C0q0E7KPAI8eKvoBNr+pvAMV6xA9bu2TXJCyT86+m1GKxXhHaGnBXrfNji2Squ2kSiVTaa19FZL9GMtWsmE
X-Gm-Message-State: AOJu0YzA93lIwjHnBHRPDhiSF+897ZiKQaXgn8XkoqUXSp1eTgfPWmBo
	h8U0FVelEi2/U2Tl7JKQ6QfN636LRlZkeAmhemYtGgzKcADGQzZ+
X-Google-Smtp-Source: AGHT+IH//tCQrtgz82xR0qYjO/7JW2L5OGK/8vxzl89g/XiCJlOf5eD4kYvIejKlG+3yFN95f1UPYw==
X-Received: by 2002:a92:dcc7:0:b0:365:1d6b:7c67 with SMTP id b7-20020a92dcc7000000b003651d6b7c67mr3404938ilr.12.1709232998912;
        Thu, 29 Feb 2024 10:56:38 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z13-20020a92d6cd000000b00365be3f841dsm460715ilp.22.2024.02.29.10.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 10:56:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b31553b6-8c4b-414d-918b-570cc4672c59@roeck-us.net>
Date: Thu, 29 Feb 2024 10:56:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/245] 5.15.150-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240227131615.098467438@linuxfoundation.org>
 <03a17f2d-ab8f-4241-8912-ebd903fb2c43@roeck-us.net>
 <2024022911-eatery-woven-f882@gregkh>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <2024022911-eatery-woven-f882@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/29/24 10:42, Greg Kroah-Hartman wrote:
> On Thu, Feb 29, 2024 at 10:15:49AM -0800, Guenter Roeck wrote:
>> On 2/27/24 05:23, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.15.150 release.
>>> There are 245 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
>>> Anything received after that time might be too late.
>>>
>>
>> $ git grep dma_fence_allocate_private_stub
>> drivers/dma-buf/dma-fence-unwrap.c:             return dma_fence_allocate_private_stub(timestamp);
>>                                                                                         ^^^^^^^^^
>> drivers/dma-buf/dma-fence-unwrap.c:             tmp = dma_fence_allocate_private_stub(ktime_get());
>>                                                                                        ^^^^^^^^^^^
>> drivers/dma-buf/dma-fence.c: * dma_fence_allocate_private_stub - return a private, signaled fence
>> drivers/dma-buf/dma-fence.c:struct dma_fence *dma_fence_allocate_private_stub(void)
>>                                                                                ^^^^
>> drivers/dma-buf/dma-fence.c:EXPORT_SYMBOL(dma_fence_allocate_private_stub);
>> drivers/gpu/drm/drm_syncobj.c:  struct dma_fence *fence = dma_fence_allocate_private_stub();
>> include/linux/dma-fence.h:struct dma_fence *dma_fence_allocate_private_stub(void);
>>                                                                              ^^^^
> 
> How is any of this building then?  Does no one actually use
> dma-fence-unwrap.c?
> 

It was found as part of the merge of v5.15.149 into ChromeOS. I did not check the
detailed circumstances and/or why ChromeOS stumbled over the problem. The merge introduces
other problems for us. We are busy tracking those down, so I don't have much time to look
into this further (not blaming v5.15.y, more likely it is the result of conflicts between
deviating code bases).

>> This was introduced with commit 4e82b9c11d3cd ("dma-buf: add dma_fence_timestamp helper") in
>> v5.15.149. The additional parameter to dma_fence_allocate_private_stub() was introduced in the
>> upstream kernel with commit f781f661e8c99 ("dma-buf: keep the signaling time of merged fences
>> v3") which is missing in v5.15.y.
> 
> f781f661e8c99 still uses an option to dma_fence_allocate_private_stub():
> -               return dma_fence_get_stub();
> +               return dma_fence_allocate_private_stub(timestamp);
> 
> So backporting that will continue the breakage, right?
> 
> confused,
> 

Most likely I missed some other commit when running "git blame". Never mind, though.
We'll deal with the problem internally. It was just a note to let people know
that there is some inconsistency in v5.15.y.

Thanks,
Guenter


