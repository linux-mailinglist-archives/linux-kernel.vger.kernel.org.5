Return-Path: <linux-kernel+bounces-161470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 775CB8B4C6E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181211F21352
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF256FE06;
	Sun, 28 Apr 2024 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D8FbD4xf"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC3F3BBCA
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714318758; cv=none; b=d8Qwm/chx438+jMeBQ7a7OHTX2yC6iWAVMefEkSPcCRPFyh+gNdMzTRUlqOK8d6leQA8XToyV5D/wHikyHHdVw6wfrm6aiBLEd8KCO5Pj6yYNAy9BpYUMSkxVdTXVOIE12RxucPWAKgRTDdyEEUxKDSGMw6XqlFyPDgP+jFmJbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714318758; c=relaxed/simple;
	bh=oansF5MIgCFtn6hkXlADfUpOEDpEBLvdw3XwMNsorcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDvHkDLDPFzLEfUs9Ui1ynFtAp2KmdXVoK7E24C78DvoVEnD/uFgHuZwNQp1d0qpK1kPP9iFCNvg5lYMLpR26CJfpuCf7JgIt8CNgez4rA5/tjaCm9UYRk1zru1YVbi4Gty6fTtpt/AdKZVUiieMObnp2CTfQKpfxHjBHfNYSyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D8FbD4xf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=K70N6/R4ukNLVBkgfael6/yLfHOMQbEihyRPODmbhMI=; b=D8FbD4xf9u5zA95aGofW2iShhY
	czXO6IInF+iL3Q84Gz8c9X30SYHrcFDyxGiPqaSKkM/0kjWq9iuMFSMw/qGaWF07j7wa+YS3rxmsZ
	HSNE0uyGlpsrpFArzzM+5q30XN2hxEGKKOEIRBIoW3MVSQzXuUBLBcJdD9xpZ/oZI3lIfoefCVJIp
	R6Nmr/dQbBFSRMo1vo6G4BjRqZYJy5LLUhwsUbgg41/36t7BVqwh21wXHyD7Iefgg2MyDFKmlbpu4
	tlivMLzLVux1hNrwC3mW7xjYMxiQeSUMMjgWdbUbp07Ty9cCouH6Ofd0L3dm2YF7PvbUzj1zpJqWQ
	GJJH6pIQ==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s16cS-00000000CuZ-2Lkm;
	Sun, 28 Apr 2024 15:39:12 +0000
Message-ID: <e482db56-e63e-4165-89de-e460fb2b8d08@infradead.org>
Date: Sun, 28 Apr 2024 08:39:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: Make the int help prompt unit readable in
 ncurses
To: Borislav Petkov <bp@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Paul E . McKenney" <paulmck@kernel.org>, Waiman Long <longman@redhat.com>
References: <20240428102143.26764-1-bp@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240428102143.26764-1-bp@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/28/24 3:21 AM, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> When doing
> 
>   make menuconfig
> 
> and searching for the CLOCKSOURCE_WATCHDOG_MAX_SKEW_US config item, the
> help says:
> 
>   │ Symbol: CLOCKSOURCE_WATCHDOG_MAX_SKEW_US [=125]
>   │ Type  : integer
>   │ Range : [50 1000]
>   │ Defined at kernel/time/Kconfig:204
>   │   Prompt: Clocksource watchdog maximum allowable skew (in   s)
>   							     ^^^^^
> 
>   │   Depends on: GENERIC_CLOCKEVENTS [=y] && CLOCKSOURCE_WATCHDOG [=y]
> 
> because on some terminals, it cannot display the 'μ' char, unicode
> number 0x3bc.
> 
> So simply write it out so that there's no trouble.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Waiman Long <longman@redhat.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  kernel/time/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
> index fc3b1a06c981..8ebb6d5a106b 100644
> --- a/kernel/time/Kconfig
> +++ b/kernel/time/Kconfig
> @@ -202,7 +202,7 @@ config HIGH_RES_TIMERS
>  	  the size of the kernel image.
>  
>  config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
> -	int "Clocksource watchdog maximum allowable skew (in μs)"
> +	int "Clocksource watchdog maximum allowable skew (in microseconds)"
>  	depends on CLOCKSOURCE_WATCHDOG
>  	range 50 1000
>  	default 125

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

