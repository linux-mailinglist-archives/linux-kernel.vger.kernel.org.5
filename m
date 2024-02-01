Return-Path: <linux-kernel+bounces-48611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A47845ED2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC37E1C25E5B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998887C6D7;
	Thu,  1 Feb 2024 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WdiQrGAf"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBCD7C6C4;
	Thu,  1 Feb 2024 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809476; cv=none; b=ILHyO0uXiqCigfkj0uKuTdZ6VBgOBR5aAqu29d+HrZSOn73YDtDZAPCqazpk8hOUukjlDpSCEpVnwF83VV6TDIkYmHY6J9+evLs80XOYZvVVuzVETLMsSOr0QoyGGMtOUVd/j3CQzauVffO2kvJvs/FrpbyEspF9C5cX43zxZM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809476; c=relaxed/simple;
	bh=Uzdepl6193sRwCFXL2uJAJ7TbZcce4Fz6L28yStz2o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRU+NKyzkD+apPBTgCvmrDrFAHlz/Q7UVj19r2qXtb94n910cVN6lb3YHYFsPrvjYd0W9tnqsQeOnExD9nYV4qxFGNIpDcvaOIZA72nK6TEFLPBMnX2wxZ8v2A33GbBRZhNBafDL+7j8GfsBNC7mODib6Ab0IrKyt9CFTfv5Hig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WdiQrGAf; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C925760007;
	Thu,  1 Feb 2024 17:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706809472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2eSz6xHT02lBc/gMOVn5cXX8MOGfH9HB9ARtQj/XSs=;
	b=WdiQrGAfd1aCElsJILtpHLWVE5x0oyhwGGaVsEg2k0gQTCXRsqxQzyrPufMjkoSvhPKeg9
	iRgj79a6mTKg/TJZx+se97sZChWsqmoCstkJTZN4kR4VUawc9ipgJTTAMVVU+vbh40lfNv
	nkaZnTd8ptB3ZbyV1Q21NtTOf8nPRGnJIvnnt0xmA7GzFTn8w08zyp7XUrt+X+y6rBKzYF
	923WnfIpLSEgcqK2WwEr/5ykkobrOvhGL4jj0W8tYF38K1Q7UfkLv0+N3hzIt3J0rHWkKE
	OcrzTSukNlHwOvhfSMr40dbyEPzjtO+Yz2bk8TnDW2aW4wr+0uNQPYTTVGZh8A==
Date: Thu, 1 Feb 2024 18:44:29 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Arthur Grillo <arthurgrillo@riseup.net>
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Melissa Wen <melissa.srw@gmail.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 5/7] drm/vkms: Add YUV support
Message-ID: <ZbvYfaxBoGI_LzYS@localhost.localdomain>
Mail-Followup-To: Arthur Grillo <arthurgrillo@riseup.net>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Melissa Wen <melissa.srw@gmail.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org
References: <20240110-vkms-yuv-v2-0-952fcaa5a193@riseup.net>
 <20240110-vkms-yuv-v2-5-952fcaa5a193@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240110-vkms-yuv-v2-5-952fcaa5a193@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 10/01/24 - 14:44, Arthur Grillo a écrit :
> Add support to the YUV formats bellow:
> 
> - NV12
> - NV16
> - NV24
> - NV21
> - NV61
> - NV42
> - YUV420
> - YUV422
> - YUV444
> - YVU420
> - YVU422
> - YVU444
> 
> The conversion matrices of each encoding and range were obtained by
> rounding the values of the original conversion matrices multiplied by
> 2^8. This is done to avoid the use of fixed point operations.
> 
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> ---
>  drivers/gpu/drm/vkms/vkms_formats.c | 147 ++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_formats.h |   4 +
>  drivers/gpu/drm/vkms/vkms_plane.c   |  14 +++-
>  3 files changed, 164 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 098ed16f2104..7c1a0ca322d9 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -119,6 +119,137 @@ static void RGB565_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel
>  	out_pixel->b = drm_fixp2int_round(drm_fixp_mul(fp_b, fp_rb_ratio));
>  }
>  
> +static void ycbcr2rgb(const s16 m[3][3], u8 y, u8 cb, u8 cr, u8 y_offset, u8 *r, u8 *g, u8 *b)
> +{
> +	s32 y_16, cb_16, cr_16;
> +	s32 r_16, g_16, b_16;
> +
> +	y_16 =  y - y_offset;
> +	cb_16 = cb - 128;
> +	cr_16 = cr - 128;
> +
> +	r_16 = m[0][0] * y_16 + m[0][1] * cb_16 + m[0][2] * cr_16;
> +	g_16 = m[1][0] * y_16 + m[1][1] * cb_16 + m[1][2] * cr_16;
> +	b_16 = m[2][0] * y_16 + m[2][1] * cb_16 + m[2][2] * cr_16;
> +
> +	*r = clamp(r_16, 0, 0xffff) >> 8;
> +	*g = clamp(g_16, 0, 0xffff) >> 8;
> +	*b = clamp(b_16, 0, 0xffff) >> 8;
> +}
> +
> +static void yuv_u8_to_argb_u16(struct pixel_argb_u16 *argb_u16, const struct pixel_yuv_u8 *yuv_u8,
> +			       enum drm_color_encoding encoding, enum drm_color_range range)
> +{
> +	static const s16 bt601_full[3][3] = {
> +		{256,   0,  359},
> +		{256, -88, -183},
> +		{256, 454,    0},
> +	};
> +	static const s16 bt601[3][3] = {
> +		{298,    0,  409},
> +		{298, -100, -208},
> +		{298,  516,    0},
> +	};
> +	static const s16 rec709_full[3][3] = {
> +		{256,   0,  408},
> +		{256, -48, -120},
> +		{256, 476,   0 },
> +	};
> +	static const s16 rec709[3][3] = {
> +		{298,   0,  459},
> +		{298, -55, -136},
> +		{298, 541,    0},
> +	};
> +	static const s16 bt2020_full[3][3] = {
> +		{256,   0,  377},
> +		{256, -42, -146},
> +		{256, 482,    0},
> +	};
> +	static const s16 bt2020[3][3] = {
> +		{298,   0,  430},
> +		{298, -48, -167},
> +		{298, 548,    0},
> +	};
> +
> +	u8 r = 0;
> +	u8 g = 0;
> +	u8 b = 0;
> +	bool full = range == DRM_COLOR_YCBCR_FULL_RANGE;
> +	unsigned int y_offset = full ? 0 : 16;
> +
> +	switch (encoding) {
> +	case DRM_COLOR_YCBCR_BT601:
> +		ycbcr2rgb(full ? bt601_full : bt601,
> +			  yuv_u8->y, yuv_u8->u, yuv_u8->v, y_offset, &r, &g, &b);
> +		break;
> +	case DRM_COLOR_YCBCR_BT709:
> +		ycbcr2rgb(full ? rec709_full : rec709,
> +			  yuv_u8->y, yuv_u8->u, yuv_u8->v, y_offset, &r, &g, &b);
> +		break;
> +	case DRM_COLOR_YCBCR_BT2020:
> +		ycbcr2rgb(full ? bt2020_full : bt2020,
> +			  yuv_u8->y, yuv_u8->u, yuv_u8->v, y_offset, &r, &g, &b);
> +		break;
> +	default:
> +		pr_warn_once("Not supported color encoding\n");
> +		break;
> +	}
> +
> +	argb_u16->r = r * 257;
> +	argb_u16->g = g * 257;
> +	argb_u16->b = b * 257;
> +}
> +
> +static void semi_planar_yuv_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel,
> +					enum drm_color_encoding encoding,
> +					enum drm_color_range range)
> +{
> +	struct pixel_yuv_u8 yuv_u8;
> +
> +	yuv_u8.y = src_pixels[0][0];
> +	yuv_u8.u = src_pixels[1][0];
> +	yuv_u8.v = src_pixels[1][1];
> +
> +	yuv_u8_to_argb_u16(out_pixel, &yuv_u8, encoding, range);
> +}
> +
> +static void semi_planar_yvu_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel,
> +					enum drm_color_encoding encoding,
> +					enum drm_color_range range)
> +{
> +	struct pixel_yuv_u8 yuv_u8;
> +
> +	yuv_u8.y = src_pixels[0][0];
> +	yuv_u8.v = src_pixels[1][0];
> +	yuv_u8.u = src_pixels[1][1];
> +
> +	yuv_u8_to_argb_u16(out_pixel, &yuv_u8, encoding, range);
> +}
> +
> +static void planar_yuv_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel,
> +				   enum drm_color_encoding encoding, enum drm_color_range range)
> +{
> +	struct pixel_yuv_u8 yuv_u8;
> +
> +	yuv_u8.y = src_pixels[0][0];
> +	yuv_u8.u = src_pixels[1][0];
> +	yuv_u8.v = src_pixels[2][0];
> +
> +	yuv_u8_to_argb_u16(out_pixel, &yuv_u8, encoding, range);
> +}
> +
> +static void planar_yvu_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel,
> +				   enum drm_color_encoding encoding, enum drm_color_range range)
> +{
> +	struct pixel_yuv_u8 yuv_u8;
> +
> +	yuv_u8.y = src_pixels[0][0];
> +	yuv_u8.v = src_pixels[1][0];
> +	yuv_u8.u = src_pixels[2][0];
> +
> +	yuv_u8_to_argb_u16(out_pixel, &yuv_u8, encoding, range);
> +}
> +
>  /**
>   * vkms_compose_row - compose a single row of a plane
>   * @stage_buffer: output line with the composed pixels
> @@ -267,6 +398,22 @@ void *get_pixel_conversion_function(u32 format)
>  		return &XRGB16161616_to_argb_u16;
>  	case DRM_FORMAT_RGB565:
>  		return &RGB565_to_argb_u16;
> +	case DRM_FORMAT_NV12:
> +	case DRM_FORMAT_NV16:
> +	case DRM_FORMAT_NV24:
> +		return &semi_planar_yuv_to_argb_u16;
> +	case DRM_FORMAT_NV21:
> +	case DRM_FORMAT_NV61:
> +	case DRM_FORMAT_NV42:
> +		return &semi_planar_yvu_to_argb_u16;
> +	case DRM_FORMAT_YUV420:
> +	case DRM_FORMAT_YUV422:
> +	case DRM_FORMAT_YUV444:
> +		return &planar_yuv_to_argb_u16;
> +	case DRM_FORMAT_YVU420:
> +	case DRM_FORMAT_YVU422:
> +	case DRM_FORMAT_YVU444:
> +		return &planar_yvu_to_argb_u16;
>  	default:
>  		return NULL;
>  	}
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
> index cf59c2ed8e9a..a8b2f92bdcb5 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.h
> +++ b/drivers/gpu/drm/vkms/vkms_formats.h
> @@ -9,4 +9,8 @@ void *get_pixel_conversion_function(u32 format);
>  
>  void *get_pixel_write_function(u32 format);
>  
> +struct pixel_yuv_u8 {
> +	u8 y, u, v;
> +};
> +
>  #endif /* _VKMS_FORMATS_H_ */
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index e87c80575b7d..932736fc3ee9 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -17,7 +17,19 @@ static const u32 vkms_formats[] = {
>  	DRM_FORMAT_XRGB8888,
>  	DRM_FORMAT_XRGB16161616,
>  	DRM_FORMAT_ARGB16161616,
> -	DRM_FORMAT_RGB565
> +	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_NV12,
> +	DRM_FORMAT_NV16,
> +	DRM_FORMAT_NV24,
> +	DRM_FORMAT_NV21,
> +	DRM_FORMAT_NV61,
> +	DRM_FORMAT_NV42,
> +	DRM_FORMAT_YUV420,
> +	DRM_FORMAT_YUV422,
> +	DRM_FORMAT_YUV444,
> +	DRM_FORMAT_YVU420,
> +	DRM_FORMAT_YVU422,
> +	DRM_FORMAT_YVU444
>  };
>  
>  static struct drm_plane_state *
> 
> -- 
> 2.43.0
> 

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

