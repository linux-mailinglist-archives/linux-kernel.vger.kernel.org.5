Return-Path: <linux-kernel+bounces-81753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BDD8679C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B74629DAA0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A040F12F5BE;
	Mon, 26 Feb 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuhmgDku"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF3612F586
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959685; cv=none; b=EETGBDp+MW8iVSEiXwWlHh8V3A/axRawUlJb4icwzmh9AURTD5E+uLzBmRxKqKeBiRAKcM/+Nssdf55S3s+xcu+nylG28/ZjrOzV0aDgvUdpyccwLptJyVVD3kfvtVsNvlXXEgAqq24hkXdVCBSYYYCCbAwqNebD7gDMDOCz/JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959685; c=relaxed/simple;
	bh=PMR5Baugew8ZudeAt7adXe2sXDT+X7P1/vLWZeSRSj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rk6m+k2mLQlqXkQMxYDLMozUTZCmlbfMqXEuniTY9LZib/507ruvEPtgsngRiZnYWVlATW86cLFy4XqMN1B6y/NCY3zcOKEvCROeyTFj3DQElvplxSxxB27Wo7FLhCjQdZ0xDCVj99mWS3XXxXXHY94IAZNeuSimplbdYeBb8Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuhmgDku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB7AC433C7;
	Mon, 26 Feb 2024 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708959684;
	bh=PMR5Baugew8ZudeAt7adXe2sXDT+X7P1/vLWZeSRSj0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BuhmgDku9kaoBnzoc66cRL7wsx10AWfAgNlqyCjGlKGTBfBn4rrHryqrlSbOXi2Vx
	 Zai8l/4AYc9bXExiox+nV5iKy4JewRR8nt5pa3SpZthSK8mnslsYy+qnPvIJ6EuO0g
	 8flrRd6vr2nh/98VB4g1ddYh2HbHP3znVopIMa9M29JntY6JpG/EAbgjsfTM1eo9tC
	 568cpk6sg0I0MjzYYl26pTsaeA6CH8bJFgWpXqXTdaMV93X6l2W9N2by3WQHYnyFXX
	 VVsy/PEC5uWGuq88E+zw8QvGhGMz+eEYaqjaf+vMC3eTmutDfPEprbMKX5i4oEMxiL
	 WzcT4SSuKUnkw==
Message-ID: <595c5b83-79a8-4b68-bf34-32241c83544a@kernel.org>
Date: Mon, 26 Feb 2024 07:01:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: deprecate CONFIG_MMU=n
Content-Language: en-US
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Andrew Jones <ajones@ventanamicro.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Atish Patra <atishp@rivosinc.com>
References: <20240226140649.293254-1-cleger@rivosinc.com>
 <07675649-181a-4509-a595-d7ff9230e402@kernel.org>
 <90b440e9-65b1-4482-88d4-f06e76863aa6@rivosinc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <90b440e9-65b1-4482-88d4-f06e76863aa6@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/02/26 6:59, Clément Léger wrote:
> 
> 
> On 26/02/2024 15:57, Damien Le Moal wrote:
>> On 2024/02/26 6:06, Clément Léger wrote:
>>> Deprecation of NOMMU support for riscv was discussed during LPC 2023
>>> [1]. Reasons for this involves lack of users as well as maintenance
>>> efforts to support this mode. psABI FDPIC specification also never
>>> made it upstream and last public messages of this development seems to
>>> date back from 2020 [2]. Plan the deprecation to be done in 2 years from
>>> now. Mark the Kconfig option as deprecated by adding a new dummy option
>>> which explicitly displays the deprecation in case of CONFIG_MMU=n. This option
>>> is selected indirectly by CONFIG_RISCV_M_MODE since an option can not
>>> select another one directly with a "select" in case of such CONFIG=n.
>>> Additionally, display a pr_err() message at boot time in case of NOMMU
>>> build to warn about upcoming deprecation.
>>>
>>> Link: https://lpc.events/event/17/contributions/1478/ [1]
>>> Link: https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/ZjYUJswknQ4/m/WYRRylTwAAAJ [2]
>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>>
>>> ---
>>>  arch/riscv/Kconfig        | 8 ++++++++
>>>  arch/riscv/kernel/setup.c | 4 ++++
>>>  2 files changed, 12 insertions(+)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index bffbd869a068..8da58c102d3f 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -221,6 +221,7 @@ config ARCH_MMAP_RND_COMPAT_BITS_MAX
>>>  # set if we run in machine mode, cleared if we run in supervisor mode
>>>  config RISCV_M_MODE
>>>  	bool
>>> +	select NOMMU
>>>  	default !MMU
>>>  
>>>  # set if we are running in S-mode and can use SBI calls
>>> @@ -236,6 +237,13 @@ config MMU
>>>  	  Select if you want MMU-based virtualised addressing space
>>>  	  support by paged memory management. If unsure, say 'Y'.
>>>  
>>> +config NOMMU
>>> +	depends on !MMU
>>> +	bool "NOMMU kernel (DEPRECATED)"
>>> +	help
>>> +	  NOMMU kernel is deprecated and is scheduled for removal by
>>> +	  the beginning of 2027.
>>
>> 2 years from now is 2026...
> 
> Guess I'm a bit tired -_-'

Off-by-1 bug. It happens :)

> 
>>
>>> +
>>>  config PAGE_OFFSET
>>>  	hex
>>>  	default 0xC0000000 if 32BIT && MMU
>>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>>> index 4f73c0ae44b2..8799816ef0a6 100644
>>> --- a/arch/riscv/kernel/setup.c
>>> +++ b/arch/riscv/kernel/setup.c
>>> @@ -295,6 +295,10 @@ void __init setup_arch(char **cmdline_p)
>>>  	riscv_set_dma_cache_alignment();
>>>  
>>>  	riscv_user_isa_enable();
>>> +
>>> +#if !defined(CONFIG_MMU)
>>
>> 	if (!IS_ENABLED(CONFIG_MMU))
>>
>> would be more elegant here...
> 
> Sure.
> 
>>
>>> +	pr_err("RISC-V NOMMU support is deprecated and scheduled for removal by the beginning of 2027\n");
>>
>> Why pr_err() ? pr_warn() seems more appropriate.
> 
> Agreed.
> 
> Thanks,
> 
> Clément
> 
>>
>>> +#endif
>>>  }
>>>  
>>>  bool arch_cpu_is_hotpluggable(int cpu)
>>

-- 
Damien Le Moal
Western Digital Research


