Return-Path: <linux-kernel+bounces-128706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3ED895E73
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0A51F23C04
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CC515E218;
	Tue,  2 Apr 2024 21:09:35 +0000 (UTC)
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF079DD4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 21:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092175; cv=none; b=SdbaJHne3D996DSD3SSW51fHfgCchvT9PHakGH/JZxK0ovyJO8eZ9f455OrdiqUOY6r7AYbfNipMhqC0n5dO1+B5XDZkFCT05rudfNKQwiIbigv4iOvadAKl6Ae0f0ZHnRPSXj5oOSUVkcdDTqt2OKPrerYHgBiSiXnevPdKbAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092175; c=relaxed/simple;
	bh=EOJFldhFJH635Qqc1irTWwT+rLVHQgHvJvxPJ5C6Zq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwMHoGf4CWmAzv6uk33eXfsM467+JRmr4qGeBReO7V717BywmzCqA/oFCebm4zpy9hFroDN7r0kpI3hDvQFlrvzYu7CrMnlX8/PIrCEeRILRpjt2iRN61pUL3HVhFCAjVUc9rsOU0LMyrE5BEMNjWgi4mQq9VQChEfjgLzxRcAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 1579C202FC;
	Tue,  2 Apr 2024 23:09:31 +0200 (CEST)
Date: Tue, 2 Apr 2024 23:09:29 +0200
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
Subject: Re: [PATCH v3 3/4] drm/mipi-dsi: add mipi_dsi_compression_mode_ext()
Message-ID: <dgvztw55cr4wsbfxhf4ondzhaetodfcv4pndfug73suae5vp3v@4ozlmmsemfbm>
References: <20240402-lg-sw43408-panel-v3-0-144f17a11a56@linaro.org>
 <20240402-lg-sw43408-panel-v3-3-144f17a11a56@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402-lg-sw43408-panel-v3-3-144f17a11a56@linaro.org>

On 2024-04-02 02:51:14, Dmitry Baryshkov wrote:
> Add the extended version of mipi_dsi_compression_mode(). It provides
> a way to specify the algorithm and PPS selector.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 33 +++++++++++++++++++++++++++------
>  include/drm/drm_mipi_dsi.h     |  9 +++++++++
>  2 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index 9874ff6d4718..0ecbc811eb7a 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -645,19 +645,24 @@ int mipi_dsi_set_maximum_return_packet_size(struct mipi_dsi_device *dsi,
>  EXPORT_SYMBOL(mipi_dsi_set_maximum_return_packet_size);
>  
>  /**
> - * mipi_dsi_compression_mode() - enable/disable DSC on the peripheral
> + * mipi_dsi_compression_mode_ext() - enable/disable DSC on the peripheral
>   * @dsi: DSI peripheral device
>   * @enable: Whether to enable or disable the DSC
> + * @algo: Selected algorithm
> + * @pps_selector: The PPS selector

Not a big fan of paraphrasing the parameter name, it adds no value.  How about
describing what this parameter means and what it does?:

	PPS table index to use.  Corresponds to a table pre-programmed on the peripheral
	or a table programmed with &drm_dsc_picture_parameter_set.pps_identifier.

(That should be a valid kernel-doc cross-reference to the field)

>   *
> - * Enable or disable Display Stream Compression on the peripheral using the
> - * default Picture Parameter Set and VESA DSC 1.1 algorithm.
> + * Enable or disable Display Stream Compression on the peripheral.
>   *
>   * Return: 0 on success or a negative error code on failure.
>   */
> -int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
> +int mipi_dsi_compression_mode_ext(struct mipi_dsi_device *dsi, bool enable,
> +				  enum mipi_dsi_compression_algo algo,
> +				  unsigned int pps_selector)
>  {
> -	/* Note: Needs updating for non-default PPS or algorithm */
> -	u8 tx[2] = { enable << 0, 0 };
> +	u8 data = (enable << 0) |
> +		(algo << 1) |
> +		(pps_selector << 4);

Do we need some size validation (if > 3 return -EINVAL)?  FIELD_PREP() might be
too heavy though.

> +	u8 tx[2] = { data, 0 };
>  	struct mipi_dsi_msg msg = {
>  		.channel = dsi->channel,
>  		.type = MIPI_DSI_COMPRESSION_MODE,
> @@ -668,6 +673,22 @@ int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
>  
>  	return (ret < 0) ? ret : 0;
>  }
> +EXPORT_SYMBOL(mipi_dsi_compression_mode_ext);
> +
> +/**
> + * mipi_dsi_compression_mode() - enable/disable DSC on the peripheral
> + * @dsi: DSI peripheral device
> + * @enable: Whether to enable or disable the DSC
> + *
> + * Enable or disable Display Stream Compression on the peripheral using the
> + * default Picture Parameter Set and VESA DSC 1.1 algorithm.
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
> +{
> +	return mipi_dsi_compression_mode_ext(dsi, enable, 0, MIPI_DSI_COMPRESSION_DSC);

I hope the compiler complains here that it should be MIPI_DSI_COMPRESSION_DSC,0

(Enum algo first, int pps_selector last)

> +}
>  EXPORT_SYMBOL(mipi_dsi_compression_mode);
>  
>  /**
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 3011d33eccbd..78cb7b688b1d 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -226,6 +226,12 @@ static inline int mipi_dsi_pixel_format_to_bpp(enum mipi_dsi_pixel_format fmt)
>  	return -EINVAL;
>  }
>  
> +enum mipi_dsi_compression_algo {
> +	MIPI_DSI_COMPRESSION_DSC = 0,

Add 1.1?  Or does it also allow 1.2 (when the version is also set via PPS)?

> +	MIPI_DSI_COMPRESSION_VENDOR = 3,
> +	/* other two values are reserved, DSI 1.3 */
> +};
> +
>  struct mipi_dsi_device *
>  mipi_dsi_device_register_full(struct mipi_dsi_host *host,
>  			      const struct mipi_dsi_device_info *info);
> @@ -242,6 +248,9 @@ int mipi_dsi_turn_on_peripheral(struct mipi_dsi_device *dsi);
>  int mipi_dsi_set_maximum_return_packet_size(struct mipi_dsi_device *dsi,
>  					    u16 value);
>  int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable);
> +int mipi_dsi_compression_mode_ext(struct mipi_dsi_device *dsi, bool enable,
> +				  unsigned int pps_selector,
> +				  enum mipi_dsi_compression_algo algo);

Oh, this declaration is inverse from the definition...

- Marijn

>  int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
>  				   const struct drm_dsc_picture_parameter_set *pps);
>  
> 
> -- 
> 2.39.2
> 

