Return-Path: <linux-kernel+bounces-107524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E88E587FDA9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F6828352E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9735A4C7;
	Tue, 19 Mar 2024 12:36:30 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CBD5474B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710851790; cv=none; b=ftjQeJeOCMkKk6nLWjqZiOw++AQGpPBx2aoMrt1oRNff3agK+47kKnN1Rx2G9nUiPmb3ISsVK0tiy54+p3p0oLY+IxX3Y2tHnXZWxZpVHC2moFS1G2ceznluPMfLw16RHGBt865qZvI5MC+/wUETq9+q+NnXfHXf76fcLm20Kvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710851790; c=relaxed/simple;
	bh=hf6IsCm4ZA2pa5JfzOk0nXMPDY1UVjN+vOmqMW3XA5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksrwcN4oFRsreqx2lUzwGSucJbIBzi4SumeaQ4fK3BhDJuGretcZRZDRRY86wvA1rS2XVqYtGStMMqt+7hwgj8ZQpj1z1244OWclJE7vMDEsA3Ou3rPnpQPEayAODEsV07m/YtvZH2I4m8ck42ANYc3vJthrlI5Bf1EF5Jyesjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4743CC0006;
	Tue, 19 Mar 2024 12:36:16 +0000 (UTC)
Message-ID: <112ac071-71cc-466e-ab13-f624edb77bb9@ghiti.fr>
Date: Tue, 19 Mar 2024 13:36:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Remove redundant CONFIG_64BIT from
 pgtable_l{4,5}_enabled
Content-Language: en-US
To: Dawei Li <dawei.li@shingroup.cn>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 set_pte_at@outlook.com
References: <20240312085005.298657-1-dawei.li@shingroup.cn>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240312085005.298657-1-dawei.li@shingroup.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Dawei,

On 12/03/2024 09:50, Dawei Li wrote:
> IS_ENABLED(CONFIG_64BIT) in assignment of pgtable_l{4,5}_enabled is
> redundant, remove it.
>
> While at it, annotate pgtable_l{4,5}_enabled with __ro_after_init.


I guess this comment ^ implies that you need to split this patch into 2 :)

Feel free to add on both:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


>
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>   arch/riscv/mm/init.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index fa34cf55037b..204cdf5b829d 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -50,8 +50,8 @@ u64 satp_mode __ro_after_init = SATP_MODE_32;
>   EXPORT_SYMBOL(satp_mode);
>   
>   #ifdef CONFIG_64BIT
> -bool pgtable_l4_enabled = IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL);
> -bool pgtable_l5_enabled = IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL);
> +bool pgtable_l4_enabled __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL);
> +bool pgtable_l5_enabled __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL);
>   EXPORT_SYMBOL(pgtable_l4_enabled);
>   EXPORT_SYMBOL(pgtable_l5_enabled);
>   #endif

