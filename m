Return-Path: <linux-kernel+bounces-58502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA6E84E739
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25C8283F55
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565CD84FA4;
	Thu,  8 Feb 2024 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="bt6l/+E5"
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22217EF01
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415125; cv=none; b=uIs12Bk3qHghSq6hskkjDexZgpy3NmWVnN6FlxxzjZQBhhX1uarSdN1PuFg1+J7edNCiCqUjdGwEVz1HnrIql5UW4Unr8ecjiKhEXyL1Hu+yEQ/di0B65Ff1sM5e4Q5TkJ2o2+vKYLWad61K1wqmjkEUBDQU8YTp1FmOJ8oriMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415125; c=relaxed/simple;
	bh=tQmlYHUhEty4mHV4CMckgvDZZYA665Avgi2W87VZ5/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3IiFTf5JxaSiAOp7crJJSvaBkC0AyL9y7oEc0Gz/usgtGcVOISqCfW5Fj5k8TXAPaBNtu62qWUmJpcHjqN+kMpWXtmOxRS92L15hStc4ptbtxICpQo89ozZhKoSEuHg0UR7mm08tNhua5yq85/QpHQdgPoLb0GKT+rByV1aAXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=bt6l/+E5; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id Y8eLrzbSOF1QfY8fXrnOuI; Thu, 08 Feb 2024 18:58:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1707415122;
	bh=c8xcuO0OsJENL1xB6fz0nq1SolddnbYqgdO4mg6NbnM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bt6l/+E5K1gbryuBcoKxEB73waSVLWOSoUtrezPgseIBh2SG9FD1BCgovYne690r7
	 ZjcJsKr+S4XHmMeGVzBIrnnmc0WD/5B31vIc3x19SZYqqM2UcJ50moetFoIwRuwIKX
	 ppdSSKGbzLRCAgTCO5QINXmfZjHj1ML0DVLxjHzQPf+j3h1tBX5gSX3uoqwjc8t9Ik
	 zT8PASzP95n3ypYTHZaBIEvOfOJKCXQod37TK8nynvhnF7RaF0Z3XICbO00h6DYreD
	 NZReNvQY+LacQ6p9Jp/vFMJYk1lm3Bept5OZUMLu4hK4weghOXC/UR8F20BKPjrWYH
	 5eEVD0/Nx06hA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 Feb 2024 18:58:42 +0100
X-ME-IP: 92.140.202.140
Message-ID: <d1a48a3c-cb2e-4dee-8fef-850296787234@wanadoo.fr>
Date: Thu, 8 Feb 2024 18:58:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slimbus: core: Remove usage of the deprecated
 ida_simple_xx() API
Content-Language: en-MW
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <8402a9a8a45937fe2e62617ff0c7408503692b20.1702745212.git.christophe.jaillet@wanadoo.fr>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <8402a9a8a45937fe2e62617ff0c7408503692b20.1702745212.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/12/2023 à 17:47, Christophe JAILLET a écrit :
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range() is inclusive. So change this change allows one more
> device. Previously address 0xFE was never used.
> 
> Fixes: 46a2bb5a7f7e ("slimbus: core: Add slim controllers support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> /!\ Untested /!\
> 
> The change of behavior is motivated by the comment in
> drivers/slimbus/slimbus.h stating that /* Manager's logical address is set
> to 0xFF per spec */, so all other values, including 0xFE should be valid,
> IMHO.
> 
> So considering this as a bug-fix, I added a Fixes tag.
> ---
>   drivers/slimbus/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
> index d43873bb5fe6..01cbd4621981 100644
> --- a/drivers/slimbus/core.c
> +++ b/drivers/slimbus/core.c
> @@ -436,8 +436,8 @@ static int slim_device_alloc_laddr(struct slim_device *sbdev,
>   		if (ret < 0)
>   			goto err;
>   	} else if (report_present) {
> -		ret = ida_simple_get(&ctrl->laddr_ida,
> -				     0, SLIM_LA_MANAGER - 1, GFP_KERNEL);
> +		ret = ida_alloc_max(&ctrl->laddr_ida,
> +				    SLIM_LA_MANAGER - 1, GFP_KERNEL);
>   		if (ret < 0)
>   			goto err;
>   

Hi,

gentle reminder.

All patches to remove the ida_simple API have been sent.
And Matthew Wilcox seems happy with the on going work. (see [1])

Based on next-20240207
$git grep ida_simple_get | wc -l
38

https://elixir.bootlin.com/linux/v6.8-rc3/A/ident/ida_simple_get
50

https://elixir.bootlin.com/linux/v6.7.4/A/ident/ida_simple_get
81

Thanks
CJ

[1]: https://lore.kernel.org/all/ZaqruGVz734zjxrZ@casper.infradead.org/

