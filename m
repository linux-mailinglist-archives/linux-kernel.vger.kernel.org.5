Return-Path: <linux-kernel+bounces-67361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEFF856A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81771F249A7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8644C136987;
	Thu, 15 Feb 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p6myUNPD"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3297913248C;
	Thu, 15 Feb 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016588; cv=none; b=qvQtTEbJt6yWTGX6KYmwJUwFvUu7ysD5B8n1pBKGyndd+TN6kF9gYrIyjNuqDtZW7IiqHXBk0bFzk4s2F6TMBeFLXU/NXJxEAYli8topMFE9EaUpjfdS3LimkI30Ss3e+mkRz20rZ4gYcCzPnUHta9pNP8XZ5no1UMuaJ3C6cVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016588; c=relaxed/simple;
	bh=sBjIQr0LJN1UQmJuAshlDh6mfxOXLwZHlVBLUfWTVko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZszAHokXqaZ/3YgkF3JaGXMzfy07PMqQCGQypgnhcLN7qkd/ExjuFEcZ4n2Tcimyl3U7nojckPx2QHCLqjL4ni2RTS/ipIY0lpfKxXrUsYiAFE9ttbfP0/MBLDzWphSp7fscpdpdr9RYkAF5hdMTKWfjqvP7SlQ3dsa9T6QAGlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p6myUNPD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=u/mYX+MjRO3DI3EVu94sKRU6KZIW+DvzqhZHidC3ciA=; b=p6myUNPDNUYzlgNwueonruyCm5
	4SKo1EIbhCRzoeTGWkgSaBgvgkrkdAdWwG2/AfEiwMJNu6/cS6fGxDvmhXF3pGcigG2QvXL66W4XL
	gm3MYAy3QNwqqlc0jiuvCVDDGqNkyqFulx3c44UIeCWkbmwkeTWliz4033r1KEnpK3saUbdbqcXIY
	QapD93pOZASpPAsxUwTOwZ5s1m9XcvDIgZSAF3GdljlGWs+B88xiPcngHoRmbvErdhroqW+xfMF9q
	YAu9EKBF8s8C4jFNvGSuBdJzVAbENuxK2u6OG6O0FkYy5HUWBeiYOsQalJkZRDXcPfSche/WdsZEG
	oJXZb9Tw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raf8a-0000000H6WZ-06MM;
	Thu, 15 Feb 2024 17:03:04 +0000
Message-ID: <dd8ee0cd-4b00-4b94-b3c9-51c9574dd01c@infradead.org>
Date: Thu, 15 Feb 2024 09:03:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hexagon: select FRAME_POINTER instead of redefining it
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240215140702.1910276-1-masahiroy@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240215140702.1910276-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/15/24 06:07, Masahiro Yamada wrote:
> Because FRAME_POINTER is defined in lib/Kconfig.debug, the arch Kconfig
> should select it.
> 
> Add 'select FRAME_POINTER' to HEXAGON. ARCH_WANT_FRAME_POINTERS must
> also be selected to avoid the unmet dependency warning.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
>  arch/hexagon/Kconfig | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> index a880ee067d2e..e922026fef09 100644
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@ -7,7 +7,9 @@ config HEXAGON
>  	select ARCH_32BIT_OFF_T
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select ARCH_NO_PREEMPT
> +	select ARCH_WANT_FRAME_POINTERS
>  	select DMA_GLOBAL_POOL
> +	select FRAME_POINTER
>  	# Other pending projects/to-do items.
>  	# select HAVE_REGS_AND_STACK_ACCESS_API
>  	# select HAVE_HW_BREAKPOINT if PERF_EVENTS
> @@ -43,9 +45,6 @@ config HEXAGON_PHYS_OFFSET
>  	help
>  	  Platforms that don't load the kernel at zero set this.
>  
> -config FRAME_POINTER
> -	def_bool y
> -
>  config LOCKDEP_SUPPORT
>  	def_bool y
>  

-- 
#Randy

