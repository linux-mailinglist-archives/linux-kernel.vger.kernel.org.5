Return-Path: <linux-kernel+bounces-73417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B6385C24E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188FD1C223FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C7476C9B;
	Tue, 20 Feb 2024 17:17:34 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C9576C87;
	Tue, 20 Feb 2024 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449454; cv=none; b=IalLkhV+gIvnpPT2YqgDONOxvZiDDquIEF6OcIawAbJDpq3E98qPr4pIBgTImnkeMyxw53qzqivOwvMfguBfBUJScdKqLHp+/oEcv2BP3+w2jVJgEiUbSOzCW43LOSe2wUWkyizeP/AGR/ecTXuiiKTrQmb7D2FAkXztCtL+gqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449454; c=relaxed/simple;
	bh=96ksfqWINydkRiMCjGad2oGhzIwnfo2QrZw43uLx3is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogfO68XttrSf5yiHGSn+y5MiRtrCWVBuB4/WQaY5rEqLC4D4To6LaGf3o0A5Fkl1vGF2p23srbzh+aXBcRL2Y9t8EMKpNt1dhz1yDGtaBNuzHs+njYjWM36xW78T1iCu0IbhHkBaL9T11hifwUr8dtrMUJmd8oJHyZu64zEhn6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2098E61E5FE01;
	Tue, 20 Feb 2024 18:16:40 +0100 (CET)
Message-ID: <26acdacd-e63b-494f-bf7d-215b8643a0c5@molgen.mpg.de>
Date: Tue, 20 Feb 2024 18:16:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: host: replace 1st argument to struct device * for
 mmc_of_parse_clk_phase()
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Adrian Hunter <adrian.hunter@intel.com>, Joel Stanley <joel@jms.id.au>,
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Yang,


Thank you very much for your patch. Some nits from my side.

For the summary, I suggest:

 > mmc: host: mmc_of_parse_clk_phase(): Pass struct device * instead of 
mmc_host *

Am 15.02.24 um 12:03 schrieb Yang Xiwen via B4 Relay:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Parsing dt usaully happens very early, sometimes even bofore struct

1.  us*ua*lly
2.  b*e*fore

> mmc_host is allocated (e.g. dw_mci_probe() and dw_mci_parse_dt() in
> dw_mmc.c). Looking at the source of mmc_of_parse_clk_phase(), it's
> actually not mandatory to have a initialized mmc_host first, instead we

a*n*

> can pass struct device * to it directly.
> 
> Also fix the only current user (sdhci-of-aspeed.c).
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>   drivers/mmc/core/host.c            | 4 +---
>   drivers/mmc/host/sdhci-of-aspeed.c | 2 +-
>   include/linux/mmc/host.h           | 2 +-
>   3 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index cf396e8f34e9..8b2844ac5dc5 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -234,10 +234,8 @@ static void mmc_of_parse_timing_phase(struct device *dev, const char *prop,
>   }
>   
>   void
> -mmc_of_parse_clk_phase(struct mmc_host *host, struct mmc_clk_phase_map *map)
> +mmc_of_parse_clk_phase(struct device *dev, struct mmc_clk_phase_map *map)
>   {
> -	struct device *dev = host->parent;
> -
>   	mmc_of_parse_timing_phase(dev, "clk-phase-legacy",
>   				  &map->phase[MMC_TIMING_LEGACY]);
>   	mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs",
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 42d54532cabe..430c1f90037b 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -435,7 +435,7 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
>   		goto err_sdhci_add;
>   
>   	if (dev->phase_desc)
> -		mmc_of_parse_clk_phase(host->mmc, &dev->phase_map);
> +		mmc_of_parse_clk_phase(&pdev->dev, &dev->phase_map);
>   
>   	ret = sdhci_add_host(host);
>   	if (ret)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 2f445c651742..5894bf912f7b 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -539,7 +539,7 @@ struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra);
>   int mmc_add_host(struct mmc_host *);
>   void mmc_remove_host(struct mmc_host *);
>   void mmc_free_host(struct mmc_host *);
> -void mmc_of_parse_clk_phase(struct mmc_host *host,
> +void mmc_of_parse_clk_phase(struct device *dev,
>   			    struct mmc_clk_phase_map *map);
>   int mmc_of_parse(struct mmc_host *host);
>   int mmc_of_parse_voltage(struct mmc_host *host, u32 *mask);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

