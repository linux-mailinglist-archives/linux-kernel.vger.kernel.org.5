Return-Path: <linux-kernel+bounces-97796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B51876F80
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D685C1C20C7D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 07:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1EA3714C;
	Sat,  9 Mar 2024 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Vlyx6WWa"
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1974E36B0A
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709968874; cv=none; b=Yfp9xcB3EyBgYfgAVDO4LVVNB4xiE06zyd3TMo3fJAIHf69aQzQPmjSjdio5NK33NML+1LnaBC8r3AyTkoYmHfpAdVgbLW/VenwyFNeRDc51bzUQzFCGt8+L5mYHE3KQhCIc4ZKy+/86NFwTjWR7PbtkzX+UflRYMz2YGkri6Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709968874; c=relaxed/simple;
	bh=iG1yhrg/0K2EdQmQT9vQlMQcac9QO2D1JEfhshqra/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sza3pNdi4px7jtCJu9Cxqa0OF2RadGAyWJnWWVpWRP1HfIvs/ZxgJuwOjgzeqx97Hm3xbOEv3GXUU4/LRT27/wJOORy6GmS4blQWIRjxTs8OviVYZFrOy3jw1vbNeNCu87c8yaS75P790igs2W+4k0TTHaYxCbFEQVrCTcMsmcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Vlyx6WWa; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id iqztrHamf72ktiqztruaWU; Sat, 09 Mar 2024 08:19:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1709968798;
	bh=NVjD+zur/H0cVOMWoHKFUUJ9EN9OmLsF2VzhA0+25JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Vlyx6WWaSUqIPnkqhOkEiWJ4SVmH2UWSG175lIZlHSR0grVIhA0Bce1ROP3jcYXIL
	 7Lmpvr6QD19uzpn6jRW2IDGZu3F7c2kXAGRyS1eKEafdAYf5U58S2oDxJoQZ9Sgtcd
	 4LtOjh5h/qzFVkbK7zxuqT5iW5K3vOYjulF2Z4p+DItcBYqHivVe/00nbLDc/rajsu
	 ZPdtnSKxOD1u0giEjFz7XaTs5DE9TUU32TdCEGoDjWtJZcsHFoj7HkAL3FkunU1BQK
	 AmwB4vV9m+X5Im+QJ38quZLQCRKjEy3FOoDRvARBwdMs/rhcL2W1AWAy58Wqq8RWcb
	 KWDl4tLJQMo2w==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 09 Mar 2024 08:19:58 +0100
X-ME-IP: 92.140.202.140
Message-ID: <63c898e4-fedf-44eb-8887-ffda4a81e1e6@wanadoo.fr>
Date: Sat, 9 Mar 2024 08:19:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] clk: fractional-divider: Move mask calculations
 out of lock
To: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>
References: <20240303121410.240761-1-andy.shevchenko@gmail.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240303121410.240761-1-andy.shevchenko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 03/03/2024 à 13:14, Andy Shevchenko a écrit :
> There is no need to calculate masks under the lock taken.
> Move them out of it.
> 
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>   drivers/clk/clk-fractional-divider.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
> index a0178182fc72..da057172cc90 100644
> --- a/drivers/clk/clk-fractional-divider.c
> +++ b/drivers/clk/clk-fractional-divider.c
> @@ -195,14 +195,14 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsigned long rate,
>   		n--;
>   	}
>   
> +	mmask = GENMASK(fd->mwidth - 1, 0) << fd->mshift;
> +	nmask = GENMASK(fd->nwidth - 1, 0) << fd->nshift;
> +

Hi,

if this is a hot path, you could maybe even compute:
    mask = ~(GENMASK(fd->mwidth - 1, 0) << fd->mshift |
             GENMASK(fd->nwidth - 1, 0) << fd->nshift)

unless gcc is smart enough to do it by itself.

>   	if (fd->lock)
>   		spin_lock_irqsave(fd->lock, flags);
>   	else
>   		__acquire(fd->lock);
>   
> -	mmask = GENMASK(fd->mwidth - 1, 0) << fd->mshift;
> -	nmask = GENMASK(fd->nwidth - 1, 0) << fd->nshift;
> -
>   	val = clk_fd_readl(fd);
>   	val &= ~(mmask | nmask);

    val &= mask;

>   	val |= (m << fd->mshift) | (n << fd->nshift);

and pre-compute "(m << fd->mshift) | (n << fd->nshift)" outside of the 
lock too.

CJ

