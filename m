Return-Path: <linux-kernel+bounces-82304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F736868224
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248F428984B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536B5130E5F;
	Mon, 26 Feb 2024 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="hbhyWQdG"
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5D2AD0F;
	Mon, 26 Feb 2024 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980957; cv=none; b=XS49tVPjDDruoxZz5951KNH35BGHLqFIL7+43EmAkI9mb7JWybV78PIb5hrR7BrITYEy9RSM9fdeLe3SYuJNtPuJJq1kK5lCPdG7EtbORRgSMHv/s0GWBWuBpeSXrDrwJGTBalxEguJ8kzcl/X/7Mr0yVdpYReB02kp48lDFtss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980957; c=relaxed/simple;
	bh=02zprmOhLIbgChsRDiWJHbDY7QAwsInduXqZqDxFSDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGpsDy7xIClgjz7O7Fp0sgNfFyykJpOJITX/m90CxLuXUEHe5iWG5q7Ik0bP/FV5la5G5A2M4Z1xmPVwLJsUNjQGe7QVWzxwF2oDWAoiIdFxpXoGagPNl9vkSooS1Jvhuk+8zHSQ5vSC5bk4cGMgs8OniiVPC2cAv59W6OIfVOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=hbhyWQdG; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from [IPV6:2003:e9:d739:bb29:632d:d63:dac0:8169] (p200300e9d739bb29632d0d63dac08169.dip0.t-ipconnect.de [IPv6:2003:e9:d739:bb29:632d:d63:dac0:8169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id CA816C0924;
	Mon, 26 Feb 2024 21:49:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1708980590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7OAuuFC+fmZ1nPUbf+yUsQuGL64Qf+7Ju4BkHDCQyU=;
	b=hbhyWQdGtF1jVC6oFeUWMiEA/2Uib6EkQ9ecEZuw5ktZEAFcoeRjg36hFd+fjGEi1Ry3bg
	FTfFLjiNkbsHpRnwGCAeDr2kmyJBzchfBRjEvRgYrdFiwHk7DggMh3tsa/+m7nSN1s10XT
	UhA49YuCE0Ctac11Zadx53QbVWQ5NMcvmHEgLTirVGWm4ne24wyQ8/KjK5uhcl51EVowba
	0keODdJYk1JEG8emE9DsER76SyIIPL59ZpukYG29wPjDYuuI83vm4JUFzjJG9/PL2XX32S
	MtuKOcZmiNQ7oPhMf0kgl5lel3SFTruW3U6U+YmSO4QaY509Mpb708uVTPkURg==
Message-ID: <87cc872f-d6f9-47d6-b579-f0412430889c@datenfreihafen.org>
Date: Mon, 26 Feb 2024 21:48:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ieee802154: at86rf230: convert to use maple tree
 register cache
Content-Language: en-US
To: Bo Liu <liubo03@inspur.com>, alex.aring@gmail.com,
 miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240202064512.39259-1-liubo03@inspur.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20240202064512.39259-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 02.02.24 07:45, Bo Liu wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>   drivers/net/ieee802154/at86rf230.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index 164c7f605af5..6212164ffb36 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -316,7 +316,7 @@ static const struct regmap_config at86rf230_regmap_spi_config = {
>   	.val_bits = 8,
>   	.write_flag_mask = CMD_REG | CMD_WRITE,
>   	.read_flag_mask = CMD_REG,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>   	.max_register = AT86RF2XX_NUMREGS,
>   	.writeable_reg = at86rf230_reg_writeable,
>   	.readable_reg = at86rf230_reg_readable,

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt

