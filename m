Return-Path: <linux-kernel+bounces-76820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFE485FD15
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B11B1F22322
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3BB14F9DD;
	Thu, 22 Feb 2024 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRMW/RK6"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9600039FC7;
	Thu, 22 Feb 2024 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617153; cv=none; b=U+49Lk2DbDKxlLeIOIDw9f4hfJaZbRqhhSpMkSwX3BDaYI2UJCplhZKMtFxn02s9/T7XoKtER88fKBFKp4HoelbjLrMINBBB/3a59Nk4faMTwTy7Zy6ux3OlHUwLt2hBttFM8aEd3yy7soUZczRMRxHmF4629uwRTNYcOWyWe34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617153; c=relaxed/simple;
	bh=bn8uPy9NUwkuWcPrhW2ZxErj+dNvQN0TGKWWMtVsyDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5AqZpsrq9Fe5LOhzAaKMm8k252rzyr1dMvOVIPKzUe3UnuRcl2hoUUA0cHI11zoFl4dI+CPoe0HiV4sbUG35cuP7UZyHuGJROFNlfKIFLi1w0g8NJh8+SUHlXqVkmaI/4gTjrOYc5Buu9/vvCbWDSvQ7fMIfAlI/vV7o642mOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRMW/RK6; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso1528045a12.2;
        Thu, 22 Feb 2024 07:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708617151; x=1709221951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=acEUAKerH6u/Pty/kZT9MouuZZClvd2ChedKeZNi+0w=;
        b=DRMW/RK6Pp3pURyZuj8Zi7T/qSASqdUY9WSmem+R1y5V1RudJ8dJ4WeM6nO1qkcJcE
         giA6NgXMqaUbDNlGfjSlYVMK+v8Tm7DhwI2ilqMWeRH7HI8DahAFZynZEuaj6zMgnVFD
         Lkey2scvAtLTZnKV9uUJytUm4DEjgZxMmerkMLCjDU1M2toJCFAQrVRxJergEuhlDCx/
         rFYbQ6G5O13fPWf3IKqtC8UvR5OqaR/hu63d7bf90dVqhT9AFUiG0iIGyAumtD7zHhRL
         NKK0bunib+I0jcjbKpPKSH265YSfgcGwVwsUyevbjC64Ee0foWsw6P8K50P7XG8QwHxj
         vLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708617151; x=1709221951;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=acEUAKerH6u/Pty/kZT9MouuZZClvd2ChedKeZNi+0w=;
        b=jxEy9HwjhHDDKs3a8J1+217F5Csu0NgI2kea88roOv0ZNQmW2/a9vSQqamuE9yVkcr
         dVO0VxsKxaxTaUuj1BPWzMe4dOL4z7vkflvvf+FNUCD3+LkNzJ54u3XZuHl/zWdU85PR
         U3uGZS54jLb+Aya+8B9klFVWeVmstHqe1r4UevZdJwGQWSKhB4WzKylye8D5cKUQgJkU
         GnXDOlS89JBZJd4c4ADT6un5f70XGNzycy7XULvuIdCx8buMaRNPQz3yfC2Rpm6yRpWM
         1yBzcdFcud1LCVyHfam55W5MUBagTupn4jf2NnHvtRHpZCxtuMax45EJDP5JxeFU7sq8
         5fWA==
X-Forwarded-Encrypted: i=1; AJvYcCW5IcaL374ObuHQMLQdTWNcFMFZMz0SK6eUtmDkpEU1sdXTeCJrEgdo7hXiL6KOmzZZQveyj+XZ8m6+tHWrKdhVCSGCcMe+UqQY2mbFo2lNdrd2OjnqA5ecVirXS9t90dqefGS6iulAi4U=
X-Gm-Message-State: AOJu0Yxo1P8193xbLIIPZfQjhDusl6Ty/FbJ2kzJCWwJ/FstdA4CuDcN
	x3QwHjYm+rgrFrMOjloaQXZTV8nFz1jYfu+7QEMVEeYW9cJxflXN
X-Google-Smtp-Source: AGHT+IGCzlwXgu8YVaMZ+m+7Kvgs800J1GdzbPKXXvO1tqGjOGUMFAYuRt/VIQi6Pgo50/PbmFYg6w==
X-Received: by 2002:a17:90a:460e:b0:29a:4f72:28d with SMTP id w14-20020a17090a460e00b0029a4f72028dmr1522156pjg.33.1708617150759;
        Thu, 22 Feb 2024 07:52:30 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9-20020a17090ad3c900b002998dbcf570sm9648815pjw.8.2024.02.22.07.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:52:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fb2ac929-6650-444e-8f24-c9b1562d2bb3@roeck-us.net>
Date: Thu, 22 Feb 2024 07:52:26 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/test: add a test suite for GEM objects backed by
 shmem
Content-Language: en-US
To: Marco Pagani <marpagan@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Koenig <christian.koenig@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20231130171417.74162-1-marpagan@redhat.com>
 <a45b796d-5e04-4eac-b5ba-ea6bb3b6131b@roeck-us.net>
 <045bfb84-9833-442c-ac54-ed7a26451afa@redhat.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <045bfb84-9833-442c-ac54-ed7a26451afa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marco,

On 2/22/24 07:32, Marco Pagani wrote:
> 
> 
> On 2024-02-18 16:49, Guenter Roeck wrote:
>> Hi,
>>
>> On Thu, Nov 30, 2023 at 06:14:16PM +0100, Marco Pagani wrote:
>>> This patch introduces an initial KUnit test suite for GEM objects
>>> backed by shmem buffers.
>>>
>>> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
>>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>>
>> When running this in qemu, I get lots of warnings backtraces in the drm
>> core.
>>
>> WARNING: CPU: 0 PID: 1341 at drivers/gpu/drm/drm_gem_shmem_helper.c:327
>> WARNING: CPU: 0 PID: 1341 at drivers/gpu/drm/drm_gem_shmem_helper.c:173
>> WARNING: CPU: 0 PID: 1341 at drivers/gpu/drm/drm_gem_shmem_helper.c:385
>> WARNING: CPU: 0 PID: 1341 at drivers/gpu/drm/drm_gem_shmem_helper.c:211
>> WARNING: CPU: 0 PID: 1345 at kernel/dma/mapping.c:194
>> WARNING: CPU: 0 PID: 1347 at drivers/gpu/drm/drm_gem_shmem_helper.c:429
>> WARNING: CPU: 0 PID: 1349 at drivers/gpu/drm/drm_gem_shmem_helper.c:445
>>
>> It looks like dma_resv_assert_held() asserts each time it is executed.
>> The backtrace in kernel/dma/mapping.c is triggered by
>> 	if (WARN_ON_ONCE(!dev->dma_mask))
>> 		return 0;
>> in __dma_map_sg_attrs().
>>
>> Is this a possible problem in the test code, or can it be caused by
>> some limitations or bugs in the qemu emulation ? If so, do you have any
>> thoughts or ideas what those limitations / bugs might be ?
> 
> Hi Guenter,
> 
> Thanks for reporting this issue. As you correctly noted, the warnings appear to
> be caused by the dma_mask in the mock device being uninitialized. I'll send a
> patch to fix it soon.
> 

Thanks a lot for the update.

In this context, the TTM unit tests fail as well in qemu, with worse result:
It seems there is some bad cleanup after a failed test case, causing list
corruptions in the drm core and ultimately a crash. I don't know if this
is also caused by the missing dma_mask initialization.

Thanks,
Guenter


