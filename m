Return-Path: <linux-kernel+bounces-67324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BC98569E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE354282648
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419DC13664F;
	Thu, 15 Feb 2024 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3cJHhxVO"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE45912FB27;
	Thu, 15 Feb 2024 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015678; cv=none; b=sNEsa1U/nUOCmHCa3HfyQ6Q3b1l8XbSkRdeTLoTSdeqXJLLrH0XX4r0SNBUbDhX7Nac82OVCA3tlMBWBaSjZvvvwJXYEpYWLvkTuoJM8iH6GGNMcVuiQRGUEa0wCeBJuZ/BeLDowf6jeJ8r++ojV9PjOmx9PZm0i8sQSv38O9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015678; c=relaxed/simple;
	bh=2MDqDK5KJeAWqgFYkfq2/cDfJ1KxqdbOo+HOTsTs77o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXEwqVk52aApkH6s7j1A8slWNWZm1pu0g2+YyrW9L3QmhM8PAYj1oklCZ0Y8RMC9PP1MhS3f1Q1Ul0qqbmdw2AJXBUc94bBI/2+Fc72XQZYchygXtc/lXLqEb72K0VLIL55y0jMBBBChzYjNEb3R8oJJBscOzOmQSOFzPHZYE0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3cJHhxVO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=OX+OpjYxr2oxFNk00FGu48FNpIfxVze5LlItzG4BCoU=; b=3cJHhxVOA7HyXI5qSs+tiq/vJD
	M/66r8QVshCxd+vOByXWCfOsdO0ny19+lsbsdxRD0LU3mdqwX4mK3wL/FG1XB11fYkIqg5gnREp+W
	i3pWn8I1gESui/NtopJMJiVBurWusUYfUWS7VbmXOef2yteZD50Ld/jC0h+Fnaf+c+j4dN1M8Dw1h
	UhHfQw53irjwv0T0c9DfZOAPswlQ7TPsckgebt6xfTAi2JCxWlDhoO0mxy0tsNbXv1kFDhdrDYX62
	BgMKJmw6L+5P21qDw9l+wFPmR7QwKDdV6URmovxpvjAsMqJTMkPKZ9RVGcKStafgAB2A/WPcOrFn/
	gJp0dNIw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raetv-0000000H2QW-0pd1;
	Thu, 15 Feb 2024 16:47:55 +0000
Message-ID: <737d2870-7a01-4f3f-9825-6583804607bb@infradead.org>
Date: Thu, 15 Feb 2024 08:47:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: select FRAME_POINTER instead of redefining it
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org
References: <20240215135749.1909812-1-masahiroy@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240215135749.1909812-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/15/24 05:57, Masahiro Yamada wrote:
> Because FRAME_POINTER is defined in lib/Kconfig.debug, the arch Kconfig
> should select it.
> 
> Add 'select FRAME_POINTER' to MCOUNT. ARCH_WANT_FRAME_POINTERS must
> also be selected to avoid the unmet dependency warning.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
>  arch/sparc/Kconfig.debug | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/sparc/Kconfig.debug b/arch/sparc/Kconfig.debug
> index 37e003665de6..d475a056a2e0 100644
> --- a/arch/sparc/Kconfig.debug
> +++ b/arch/sparc/Kconfig.debug
> @@ -8,11 +8,8 @@ config MCOUNT
>  	bool
>  	depends on SPARC64
>  	depends on FUNCTION_TRACER
> -	default y
> -
> -config FRAME_POINTER
> -	bool
> -	depends on MCOUNT
> +	select ARCH_WANT_FRAME_POINTERS
> +	select FRAME_POINTER
>  	default y
>  
>  config HAVE_HARDLOCKUP_DETECTOR_SPARC64

-- 
#Randy

