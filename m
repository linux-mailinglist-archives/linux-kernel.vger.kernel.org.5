Return-Path: <linux-kernel+bounces-92582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07485872277
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12671F22F20
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2F51272A2;
	Tue,  5 Mar 2024 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Bknpb/tx"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009AC126F11;
	Tue,  5 Mar 2024 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651649; cv=none; b=V/UL2LMTWF/iqGpf2bEpuqtthQP3E20QlkWZAo45JQroLW26xkk56u08AHaMNQnH4zdWJpLqCqh0Id3CKSC+8OK0qFlNxP6oAHH0ZbYoN6BR17o3rj26vdzog5piBkLXldICxdLljwYodn1v5NOg6C+tAACEQEHfP6XrTcESzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651649; c=relaxed/simple;
	bh=9BcKeqQgSspXTd5pEOPZ0emw1R0TCGbT2Hk5UPqGfyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIy/+JfytuGkDmLoQnaiOHnUe+4mqBLfcFaad2rF/hgNSKAtQ1rzARliqVxZEwqwFbvDPu8ZCRP9LTN/+1IuLFEoko4xqD9zui6Zq7py3Z22kTjyEGKd9BH5ukTje0NoJmq8UmstG3DGryE9ykncmMueWCg428qLEZc3eGbuv9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Bknpb/tx; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4TpzRF2MjHz682F;
	Tue,  5 Mar 2024 16:06:17 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4TpzR46xgsz683V;
	Tue,  5 Mar 2024 16:06:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1709651177;
	bh=nAOcQQxfyLWQEVg8hHMxXxhTQYWM+Xvfq+95GhjZvz4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Bknpb/txNNHizrs/JKzE+iUe9fa6nvHCeop4lVEzvRtfRsbwSIgYqtHOBIXZGM17A
	 tVyXKtgPZr/Fp+duFOk6h4o7ScbzA3kuZxdawDunQJ4H4EQoMgLo2iSduHf5ZiODAg
	 e9qWHtWvXzpECAGwm+vql0ntyXUY8ImWIA9lpZyU=
Message-ID: <8d5780f5-1047-48d7-a9c9-09b95c7b5604@gaisler.com>
Date: Tue, 5 Mar 2024 16:06:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] sparc32: Do not select ZONE_DMA
Content-Language: en-US
To: sam@ravnborg.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 sparclinux@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-24 18:42, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> sparc32 has no limited DMA zone so there is no need to select ZONE_DMA.
> 
> Based on analysis from Marciej:
> "
>     Actually I think ZONE_DMA should go too (it's linked to GENERIC_ISA_DMA,
>     isn't it? -- cf. commit 5ac6da669e24 ("[PATCH] Set CONFIG_ZONE_DMA for
>     arches with GENERIC_ISA_DMA")), and the whole thing use:
> 
>     Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
>     The GENERIC_ISA_DMA option itself was added to arch/sparc/config.in with
>     2.5.31 as:
> 
>         define_bool CONFIG_GENERIC_ISA_DMA y
> 
>     despite of:
> 
>         define_bool CONFIG_ISA n
> "
> 
> The sparc32 code did not differ between ZONE_NORMAL and ZONE_DMA,
> which confirms the above. This patch drop ZONE_DMA.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Reported-by: "Maciej W. Rozycki" <macro@orcam.me.uk>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Maciej W. Rozycki <macro@orcam.me.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/sparc/Kconfig    | 1 -
>  arch/sparc/mm/srmmu.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 734f23daecca..bdbde506c01e 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -62,7 +62,6 @@ config SPARC32
>  	select HAVE_UID16
>  	select LOCK_MM_AND_FIND_VMA
>  	select OLD_SIGACTION
> -	select ZONE_DMA

This however makes a number of PCI drivers that depend on
ZONE_DMA unselectable.

>  
>  config SPARC64
>  	def_bool 64BIT
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index 852085ada368..7aae2f6f4973 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -975,7 +975,6 @@ void __init srmmu_paging_init(void)
>  	{
>  		unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
>  
> -		max_zone_pfn[ZONE_DMA] = max_low_pfn;
>  		max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
>  		max_zone_pfn[ZONE_HIGHMEM] = highend_pfn;
>  
> 
Thanks,
Andreas


