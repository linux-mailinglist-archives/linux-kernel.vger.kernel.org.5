Return-Path: <linux-kernel+bounces-89565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 027F686F21E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75391F21DEC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09333FE5B;
	Sat,  2 Mar 2024 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VazmT78Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2607182CA;
	Sat,  2 Mar 2024 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709407412; cv=none; b=PKfaiRcJupVY6ySDsBTQ/iBGZ8xpTxRsGQuiApR/AtHX2xM3e0pcv3RQnjXE6tNdl2xxMDuBmZsyEDO4pKdmSrEJFVPiVM3rEjkYU4Wy8GSjBuV4FlS2xUT0W0XGAYEVv6OAQufXkHblRzx1/KAc46SY6z8N1XD1zhJHSaV0R7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709407412; c=relaxed/simple;
	bh=8jSw52uXjV4fw2ydJjEpV5D5UyF/AePP07C1rTZG3iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xpnev721EFcW2xQ5HvOf7DcqRhr1i7VVXdeC8NBckMhS2C7NehHNHoBnuDwNCnAdXdHHMVwWjT5NKC2LlxGeSoUX2yCJq4ul1i6NcFtaUAPcPktO9vkfXqMQjONXjsExHGmnml44KJkjtGUeu17eHax0TbqHUB8R4s3BngFYl8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VazmT78Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEFAC433C7;
	Sat,  2 Mar 2024 19:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709407412;
	bh=8jSw52uXjV4fw2ydJjEpV5D5UyF/AePP07C1rTZG3iI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VazmT78QFfRnBeDbPXyLF/BWMr928o9g3aSl++R5Iv6TCjlj2wOx4DOE1GAQy6UiH
	 UoQ6CSJtrf3kO+5/yHjMuEe2/PVm/Uh4JzBwvchiqcKxGUtSCR+Bxou/oNep8jmRY8
	 OdpIVcdXqy0vincsc4ka8egE6hGxSP8FYwKAxCbAr+5npL5LrFcZfiYp6pG7wKU/sr
	 Y+1sGg7OOKpvSp2ZLUrGMSdkEfq4XE2XdZhhvpsVOIk7eqtsB3GfWS1IW++8g7v5Rq
	 WVa68VTUwYSr1yL6Q6wMtbK4Bzg1z+kjmdrSmB6YhIS/xIpu1Z3BQSAbKwpMm1Miv8
	 kNaYMhDVVwCCw==
Date: Sat, 2 Mar 2024 13:23:29 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linus.walleij@linaro.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v12 9/9] firmware: scm: Remove redundant scm argument
 from qcom_scm_waitq_wakeup()
Message-ID: <xeijmkykwsdk2x2g425ljowiuh4t46qicwxasmedqrt4iejfju@7mfkjubfiehl>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
 <20240227155308.18395-10-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227155308.18395-10-quic_mojha@quicinc.com>

On Tue, Feb 27, 2024 at 09:23:08PM +0530, Mukesh Ojha wrote:
> Remove unused scm argument from qcom_scm_waitq_wakeup().

Is it unused or redundant? Please pick on word (the right one ;))

Regards,
Bjorn

> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index a1dce417e6ec..d91f5872e003 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1853,7 +1853,7 @@ int qcom_scm_wait_for_wq_completion(u32 wq_ctx)
>  	return 0;
>  }
>  
> -static int qcom_scm_waitq_wakeup(struct qcom_scm *scm, unsigned int wq_ctx)
> +static int qcom_scm_waitq_wakeup(unsigned int wq_ctx)
>  {
>  	int ret;
>  
> @@ -1885,7 +1885,7 @@ static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
>  			goto out;
>  		}
>  
> -		ret = qcom_scm_waitq_wakeup(scm, wq_ctx);
> +		ret = qcom_scm_waitq_wakeup(wq_ctx);
>  		if (ret)
>  			goto out;
>  	} while (more_pending);
> -- 
> 2.43.0.254.ga26002b62827
> 

