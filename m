Return-Path: <linux-kernel+bounces-36631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9998B83A40F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157171F217DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A77717566;
	Wed, 24 Jan 2024 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eb5fDZ/D"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CBF1774E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084562; cv=none; b=M0KdhEm3Man6v2Dt5Vx8RGwGhwVQAUCByaKsBHyTq8mwH/iVx+WapsCe/usP8qW0r82KuXj+RLbnSFK+sWdwe2r8WFtp/9QiOyHb+JN3moS8kHafs+0wkR9Y0e/eBP+IQnafpotmP4+3yrExQ2po0MQiAu4kl9X3Nq4Ev/HvRJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084562; c=relaxed/simple;
	bh=GwYYyIKHpPbisEwWC6WETTohGHFFDsZNlW29Ta37IRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQ20xxMV2Adf+tvVg5kI++x3WGoP3ePWmFxx8UwfWPUb2V/kcYZR8pPsS5Okh+hru+9f6hgbLX2cj1lb7fJCmACvVv8NFo4eXu8fYD/nnEFGifpLpMaeikfseUKY8i+1KHU1dFeoNHmh9L+Bb325PlxujjB6Rio+z0fZR43QNFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eb5fDZ/D; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so633452a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706084559; x=1706689359; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xHnMGTip0k5WQr/ocF61LjVmzrROreb8ZXQsvgEPM10=;
        b=eb5fDZ/DgdxAvh1qiMCYwQGoY6EeTDznvXpToqOE4i37MCsStZSxiCXJQI/HS8RAnm
         Pc+dNHBYCkxk2DnCezCoN9zhqg383U67VurebYOiWc3t2cFsOI5OHOClRL2SUmIWet+L
         OmbglyBreoy0XfwKP++GRtkL5+Rkqy1hD92/VKYA7OnWEzxNxEAGQuv3cwskmqkRWtFB
         4PSzz4Vxom9bJnOWSeeuHplf4sS/mJSDMrbi/5UXgBveCZXA612iug/a/rZ0r1pPKtMs
         nua1kkaZV5uMtqEaBoYFhfjjPNo7epf2xSrEY8WavA1Ak/9squqi9KGooAHaIf/ewOSL
         afOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706084559; x=1706689359;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHnMGTip0k5WQr/ocF61LjVmzrROreb8ZXQsvgEPM10=;
        b=usSLnzno6vTJC14xNNy/KeXlWLJO2WRvESPFEakxR18lS2tyXIUdRbyvinZZ1s3Cf3
         L4LfyHkrRagnGaR/V8BYXZZMaEaVNEs3tN1hwwFxb9VUgBhl1oSqjacAQsvL3okREVdX
         f68lN3PPtuV3WlYpBVkG7DwwQ8sFT02KeWz0Ydhr7QH9ezGnOfGM3GRmQzUjfPVxD1bn
         UT4ypiOJIOnNld8z8qxsgIgLc6LC6w/jrU1YQU23seQJ5m/srIoXCNOtaWMywzn0H23U
         dc+t3QGtf9UgWhE4+pMPO0M7rYMRBaJIuBz08R0jHqmvwLG9UHFX4pGy/DSkG2H6YrbY
         CPkg==
X-Gm-Message-State: AOJu0YwfU+D4EvgaX5z7HI0q86LsiJ5Yzvo62TAQauY4ydiPJg2mmKkx
	5hZBKSUyMr841GFYEz9/1Srern+B7RtLzArorSApdVB95UpY6blSQIlRt6hJYQ==
X-Google-Smtp-Source: AGHT+IFYijfZfQJRYeJr90+4Q5xmMq6ccGYCRmITy1K5PGzM1guUVEdm+Q1tNA1zYNMr19HRhkaD0g==
X-Received: by 2002:a05:6a20:6115:b0:19c:32cf:8ff2 with SMTP id m21-20020a056a20611500b0019c32cf8ff2mr273690pzb.79.1706084559474;
        Wed, 24 Jan 2024 00:22:39 -0800 (PST)
Received: from thinkpad ([117.217.189.109])
        by smtp.gmail.com with ESMTPSA id z66-20020a626545000000b006dbe6eba197sm4768321pfb.217.2024.01.24.00.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:22:39 -0800 (PST)
Date: Wed, 24 Jan 2024 13:52:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	Can Guo <quic_cang@quicinc.com>,
	Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: Re: [PATCH V1 1/2] scsi: ufs: qcom : Refactor phy_power_on/off calls
Message-ID: <20240124082231.GA4906@thinkpad>
References: <20240112153348.2778-1-quic_nitirawa@quicinc.com>
 <20240112153348.2778-2-quic_nitirawa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240112153348.2778-2-quic_nitirawa@quicinc.com>

On Fri, Jan 12, 2024 at 09:03:47PM +0530, Nitin Rawat wrote:
> Commit 3f6d1767b1a0 ("phy: ufs-qcom: Refactor all init steps into
> phy_poweron") removes the phy_power_on/off from ufs_qcom_setup_clocks

s/removes/moved

> to suspend/resume func.
> 
> To have a better power saving, remove the phy_power_on/off calls from
> resume/suspend path and put them back to ufs_qcom_setup_clocks, so that
> PHY's regulators & clks can be turned on/off along with UFS's clocks.
> 
> Since phy phy_power_on is separated out from phy calibrate, make
> separate calls to phy_power_on and phy_calibrate calls from ufs qcom
> driver.
> 

Above change should be in a separate patch.

> Also add a mutex lock to protect the usage of is_phy_pwr_on against
> possible racing.
> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 104 +++++++++++++++++++++++-------------
>  drivers/ufs/host/ufs-qcom.h |   4 ++
>  2 files changed, 72 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 39eef470f8fa..2721a30f0db8 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -338,6 +338,46 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba)
>  	return UFS_HS_G3;
>  }
> 
> +static int ufs_qcom_phy_power_on(struct ufs_hba *hba)
> +{
> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +	struct phy *phy = host->generic_phy;
> +	int ret = 0;
> +
> +	mutex_lock(&host->phy_mutex);

You do not need mutex to protect a variable. If you want to ensure that the
access to the flag is atomic, you can use test_and_{set/clear}_bit helpers.

> +	if (!host->is_phy_pwr_on) {
> +		ret = phy_power_on(phy);
> +		if (ret) {
> +			mutex_unlock(&host->phy_mutex);
> +			return ret;
> +		}
> +		host->is_phy_pwr_on = true;
> +	}
> +	mutex_unlock(&host->phy_mutex);
> +
> +	return ret;
> +}
> +
> +static int ufs_qcom_phy_power_off(struct ufs_hba *hba)
> +{
> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +	struct phy *phy = host->generic_phy;
> +	int ret = 0;
> +
> +	mutex_lock(&host->phy_mutex);
> +	if (host->is_phy_pwr_on) {
> +		ret = phy_power_off(phy);
> +		if (ret) {
> +			mutex_unlock(&host->phy_mutex);
> +			return ret;
> +		}
> +		host->is_phy_pwr_on = false;
> +	}
> +	mutex_unlock(&host->phy_mutex);
> +
> +	return ret;
> +}
> +
>  static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> @@ -378,13 +418,18 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  		goto out_disable_phy;
> 
>  	/* power on phy - start serdes and phy's power and clocks */
> -	ret = phy_power_on(phy);
> +	ret = ufs_qcom_phy_power_on(hba);
>  	if (ret) {
>  		dev_err(hba->dev, "%s: phy power on failed, ret = %d\n",
>  			__func__, ret);
>  		goto out_disable_phy;
>  	}
> 
> +	ret = phy_calibrate(phy);
> +	if (ret) {
> +		dev_err(hba->dev, "%s: Failed to calibrate PHY %d\n",
> +				  __func__, ret);

Even though the driver already has a lot of "__func__" to print the function
names in error log, please do not add more. I will get rid of the existing ones
at some point.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

