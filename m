Return-Path: <linux-kernel+bounces-162646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8978B5E88
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF87CB21CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E43B84A5F;
	Mon, 29 Apr 2024 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Atc7dCh5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF19784055
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406671; cv=none; b=ddMAibaSh0XNc+ufB/0fVRHHMEvsGhqP+rakWtq1V1uxIN4WVIzJPwNcaQZWPhz/iC4pGrmEkVmWzoXitDz6Z6IkJ4M2NaeWapkObWt6vdgAwds4bKFhYqprGt7xetOHN2EVK+JrOc/wakXPUZEqxFXZXS78yWv8+QaeMV0wCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406671; c=relaxed/simple;
	bh=3Akvy/b5izB4kqfT7MdpoXx2r9BpHcFSi1Qq/BkMavU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLmvZ9FCtKNHL0Eprrf/E2woGZSMVBXJQayUr7ZHd87/zrVSz2HKCdctMIOyW7d2SJFIeIHUmrWZ7ph7adpX9f0/ODN46he3tUPJQNCoMMvLF8WnPOnBjMztbvHuHz0N7m50ipQoBAWvfIbjH7Mtw0R7y0GE/0NeM4dFju9UR/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Atc7dCh5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E356C113CD;
	Mon, 29 Apr 2024 16:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714406671;
	bh=3Akvy/b5izB4kqfT7MdpoXx2r9BpHcFSi1Qq/BkMavU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Atc7dCh5i4jquNFaDv399jPsTzFhOBAo9UsCSsb3dYuEEzdtY86nrc/ppAkSiJWLe
	 EPoHUkjrICWTryo/MgjosA6U+TNqvC1bwNlsB74WVIAqapsIToIs7HK5nPR/HMUXCp
	 Lx8w9DTQQNojfzqWKkmSSSdqGi5zX7UXK6BoiqTY7VS6RaoWy2hmOIE6vMg2RfvUQr
	 /rDiBvCkDBY8yx9Rd2nVbVFUbkroTqX5E+HoNngXhGdAQ8NkQXaJ84f9zkeWc5NJEG
	 AUgpgcALl7rg6SfDafsdizv8T6S2QN4Qr8i81fNxqOmnWWTY7RHT8zupJliwvJ3TMw
	 ZPV88G+lMh8OA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E7BEBCE0B6B; Mon, 29 Apr 2024 09:04:30 -0700 (PDT)
Date: Mon, 29 Apr 2024 09:04:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Borislav Petkov <bp@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] clocksource: Make the int help prompt unit readable in
 ncurses
Message-ID: <ecde0c52-3a91-4762-b0c3-6455d3cedecd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240428102143.26764-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240428102143.26764-1-bp@kernel.org>

On Sun, Apr 28, 2024 at 12:21:43PM +0200, Borislav Petkov wrote:
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

So all the world is not yet a UTF-8?  ;-)

Acked-by: Paul E. McKenney <paulmck@kernel.org>

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
> -- 
> 2.43.0
> 

