Return-Path: <linux-kernel+bounces-89623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E2086F32A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 00:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B53B22E77
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 23:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2128053E3D;
	Sat,  2 Mar 2024 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="30yACwz0"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1EE1E86C;
	Sat,  2 Mar 2024 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709423470; cv=none; b=FwsfJo9w0Az6vhXshhmFPuv1REewwlu78wVzpApK+fl7yB4PMmLsBgoB6wcU3DX3dCZ/TlEZN1u8fKuKCTRMLY2t1jkW6DWeVoq3oRn8VTec/a6bLrMsrdWJ+qWljZCmPcsWjrr21/cWvCDZswMQaKnJek8SrIJpHXJ/CnbA4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709423470; c=relaxed/simple;
	bh=YVV/LRSOPQIuVZppKmH3vYEUPv5/W2F5X06MAiDMh9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mW8opr/daxs6/9IhQluSF8876Fxue+5dxVsSuefmoNohXVQkndSGDnbTEmVMR4N3dSmilJG3872Dnn13Al3p4MO3yld53XCUnFdDAjBRoaa2y/x8AW0DFlCXJNfKHGk39U1H1nrHHOUwnn6x9u67nh3/jGWxq89TZPOASijSpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=30yACwz0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=U23c8qDFSaCYYJiNvipaVhnVpZ+kBbhVnMi2Nw79GGA=; b=30yACwz0kDzq2/TRq9mXttFtsN
	fXDqUoVA2llP/FU4/Of31lMIDWNfDtGV6GdFaU9v8okCzSUEfcCne79tvQ5/TMDzYQPcyxKvnV4Xd
	EKmV9Cpc/RV1RWNe4ilgpWQtzuTft1MmHUxi15zb6RpggvPOMa7dQN4mo4qNMrKc49un6sOFzqlPG
	RHAJAjniJOjR6RRVm83Vt03VkzSEW7TcvKwRUXRfaO8t4RXjyrhgujAvxkxqeNaDWh0l4e8uYwRKQ
	I3qtmJhGftxQoRWOF/srXC4w7is8/AQiluUmuwFiWeNq7xf0AWKrcJKc9e80AeTRj8xeR0DBEPs1w
	zUjRpa5A==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgZ8B-00000004gN2-1GY1;
	Sat, 02 Mar 2024 23:51:03 +0000
Message-ID: <1ae706db-3684-4961-bfc2-6916d4b79bba@infradead.org>
Date: Sat, 2 Mar 2024 15:51:02 -0800
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
 sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/24 09:42, Sam Ravnborg via B4 Relay wrote:
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

Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

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

-- 
#Randy

