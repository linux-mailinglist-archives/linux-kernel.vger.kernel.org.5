Return-Path: <linux-kernel+bounces-30496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3128A831F7B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646661C232AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D412E631;
	Thu, 18 Jan 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqelJzJc"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD3B2E40B;
	Thu, 18 Jan 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605040; cv=none; b=YnsW1llbtz+c3h5orx632px94Dpm09blYLseXwrL+ZcL2mg7LlWXzBqMuTW50HAKEL4CGcZwQfaS7crjkVIjAJExuDr1NEb5/w1R9M4X5g9wBduV/vJmlGW0y5BIcl+FcQ82cn4hPoqasdOagiPe+E13YheabVLXGIOsqHflH0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605040; c=relaxed/simple;
	bh=QGy/gV3NdSFRk3x+356l/x+E2n1PrWJbsuTSzohNMVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wh1a3k2p3kDcQ4Pk8V1SkNNaOqyuhkx+INj0F6k4ZqwOtLPwCpucdwP8gko5n1iPlk/iG60wrKD3/EidcStlF1MKtLLSdWjk/YmkfR6YzFLm4hlY1HqZ7T70o96erPSI1J028Of2WjfZ5OlLkmMcLpT6FOjW1gQuzL1qdLroIHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqelJzJc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d70b0e521eso6198505ad.1;
        Thu, 18 Jan 2024 11:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705605038; x=1706209838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1v/TZYvh2MJ80QgyM922C9D8jEpr9cFLhd1cuq1fI6E=;
        b=mqelJzJc1bl3B1Bax3INUnxYfwhpd7xy2fIdI8nZga9r3lW2Tp4Xdekf/BrEZP/C79
         bCDKs1qVPWtaRsQUHi44i9wsnjauVQJblnbqYyCL/TZInsx6kYRiJiB1FQjPAGQkYvS7
         a/92ERBno4m4EpZqwm48UE9BQkdl90u8PLnYx3JYS93wNuWb6YJUrhHvGjWhzwu54tiQ
         EbpmYl9qzSuodkwruRMRRJaQ2t6zy1t5Ft2xb8pNx/RPwRwfh1/NfMBbYm7toXk1fNWJ
         KH/51nZRSZOC+/D5VX7HasUNaQKy3KPMKZu+aMPCQ1Ta+lLUPPXzQ/zYiQ2fMswHIwz0
         PCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705605038; x=1706209838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1v/TZYvh2MJ80QgyM922C9D8jEpr9cFLhd1cuq1fI6E=;
        b=oE9LxE1V53Oz6ZA8g/ZoF6a3LHmXQBdCR9+jml8kJr+kDY/AFDBOQO8cAUkku1GOLt
         +zJXMPTcw8fIq2iAnLYFsLiQTfg+4O7fRDfe/D2f8UNEWW/ooeR4Eaj1/h9tLxzqbtd6
         scTHb6EZHK4QL7W7kceetnYnYH0oq1Pt1Hh72ExsuJF+SOlHCANWAITe0KOeeEc+IlUz
         lseHjSRUsOIQmTuIS/qoPOmVEQ0Ey1MuW5LJAWU68hfm0FKedV7Ihq3vAWxIDwneylqk
         dFQxuOnV1fIDnHPcsloRGfcuHBi0YiW7ppWtz4zy0mvcaMM2APVvJnrlkt4QzaaJAdL+
         uleQ==
X-Gm-Message-State: AOJu0YzOHTqNs9aaDgLK50vGgbQ5Ir6PCzWw87ZcHct5tXAvV78wshUD
	jcqJAR8GCUFijtWD4EuoyFkhw7Qtr4StyGdxoOGIs6EJaNQyfT7/
X-Google-Smtp-Source: AGHT+IH4Ocz9kjSah+mw055Dw5Myw+oA+YfyxXg4b3gE3cy9rSFukaLV5FVQ5ejGALvuuCDYVFztVg==
X-Received: by 2002:a17:902:ebc5:b0:1d6:fc43:6005 with SMTP id p5-20020a170902ebc500b001d6fc436005mr1824509plg.133.1705605038093;
        Thu, 18 Jan 2024 11:10:38 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bi3-20020a170902bf0300b001d6fe15b563sm1704682plb.157.2024.01.18.11.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 11:10:37 -0800 (PST)
Message-ID: <96dc2b0b-ad51-42f9-a305-744d9d97272e@gmail.com>
Date: Thu, 18 Jan 2024 11:10:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/100] 6.1.74-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240118104310.892180084@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240118104310.892180084@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+Stefan,

On 1/18/24 02:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.74 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.74-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

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

which is caused by 7c20a4cc189eff36d5aeb586008a540d8024fbff ("mips/smp: 
Call rcutree_report_cpu_starting() earlier").

It looks like rcutree_report_cpu_starting() has been introduced 
448e9f34d91d1a4799fdb06a93c2c24b34b6fd9d ("rcu: Standardize explicit 
CPU-hotplug calls") which is in v6.7.

For MIPS, it would like an adequate fix would be to 
's/rcutree_report_cpu_starting/rcu_cpu_starting/' for the 6.1 and 6.6 
branches.

Stefan, do you agree?
-- 
Florian


