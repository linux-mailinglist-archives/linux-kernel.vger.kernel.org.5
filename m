Return-Path: <linux-kernel+bounces-126659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E9C893B09
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C93BDB21BF2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11FB3E491;
	Mon,  1 Apr 2024 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="eMmDZqfv"
Received: from msa.smtpout.orange.fr (smtp-72.smtpout.orange.fr [80.12.242.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2D13BB35;
	Mon,  1 Apr 2024 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711975198; cv=none; b=iIxQE6cbWT/BpdJvyoHOqjc/NDM2A1v6FlFRpMIJuT5+l6wY4Faxwy0Lj5BlCBRB1Bbb2uojUFz74/rjXSGx+PA87HtuiTlDfdPeRoPQuPXRqqzgniR+H6d5AL8T/9pcIy3xOw+osQFqLJ5Ymp981LOmKO1+T7XSPLFwGfTNtTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711975198; c=relaxed/simple;
	bh=gBcYJWd1q7/NR3aoPM7mtxpMQRQIPmsEQrB3y9U5vME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NpkK8AYibV+hJSOVOL5s+7Hwt6MOxuyzXAXEs7YWaP1w36rmg8VTBXQ1ORXWwqBnr0aZwiRhMGz1bxgDLukz5eRswTJNtVGlOY4dkaOdPmSjb6JrCJA28IIyiysqDrx55SsXYuZ3k+LA5e51x+1tn7AwmEVFTtZKTQ1xCvg7AdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=eMmDZqfv; arc=none smtp.client-ip=80.12.242.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id rGQarQ8Mn0o2lrGQarE04V; Mon, 01 Apr 2024 14:06:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1711973179;
	bh=uH09Q5GwpmfQcuHQvAdOeb+DYLVuiN921+6a8fEHOK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=eMmDZqfvgjX6mJkWXxKaP62oUXJ9QqqLhSqxJldTTFFKHaDga1sJJwkXGzWmhUqDY
	 Nl3fFGsKhPUpq4pRTdhrkH7j4QgOpYGYqRmoVL/CaexInh21LEfsxwmLTkyiM72wI4
	 Jp+yDqlchMsJkJ3yrwk2kV4QKfD4v6PgnshwMJxvHlEY308w5+kdhJlmqfIjz0Crjt
	 oiBvGk/45DJQTgCs4MGDKE8+PO8T5B+g8Lxgq2kBXNsEyRFvATqoiUlDGvvhL+vO6b
	 3ntNT9xnk0vzLi1gHE5uSTE5xvnCLtUOthaK3oeSXK6mMcFbIzIDAX03/ZEV+osXeY
	 34SR8uCH50Smw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 01 Apr 2024 14:06:19 +0200
X-ME-IP: 86.243.17.157
Message-ID: <ba5a9935-fb62-495e-8b52-bdb6a6d64f84@wanadoo.fr>
Date: Mon, 1 Apr 2024 14:06:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: s2mps11: Check of_clk_add_hw_provider() result
To: Aleksandr Aprelkov <aaprelkov@usergate.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240401103808.617463-1-aaprelkov@usergate.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240401103808.617463-1-aaprelkov@usergate.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 01/04/2024 à 12:38, Aleksandr Aprelkov a écrit :
> There is no check if error occurs in clock provider registration.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: b228fad50c00 ("clk: s2mps11: Migrate to clk_hw based OF and registration APIs")
> Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
> ---
>   drivers/clk/clk-s2mps11.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
> index 38c456540d1b..f9ce413b6c02 100644
> --- a/drivers/clk/clk-s2mps11.c
> +++ b/drivers/clk/clk-s2mps11.c
> @@ -187,8 +187,10 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
>   	}
>   
>   	clk_data->num = S2MPS11_CLKS_NUM;
> -	of_clk_add_hw_provider(s2mps11_clks->clk_np, of_clk_hw_onecell_get,
> +	ret = of_clk_add_hw_provider(s2mps11_clks->clk_np, of_clk_hw_onecell_get,
>   			       clk_data);

Hi,

Nit: "clk_data);" is wrongly aligned now.

CJ

> +	if (ret < 0)
> +		goto err_reg;
>   
>   	platform_set_drvdata(pdev, s2mps11_clks);
>   


