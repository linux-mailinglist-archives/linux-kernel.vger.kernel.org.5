Return-Path: <linux-kernel+bounces-82301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3772D868218
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F10A1C25806
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40552131E27;
	Mon, 26 Feb 2024 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="NCJ3Q9Us"
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B701F131745;
	Mon, 26 Feb 2024 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980644; cv=none; b=Cka4RWpjEWSUQ8bg7uc1Y0GM4uX2eLeOOY+YFDmodL6sV2pPx5+G5milQ5YygU+ZmQCgAAU2Tvz7+xueBqA7m250MZ6bOSU/FjeX/VwpazOnIE7bmbG6J1yRxiEW0nGaz6tPDNoCuhxCWV5vwPwkaRMwqEfZ+0c7RM/m1q2z6TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980644; c=relaxed/simple;
	bh=QgzzaM9ViGKcwOoH1Mzli8mKf9EzfwB3b2b39L7lRuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXzQWH/XyJf9bBdJvAK53DGyBen2j7eEYvhC/lvePvIYhasKkUvSYu4foRa6PQj88nuuliZIbnM+2Kf7v26x8Hqah/B5lKnLyonqpVEMy2B2IqSlJykJDEd+cgQiVKB+qlCPnobInhd+j8qA2I36o2IJqXtAt70yfN2ivZMcmu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=NCJ3Q9Us; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from [IPV6:2003:e9:d739:bb29:632d:d63:dac0:8169] (p200300e9d739bb29632d0d63dac08169.dip0.t-ipconnect.de [IPv6:2003:e9:d739:bb29:632d:d63:dac0:8169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 7B8F2C0944;
	Mon, 26 Feb 2024 21:50:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1708980638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHQOxK4Dx7A2fhV1c1TcZ/1+zV41qKk72MzwYutnA1Y=;
	b=NCJ3Q9UsGp96FnucjRhhPvB/ig41Kdjsesa9mMLjvhWK/mvvvRNCp/3CsfuMXWjKauj3AL
	AgWDvwNz98ivtFV4e0o/mzmvRiT4vLAc0eYb64AlrYDQ+w9fxio0z/l4veGuczkpCKzleo
	0CiVqbBKeIt8yW3XrSM9+eawng5pQa9mojJIjifDAPCCzWzxEcezxHLBIZqUwKFThekOFF
	d4DLjnCuL4LdVCm4Ub5a9/t2JLuiwWt2l+Nsal/Wb4z9ut5avAL8/z4wZ0nU4GdroDIf52
	csNk+eC+I4jU1jMapT/+g/OtcUP7mN61xkjY4vgqZRcSAnI6KXVyohAt0xbalA==
Message-ID: <bc64b713-0e38-4674-8d8e-54389c22d95c@datenfreihafen.org>
Date: Mon, 26 Feb 2024 21:50:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ieee802154: mcr20a: convert to use maple tree
 register cache
Content-Language: en-US
To: Bo Liu <liubo03@inspur.com>, alex.aring@gmail.com,
 miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240202064611.39346-1-liubo03@inspur.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20240202064611.39346-1-liubo03@inspur.com>
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
>   drivers/net/ieee802154/mcr20a.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> index 87abe3b46316..efb1be3c644e 100644
> --- a/drivers/net/ieee802154/mcr20a.c
> +++ b/drivers/net/ieee802154/mcr20a.c
> @@ -251,7 +251,7 @@ static const struct regmap_config mcr20a_dar_regmap = {
>   	.val_bits		= 8,
>   	.write_flag_mask	= REGISTER_ACCESS | REGISTER_WRITE,
>   	.read_flag_mask		= REGISTER_ACCESS | REGISTER_READ,
> -	.cache_type		= REGCACHE_RBTREE,
> +	.cache_type		= REGCACHE_MAPLE,
>   	.writeable_reg		= mcr20a_dar_writeable,
>   	.readable_reg		= mcr20a_dar_readable,
>   	.volatile_reg		= mcr20a_dar_volatile,
> @@ -387,7 +387,7 @@ static const struct regmap_config mcr20a_iar_regmap = {
>   	.val_bits		= 8,
>   	.write_flag_mask	= REGISTER_ACCESS | REGISTER_WRITE | IAR_INDEX,
>   	.read_flag_mask		= REGISTER_ACCESS | REGISTER_READ  | IAR_INDEX,
> -	.cache_type		= REGCACHE_RBTREE,
> +	.cache_type		= REGCACHE_MAPLE,
>   	.writeable_reg		= mcr20a_iar_writeable,
>   	.readable_reg		= mcr20a_iar_readable,
>   	.volatile_reg		= mcr20a_iar_volatile,

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt

