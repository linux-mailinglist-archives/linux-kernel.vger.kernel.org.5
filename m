Return-Path: <linux-kernel+bounces-74112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719E985D019
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4181F25323
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC9C3A1DA;
	Wed, 21 Feb 2024 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lcLgY0vB"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9C43A1D1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494417; cv=none; b=azAwEvdAwHtZhVY/Wn7CpKiS5BwcOo2NqnnHSb8aSr+Ud+ibukBn7QXXe1nhD6rUYjHFy99yw6Apg7ghpQ5NUGlzD1YyExEpImkKH73J7fv9ctRJtIg8ugfXO6M4ZvigE0typaSab2IPgEaWlgBTEGMCSZApgvpZm7cbg9E44Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494417; c=relaxed/simple;
	bh=EejifAIIIqlNGTe194ZrNgu7jwOUb/6ws5PuHJXFnDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j49gZXDP8WshNQsyDCx0g7PPoe2PJ5PgXNydesRhAeRWgzlv+8K7D0AFcaJrncMKOgosvIeVr1BGlPQT15CK8EaFvu/WthaZRas0z/0lxdhNCY44FDbeXMkXDGqYD+l+CrS/WUcJdy4o7iFljkWrPs4XqmQm57y/kWSsS9169Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lcLgY0vB; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c02adddb8eso159700b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708494414; x=1709099214; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hOHufyaUQg7qQ+PlVV++ODz0Os0md+bru9Bl+3Cp+VM=;
        b=lcLgY0vBAz7Bpi/JKoyYDQNJjlMsIKnnXSNALiZQ1+7Vqh4nj7n9HWtxAgtgDt//E+
         K+iD69rcGnNiRFgeDe+81F/n/gkLg6nnZMGdqi2Vi0qZ8WtcsthAhfmxQoR7u6+dR04B
         ZdlVfk7WO3CkDujR7K+sQ1RPVwtF7LYdPOR4ZT3kjFKTf017Dl9NmRJ5GBwNkktgP6KQ
         drqytBHDS9kMGCsoTTorhExCbmZlML9anxj63pnw+ks/8dkEBtuA3rDJvHmojY6CRgwh
         SgaMSOXL9iIKsqbaECxLm7H8Fazog1Z+NVFoEcIIv4Lc3Y9c8ddoMFK+83qWfyCWwCt6
         zEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708494414; x=1709099214;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOHufyaUQg7qQ+PlVV++ODz0Os0md+bru9Bl+3Cp+VM=;
        b=CNrhXUyuFsxwNUBkqnu15DhqhgG/hJv59On/FqGDerx49dTME5KShmeqc20QZaQotB
         gRJCwraqjO5HnzqGw7qWD/8nRyWmn0gXREMoCpaF/LYuBtXdaOtpo/HZLepTLHxoAw5s
         GHMS6pH9hD27kdaANMTq0WBgbiBXqGIAdxM5pVQCBkq6Ma45SKs5Jpjd8ikgbR3qUF2c
         B7Up2jn3hTZTWXXR8aiYQfu4vq4sE6u6ObOUb+1qbS9jhR8w/TWwpKnQiR/LOMG8ZSHn
         y3SG7tykREPq/qZjrN72mNRznURG7s8uOxR5tM0s+FkWzsSIh9b2H6jmwMIv/QrvozbW
         9KzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1g/2NQBNVQiD6kSnVi9+e3p9YQmbdg6VZZ2Z6FhOcvIgasGlaJINq7aKMvRdqipuuDomayLPT1OswkC5Xr3zNQyktAhu82E1xxQVF
X-Gm-Message-State: AOJu0YyOmVVvIv8CnU6Kwn7agZmi7e3dUo1MRgqsbLqZJibv6fh6k4P/
	Gwg1S1v1F8MGkmVHfHOsrnYHtkd6neLojPXp5djVRYJT+RdBkxQubdi0lpqtqoYYK5FD0iqPSiw
	=
X-Google-Smtp-Source: AGHT+IEtzxtZGC9mTzPgKJvrxQsLwBKQDo/HWMA8YLvnxJue2+Wz88g07Itfl/gdFlMl2lPsEib/Rw==
X-Received: by 2002:a05:6808:1907:b0:3c0:408f:2098 with SMTP id bf7-20020a056808190700b003c0408f2098mr24972063oib.24.1708494414424;
        Tue, 20 Feb 2024 21:46:54 -0800 (PST)
Received: from thinkpad ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79a50000000b006e471ade144sm3731002pfj.188.2024.02.20.21.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 21:46:54 -0800 (PST)
Date: Wed, 21 Feb 2024 11:16:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "bus: mhi: core: Add support for reading MHI info
 from device"
Message-ID: <20240221054648.GD11693@thinkpad>
References: <20240219180748.1591527-1-quic_jhugo@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219180748.1591527-1-quic_jhugo@quicinc.com>

On Mon, Feb 19, 2024 at 11:07:48AM -0700, Jeffrey Hugo wrote:
> This reverts commit 3316ab2b45f6bf4797d8d65b22fda3cc13318890.
> 
> The MHI spec owner pointed out that the SOC_HW_VERSION register is part
> of the BHIe segment, and only valid on devices which implement BHIe.
> Only a small subset of MHI devices implement BHIe so blindly accessing
> the register for all devices is not correct. Also, since the BHIe
> segment offset is not used when accessing the register, any
> implementation which moves the BHIe segment will result in accessing
> some other register.  We've seen that accessing this register on AIC100
> which does not support BHIe can result in initialization failures.
> 
> We could try to put checks into the code to address these issues, but in
> the roughly 4 years this functionality has existed, no one has used it.
> Easier to drop this dead code and address the issues if anyone comes up
> with a real world use for it.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/bus/mhi/host/init.c     | 12 ------------
>  drivers/bus/mhi/host/internal.h |  6 ------
>  include/linux/mhi.h             | 17 -----------------
>  3 files changed, 35 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 944da46e6f11..44f934981de8 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -914,7 +914,6 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>  	struct mhi_chan *mhi_chan;
>  	struct mhi_cmd *mhi_cmd;
>  	struct mhi_device *mhi_dev;
> -	u32 soc_info;
>  	int ret, i;
>  
>  	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->regs ||
> @@ -989,17 +988,6 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>  		mhi_cntrl->unmap_single = mhi_unmap_single_no_bb;
>  	}
>  
> -	/* Read the MHI device info */
> -	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs,
> -			   SOC_HW_VERSION_OFFS, &soc_info);
> -	if (ret)
> -		goto err_destroy_wq;
> -
> -	mhi_cntrl->family_number = FIELD_GET(SOC_HW_VERSION_FAM_NUM_BMSK, soc_info);
> -	mhi_cntrl->device_number = FIELD_GET(SOC_HW_VERSION_DEV_NUM_BMSK, soc_info);
> -	mhi_cntrl->major_version = FIELD_GET(SOC_HW_VERSION_MAJOR_VER_BMSK, soc_info);
> -	mhi_cntrl->minor_version = FIELD_GET(SOC_HW_VERSION_MINOR_VER_BMSK, soc_info);
> -
>  	mhi_cntrl->index = ida_alloc(&mhi_controller_ida, GFP_KERNEL);
>  	if (mhi_cntrl->index < 0) {
>  		ret = mhi_cntrl->index;
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index 091244cf17c6..5fe49311b8eb 100644
> --- a/drivers/bus/mhi/host/internal.h
> +++ b/drivers/bus/mhi/host/internal.h
> @@ -15,12 +15,6 @@ extern struct bus_type mhi_bus_type;
>  #define MHI_SOC_RESET_REQ_OFFSET			0xb0
>  #define MHI_SOC_RESET_REQ				BIT(0)
>  
> -#define SOC_HW_VERSION_OFFS				0x224
> -#define SOC_HW_VERSION_FAM_NUM_BMSK			GENMASK(31, 28)
> -#define SOC_HW_VERSION_DEV_NUM_BMSK			GENMASK(27, 16)
> -#define SOC_HW_VERSION_MAJOR_VER_BMSK			GENMASK(15, 8)
> -#define SOC_HW_VERSION_MINOR_VER_BMSK			GENMASK(7, 0)
> -
>  struct mhi_ctxt {
>  	struct mhi_event_ctxt *er_ctxt;
>  	struct mhi_chan_ctxt *chan_ctxt;
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index 474d32cb0520..77b8c0a26674 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -320,10 +320,6 @@ struct mhi_controller_config {
>   * @hw_ev_rings: Number of hardware event rings
>   * @sw_ev_rings: Number of software event rings
>   * @nr_irqs: Number of IRQ allocated by bus master (required)
> - * @family_number: MHI controller family number
> - * @device_number: MHI controller device number
> - * @major_version: MHI controller major revision number
> - * @minor_version: MHI controller minor revision number
>   * @serial_number: MHI controller serial number obtained from BHI
>   * @mhi_event: MHI event ring configurations table
>   * @mhi_cmd: MHI command ring configurations table
> @@ -368,15 +364,6 @@ struct mhi_controller_config {
>   * Fields marked as (required) need to be populated by the controller driver
>   * before calling mhi_register_controller(). For the fields marked as (optional)
>   * they can be populated depending on the usecase.
> - *
> - * The following fields are present for the purpose of implementing any device
> - * specific quirks or customizations for specific MHI revisions used in device
> - * by the controller drivers. The MHI stack will just populate these fields
> - * during mhi_register_controller():
> - *  family_number
> - *  device_number
> - *  major_version
> - *  minor_version
>   */
>  struct mhi_controller {
>  	struct device *cntrl_dev;
> @@ -407,10 +394,6 @@ struct mhi_controller {
>  	u32 hw_ev_rings;
>  	u32 sw_ev_rings;
>  	u32 nr_irqs;
> -	u32 family_number;
> -	u32 device_number;
> -	u32 major_version;
> -	u32 minor_version;
>  	u32 serial_number;
>  
>  	struct mhi_event *mhi_event;
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

