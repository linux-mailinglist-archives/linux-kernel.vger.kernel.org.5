Return-Path: <linux-kernel+bounces-145023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5939B8A4E54
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E681F21C86
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAF16A008;
	Mon, 15 Apr 2024 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRTtDkr0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464A679ED;
	Mon, 15 Apr 2024 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182564; cv=none; b=abihrJwNcZ5ZNVD3VKFNRyPFbiCRDrnIfTW+oMaRBAhRXwrjs2XtwpTkrqcKCbn7k6vqiijDKOaZSHrkCXCHIRonRlzbTHjBGMGQPXn7f3450jIqGpFFKiHYwTt2vsgzfjJjUu+v/Z/jELccyRqXwZDX+ytYkBfGHK6HPYuB9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182564; c=relaxed/simple;
	bh=NchaIwl0enMKrAZADevkzNL4pVQIaCSWH3SoIG+yOuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dn/jlgw0VgokqBgH+CE5ptpK2OWqw8GN8W9d0JXbHDQHlDyu2Ku1xcXNhQDhxve2gyrIAB2XIn8gBkyZiuw4n8gQESJvOhLMSSyofhofu2nMfq2n+W/+OUqS/A2D4Bo+28IpLFWoUWDn9mMEf5zGbunWkLnHXL50s1KIYHjLT9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRTtDkr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB75C2BD11;
	Mon, 15 Apr 2024 12:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713182563;
	bh=NchaIwl0enMKrAZADevkzNL4pVQIaCSWH3SoIG+yOuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mRTtDkr0BCzbP+RDDyHgfeVPUsM9Gi2YfaRdVU+mGIlC50ZY5PwPARWJuuwoEGovK
	 qJuIV1B1gLnkK7IKvSJqVKdd6eG93brhZeGjaDK+AoMaMVFkhC6p5uX4RdAexBioL1
	 Ook+NV9X0aJL1u91pE7/aLKhXxSpuxVzAHGPScXbfEFD44EWe8YdYkpWUGdPK2nZKM
	 VfWsdNhbgDYQeW8D/GxBNHKNCFBi3AtnjHq14GSlbP5yWcCAayZ5XwD/+HkuO9u+Lm
	 1yfn0tYg6mmGI/S6q4w00NjX7AItSA4kq6If2Bwm8QRt3e+yRMgbCz/mZjfQanyw+3
	 j073IdJlm/yRw==
Date: Mon, 15 Apr 2024 17:32:37 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: quic_jhugo@quicinc.com, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v3 2/3] bus: mhi: host: Add a new API for getting channel
 doorbell address
Message-ID: <20240415120237.GG7537@thinkpad>
References: <1713170945-44640-1-git-send-email-quic_qianyu@quicinc.com>
 <1713170945-44640-3-git-send-email-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1713170945-44640-3-git-send-email-quic_qianyu@quicinc.com>

On Mon, Apr 15, 2024 at 04:49:04PM +0800, Qiang Yu wrote:
> Some controllers may want to know the address of a certain doorbell. Hence
> add a new API where we read CHDBOFF register to get the base address of
> doorbell, so that the controller can calculate the address of the doorbell
> it wants by adding additional offset.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  drivers/bus/mhi/host/main.c | 17 +++++++++++++++++
>  include/linux/mhi.h         |  7 +++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index 15d657a..947b5ec 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -1691,3 +1691,20 @@ void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
>  	}
>  }
>  EXPORT_SYMBOL_GPL(mhi_unprepare_from_transfer);
> +
> +int mhi_get_channel_doorbell(struct mhi_controller *mhi_cntrl, u32 *chdb_offset)

s/mhi_get_channel_doorbell/mhi_get_channel_doorbell_offset

> +{
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	void __iomem *base = mhi_cntrl->regs;
> +	int ret;
> +
> +	/* Read channel db offset */

No need of this comment.

> +	ret = mhi_read_reg(mhi_cntrl, base, CHDBOFF, chdb_offset);
> +	if (ret) {
> +		dev_err(dev, "Unable to read CHDBOFF register\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}

Why can't you use this API in mhi_init_mmio()?

> +EXPORT_SYMBOL_GPL(mhi_get_channel_doorbell);
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index 8280545..1135142 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -816,4 +816,11 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
>   */
>  bool mhi_queue_is_full(struct mhi_device *mhi_dev, enum dma_data_direction dir);
>  
> +/**
> + * mhi_get_channel_doorbell - read channel doorbell offset register to get

'Get the channel doorbell offset'

> + *                            channel doorbell address
> + * @mhi_cntrl: MHI controller
> + * @chdb_offset: channel doorbell address

s/channel doorbell address/Channel doorbell offset

- Mani

-- 
மணிவண்ணன் சதாசிவம்

