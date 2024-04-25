Return-Path: <linux-kernel+bounces-158626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 095E38B2335
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54366B22BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10285149E0A;
	Thu, 25 Apr 2024 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWxqf85T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502DF149DF0;
	Thu, 25 Apr 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053317; cv=none; b=DykYE5xWhwK9UuZpOO+qFo8FJqYPJRDkd3Iwtc4RJhWR0DcTwvalkLCpy24pV0C6LgHlQYNwaBRwI3NBBsh+5NvFu+VTi+o6Fju2hjNty3a7xOl+1IhG2lRM4zoobFMiWrpbngVbtL9dt6eVwHlg+wtp6yPbfl3obCst0RfVY+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053317; c=relaxed/simple;
	bh=rGX1kGwneL3/PGdNllq2QBsrGpesZjG2VX8TcFm1Z98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohvPJURszg2InnAyCqfbCdF3/RnjjDV8BOFOAgqUssZ1k+MhnzDE5WnJrS4a0EB6xtTBXo+IvGhDGZHepHOlzz0XyvDldBFz3iN+gdykgRRxZ2kqY13pcB6GuS4P5jECIuWSUa4u5FkC6DWVBoc0TW7o3UpV3cDDNrnWGgL57cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWxqf85T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934B3C113CC;
	Thu, 25 Apr 2024 13:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714053316;
	bh=rGX1kGwneL3/PGdNllq2QBsrGpesZjG2VX8TcFm1Z98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWxqf85TcYDGftbtM/0Kcfk4fmo4CNjwsPYu0PmuWTKny7o+fl3+c/jjaGuSvSufV
	 aIh7134gn8pDD7fKtawkIwmH1rCYasAe082OCPdQkQSFnvkzQOi862di9oCWMxLmSk
	 360yfty/bLN0il0y9l5OGeCym944lJNNBkUspV5+nVJMxiTZHdo39UnrZbsiUNvocP
	 PquJHAC0ne/XjmytX5y3WE3qAYcOB4ZxU2BTa6mqsxv7Q9pSTE+usogLueNQrE+PeP
	 kmNzXub6BLMpNH4Jetkw/HuQ1hmFRGDVqa3MxFZxrbrvpCH+H0yTfXsAVd8OBx+AED
	 rV0RBRqu1yQSA==
Date: Thu, 25 Apr 2024 19:25:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: quic_jhugo@quicinc.com, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v4 2/3] bus: mhi: host: Add a new API for getting channel
 doorbell address
Message-ID: <20240425135506.GF3449@thinkpad>
References: <1713868417-37856-1-git-send-email-quic_qianyu@quicinc.com>
 <1713868417-37856-3-git-send-email-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1713868417-37856-3-git-send-email-quic_qianyu@quicinc.com>

On Tue, Apr 23, 2024 at 06:33:36PM +0800, Qiang Yu wrote:
> Some controllers may want to know the address of a certain doorbell. Hence
> add a new API where we read CHDBOFF register to get the base address of
> doorbell, so that the controller can calculate the address of the doorbell
> it wants by adding additional offset.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

One nitpick below. But I'll fix it.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
>  drivers/bus/mhi/host/init.c |  6 ++----
>  drivers/bus/mhi/host/main.c | 16 ++++++++++++++++
>  include/linux/mhi.h         |  6 ++++++
>  3 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 7104c18..6e0fa79 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -541,11 +541,9 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>  	dev_dbg(dev, "Initializing MHI registers\n");
>  
>  	/* Read channel db offset */
> -	ret = mhi_read_reg(mhi_cntrl, base, CHDBOFF, &val);
> -	if (ret) {
> -		dev_err(dev, "Unable to read CHDBOFF register\n");
> +	ret = mhi_get_channel_doorbell_offset(mhi_cntrl, &val);
> +	if (ret)
>  		return -EIO;

	return ret;

- Mani

> -	}
>  
>  	if (val >= mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB)) {
>  		dev_err(dev, "CHDB offset: 0x%x is out of range: 0x%zx\n",
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index 15d657a..4de7567 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -1691,3 +1691,19 @@ void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
>  	}
>  }
>  EXPORT_SYMBOL_GPL(mhi_unprepare_from_transfer);
> +
> +int mhi_get_channel_doorbell_offset(struct mhi_controller *mhi_cntrl, u32 *chdb_offset)
> +{
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	void __iomem *base = mhi_cntrl->regs;
> +	int ret;
> +
> +	ret = mhi_read_reg(mhi_cntrl, base, CHDBOFF, chdb_offset);
> +	if (ret) {
> +		dev_err(dev, "Unable to read CHDBOFF register\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mhi_get_channel_doorbell_offset);
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index d968e1a..cb3b676 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -816,4 +816,10 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
>   */
>  bool mhi_queue_is_full(struct mhi_device *mhi_dev, enum dma_data_direction dir);
>  
> +/**
> + * mhi_get_channel_doorbell_offset - Get the channel doorbell offset
> + * @mhi_cntrl: MHI controller
> + * @chdb_offset: Channel doorbell offset
> + */
> +int mhi_get_channel_doorbell_offset(struct mhi_controller *mhi_cntrl, u32 *chdb_offset);
>  #endif /* _MHI_H_ */
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

