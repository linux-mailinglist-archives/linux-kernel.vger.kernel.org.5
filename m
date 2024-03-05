Return-Path: <linux-kernel+bounces-93131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B52872B6C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FF4283C1F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CDB137775;
	Tue,  5 Mar 2024 23:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkKw9JSK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A37137901;
	Tue,  5 Mar 2024 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683133; cv=none; b=emqe8XFrbZF/3T/A1uy8mLtqz/TwhTfQLITHHVvWW0dwT695/DLXmySsL6VxjdS5ZQhBCY6vY6CkC1moMi6WWQiIQ668s5GpXBsUQ2D6TKXGnFpBzuwmj3qB3AidMS4k6xZZcVA3e6UndfJ26340S+OrrXtMDl48qdHF8AnGgxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683133; c=relaxed/simple;
	bh=4m3UYcXB+SiijSFEXT4aO9oLM2P/SBGwSBd5v733kis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJIva6oo+FXvjDx/S4vePsboMe6WB8IfPLexyxlFkHQ1U53Fn3eO9hkZgoCx4m3XVm0215f4cbHFn4it+XOs4IA4PYMw3bGeSpL2EXZynFWltuKqon552Gmr+ufoPXnoFeOfwYBmhhAYj1if+MURIdd+8ML/K6X6rMbepqIvTOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkKw9JSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D0CC433C7;
	Tue,  5 Mar 2024 23:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709683132;
	bh=4m3UYcXB+SiijSFEXT4aO9oLM2P/SBGwSBd5v733kis=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TkKw9JSKB5H6BhFodbbUblRTJv/WG01QKKMY8DWwWA1Zg661jA6QWfSi5DcgZ5CYY
	 gOqtfC6yzNgqsHKVFS/DrSaEzC0hg899TWegmtszDWoeUJvTw6YyMUOHEBsrQL05Bt
	 +od0e/wmluRxRknht3ZPQ3NMAFn87ba2oR8dROdgS8m0f1Ux9/Hrn1S8nNIUdI3wgr
	 XQwFyZcRswsjwAlnDXBBNtCfDgF1FI1i52RxFSzK98bey37mXJ9ahEH1eaupPZ0W+3
	 xXnyRvOfKgN9WCKWXT7LGcwY6QE4vlkmRba3HS5X36qjoyynC90RMonbnx0a8CuveJ
	 W2aqQZ3cTSvqA==
Message-ID: <311bdf17-c16f-41d8-8366-10f9b00adf27@kernel.org>
Date: Wed, 6 Mar 2024 08:58:49 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] riscv: Kconfig.socs: Allow SOC_CANAAN with MMU for
 K230
To: Conor Dooley <conor@kernel.org>, Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
 <tencent_0432DA968E39B81431F921F38D747C008208@qq.com>
 <ef8df22f-dac8-4652-bf17-d10254e6abfb@kernel.org>
 <tencent_E56A833916E00EC7B4840C34FAF1250ADE0A@qq.com>
 <20240305-fascism-enrich-06483ddeb149@spud>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240305-fascism-enrich-06483ddeb149@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/24 02:20, Conor Dooley wrote:
> On Tue, Mar 05, 2024 at 03:47:15PM +0800, Yangyu Chen wrote:
>> On 2024/3/5 07:46, Damien Le Moal wrote:
>>> On 3/5/24 06:05, Yangyu Chen wrote:
>>>> Since K230 was released, SOC_CANAAN is no longer only referred to the K210.
>>>> Remove it depends on !MMU will allow building dts for K230 and remove the
>>>> K210 string from the help message.
>>>>
>>>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>>> ---
>>>>   arch/riscv/Kconfig.socs | 5 ++---
>>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>>>> index 623de5f8a208..b4e9b7f75510 100644
>>>> --- a/arch/riscv/Kconfig.socs
>>>> +++ b/arch/riscv/Kconfig.socs
>>>> @@ -75,13 +75,12 @@ config ARCH_CANAAN
>>>>   	def_bool SOC_CANAAN
>>>>   config SOC_CANAAN
>>>> -	bool "Canaan Kendryte K210 SoC"
>>>> -	depends on !MMU
>>>
>>> This seems wrong to me. The k210 support does require no-mmu. So why remove
>>> this ?
>>
>> It just allows SOC_CANAAN to be selected when MMU=y. With this patch,
>> nommu_k210_defconfig still works.
> 
> I think the concern here is that this would allow people to build a
> kernel for the k120 with the MMU enabled, not that the existing nommu
> build will be affected.

Yes, this is my concern. Apologies for the lack of clarity.

> 
> Maybe you could squash in something like the following?
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index b4e9b7f75510..75d55059163f 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -72,15 +72,19 @@ config SOC_VIRT
>  	  This enables support for QEMU Virt Machine.
>  
>  config ARCH_CANAAN
> -	def_bool SOC_CANAAN
> +	bool "Canaan Kendryte SoCs"
> +	help
> +	  This enables support for Canaan Kendryte SoC platform hardware.
>  
>  config SOC_CANAAN
> -	bool "Canaan Kendryte SoC"
> +	bool "Canaan Kendryte K210 SoC"
> +	depends on !MMU
> +	depends on ARCH_CANAAN
>  	select CLINT_TIMER if RISCV_M_MODE
>  	select ARCH_HAS_RESET_CONTROLLER
>  	select PINCTRL
>  	select COMMON_CLK
>  	help
> -	  This enables support for Canaan Kendryte SoC platform hardware.
> +	  This enables support for Canaan Kendryte K210 SoC platform hardware.
>  
>  endmenu # "SoC selection"
> 
> (Which reminds me, I really need to go and finish sorting out the ARCH_
> stuff)

-- 
Damien Le Moal
Western Digital Research


