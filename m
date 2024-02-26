Return-Path: <linux-kernel+bounces-81749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3638679B1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76971F2EF60
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BEA12EBEA;
	Mon, 26 Feb 2024 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ej+wAHii"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD0C12EBE3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959550; cv=none; b=ncjMJDG3a0iyNh1F2yP7YgaY31tz6haO+s/LejU4x6iGhTa+xA9MB4AItI7qcA/pBU6XIqK7eXTKcxXFFEhlIvBQGSseVJ9jo8VbXeMHifxHQtlcMbu9Hyl0WMheiw/fnpLDIWuE6P4izYe8ikng4uquZjvrqSidYb814NZ4nYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959550; c=relaxed/simple;
	bh=e4U5vVyYaJg8LWO2Sq61iXxnq8tlNBlLLfEkvRIVKRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWN7RmtcBDKjxuOk87H7CZAp2bXcv0Y+zGXhEP0id6S+qYWe//Wu/oAz6MUfXnC/08JDYc3euq3vSW3bb/Ya+WV5kAlncI1f8H1LqRsam3W51k9sdY3HZzTCRRr2mwstP1+i21DLnk9W0S4yZOJLhxSxuCATkhi62ITfd45IJFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ej+wAHii; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412854b6d9cso3839775e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708959546; x=1709564346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jbzdHiROhM3KOwFQ++XGfcTi7Kt4ditHOvX4BfEo9zQ=;
        b=Ej+wAHiiVAJ5n/GDfgGS1L31qQuF3bf12CxjZIrIWrfgN04pgAxnG+RYsA0ftwSOlk
         J3Q+I76s/dDhK3dkvPKG+3WzU0zp/GxFchMEAHuhYjIqtppeLCbwP8AnznNvfoP2a7M6
         o4RfEs1JaP1ZiWhBFqoT3IIyUJ4d/1/YJNRL4TE3OJf6rfyTbcVU7MXv/6hYuamv8+k8
         FnDuswAxfF2QzNKJyeurMSbbQ4F5Nw/OKhzwZl4G90CxLyD+D8iMMJ3SiRCKX+C50EM5
         YknQaOpTNItmbUkl/f9+fu2MIrVajZuSKbwJzcquW1RXZiYz2zJMMkDMJKK45q8u40pD
         7EGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708959546; x=1709564346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbzdHiROhM3KOwFQ++XGfcTi7Kt4ditHOvX4BfEo9zQ=;
        b=u1dsJGCh9yOkUltLysfC3WuS9xvS9Dy7FbuDvB22xzSesSmPOdcVMVXmick4FeDCLp
         2/Z0iUlVxd0fJrHaGpzkqvenkgwsQt+JWyANFlly8zPU5zr5HvelW6dokNNVqbz5ZVzB
         f+U/Zcvf8dIgW7fwjo83npKvmms9K/QKBDYeusAucB1jvf33ihbSsiY+9XJCsP4rAKV7
         WWVIVtdqYnZU1ToPM72nPeilfYYL+ekCDJYytu0KrILnRQdlrXwPXl2kFb5w8SmDwCBP
         z68PnQusBAdcwMrVse6yDHhvLwP0CzpHsEnkzrq3wXTol2ZgGeC9K9+jPsCEWgma8ben
         Mhpw==
X-Forwarded-Encrypted: i=1; AJvYcCWPs01r3A0srz3j5fYGkYIgAed2eoHT8BDspD6nYv4H3wi7j5il2yHn91Vb5XDJI+z2xZLv2vlCqtq4DYDMR+anwuiTKWgmarElpc0h
X-Gm-Message-State: AOJu0Yygrn+Z58AreNjnw63clVSILQ7fkgVjpTP367+nnh7T/6y1PGWF
	4nBcSTWk/0o3G5/3A/N/SzDZmRDHlNo6WCrGEvRSwsj9XNmVGMCZprINMKQxXkaqiHssE9eyFKN
	l
X-Google-Smtp-Source: AGHT+IFAQUdjLR0gN1Ir02c0SaOnPg7uUNyhsMH8PQD/4SQJdQYSageDBv1veq6hfY3sd1X1CktvUg==
X-Received: by 2002:a05:600c:5125:b0:412:952d:3c6b with SMTP id o37-20020a05600c512500b00412952d3c6bmr5632433wms.2.1708959546547;
        Mon, 26 Feb 2024 06:59:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:83a3:2c00:c690:18b0? ([2a01:e0a:999:a3a0:83a3:2c00:c690:18b0])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b004128da16dddsm12030495wmm.15.2024.02.26.06.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 06:59:06 -0800 (PST)
Message-ID: <90b440e9-65b1-4482-88d4-f06e76863aa6@rivosinc.com>
Date: Mon, 26 Feb 2024 15:59:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: deprecate CONFIG_MMU=n
To: Damien Le Moal <dlemoal@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Andrew Jones <ajones@ventanamicro.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Atish Patra <atishp@rivosinc.com>
References: <20240226140649.293254-1-cleger@rivosinc.com>
 <07675649-181a-4509-a595-d7ff9230e402@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <07675649-181a-4509-a595-d7ff9230e402@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/02/2024 15:57, Damien Le Moal wrote:
> On 2024/02/26 6:06, Clément Léger wrote:
>> Deprecation of NOMMU support for riscv was discussed during LPC 2023
>> [1]. Reasons for this involves lack of users as well as maintenance
>> efforts to support this mode. psABI FDPIC specification also never
>> made it upstream and last public messages of this development seems to
>> date back from 2020 [2]. Plan the deprecation to be done in 2 years from
>> now. Mark the Kconfig option as deprecated by adding a new dummy option
>> which explicitly displays the deprecation in case of CONFIG_MMU=n. This option
>> is selected indirectly by CONFIG_RISCV_M_MODE since an option can not
>> select another one directly with a "select" in case of such CONFIG=n.
>> Additionally, display a pr_err() message at boot time in case of NOMMU
>> build to warn about upcoming deprecation.
>>
>> Link: https://lpc.events/event/17/contributions/1478/ [1]
>> Link: https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/ZjYUJswknQ4/m/WYRRylTwAAAJ [2]
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>
>> ---
>>  arch/riscv/Kconfig        | 8 ++++++++
>>  arch/riscv/kernel/setup.c | 4 ++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index bffbd869a068..8da58c102d3f 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -221,6 +221,7 @@ config ARCH_MMAP_RND_COMPAT_BITS_MAX
>>  # set if we run in machine mode, cleared if we run in supervisor mode
>>  config RISCV_M_MODE
>>  	bool
>> +	select NOMMU
>>  	default !MMU
>>  
>>  # set if we are running in S-mode and can use SBI calls
>> @@ -236,6 +237,13 @@ config MMU
>>  	  Select if you want MMU-based virtualised addressing space
>>  	  support by paged memory management. If unsure, say 'Y'.
>>  
>> +config NOMMU
>> +	depends on !MMU
>> +	bool "NOMMU kernel (DEPRECATED)"
>> +	help
>> +	  NOMMU kernel is deprecated and is scheduled for removal by
>> +	  the beginning of 2027.
> 
> 2 years from now is 2026...

Guess I'm a bit tired -_-'

> 
>> +
>>  config PAGE_OFFSET
>>  	hex
>>  	default 0xC0000000 if 32BIT && MMU
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index 4f73c0ae44b2..8799816ef0a6 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -295,6 +295,10 @@ void __init setup_arch(char **cmdline_p)
>>  	riscv_set_dma_cache_alignment();
>>  
>>  	riscv_user_isa_enable();
>> +
>> +#if !defined(CONFIG_MMU)
> 
> 	if (!IS_ENABLED(CONFIG_MMU))
> 
> would be more elegant here...

Sure.

> 
>> +	pr_err("RISC-V NOMMU support is deprecated and scheduled for removal by the beginning of 2027\n");
> 
> Why pr_err() ? pr_warn() seems more appropriate.

Agreed.

Thanks,

Clément

> 
>> +#endif
>>  }
>>  
>>  bool arch_cpu_is_hotpluggable(int cpu)
> 

