Return-Path: <linux-kernel+bounces-91422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0249B87114E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E936AB22B7C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDDE7D3EF;
	Mon,  4 Mar 2024 23:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIjIbBWf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD98F7D06E;
	Mon,  4 Mar 2024 23:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595993; cv=none; b=gH1Lz7TUfa3vq7RHMDCE04I7ZIiUSJuO67XEtoaGoI39VXriG8i/1NUf6XcbwlyumKWTzbdAjLGH6ENc5Y7uWmLiM2t+K7muu9+oB5jm51kGORR/jpif1RweLVueRyQsKau5maRseiyB1rR636wFrTdpR5Vziy6BrIxMvxYmKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595993; c=relaxed/simple;
	bh=7WNSrD/gX6pibCjhneUKu3M0LMXGqqIQ3WUVG/m73CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgPkx9uOdDO04Z9Z7XG+ykB5S3hwrmOHYklfQo9FNn9tdn5SpbTwofhvxsmdvN7BhsGZCJDUgEMyQ37NbybuXllupxqlkQvs0KB/Uz0eem2qJXpjpxkpcAJSrmgIu1zlKYrq9LWNq2A3yGTwgIUFaOxe5VreO0NtSF4UH0jRE1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIjIbBWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65789C433F1;
	Mon,  4 Mar 2024 23:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709595993;
	bh=7WNSrD/gX6pibCjhneUKu3M0LMXGqqIQ3WUVG/m73CI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nIjIbBWftHai18rNn9jTJowhR3eCHntl3VdVe+YCqfo+/Aw8Ogr3jceQj2XoJG6vn
	 OR35iMW+pnXfkgwM9cxbv2g1a0rEzNBpeCRdo4SPH/AXH+LcP1Y2ovA187cJ/Ul04C
	 jbkmWH/HKPwkqlzQpGOqxLGHTqF0rEH9FRbboVRrziiTdnCLVLPlR9c2cqj+2iSDZy
	 lZ8l2wyalfWn80EzB7dar6xRtYfPIdE5Z57oMwafPjzlV2ks1Q+oei4WZL5B35qp+o
	 UezBaw+B49MQ3T0kGoZgCOZPoJPdl9+r7bga9PIH+zFY6w0mzoIxsoJVtVNB24kyVm
	 OE3cVtk6QxuPg==
Message-ID: <ef8df22f-dac8-4652-bf17-d10254e6abfb@kernel.org>
Date: Tue, 5 Mar 2024 08:46:26 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] riscv: Kconfig.socs: Allow SOC_CANAAN with MMU for
 K230
Content-Language: en-US
To: Yangyu Chen <cyy@cyyself.name>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
 <tencent_0432DA968E39B81431F921F38D747C008208@qq.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <tencent_0432DA968E39B81431F921F38D747C008208@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/24 06:05, Yangyu Chen wrote:
> Since K230 was released, SOC_CANAAN is no longer only referred to the K210.
> Remove it depends on !MMU will allow building dts for K230 and remove the
> K210 string from the help message.
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/Kconfig.socs | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 623de5f8a208..b4e9b7f75510 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -75,13 +75,12 @@ config ARCH_CANAAN
>  	def_bool SOC_CANAAN
>  
>  config SOC_CANAAN
> -	bool "Canaan Kendryte K210 SoC"
> -	depends on !MMU

This seems wrong to me. The k210 support does require no-mmu. So why remove
this ? Does the k230 have MMU support ? If yes, then I do not think these 2 can
fall under the same SOC_CANAAN.

> +	bool "Canaan Kendryte SoC"
>  	select CLINT_TIMER if RISCV_M_MODE
>  	select ARCH_HAS_RESET_CONTROLLER
>  	select PINCTRL
>  	select COMMON_CLK
>  	help
> -	  This enables support for Canaan Kendryte K210 SoC platform hardware.
> +	  This enables support for Canaan Kendryte SoC platform hardware.
>  
>  endmenu # "SoC selection"

-- 
Damien Le Moal
Western Digital Research


