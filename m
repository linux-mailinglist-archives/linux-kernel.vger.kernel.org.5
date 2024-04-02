Return-Path: <linux-kernel+bounces-128690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 245B2895E34
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76661F22F35
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A400615E209;
	Tue,  2 Apr 2024 21:00:36 +0000 (UTC)
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7850179DD4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091636; cv=none; b=ux72IXL/NW4grIMjhbT7MiIEswbBhCxiee+qM4xDiIU/pnCMeTQBKwPmPNphAoymRI1hzpoQtehiiB5N7QcOX64sR6+Lk2y4ROgq8b6w5kvFxlVWqABah5jDXGVGN3wOOai8j90UrL3330QWHxoxxEYobRsuzfwLQMp85VJJFOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091636; c=relaxed/simple;
	bh=8NTqXgOWWcuq40W6UaNmXdNJpMviS07rSOpM1sm2UEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZxTwOGeapgxXxfl7t/CKImWV8rUx0c+4GaTsEISCZFJhvaOrfic12CNqVYLSQlmrcGEIBlOIzSOMs+FkX9RzFX+9YVKQ0y7DTjD6GxibnNq/uIGB5TeVOLomSQNXkbzTRFar48AD73kj1aubtQR2HFhXqP5Z8fBEMaPet7z4Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id CF73D1F509;
	Tue,  2 Apr 2024 23:00:31 +0200 (CEST)
Date: Tue, 2 Apr 2024 23:00:30 +0200
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
Subject: Re: [PATCH v3 2/4] drm/mipi-dsi: use correct return type for the DSC
 functions
Message-ID: <rqj27ry5bvh5mcnstptshynm4t74jjcnvnr2qw4d7plqy4nkxi@xlisoqjblidj>
References: <20240402-lg-sw43408-panel-v3-0-144f17a11a56@linaro.org>
 <20240402-lg-sw43408-panel-v3-2-144f17a11a56@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402-lg-sw43408-panel-v3-2-144f17a11a56@linaro.org>

On 2024-04-02 02:51:13, Dmitry Baryshkov wrote:
> The functions mipi_dsi_compression_mode() and
> mipi_dsi_picture_parameter_set() return 0-or-error rather than a buffer
> size. Follow example of other similar MIPI DSI functions and use int
> return type instead of size_t.
> 
> Fixes: f4dea1aaa9a1 ("drm/dsi: add helpers for DSI compression mode and PPS packets")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 6 +++---
>  include/drm/drm_mipi_dsi.h     | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index ef6e416522f8..9874ff6d4718 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -654,7 +654,7 @@ EXPORT_SYMBOL(mipi_dsi_set_maximum_return_packet_size);
>   *
>   * Return: 0 on success or a negative error code on failure.
>   */
> -ssize_t mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
> +int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
>  {
>  	/* Note: Needs updating for non-default PPS or algorithm */
>  	u8 tx[2] = { enable << 0, 0 };
> @@ -679,8 +679,8 @@ EXPORT_SYMBOL(mipi_dsi_compression_mode);
>   *
>   * Return: 0 on success or a negative error code on failure.
>   */
> -ssize_t mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
> -				       const struct drm_dsc_picture_parameter_set *pps)
> +int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
> +				   const struct drm_dsc_picture_parameter_set *pps)
>  {
>  	struct mipi_dsi_msg msg = {
>  		.channel = dsi->channel,
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index c0aec0d4d664..3011d33eccbd 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -241,9 +241,9 @@ int mipi_dsi_shutdown_peripheral(struct mipi_dsi_device *dsi);
>  int mipi_dsi_turn_on_peripheral(struct mipi_dsi_device *dsi);
>  int mipi_dsi_set_maximum_return_packet_size(struct mipi_dsi_device *dsi,
>  					    u16 value);
> -ssize_t mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable);
> -ssize_t mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
> -				       const struct drm_dsc_picture_parameter_set *pps);
> +int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable);
> +int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
> +				   const struct drm_dsc_picture_parameter_set *pps);
>  
>  ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
>  			       size_t size);
> 
> -- 
> 2.39.2
> 

