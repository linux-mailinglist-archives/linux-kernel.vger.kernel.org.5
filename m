Return-Path: <linux-kernel+bounces-30506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96A4831F94
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE2A1F29917
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A082E40F;
	Thu, 18 Jan 2024 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1NkR2QN"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED52E3FB;
	Thu, 18 Jan 2024 19:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605730; cv=none; b=IzTt5fLdm2YPQs5h8OJMFdbC+zRCxYFc1dmqCtZLpMPtMvfPDJrXbUwfLlAW4nBtUES5hUtsBd7Vje/9IMudESI7Ugl04XzgNj7hox4sbbrQlJDtJvhksgdBZks8ynMHrGrxeOapF9O0b0o2dVrS1KC3N4vdQstzXx0Nm+3NF5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605730; c=relaxed/simple;
	bh=SrRbwpTDfXLX2j/Mn2Wvk81ST3LhR6HY3Tnc+uJKbl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4juosE3gtxEKC6nE+HaXpxSSN1qbAwgN0erluDTkaJ0tWmCMtkM5+yoUjaKcV83kpQc5NgxMBNQw5/ORu9Qge6CxB3IZ+2l7qmqNRu+bS0Hk/LuA4uKO3BuD9UXUqNeQKVYn12/CSIRLy8Wx2wAs9ichrzdnPYEoQ8wOVItHbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1NkR2QN; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6daf9d5f111so70863b3a.0;
        Thu, 18 Jan 2024 11:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705605729; x=1706210529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eIZHdTR71za9DIyPMIvJQ62OJfFj0JIbKk8OksEAc1U=;
        b=d1NkR2QNeTK2mRk7w2NasNMdZqsYCLexD7KJ1nC5I9BYv6XEYsz0VjH/prZowQWNkS
         mgMEBU5f9CpOsASZKgw+7hMyJQpa7ARE1MW3V/cjChB9wY2croZaLABOZ9lssOZpW2Qz
         rbqW5kdJNMg1vqCUmA4fE5z9g/NqmX66+MztPw7s6w4sft7t02UpoU/QjtZa4K8EDiuD
         24q7BWVOBjyxx0M2cFfYhGnnhaAvTvI9FJGwWkGmmxehm+ZQNCa8FC19fT9whiakWbC1
         kf17+tN3IeDL155ebnfDNa9KWE6obLyCCYCJbaGl8WqXJjYYtIgWiPqpCU62qYG2O3md
         XV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705605729; x=1706210529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIZHdTR71za9DIyPMIvJQ62OJfFj0JIbKk8OksEAc1U=;
        b=DMEoShQs2Gw/NLgPZuvE1P+5nPfuI0UiHV3Do+XfLUIrJrMQO7cKCQxilx2LCAtJxb
         avXfbJCOXQ+aOEx78VQAzvvt2EnWgr52NDX3br01k1Isn2xEjY4woPeZu6A1tuq6do9t
         e90dX21TyCj4dWFzsfXidTxBAutjFggkhZoHAm0gIrYoIKxt1hi7RADdMgq17IALYEsd
         SAPhadM7drocJIi9BZ5mvOA68gHGwgZ2NlBl7y7QHZ1Gf4m/qX7VVHfZtD9RXx+ma5c8
         2Ed5tjrr2c4zGXO1ymOhweUGMoqeP9wKZN7y4DycTtpWvBYKtEpZ1YQzu5BP+LPSs2iD
         cDoQ==
X-Gm-Message-State: AOJu0YzXMqk2jkKjIoRho+xrQqjnx/kDvynBM+7ZNOkRPVXnOeDTjWdn
	24jyVTQis0ala9EUYMOH7aMSHe1BUfc+nlh5M2ztZGMmMovNV0Q9
X-Google-Smtp-Source: AGHT+IEIR0jISgGDTiNiveync7yB2yYqyPiTmLy8ZnhSieBLfY6BPqzjwTrK+ZaiFHELMp5FPh8s/w==
X-Received: by 2002:a05:6a00:2d25:b0:6d9:bf35:768f with SMTP id fa37-20020a056a002d2500b006d9bf35768fmr1492354pfb.46.1705605728757;
        Thu, 18 Jan 2024 11:22:08 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n24-20020aa78a58000000b006d95b565418sm3643211pfa.153.2024.01.18.11.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 11:22:08 -0800 (PST)
Message-ID: <ab9bef24-a07b-4930-b09a-b3c0f4e04789@gmail.com>
Date: Thu, 18 Jan 2024 11:22:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/150] 6.6.13-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240118104320.029537060@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240118104320.029537060@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/18/24 02:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.13 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Same as with 6.1:

ARM and ARM64 builds worked fine and passed tests, however BMIPS_GENERIC 
fails to build with:

arch/mips/kernel/smp.c: In function 'start_secondary':
arch/mips/kernel/smp.c:340:2: error: implicit declaration of function 
'rcutree_report_cpu_starting'; did you mean 'rcu_cpu_starting'? 
[-Werror=implicit-function-declaration]
   rcutree_report_cpu_starting(cpu);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   rcu_cpu_starting
cc1: all warnings being treated as errors
host-make[5]: *** [scripts/Makefile.build:250: arch/mips/kernel/smp.o] 
Error 1
host-make[4]: *** [scripts/Makefile.build:500: arch/mips/kernel] Error 2
host-make[3]: *** [scripts/Makefile.build:500: arch/mips] Error 2
host-make[3]: *** Waiting for unfinished jobs....

which is caused by 1fa03a4622bb26a31279a453aa251154f11e6c70 ("mips/smp: 
Call rcutree_report_cpu_starting() earlier").

It looks like rcutree_report_cpu_starting() has been introduced 
448e9f34d91d1a4799fdb06a93c2c24b34b6fd9d ("rcu: Standardize explicit 
CPU-hotplug calls") which is in v6.7.

For MIPS, it would like an adequate fix would be to 
's/rcutree_report_cpu_starting/rcu_cpu_starting/' for the 6.1 and 6.6 
branches.
-- 
Florian


