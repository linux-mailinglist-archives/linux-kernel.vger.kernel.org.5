Return-Path: <linux-kernel+bounces-74118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B1285D028
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC422865E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEBB39FE9;
	Wed, 21 Feb 2024 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="THHZ/f4z"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C605139FC4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494796; cv=none; b=RfQooXhCeHj2TN5nNWaTnMrx99XBXxrdkTXo1hqokuCkNKkdkNdVi+uuk/75gadOfN5yC5noxhZPpVWAsyp1ZvN1Qh2are2YuqHRYoDVFBaY1ArZ7cR2ieFvL2CmTLZIO2+PKYNo0QlhtUALxfcKKsF6xCWa+nreyPdXHjm4Hnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494796; c=relaxed/simple;
	bh=VGwYTx7Gi5TTVoTRuqmNpO3DNZJwHqE4ELe/KeP5rZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDTuvqZRPGWm22iTeERQf7GYmyTuw92AgNLORy3lcBePReGc7YSBZQx50BG51yn4jifREJztTaiyYasWxetJ20PiQ4OTASJig9ZN35x1LapA1osGu+7XKVwtOHSVJbwBGl67LexyK7pyjaSVFGklLQ3CoBM7Jaqt8NlI8yeAnBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=THHZ/f4z; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so26347615ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708494794; x=1709099594; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7oLdmw7yJp/G7d6boWdv4H/Pf9LYOiQe2zk/LSJDUI8=;
        b=THHZ/f4z8HP/JRejkaipRp7keAbbnc0CJkRyTQFoM7lDly6CsNmpI121YACp+HfYuC
         KR59jo8EHghfE+28kH/1KCqXZPKABy/M6sUWD4zTbJF2ddH5BidgEsvYn/T57GXgvQz8
         hJHXYOqSmeONxGSNnhV2Hn/5jxV3bI4S5ffZMRC5aCpTGKylNxL2cPx07QJOq8B/Ufkg
         OU+dedI+Qmi6O6e0seHRkkCDiQxl2rzpKVaarAtRx9DzDzScflCCpaC3N+slVozb9kL+
         XwTh59BLfxlqnGlaIA+Fibu2H1k7xtnemow7eAia0wmghLPA9Xopdr4dnyFF8XDSTi6P
         iCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708494794; x=1709099594;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7oLdmw7yJp/G7d6boWdv4H/Pf9LYOiQe2zk/LSJDUI8=;
        b=gxGrq3Vcn6miU+gbdpHb2txC9urUEih9XSsT0jKcsFiQvmPwH/7wkEg3T8Qpv33eCW
         0w8Xxah9X1wGd1Pn1Th0D/0Ba7rPT6SFw1ogksV5OZx7BZivyKJaj8OwPgLTyS7gap9q
         cD5N+u2Gw0pG+DU5fEq3Q3FQzuLSRI5JGKJNrEREjuHuS86w3EabD2ei2FIYFHzUHeM6
         wX95zGBP1tb6FnZyeGSl1DZPt9u89z488qNMjZcCoQPsTi/RxnosVzqyzFMerL2T3590
         OphcUF8punQqs5D888rE0obpHN0/nIAN8XsVKaHtylmLgL1f7jQCYKoKyfNJ4CTUVUWo
         pUxg==
X-Forwarded-Encrypted: i=1; AJvYcCVcIf1wkPucTlRwXMzxeQzLQv3V/19akWNq4EDAQ7Bj1Eh0F0c98KqZm37SFqXr2V1X6TK0P7zvXx6TJgfUiyqDAdvKNezuP78MydRo
X-Gm-Message-State: AOJu0Yy1jZiMSGkgIdrsnLndw9FCSfhdxf4GdMMn4IIZRuVtgdPtUsYr
	NoUcb7pMm5Wi5HauDcyP6GyXFJgKdzLuCBlYUY0z47Usnm2o+O/XuuvPNX+a6xnGiWqmhv9mpU0
	=
X-Google-Smtp-Source: AGHT+IF243omxbLHF6WsbFCoQ9WU8t84wuLHWYp+nKkFV1c1FGBcwW3iFQfcLEwQtRXhgdOkDJf8Ag==
X-Received: by 2002:a17:902:ce85:b0:1db:d120:5cda with SMTP id f5-20020a170902ce8500b001dbd1205cdamr11644030plg.11.1708494794091;
        Tue, 20 Feb 2024 21:53:14 -0800 (PST)
Received: from thinkpad ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id d10-20020a170903208a00b001d8be6d1ec4sm7225867plc.39.2024.02.20.21.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 21:53:13 -0800 (PST)
Date: Wed, 21 Feb 2024 11:23:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "bus: mhi: core: Add support for reading MHI info
 from device"
Message-ID: <20240221055308.GE11693@thinkpad>
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

Applied to mhi-next!

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

