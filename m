Return-Path: <linux-kernel+bounces-89566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 455EC86F221
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A0CB218A6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0D13FE5B;
	Sat,  2 Mar 2024 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2Kzifhm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9951629D11;
	Sat,  2 Mar 2024 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709407548; cv=none; b=q/XW9qnBMxhKpqUHhzi6e8fCocExCoPXDJiAXrLaRrpKFJppjQiYAvQWVb+8QqtyO2UxdnBVWdZb7xu1IrD9ebOxw2dr7SXPHT7koQ41/aWWVjpDxgbQBBAfZ8yejB2Cs0ldt+GhRqdfKGMix4Ro9wc6TqR/bWquoEUypfNij7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709407548; c=relaxed/simple;
	bh=MeR1UFYMjfBi5U2g3HdYII+Nu312YIrJkntoZr+VBJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGxJwdYSi27gQp11wdl8iPMorluWcUIYuRBphVVEjWyM7YVDhD5vgJlmG1zsvqvMyRyZGPfeevJAU2EBQ7ujxjy0xcJbrEDKlE/14P38WhGW5ANuVGQdvHvihCz+f7TUmNvmojo6eamZRamcGwBWw5rG9ag8u1QGBJ9tNHh2T7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2Kzifhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99732C433C7;
	Sat,  2 Mar 2024 19:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709407548;
	bh=MeR1UFYMjfBi5U2g3HdYII+Nu312YIrJkntoZr+VBJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I2Kzifhm6objQzgMOTMsNyAoYekMxHI4OG7SvlsgPOHHeTHQX8l1s8tJa2q68ws2A
	 LJZ7lm25zihEimMiTjFTBAWnfGuYGEbTY5xEoUZcXNjIg0kFgk+vp008DpJOKAOsAW
	 hZ8m4vMx2zQQ2+tlPg0Vt1zRr21knKQ8XrVEdqs7GfMX8QoZNJZnE5VoJcctG2IB/n
	 pa2kSguPZB+Y+CZ7uSjJlZkhFSe0t2uJBv7uDhNl5kKY6v+Xha6YN+qLvwBn/W43/l
	 gbAxa5aQ+a9mCWY/9iYn1FF9bBjHuyAZNIPzPWJM2FyBrpKQdLuB7yGjZglvVG0x6T
	 wk2EDBVAYRqMQ==
Date: Sat, 2 Mar 2024 13:25:45 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linus.walleij@linaro.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v12 7/9] firmware: qcom: scm: Fix __scm->dev assignement
Message-ID: <n2gomlmlzwodpg2v3gzuc62n3plewdqgiwctrv2tawdih26rig@obqd2a2ovqvp>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
 <20240227155308.18395-8-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227155308.18395-8-quic_mojha@quicinc.com>

On Tue, Feb 27, 2024 at 09:23:06PM +0530, Mukesh Ojha wrote:
> qcom_scm_is_available() gives wrong indication if __scm
> is initialized but __scm->dev is not.
> 
> Fix this appropriately by making sure if __scm is
> initialized and then it is associated with its
> device.
> 

This seems like a bug fix, and should as such have a Fixes: tag and
probably Cc: stable@vger.kernel.org

> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 6c252cddd44e..6f14254c0c10 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1859,6 +1859,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  	if (!scm)
>  		return -ENOMEM;
>  
> +	scm->dev = &pdev->dev;
>  	ret = qcom_scm_find_dload_address(&pdev->dev, &scm->dload_mode_addr);
>  	if (ret < 0)
>  		return ret;
> @@ -1895,7 +1896,6 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	__scm = scm;
> -	__scm->dev = &pdev->dev;

Is it sufficient to just move the line up, or do we need a barrier of
some sort here?

Regards,
Bjorn

>  
>  	init_completion(&__scm->waitq_comp);
>  
> -- 
> 2.43.0.254.ga26002b62827
> 

