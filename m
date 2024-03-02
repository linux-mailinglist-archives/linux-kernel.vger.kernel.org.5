Return-Path: <linux-kernel+bounces-89562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80A486F216
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5BB283D05
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07983FE4E;
	Sat,  2 Mar 2024 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTF3Rejw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D74117C77;
	Sat,  2 Mar 2024 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709407139; cv=none; b=qIMlxy8K41cU6BopA80WEPJ89lA5brHMccI6C+w/pmT5wrbdqCh3/eW0WKoQj97py7CTeNYJuL+mC6B7VQNZBIqBxlTSWan0FQGJcy+1T+Nf0JSkFx3Am1pA9W39htuj/rk2xLQHn6z3rc9q6ZWHRY9FTov3m0+WZBuQQYhLNrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709407139; c=relaxed/simple;
	bh=NzbhSdr/NBjCmH9e1ImgNzn6dVpYSWiisFslYjeKN+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7WlaR19Y5gla7qxRmEUnGCBQIhPSJPi1rrzgEOxpXwzt7HuqduHqbWZEaY2oyH6yaRFpjDeG0/KP0Xuv3dqxaUT/GOc/i4tIeguHUJKzDJdh3kZzc9yrgGI20ufeyG8fTwcr5IcDclDiFclm/QfGHqv7Ak5qjmaKrfMVWUDG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTF3Rejw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE4CC433C7;
	Sat,  2 Mar 2024 19:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709407138;
	bh=NzbhSdr/NBjCmH9e1ImgNzn6dVpYSWiisFslYjeKN+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTF3RejwvLu0SrNmQ4uhnkGJhFVZ9PnIvjaGMxvqTK9f+kiwiQte99mTTgDgKE+Wg
	 RhkI6UtsRLJqNIoMNmSrZYAyhY2KzuTtoAw79/5NDkejoeQxgj2j7xYbNO92tdSH6J
	 2yDEuP682dtD+oV89DIKkhsbpXOHC7Ky4rqJ/f91UAR0Qm6pa4U8BdZGE1QWl8UWoJ
	 QbZA5LGBHwJT0ePHuNhJ0QfB5GWOITz3IGr18PJCTGaeMhK6NThnek2eMFH6UiZfw9
	 yg5s9DqP6dSDbRRczjw+ApC6xrmT9wDpuZPA7nWHwdi9pPODtrdpo9YhDdmsssJmA6
	 I75LkgHCDYm8A==
Date: Sat, 2 Mar 2024 13:18:56 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linus.walleij@linaro.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v12 6/9] firmware: qcom: scm: Remove log reporting memory
 allocation failure
Message-ID: <2dn2o57yfgfwrkdb2dcdz4qdlhxyhr4tozdsxumgkib5tlgnj7@6qpvoe2zb3q4>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
 <20240227155308.18395-7-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227155308.18395-7-quic_mojha@quicinc.com>

On Tue, Feb 27, 2024 at 09:23:05PM +0530, Mukesh Ojha wrote:
> Remove redundant memory allocation failure.
> 
> WARNING: Possible unnecessary 'out of memory' message
> +       if (!mdata_buf) {
> +               dev_err(__scm->dev, "Allocation of metadata buffer failed.\n");
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

This seems unrelated to the rest of the series, if you send independent
patches (or patch series) on their own it's easy to just pick them.

Regards,
Bjorn

> ---
>  drivers/firmware/qcom/qcom_scm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 3fd89cddba3b..6c252cddd44e 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -598,10 +598,9 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
>  	 */
>  	mdata_buf = dma_alloc_coherent(__scm->dev, size, &mdata_phys,
>  				       GFP_KERNEL);
> -	if (!mdata_buf) {
> -		dev_err(__scm->dev, "Allocation of metadata buffer failed.\n");
> +	if (!mdata_buf)
>  		return -ENOMEM;
> -	}
> +
>  	memcpy(mdata_buf, metadata, size);
>  
>  	ret = qcom_scm_clk_enable();
> -- 
> 2.43.0.254.ga26002b62827
> 

