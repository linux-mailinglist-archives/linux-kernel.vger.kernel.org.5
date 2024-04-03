Return-Path: <linux-kernel+bounces-129021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C13CB896348
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21761C225C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA7A405F2;
	Wed,  3 Apr 2024 03:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gt2LcNSI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902411C280;
	Wed,  3 Apr 2024 03:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712116579; cv=none; b=rHCVK9kHatdv6V8Uvb3a6eoFbJ6UPdohvtFVU7x4BB07ai0p2MMCEiXzFpq7/RIhQoYu7VIAouum2oqv7fooXP1E8NyesTWyCOAyqglHYtF22KyLgWCeLV62Df+kGyKpDnc5c00RGyv1KXv15YBm1MQxgo3vdHHfPiMp7ZzB1R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712116579; c=relaxed/simple;
	bh=WuzYYKykOS0ZsBeI47G9ftWcl9HjzB1r6T6Fa6/H5+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTUKU9sqP5epI7xHMRC3i2aMZg+FmcxTvKMEoXKcJzBx+Wt4PqypJI8d6PJoy3adQQQeaqLPxxArclW9lG5cbG2fAoYRpEF5JpE6HRVhtkp1AktxuersbEQFK0YG5J3kWcI+kN9CAXzB+aCEC+N+SBuWFy8qWYaD0yZPdfIyl/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gt2LcNSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64608C433C7;
	Wed,  3 Apr 2024 03:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712116579;
	bh=WuzYYKykOS0ZsBeI47G9ftWcl9HjzB1r6T6Fa6/H5+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gt2LcNSIW6JpbxCaWbs9H5hLH+Z+zjBigamxsQo/KFhCI8OAuc61Q5LqgGV3rZsBz
	 But37YNhmVg9akYJIEY8uAeyB2tVZhsyLCPXuwRXVYqZN/ztErx/bd0ehshlkKfgxq
	 OnUoeKlFY9NKVemgfFFe4+gqnPrOe9lR0QdsSXsVffZ1VqAYquanuWYlM2Dzr/OB11
	 fexy08fJutDJNXkjzrhuLLKM5t5Ss1RuFmPIenUHsDDYdEhD0iznE6cMD+dNcrxlpT
	 MYxX+NA7qiqThHnpZpZHWNlgO39ow2tevwEu5WFSILRjSJizXgB7K/10R5xRcAChzt
	 m4D7Ya8GpEfvg==
Message-ID: <679e665c-73cf-4dfb-ad86-efc799b3f8e3@kernel.org>
Date: Wed, 3 Apr 2024 12:56:17 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_gemini: Add check for clk_enable
To: Chen Ni <nichen@iscas.ac.cn>, linus.walleij@linaro.org, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240403034314.3623830-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240403034314.3623830-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 12:43, Chen Ni wrote:
> As the potential failure of the clk_enable(), it should be better to
> check it and return error if fails.

Simplify please:

The call to clk_enable() in gemini_sata_start_bridge() can fail. Add a check to
detect such failure.

> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/ata/sata_gemini.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
> index 400b22ee99c3..4c270999ba3c 100644
> --- a/drivers/ata/sata_gemini.c
> +++ b/drivers/ata/sata_gemini.c
> @@ -200,7 +200,10 @@ int gemini_sata_start_bridge(struct sata_gemini *sg, unsigned int bridge)
>  		pclk = sg->sata0_pclk;
>  	else
>  		pclk = sg->sata1_pclk;
> -	clk_enable(pclk);
> +	ret = clk_enable(pclk);
> +	if (ret)
> +		return ret;
> +
>  	msleep(10);
>  
>  	/* Do not keep clocking a bridge that is not online */

-- 
Damien Le Moal
Western Digital Research


