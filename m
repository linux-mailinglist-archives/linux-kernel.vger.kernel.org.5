Return-Path: <linux-kernel+bounces-136935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C98089DA16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED901F21C3A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505D112F383;
	Tue,  9 Apr 2024 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pJqQuZNF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/ndUaydY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED75E12F592;
	Tue,  9 Apr 2024 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668966; cv=none; b=AgBG+WTx5CqigB4VkQcwm06XCeLRCFS/6ofxppqFHll72kAL2Pzcpp4cJC8YNszgt4ArzL+y/k4HuxqAmJLne16emH5JZUkXrsVgu7GDhMcQAbtiXhKTdORNMm67mSqfk8VHMnsuHlXI7dUTPX7nS1wJUgLl1OYS/4M+aAalKNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668966; c=relaxed/simple;
	bh=n8lMrvoOAZr4zQFT/jywmQXSwhUzFGLvlnoZwlXr8Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYZnwan+rfTdGfltaBMVm9/YsEY6Iu6Ww/V3KqOI0S8aSP9IphtehEQccZT4v1Bq73uLivTG3FnhhFKgos36sMXL06z5BPxroApTxWPFeRoj8o5af5X0e90swSqxc5DZt5enpfTCT4UWznp6iAzdwFDUHjjTd3lc3UrDiBKF5r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pJqQuZNF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/ndUaydY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 9 Apr 2024 15:22:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712668962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2m0Auujs2P8xmXDlDR/Z+F4/NBU8yQjw72yULiEyoFg=;
	b=pJqQuZNFMXmg3nAL8VwURA0FNzNMzYzlodq1a8wDtMal/m4mI0sNLc7uujYISaXeTRYoL0
	XdIdONL+qE3cjpVMCrDn2HuNh0Ik0c7Dig9eYLt91XgYMvFD2V4AXwIJNMuiLoVDsims9x
	OC+MFADulGFst/qqw7jogSHsv6x0ycrgnr2x+Pnt3Q3wpdMzhv6k7QYueFA/eShxOVoBkT
	C6uZJHwuOav4vH+6lfoqNRpuvbe5cSTcvGh0K3LNGq8QAM+TvEhEui8jRr9vui0RrnatdV
	E2b3WnFiPakukYOvPTSa3QtKfJ2uwIcmdziYnEtTFeIJF9ByVBHK8PbPnQzU8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712668962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2m0Auujs2P8xmXDlDR/Z+F4/NBU8yQjw72yULiEyoFg=;
	b=/ndUaydYh8prkaW7KAhCQbQdM4GWF00KJgFSnOtVLCEMxbvHQjM32ljYlPEmPmCR3WvKYo
	w15ydUBdG7owi/Dg==
From: Nam Cao <namcao@linutronix.de>
To: topcat <bfonseca@ime.usp.br>
Cc: Marc Dietrich <marvin24@gmx.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, topcat <bfonseca@ipt.br>,
 ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed spelling mistake
Message-ID: <20240409152238.31820642@namcao>
In-Reply-To: <20240409114045.13872-1-bfonseca@ipt.br>
References: <20240409114045.13872-1-bfonseca@ipt.br>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 09/Apr/2024 topcat wrote:
> ---
>  drivers/staging/nvec/nvec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> index 282a664c9176..b4485b10beb8 100644
> --- a/drivers/staging/nvec/nvec.c
> +++ b/drivers/staging/nvec/nvec.c
> @@ -712,7 +712,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
>  	 * TODO: replace the udelay with a read back after each writel above
>  	 * in order to work around a hardware issue, see i2c-tegra.c
>  	 *
> -	 * Unfortunately, this change causes an intialisation issue with the
> +	 * Unfortunately, this change causes an initialisation issue with the
>  	 * touchpad, which needs to be fixed first.
>  	 */
>  	udelay(100);

A patch has already been sent to fix the exact same problem:
https://lore.kernel.org/linux-staging/20240331170548.81409-1-dorine.a.tipo@gmail.com/T/#u

Best regards,
Nam

