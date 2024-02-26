Return-Path: <linux-kernel+bounces-81747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D636D8679AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9083F29D915
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AFB12A16F;
	Mon, 26 Feb 2024 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxbLvpIJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414B42AD16
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959448; cv=none; b=r+xOrQ8jD2u5g9/TkQiXsaUsJwiqaBrSBMjlDjKnZheRj/UBs1BC454ejTyNZxnakitR4LO0Pxj4U957kyf27IIW3o/Dro1Q6G8X4pNW+OT9wuCdRu+Btqy13uk/Q4LqRUr3oKO1PCUQ0L1jxZxQtZ8y5pzZlb8YdWtbwYSXHO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959448; c=relaxed/simple;
	bh=sPrQVnmnSPaSkztqFXjNFHxol/WrC9nhR5tw9QxJAlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SrpgD8cy1gwdwFNKjfuOb0mgizyRHICcTY7XbE4UIk1qVXEGLll3YhYiTXNyg5LxPP7y1W2leMJO+4hffuM7j0RCxDeELG97RZJ1e3dVK8RSDaFWPcUUcd5eB6WG6WwezI3t8G5++hQwvW4iuRDH8om2FAYuZuXfzMBeuTjWGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxbLvpIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8177AC433C7;
	Mon, 26 Feb 2024 14:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708959447;
	bh=sPrQVnmnSPaSkztqFXjNFHxol/WrC9nhR5tw9QxJAlg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PxbLvpIJEYlHpdr1A8xYVZRVEbIsK/+s101mjGkyPaiXKiPlcVWfV2SiMgC/jEhP+
	 pQ06pJ9ltxPT4xzdZVPbL5vPpsXFsMWNNY7WFaQchZgDkrqta2QfSXLaRZ+TMlXRsV
	 wcJseGzQbaBG4yMbJMQ8ctIV42ivMZcMBzyDTYsfYg4qytm99Bfyth0btOZvBHrzf5
	 NTsW19P3iTQp1Cu+X93N5fQ/whpRMnjv2RYLnoXDfR2z6Y/KXZPcq/x5K/NeMuSKKy
	 ro7+4jgNNjBpkEoEFsSxPksi74HqjL7p/YvTAkn7feRnNRHCW20UNUiGZCC5K0qFqz
	 wP7R/3P8DyLGQ==
Message-ID: <07675649-181a-4509-a595-d7ff9230e402@kernel.org>
Date: Mon, 26 Feb 2024 06:57:26 -0800
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
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240226140649.293254-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/02/26 6:06, Clément Léger wrote:
> Deprecation of NOMMU support for riscv was discussed during LPC 2023
> [1]. Reasons for this involves lack of users as well as maintenance
> efforts to support this mode. psABI FDPIC specification also never
> made it upstream and last public messages of this development seems to
> date back from 2020 [2]. Plan the deprecation to be done in 2 years from
> now. Mark the Kconfig option as deprecated by adding a new dummy option
> which explicitly displays the deprecation in case of CONFIG_MMU=n. This option
> is selected indirectly by CONFIG_RISCV_M_MODE since an option can not
> select another one directly with a "select" in case of such CONFIG=n.
> Additionally, display a pr_err() message at boot time in case of NOMMU
> build to warn about upcoming deprecation.
> 
> Link: https://lpc.events/event/17/contributions/1478/ [1]
> Link: https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/ZjYUJswknQ4/m/WYRRylTwAAAJ [2]
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> ---
>  arch/riscv/Kconfig        | 8 ++++++++
>  arch/riscv/kernel/setup.c | 4 ++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index bffbd869a068..8da58c102d3f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -221,6 +221,7 @@ config ARCH_MMAP_RND_COMPAT_BITS_MAX
>  # set if we run in machine mode, cleared if we run in supervisor mode
>  config RISCV_M_MODE
>  	bool
> +	select NOMMU
>  	default !MMU
>  
>  # set if we are running in S-mode and can use SBI calls
> @@ -236,6 +237,13 @@ config MMU
>  	  Select if you want MMU-based virtualised addressing space
>  	  support by paged memory management. If unsure, say 'Y'.
>  
> +config NOMMU
> +	depends on !MMU
> +	bool "NOMMU kernel (DEPRECATED)"
> +	help
> +	  NOMMU kernel is deprecated and is scheduled for removal by
> +	  the beginning of 2027.

2 years from now is 2026...

> +
>  config PAGE_OFFSET
>  	hex
>  	default 0xC0000000 if 32BIT && MMU
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 4f73c0ae44b2..8799816ef0a6 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -295,6 +295,10 @@ void __init setup_arch(char **cmdline_p)
>  	riscv_set_dma_cache_alignment();
>  
>  	riscv_user_isa_enable();
> +
> +#if !defined(CONFIG_MMU)

	if (!IS_ENABLED(CONFIG_MMU))

would be more elegant here...

> +	pr_err("RISC-V NOMMU support is deprecated and scheduled for removal by the beginning of 2027\n");

Why pr_err() ? pr_warn() seems more appropriate.

> +#endif
>  }
>  
>  bool arch_cpu_is_hotpluggable(int cpu)

-- 
Damien Le Moal
Western Digital Research


