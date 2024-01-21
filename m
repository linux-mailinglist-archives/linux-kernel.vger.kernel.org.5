Return-Path: <linux-kernel+bounces-32121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EB58356BF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F421C21666
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C911237715;
	Sun, 21 Jan 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J08DTqzd"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3AF22069;
	Sun, 21 Jan 2024 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705855988; cv=none; b=i14Ml8jnQmJ/XHBBaOidydV7ABHk1WCRCqHhqU2Kucal8qeDCyZ8sZ5t0vSpPOrc0b16V/omu5H6AxDwg+OR/kqA9Gh82HwchLuIa1H2QYVjnuYdTphEbR2ikAFmduYws8qwA0bQckB4+93Z1Dybqnk2gq53RefWq+jFOrkXAoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705855988; c=relaxed/simple;
	bh=kAbSDrFdrLAUsF2e5e18sP9A385biMhnkaVEQcxwnUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuGkQqPqaBMkuMgzDWpVoj53x55qIzLC6gtlD5w5zbTjUGqc+9ShIiAk+zy/hscluhhIR2Axs8zC2F86EvyC5OJzdLFtEM+XHS6lVTUVfVZOTMpjdECKskUK5Ou2quU9Lkj+QF9ogipmppkb4cOu9ihPfXjhQYX+X7g/FFZTBOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J08DTqzd; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-361a8bfa168so8963735ab.3;
        Sun, 21 Jan 2024 08:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705855985; x=1706460785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qJWbDDhASFxoa0nzAKvVG8hoM9XlDndgYsXpvEO704=;
        b=J08DTqzdjP5SXKz4hn/Cqdn4xWmNpcXWAKstUsF8vjW64KHIQBLipwNrGQJXGHX+BU
         b1oXH6S7eInkmkEpL2QQlSbSP5RyQ4NKKwVFSR4j/N2LPekWdgfy0OJgSPHA6tky3kkJ
         qJzu+BfIahNFkb2YZdKbDC+abJ6+vl09+lmOXubk0cNXMRMyc1Ra4wfTiAoKAoqx8r69
         jATqoji7EtE4zQ3Yb37KsgT0TJcRF7W69XsSfVg3wDogsZ+Ub3O1E+4g5QX6zt0vHmEX
         uLxLyaND9Vy+oB2W8ha2gyk2M05u2itM7rVxfRwhnPhstnir2N8WwhioO3Ap8KUhWTNP
         zSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705855985; x=1706460785;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qJWbDDhASFxoa0nzAKvVG8hoM9XlDndgYsXpvEO704=;
        b=ey95D38clHxolk/+nxQpLp9XEevke5Dgnxi4WRwc6xiqoDlMGDCfRl+hCF5awOSABs
         qPNhqePDnDivOt/XCFzuCHOe35+Mj6QPCXWZkE3QZPEMb87thlUI0kalHeP3oK3/meat
         CVc0R4TVJmkVoZzqvGKaxUq6tG3mO4UrI0jKTNTrVuAkfHY7pt4D+KL5pFMbvSQQA26A
         ZYdS/5j3cK5coeG0Bh0f5PFvSqwscwHeDgXg5o0fxwGbtuWdjEjG0wMIdxb72P6ql0wc
         KYRutxNsJmKP8KY1u0XGHryy6iV5uFQ6ROZLuL9PrxLa/X+1TYL+ZBaWt2C/dXO+ePa4
         D7WQ==
X-Gm-Message-State: AOJu0YxSrwEbeXmEP9/zfeJfINt3zsTrL1eIpwa829Rvtoli9ZuUGRfv
	SSAqR3BHj/B/3cd62P+97PVVM2UldJHStqHzXUQ74sSggYihl0S0
X-Google-Smtp-Source: AGHT+IER6KOx6Ju4rB6Nk9IsIWP0QuHXgtG4a0tkNEX6N/yK/ut9gL5bDMh43OnA3P99H1SFqqSYqg==
X-Received: by 2002:a92:c5ad:0:b0:361:a595:19a3 with SMTP id r13-20020a92c5ad000000b00361a59519a3mr4511646ilt.1.1705855983014;
        Sun, 21 Jan 2024 08:53:03 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:ba1:a148:4065:354f:1b27? ([2600:8802:b00:ba1:a148:4065:354f:1b27])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902eb0200b001d756c2f653sm214267plb.289.2024.01.21.08.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 08:53:02 -0800 (PST)
Message-ID: <b3ddf95a-7f4a-4f15-b701-c37cfe95a4cb@gmail.com>
Date: Sun, 21 Jan 2024 08:52:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mips/smp: Call rcu_cpu_starting() earlier
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Huacai Chen <chenhuacai@loongson.cn>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <2024011935-snowman-regain-b820@gregkh>
 <20240119163811.3884999-1-stefan.wiehler@nokia.com>
 <2024012047-prompter-driveway-c418@gregkh>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <2024012047-prompter-driveway-c418@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/19/2024 10:38 PM, Greg Kroah-Hartman wrote:
> On Fri, Jan 19, 2024 at 05:38:11PM +0100, Stefan Wiehler wrote:
>> rcu_cpu_starting() must be called before clockevents_register_device() to avoid
>> the following lockdep splat triggered by calling list_add() when
>> CONFIG_PROVE_RCU_LIST=y:
>>
>>    WARNING: suspicious RCU usage
>>    ...
>>    -----------------------------
>>    kernel/locking/lockdep.c:3680 RCU-list traversed in non-reader section!!
>>
>>    other info that might help us debug this:
>>
>>    RCU used illegally from offline CPU!
>>    rcu_scheduler_active = 1, debug_locks = 1
>>    no locks held by swapper/1/0.
>>    ...
>>    Call Trace:
>>    [<ffffffff8012a434>] show_stack+0x64/0x158
>>    [<ffffffff80a93d98>] dump_stack_lvl+0x90/0xc4
>>    [<ffffffff801c9e9c>] __lock_acquire+0x1404/0x2940
>>    [<ffffffff801cbf3c>] lock_acquire+0x14c/0x448
>>    [<ffffffff80aa4260>] _raw_spin_lock_irqsave+0x50/0x88
>>    [<ffffffff8021e0c8>] clockevents_register_device+0x60/0x1e8
>>    [<ffffffff80130ff0>] r4k_clockevent_init+0x220/0x3a0
>>    [<ffffffff801339d0>] start_secondary+0x50/0x3b8
>>
>> raw_smp_processor_id() is required in order to avoid calling into lockdep
>> before RCU has declared the CPU to be watched for readers.
>>
>> See also commit 29368e093921 ("x86/smpboot:  Move rcu_cpu_starting() earlier"),
>> commit de5d9dae150c ("s390/smp: move rcu_cpu_starting() earlier") and commit
>> 99f070b62322 ("powerpc/smp: Call rcu_cpu_starting() earlier").
>>
>> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
>> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
>> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>> ---
>>   arch/mips/kernel/smp.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> What is the git commit id of this change in Linus's tree?  What
> kernel(s) should this be applied to?

The upstream commit is 55702ec9603ebeffb15e6f7b113623fe1d8872f4 
("mips/smp: Call rcutree_report_cpu_starting() earlier") and this change 
from Stefan should be applied to both the 6.1 stable and 6.6 stable 
branches. Thanks!
-- 
Florian

