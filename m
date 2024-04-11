Return-Path: <linux-kernel+bounces-139697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037708A0698
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79720B23048
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D90613BAD1;
	Thu, 11 Apr 2024 03:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdrkL7LS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22A113B795;
	Thu, 11 Apr 2024 03:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712805356; cv=none; b=B8YZUvYFQRhJ7/lifoJuayzgJrnDXJHBodlDuPax6uKFyMkj8xTtSLFc/S1aeB8EvYY7YuELxqFDr27Qcxa/TWpqB6H9mAx6dZow6COsO+SeA9+nHknqdjtvuB33R8J0oTs8UZHLQa/bOK8EYX3J86tZAGE5Pj5u9empXLhe9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712805356; c=relaxed/simple;
	bh=hy1z9iyb5VzHmSvD9OU1ijF/ELGQxBn3bMjuKQBN8zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOyAdRBVxi1rV8KYoF5Evzr9arEiSaVW7ihlflL2K3fC3W+yNU2t1vPL69/vKNNZsh3Qwhys1KOxHhEES4W82eaoS8oP1XxcNDxZ8gGbY0bgD0dH/b3hlCagCkRAsxh2Wq+bu+qhmBo+hAWsH0dFvQ0TBOezXcg2eR7TUt5NC6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdrkL7LS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F359C433C7;
	Thu, 11 Apr 2024 03:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712805356;
	bh=hy1z9iyb5VzHmSvD9OU1ijF/ELGQxBn3bMjuKQBN8zM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QdrkL7LSwLI3ym8riSY+yo8E68yp85sPRsqxrxpkU6jdLBRG+I7iGX5Rzigk21D9X
	 Kgkc1LyYXKuteE968Qjx8JbOtjjFrA1a3f+nxMG0v5d648KEC1+KOnFuKz1SAAudZQ
	 HQYHHUkY2OhpBthIn4ZlOCiOOHI6jSiG6Ue0tpW6S0UgPUZZ3R2NB8064LEtMrwTcW
	 K0vfZ+3Eg+BnDJOzHQk19wSnfAXwmviX5KDNvOIIEW4CnapLYX43Bthz9fwf8naHsK
	 gd3R+bBnzMhplBYUsEs24rdqN1TndbthAUTRzCH1DZz0BhpjuA5W0j6qihQSrBnXca
	 iftK5BtuBSyCA==
Date: Wed, 10 Apr 2024 22:15:53 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] thermal/drivers/qcom: Remove some unused fields in
 struct qpnp_tm_chip
Message-ID: <h23clexblxinnqkrxtb7cngtq4eimt65vtcqaeavjglskp2o3y@ibdua6bug4y2>
References: <d1c3a3c455f485dae46290e3488daf1dcc1d355a.1712687589.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1c3a3c455f485dae46290e3488daf1dcc1d355a.1712687589.git.christophe.jaillet@wanadoo.fr>

On Tue, Apr 09, 2024 at 09:56:34PM +0200, Christophe JAILLET wrote:
> In "struct qpnp_tm_chip", the 'prev_stage' field is unused.
> Remove it.
> 
> Found with cppcheck, unusedStructMember.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
> Compile tested only.
> 
> Apparently, it has never been used. It is not a left-over from a
> refactoring.
> ---
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> index 78c5cfe6a0c0..3cd74f6cac8f 100644
> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -74,7 +74,6 @@ struct qpnp_tm_chip {
>  	long				temp;
>  	unsigned int			thresh;
>  	unsigned int			stage;
> -	unsigned int			prev_stage;
>  	unsigned int			base;
>  	/* protects .thresh, .stage and chip registers */
>  	struct mutex			lock;
> -- 
> 2.44.0
> 
> 

