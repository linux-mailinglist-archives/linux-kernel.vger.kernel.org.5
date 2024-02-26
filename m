Return-Path: <linux-kernel+bounces-82302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A3386821C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D775A1F24196
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4DB13174E;
	Mon, 26 Feb 2024 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="jjavfR5L"
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAFB13173B;
	Mon, 26 Feb 2024 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980659; cv=none; b=pUE+JJqvQEgcjdrRveFXua+XKA3+SGsze09iT3ghcl5vYqRHd2M5Mut27JSBLTOyETGm29GzqXY2xt54IbAV7xgYdFrFady8iJkcl+flESySuNtQwbcMmAMLIG5YS8DqQOrYQq+1AraCct1dw/NQo5p4euGgdIFSETcDUZQZF2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980659; c=relaxed/simple;
	bh=lqBo3vC7JWhwC80dP7euZ+YA9k5CqjiwMk+qcXwOJ+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bs5u9zyxADqpW4ozJKwy/dGnCXVaw7kk5t8Jx5yCSK4yFsfkYj0Kxfd3mu91k/hVrOMh1KM2b5JGGH6mxLVHuxBtYbYiI6BRX6BHiliEvWVtzI0ua5EtzrwpYnoCk/FzITPsOU4wmyiKxJ66oF/Gm0VOn88dvMPRoeSqz4bpg6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=jjavfR5L; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from [IPV6:2003:e9:d739:bb29:632d:d63:dac0:8169] (p200300e9d739bb29632d0d63dac08169.dip0.t-ipconnect.de [IPv6:2003:e9:d739:bb29:632d:d63:dac0:8169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 473EDC0E61;
	Mon, 26 Feb 2024 21:50:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1708980655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kuryjzgqEEh8nWCon2N5Jc8AKiM5iARu8GEOMsnGT/o=;
	b=jjavfR5Lj2HSla7+lyJ0N5spuMXhr/9/Wzs55AMp/TY6CDaGc7nbbFo2loOeqPEJdEugZY
	mO6E+VbfaH3YF0Hos+pg9Yx1g6t0/iWJT23Y8Zc3dAG4eE5LEGwYK0AojcMzFxudNf41i7
	GzKiONg1LXY6V9B/Xs1BsmBSE/1gx5Ob6z3IipHsfY4IqHC8642kPJQ3rjUS0A0C/hLr4a
	ME7RU/Vbn76m3ytlTjBwbQe4dmLj5J9BsVLdiuX6jqcxBKabCK+jFud2dSj8iad8nMl6jF
	TGnGQwyjSToBM3vMghZ22DdZTxHaC/yBe+jSo/mcCgyitcvirM6LdqsQrSxhuw==
Message-ID: <ff45cc5c-e952-4464-a479-4b9dfafe960d@datenfreihafen.org>
Date: Mon, 26 Feb 2024 21:50:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ieee802154: mrf24j40: convert to use maple tree
 register cache
Content-Language: en-US
To: Bo Liu <liubo03@inspur.com>, alex.aring@gmail.com,
 miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240202064659.39434-1-liubo03@inspur.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20240202064659.39434-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 02.02.24 07:46, Bo Liu wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>   drivers/net/ieee802154/mrf24j40.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index ee4cfbf2c5cc..d3f42efc5d1a 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -388,7 +388,7 @@ static const struct regmap_config mrf24j40_short_regmap = {
>   	.pad_bits = 1,
>   	.write_flag_mask = MRF24J40_SHORT_WRITE,
>   	.read_flag_mask = MRF24J40_SHORT_READ,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>   	.max_register = MRF24J40_SHORT_NUMREGS,
>   	.writeable_reg = mrf24j40_short_reg_writeable,
>   	.readable_reg = mrf24j40_short_reg_readable,
> @@ -495,7 +495,7 @@ static const struct regmap_config mrf24j40_long_regmap = {
>   	.pad_bits = 5,
>   	.write_flag_mask = MRF24J40_LONG_ACCESS,
>   	.read_flag_mask = MRF24J40_LONG_ACCESS,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>   	.max_register = MRF24J40_LONG_NUMREGS,
>   	.writeable_reg = mrf24j40_long_reg_writeable,
>   	.readable_reg = mrf24j40_long_reg_readable,

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt

