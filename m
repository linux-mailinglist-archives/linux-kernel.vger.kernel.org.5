Return-Path: <linux-kernel+bounces-117198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC6B88A88E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F371F3C438
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89641128398;
	Mon, 25 Mar 2024 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PInVnx/1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C9714A8B;
	Mon, 25 Mar 2024 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375376; cv=none; b=XtUmuo+Madrl3nYJhBfkaNoEMuiwCd+72JMJ4rvSPL1WQV+svCt2aAxLwnlC+McWf0fr435dBkRpXdjsEBy47023CHMxcJmFGGE8nXditbR/bi2QmxeS3LY2BBJNvDwZ018ybSTrLMjV3f7L+aHDpwbYMScbJk8wIQuBEnqmTY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375376; c=relaxed/simple;
	bh=LK9smWuFEaz05Mp9x+m54fvpRDKiNeTfa5BBHlCzGmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnZ+dyz7hgrAFES0LzH6sknoG2e3Sw/AvUN28cVMEjJ1JRMK76t+m9qjdQTNHh1EFOuA+HtqtksyGZg++GpiIb7xWP93cTJ4SufW98/j6vibL3MVtl0VHv/5R3NttHf2a+5ZoOKp3QFqrdWcpe6TQ8Lg6tsP/Izmv36DdS74yMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PInVnx/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886A0C433F1;
	Mon, 25 Mar 2024 14:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711375376;
	bh=LK9smWuFEaz05Mp9x+m54fvpRDKiNeTfa5BBHlCzGmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PInVnx/1wR5q2p6s1rAvd7TaCX+K8ktpCtuW0gLM/Kn1O1r4FnLG83UzhLEB5HclE
	 rY+S2DUIfqXXEPGhl1g53LMhAwYz0FyqbMdFn4TtET3D4SK1/zlqtq6P48pfhMhJdi
	 X9YWGgOYEP3r50Mf7reLFz/P14hTZlR9nKIUyTBwwELk9lwZXyw29LgyPV0BzC8Gak
	 LzS4S9BtBisprlsuS9/XpCivHB3hGklkHQ7IqefIwAqu7G73Q0PvOi4/eEJBiOWf/M
	 /pEuPlUGpwdjQUkQo0vni/gmlfWGMD0OMvt93XK0Sh/UdRzJCuknav2ktdLIE9YNlo
	 CTOhy3QdaNCdA==
Date: Mon, 25 Mar 2024 09:02:53 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gdsc: treat optional supplies as optional
Message-ID: <jdnylcw35fofffszbtwd4pq3tltowmbzhugxeiuthjqnpnrjkw@bjfpfgrhk4p2>
References: <20240325085835.26158-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325085835.26158-1-johan+linaro@kernel.org>

On Mon, Mar 25, 2024 at 09:58:35AM +0100, Johan Hovold wrote:
> Since commit deebc79b28d6 ("clk: qcom: gpucc-sc8280xp: Add external
> supply for GX gdsc") the GDSC supply must be treated as optional to
> avoid warnings like:
> 
> 	gpu_cc-sc8280xp 3d90000.clock-controller: supply vdd-gfx not found, using dummy regulator
> 
> on SC8280XP.
> 
> Fortunately, the driver is already prepared to handle this by checking
> that the regulator pointer is non-NULL before use.
> 
> This also avoids triggering a potential deadlock on SC8280XP even if the
> underlying issue still remains for the derivative platforms like SA8295P
> that actually use the supply.
> 
> Fixes: deebc79b28d6 ("clk: qcom: gpucc-sc8280xp: Add external supply for GX gdsc")
> Link: https://lore.kernel.org/lkml/Zf25Sv2x9WaCFuIH@hovoldconsulting.com/
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Thanks for fixing this, it never made it off my todo list...

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/clk/qcom/gdsc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index e7a4068b9f39..df9618ab7eea 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -487,9 +487,14 @@ int gdsc_register(struct gdsc_desc *desc,
>  		if (!scs[i] || !scs[i]->supply)
>  			continue;
>  
> -		scs[i]->rsupply = devm_regulator_get(dev, scs[i]->supply);
> -		if (IS_ERR(scs[i]->rsupply))
> -			return PTR_ERR(scs[i]->rsupply);
> +		scs[i]->rsupply = devm_regulator_get_optional(dev, scs[i]->supply);
> +		if (IS_ERR(scs[i]->rsupply)) {
> +			ret = PTR_ERR(scs[i]->rsupply);
> +			if (ret != -ENODEV)
> +				return ret;
> +
> +			scs[i]->rsupply = NULL;
> +		}
>  	}
>  
>  	data->num_domains = num;
> -- 
> 2.43.0
> 

