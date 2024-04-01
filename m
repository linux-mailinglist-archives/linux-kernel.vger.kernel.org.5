Return-Path: <linux-kernel+bounces-126599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6447F893A39
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0476B1F22481
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15911CD3A;
	Mon,  1 Apr 2024 10:38:23 +0000 (UTC)
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE21CA80
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711967903; cv=none; b=EuLZNtOvZbynF8D4BSmZiIcy/kmuc4DsFnKpcHCO4/y0Uum2IrGAD293TBWEV+dw1/ewvSz+B+uhd3xEYwN8wejYimvYPZoiSWX4jvYb/N5qGZAa37oRPftClt7tXOqsYwk8XeOQmmFA6xY/X6/QjeJ4fRMNGqKVk68p38BiQBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711967903; c=relaxed/simple;
	bh=H7BslMtmEAho3K6c0yYeroJVhCd4s5RKvNp5WXCydPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNHf2gwPBHY5yHkKbOV2ry55TvgluTD/50ERRd2TD4srSmV7/JPp4Nl4TnaEChWIUUBc+KtZoTUWG3ft26IncKqJsMQELLU03iPYOu9e4G/fcEltMMkzS9cYuoxx2OG+f6HLB8UQYIib2mSrVqUeJx+StJPcuRgVrN7OmR9RXsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 57FC01F950;
	Mon,  1 Apr 2024 12:38:18 +0200 (CEST)
Date: Mon, 1 Apr 2024 12:38:17 +0200
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/mipi-dsi: add mipi_dsi_compression_mode_raw()
Message-ID: <cmevrewvs4ultfn5yeo2yqxt3eo7kpw2bt4sgeoirv7k5oske5@qv2niojixnuy>
References: <20240330-lg-sw43408-panel-v1-0-f5580fc9f2da@linaro.org>
 <20240330-lg-sw43408-panel-v1-2-f5580fc9f2da@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330-lg-sw43408-panel-v1-2-f5580fc9f2da@linaro.org>

On 2024-03-30 05:59:29, Dmitry Baryshkov wrote:
> The LG SW43408 panel requires sending non-standard data as a part of the
> MIPI_DSI_COMPRESSION_MODE packet. Rather than hacking existing
> mipi_dsi_compression_mode() add mipi_dsi_compression_mode_raw(), which
> accepts raw data buffer and length.

Even though I doubt the usefulness of this _raw() command before further
understanding the panel and driver (according the the review-followup sent a few
minutes ago), let me review this a little bit.

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 34 ++++++++++++++++++++++++++--------
>  include/drm/drm_mipi_dsi.h     |  1 +
>  2 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index ef6e416522f8..f340d1e0a9a5 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -645,29 +645,47 @@ int mipi_dsi_set_maximum_return_packet_size(struct mipi_dsi_device *dsi,
>  EXPORT_SYMBOL(mipi_dsi_set_maximum_return_packet_size);
>  
>  /**
> - * mipi_dsi_compression_mode() - enable/disable DSC on the peripheral
> + * mipi_dsi_compression_mode_raw() - control DSC on the peripheral
>   * @dsi: DSI peripheral device
> - * @enable: Whether to enable or disable the DSC
> + * @data: data to be sent to the device
> + * @len: size of the data buffer
>   *
> - * Enable or disable Display Stream Compression on the peripheral using the
> + * Control the Display Stream Compression on the peripheral using the

+ mode?

>   * default Picture Parameter Set and VESA DSC 1.1 algorithm.

This is no longer true.  Both the algoritm identifier and "default Picture
Parameter Set" (which I assume means table *index*!) are described by the
custom/raw bytes that one is allowed to pass.

In fact, in the SW43408 driver that you reference in the commit message the
custom data passed to the _raw() function is used to select the second PPS
table (unless the panel interprets the input data in a non-standard way...), and
further sets the PPS for the first table only :)

>   *
>   * Return: 0 on success or a negative error code on failure.
>   */
> -ssize_t mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
> +ssize_t mipi_dsi_compression_mode_raw(struct mipi_dsi_device *dsi, void *data, size_t len)
>  {
> -	/* Note: Needs updating for non-default PPS or algorithm */
> -	u8 tx[2] = { enable << 0, 0 };
>  	struct mipi_dsi_msg msg = {
>  		.channel = dsi->channel,
>  		.type = MIPI_DSI_COMPRESSION_MODE,
> -		.tx_len = sizeof(tx),
> -		.tx_buf = tx,
> +		.tx_len = len,
> +		.tx_buf = data,
>  	};
>  	int ret = mipi_dsi_device_transfer(dsi, &msg);
>  
>  	return (ret < 0) ? ret : 0;
>  }
> +EXPORT_SYMBOL(mipi_dsi_compression_mode_raw);
> +
> +/**
> + * mipi_dsi_compression_mode() - enable/disable DSC on the peripheral
> + * @dsi: DSI peripheral device
> + * @enable: Whether to enable or disable the DSC
> + *
> + * Enable or disable Display Stream Compression on the peripheral using the
> + * default Picture Parameter Set and VESA DSC 1.1 algorithm.

And while fixing this up, let's make it clear that this doesn't change the
PPS, just the *index* of which PPS to use (the PPS is updated with a different
command).

- Marijn

> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +ssize_t mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
> +{
> +	/* Note: Needs updating for non-default PPS or algorithm */
> +	u8 tx[2] = { enable << 0, 0 };
> +
> +	return mipi_dsi_compression_mode_raw(dsi, tx, sizeof(tx));
> +}
>  EXPORT_SYMBOL(mipi_dsi_compression_mode);
>  
>  /**
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index c0aec0d4d664..321d2b019687 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -242,6 +242,7 @@ int mipi_dsi_turn_on_peripheral(struct mipi_dsi_device *dsi);
>  int mipi_dsi_set_maximum_return_packet_size(struct mipi_dsi_device *dsi,
>  					    u16 value);
>  ssize_t mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable);
> +ssize_t mipi_dsi_compression_mode_raw(struct mipi_dsi_device *dsi, void *data, size_t len);
>  ssize_t mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
>  				       const struct drm_dsc_picture_parameter_set *pps);
>  
> 
> -- 
> 2.39.2
> 

