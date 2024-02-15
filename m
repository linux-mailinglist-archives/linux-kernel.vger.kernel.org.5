Return-Path: <linux-kernel+bounces-67366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6C0856A78
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C62E283CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D28F13699C;
	Thu, 15 Feb 2024 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IW5PasoG"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3040136665;
	Thu, 15 Feb 2024 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016640; cv=none; b=N3rVF/K8INA1Xw5DD+sEefTzddjk281mDlTyMdQQuH8LLcGils0Ne4pmY3RW3PaFtMycLeLNE1utgHKYG9SFZvkf5F6aIiKZMC+etUEDikUXM6CM25YHg/3p7w83SVp8zyZ8SorYzYbbnZP1u0JB3r2TSPUvUrtYjl9lVKXsTdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016640; c=relaxed/simple;
	bh=hBuKYR3fsfd1TuaiI1FSRZtv0QWTHDB/1CVqApapRsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBFCCKxR5GaDnD9eidos8Fsq8xLTbTwH4LYLJPEw8t+af/a7JxegPq7TpVfBpjNiZgBLngmW85b6XVRPStt55gRbuPGQjoKTnrqrzpi7BHIkwI3CX1kv6NuQJfpGn7kbTKpSUuzrZGFO174YzKU4PeqmK5lmlHMcAa6uNQLKuTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IW5PasoG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=cODzqQGi5RAHx4OAD/y3WUSbFWeGddT5cHq5NAhiPvw=; b=IW5PasoGyOZ1d0orOi9T12fNYM
	hIhSWaWimFVqW9PlOWDwmvlNWKHslt5LLL5cnF/R3lBjbJJneirAtnqKSQYn9wddyIFFAukzp26Wq
	E9DhPUmv7Pmv1iFFZr+22vmKJVbDkimTSfRv9QwDrQ7CuxM77sRWNkL1RzR79ArJI8FkicMqTVvSr
	sYooHKeC/wQSEUU37MNWMKoO8y5w+b6Bra7SLQnib5h5vJ6XZG1xvImMStYlpsyC9XvIcAK1QKxVS
	xxbdt24IlxcEWiMX7PAWuW7ZWUBRApnQINeRB9oVJ/DcjPG082919lWzDLUGVjuLQQPC9vlPhb1Sq
	UphfoIfQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raf9S-0000000H6WZ-1Bfh;
	Thu, 15 Feb 2024 17:03:58 +0000
Message-ID: <d8378775-5251-4724-a20d-b949ef42d23f@infradead.org>
Date: Thu, 15 Feb 2024 09:03:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hexagon: select GENERIC_IRQ_PROBE instead of redefining
 it
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240215140819.1910705-1-masahiroy@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240215140819.1910705-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/15/24 06:08, Masahiro Yamada wrote:
> Select GENERIC_IRQ_PROBE, as the other architectures do.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>


Thanks.

> ---
> 
>  arch/hexagon/Kconfig | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> index e922026fef09..a8dd2501f39f 100644
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@ -21,6 +21,7 @@ config HEXAGON
>  	select HAVE_PERF_EVENTS
>  	# GENERIC_ALLOCATOR is used by dma_alloc_coherent()
>  	select GENERIC_ALLOCATOR
> +	select GENERIC_IRQ_PROBE
>  	select GENERIC_IRQ_SHOW
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_TRACEHOOK
> @@ -60,9 +61,6 @@ config GENERIC_CSUM
>  #
>  # Use the generic interrupt handling code in kernel/irq/:
>  #
> -config GENERIC_IRQ_PROBE
> -	def_bool y
> -
>  config GENERIC_HWEIGHT
>  	def_bool y
>  

-- 
#Randy

