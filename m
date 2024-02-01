Return-Path: <linux-kernel+bounces-48610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E58BC845ECF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F03D1C259CD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B907C6D5;
	Thu,  1 Feb 2024 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cF+cIyUk"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CFD7C6CA;
	Thu,  1 Feb 2024 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809457; cv=none; b=er0HBwcqzHtJlNLBAtQ+pmDXAol64pHRkfy1mp+T/nU2R3iLEL3QMwTnrpyIEMPGmxywcNOLnrZWnQ2ZO6AslALPnyVOgaeqjfPeDRwXypiUZ+YtJ4SHHSSSQ2elwTrMXaoM9H4mEXo7svZn5sSsOQ63ZQ1A9TGxn9zJ28tguwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809457; c=relaxed/simple;
	bh=p75AhBZ9nUm+rR2xMcPUvj+Cm1vH07pM4LzIeXB/zdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6r+zUaJ40szplDYnIp/6Fp4K0StY4X3WLBGL5YCeC6LnxDvG8Gn1/ujYaFoPHad3JJG2j6COfwGkt6vr4h7AJP78T85Eq3FVw4n1pjtE4l2uqQAXUkF4oVoNPGG0TNt06tuDnGx+i9Xxtfr5OMtpFWFtQB1zZQU8wgL9UjXpBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cF+cIyUk; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B0F9240002;
	Thu,  1 Feb 2024 17:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706809447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zih9+WdolofxIdtK1mOeeY5rlakpVPHBzMF2MAMbfZM=;
	b=cF+cIyUk/lPcDN6GzreJj/4JeGVhE7MofYm9DoJ5vSGYXH7XCqt/oXgTrQ/jl5Lqi6EmrG
	yAakz+bwIXNXmZzCMbX5fcWMN0QqDsf4nJ+t0aCR2dAJCFWu2ggvPAVu9C5CscHk2cDHU/
	eoaxvMrYwblqq1IuYiVqNt2ZfmXOCLsqiJ0/kpvP9uneVBQAUTyl8aVCDIIO4gbx51yA/w
	WWe0kEt8ynnaHfAEYsgbVQUGpzPneXvd5Ghh+BOQCHseC++ARdjeeNDKw+kE0U2v/ybQhJ
	IvJjMf66D/I9myWbDHvsl1dOpl3LBDCRjvu32P4YMsDDkCK3fi+SDu6y50RwUQ==
Date: Thu, 1 Feb 2024 18:44:04 +0100
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
Subject: Re: [PATCH v2 3/7] drm/vkms: Add range and encoding properties to
 pixel_read function
Message-ID: <ZbvYZHCt6ynnWkoP@localhost.localdomain>
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
 <20240110-vkms-yuv-v2-3-952fcaa5a193@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240110-vkms-yuv-v2-3-952fcaa5a193@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 10/01/24 - 14:44, Arthur Grillo a écrit :
> Create range and encoding properties. This should be noop, as none of
> the conversion functions need those properties.
> 
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.h     |  3 ++-
>  drivers/gpu/drm/vkms/vkms_formats.c | 20 ++++++++++++++------
>  drivers/gpu/drm/vkms/vkms_plane.c   |  9 +++++++++
>  3 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index c38590562e4b..51349a0c32d8 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -56,7 +56,8 @@ struct vkms_writeback_job {
>  struct vkms_plane_state {
>  	struct drm_shadow_plane_state base;
>  	struct vkms_frame_info *frame_info;
> -	void (*pixel_read)(u8 **src_buffer, struct pixel_argb_u16 *out_pixel);
> +	void (*pixel_read)(u8 **src_buffer, struct pixel_argb_u16 *out_pixel,
> +			   enum drm_color_encoding enconding, enum drm_color_range range);
>  };
>  
>  struct vkms_plane {
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 5566a7cd7bb4..0156372aa1ef 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -51,7 +51,8 @@ static int get_x_position(const struct vkms_frame_info *frame_info, int limit, i
>  	return x;
>  }
>  
> -static void ARGB8888_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel)
> +static void ARGB8888_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel,
> +				 enum drm_color_encoding encoding, enum drm_color_range range)
>  {
>  	/*
>  	 * The 257 is the "conversion ratio". This number is obtained by the
> @@ -65,7 +66,8 @@ static void ARGB8888_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pix
>  	out_pixel->b = (u16)src_pixels[0][0] * 257;
>  }
>  
> -static void XRGB8888_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel)
> +static void XRGB8888_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel,
> +				 enum drm_color_encoding encoding, enum drm_color_range range)
>  {
>  	out_pixel->a = (u16)0xffff;
>  	out_pixel->r = (u16)src_pixels[0][2] * 257;
> @@ -73,7 +75,8 @@ static void XRGB8888_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pix
>  	out_pixel->b = (u16)src_pixels[0][0] * 257;
>  }
>  
> -static void ARGB16161616_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel)
> +static void ARGB16161616_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel,
> +				     enum drm_color_encoding encoding, enum drm_color_range range)
>  {
>  	u16 *pixels = (u16 *)src_pixels[0];
>  
> @@ -83,7 +86,8 @@ static void ARGB16161616_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out
>  	out_pixel->b = le16_to_cpu(pixels[0]);
>  }
>  
> -static void XRGB16161616_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel)
> +static void XRGB16161616_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel,
> +				     enum drm_color_encoding encoding, enum drm_color_range range)
>  {
>  	u16 *pixels = (u16 *)src_pixels[0];
>  
> @@ -93,7 +97,8 @@ static void XRGB16161616_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out
>  	out_pixel->b = le16_to_cpu(pixels[0]);
>  }
>  
> -static void RGB565_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel)
> +static void RGB565_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel,
> +			       enum drm_color_encoding encoding, enum drm_color_range range)
>  {
>  	u16 *pixels = (u16 *)src_pixels[0];
>  
> @@ -132,6 +137,9 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
>  	int limit = min_t(size_t, drm_rect_width(&frame_info->dst), stage_buffer->n_pixels);
>  	u8 *src_pixels[DRM_FORMAT_MAX_PLANES];
>  
> +	enum drm_color_encoding encoding = plane->base.base.color_encoding;
> +	enum drm_color_range range = plane->base.base.color_range;
> +
>  	for (size_t i = 0; i < frame_format->num_planes; i++)
>  		src_pixels[i] = get_packed_src_addr(frame_info, y, i);
>  
> @@ -146,7 +154,7 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
>  			}
>  		}
>  
> -		plane->pixel_read(src_pixels, &out_pixels[x_pos]);
> +		plane->pixel_read(src_pixels, &out_pixels[x_pos], encoding, range);
>  
>  		for (size_t i = 0; i < frame_format->num_planes; i++)
>  			src_pixels[i] += frame_format->cpp[i];
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index 8f2c6ea419a3..e87c80575b7d 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -212,5 +212,14 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
>  	drm_plane_create_rotation_property(&plane->base, DRM_MODE_ROTATE_0,
>  					   DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
>  
> +	drm_plane_create_color_properties(&plane->base,
> +					  BIT(DRM_COLOR_YCBCR_BT601) |
> +					  BIT(DRM_COLOR_YCBCR_BT709) |
> +					  BIT(DRM_COLOR_YCBCR_BT2020),
> +					  BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
> +					  BIT(DRM_COLOR_YCBCR_FULL_RANGE),
> +					  DRM_COLOR_YCBCR_BT601,
> +					  DRM_COLOR_YCBCR_FULL_RANGE);
> +
>  	return plane;
>  }
> 
> -- 
> 2.43.0
> 

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

