Return-Path: <linux-kernel+bounces-86282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B9586C360
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F60C282D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70C94DA0D;
	Thu, 29 Feb 2024 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDIk5b6D"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDCB38397
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194949; cv=none; b=q/dXoXfrEeL5+JCG1xg0quF/rnS3Y2Lj7j6xm9ircyVMBkCy2BlctVcQqJMjBU/Ouno24pQ59Z675RgAe+RxqUUmhveO9StKa1YD4uL7gs74KVCnUZGUiLmGr1MistMA3vjPijGWjJInqyl1ewzFkoVUX4YRcXL0xNI4wozP7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194949; c=relaxed/simple;
	bh=m245v/zRS4b6XTfwgpcaxTLRx33S3I3vlQWYjrwvb0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/PwhqTt0buGRGkmWO+OvLeVTS8b6RP4USqE7Ts5ZB1mXw0xbc6WKID0VgN9cRmTDcwH6/dtdJ0FodcpDCLTRB3oHPrJkBswakjgMDQWNTZL3Uz8vmv4iL4ch+lpug0ATqY9pKcP3IttfCr39/hnh1YXtwwzQ/kn51a0u4TosMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rDIk5b6D; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc96f64c10so6570935ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709194947; x=1709799747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4kIsmcKhhflwhBbcpPfclRumN4oUdpHtr9LDaDVhg4=;
        b=rDIk5b6DqDAZ+y+vyt8oMNP2AyQkCx+KKMf5SXvvxotmHBK1hlsPeMvbzZ4Z26lCuJ
         Vnf2NP8uoTQVhRTSMertZzkqdtWD/KIVuDoKnOW/AfE4el1/6txA/cf736QzH++BNa3E
         E++E6IbJBsSlLartNvaGEXufJhYOwJ2MrEqzIux3pss6SDDJa9zbdq4BQ9XS3EpVCQqV
         i+Pq9xsZDLQXaH4pPCdfUXZPU7M+kw1i/SQ0ksNuDZ+IqUoX7pi74glfl+pgMTaJukYy
         c4xmb47WkBeumJ+TTi7+8Y6uwboIRMrZ75Ate/rzR8eWn6u7Oa05NKz8N8jwITNtFm/5
         5nLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709194947; x=1709799747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4kIsmcKhhflwhBbcpPfclRumN4oUdpHtr9LDaDVhg4=;
        b=JJl7BFnCdwsNaaCA0+CVRUiby7bqNxIzSzF1k415ebHDqb8qVrcwzuQMPwVpLPhxhU
         akIzjmRdEBR606RgSsOBJEVS3Gsa/Hq0D53gFXQXFe/VW7pXhF+4e3zvvFMLTSKmbau0
         H1HrZ/+pzILKBY83336FbWDly9QKT9MNsOEJEGDgnqsejGnhWqnse+ooBZoOgOmywZZ/
         p7Uw1qeLApkRoVA+mcjDa8qX3iLVsD6x01c4q9+0lzgwW/tqWvomM+9fnvXb67ehreR9
         TS62+7bqNRlzv1gHMARCeawYeoB3oMyX8kZJrIMWj7OuM0qVmUP6ai62r8Fwqq7KW5tr
         PmHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2Wd8jTtQWUK/LFkWT9uMU36KeLEKgbUzchs/O3ksnKyUVYL0cQ4Exr/Zomgok3YFBUxxnExqM4ZOP8Phl7Q/R0Ss/2ZqkOUd9R0nG
X-Gm-Message-State: AOJu0Ywlm3Pa8OfIzMg00ICWdMhY6RSgUe7Ix38X4qu/C1x3b7a1RtLw
	wv/37X63SC7jwQMdID4C8R5/+PXiT27JHliUWjqkjd5GUlQ9bnEa56Pwo4+mjlU=
X-Google-Smtp-Source: AGHT+IHS9mdIRgTsBalN5Wx8ktYN4NJOOVtV/1p04KbzhR6lJj4k4MXvv9tFHXgr2Fz52qa2YAdq6w==
X-Received: by 2002:a17:903:495:b0:1db:e089:745b with SMTP id jj21-20020a170903049500b001dbe089745bmr1322502plb.6.1709194946750;
        Thu, 29 Feb 2024 00:22:26 -0800 (PST)
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902b28500b001d6ee9d8957sm809965plr.281.2024.02.29.00.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 00:22:26 -0800 (PST)
Date: Thu, 29 Feb 2024 13:52:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [PATCH v1 3/3] virtio-spi: Add virtio SPI driver.
Message-ID: <20240229082224.2kh2scyjpielwx7v@vireshk-i7>
References: <20240228142755.4061-1-Harald.Mommer@opensynergy.com>
 <20240228142755.4061-4-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228142755.4061-4-Harald.Mommer@opensynergy.com>

On 28-02-24, 15:27, Harald Mommer wrote:
> +static int virtio_spi_probe(struct virtio_device *vdev)
> +{
> +	struct device_node *np = vdev->dev.parent->of_node;
> +	struct virtio_spi_priv *priv;
> +	struct spi_controller *ctrl;
> +	int err;
> +	u32 bus_num;
> +	u16 csi;
> +
> +	ctrl = devm_spi_alloc_host(&vdev->dev, sizeof(*priv));
> +	if (!ctrl) {
> +		dev_err(&vdev->dev, "Kernel memory exhausted in %s()\n",
> +			__func__);

The print can be dropped I guess.

> +		return -ENOMEM;
> +	}
> +
> +	priv = spi_controller_get_devdata(ctrl);
> +	priv->vdev = vdev;
> +	vdev->priv = priv;
> +	dev_set_drvdata(&vdev->dev, ctrl);
> +
> +	init_completion(&priv->spi_req.completion);
> +
> +	err = of_property_read_u32(np, "spi,bus-num", &bus_num);
> +	if (!err && bus_num <= S16_MAX)
> +		ctrl->bus_num = (s16)bus_num;
> +
> +	virtio_spi_read_config(vdev);
> +
> +	/* Method to do a single SPI transfer */

The comments for obvious statements are normally not required. There
are a couple of them here.

> +	ctrl->transfer_one = virtio_spi_transfer_one;
> +
> +	/* Initialize virtqueues */
> +	err = virtio_spi_find_vqs(priv);
> +	if (err) {
> +		dev_err(&vdev->dev, "Cannot setup virtqueues\n");

Maybe "Failed to" instead of "Cannot" ?

> +		return err;
> +	}
> +
> +	err = spi_register_controller(ctrl);
> +	if (err) {
> +		dev_err(&vdev->dev, "Cannot register controller\n");
> +		goto err_return;
> +	}
> +
> +	board_info.max_speed_hz = priv->max_freq_hz;
> +	/* spi_new_device() currently does not use bus_num but better set it */
> +	board_info.bus_num = (u16)ctrl->bus_num;
> +
> +	/* Add chip selects to controller */
> +	for (csi = 0; csi < ctrl->num_chipselect; csi++) {
> +		dev_dbg(&vdev->dev, "Setting up CS=%u\n", csi);
> +		board_info.chip_select = csi;

Maybe a blank line here.

> +		/* TODO: Discuss setting of board_info.mode */
> +		if (!(priv->mode_func_supported & VIRTIO_SPI_CS_HIGH))
> +			board_info.mode = SPI_MODE_0;
> +		else
> +			board_info.mode = SPI_MODE_0 | SPI_CS_HIGH;

and here to improve readability.

> +		if (!spi_new_device(ctrl, &board_info)) {
> +			dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
> +			spi_unregister_controller(ctrl);
> +			err = -ENODEV;
> +			goto err_return;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_return:
> +	vdev->config->del_vqs(vdev);
> +	return err;
> +}
> +
> +static void virtio_spi_remove(struct virtio_device *vdev)
> +{
> +	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
> +
> +	/* Order: 1.) unregister controller, 2.) remove virtqueue */

Not sure if this comment is required or not, since we don't add
similar ones while registering.

> +	spi_unregister_controller(ctrl);
> +	virtio_spi_del_vq(vdev);
> +}

Other than that.

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

