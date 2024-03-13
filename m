Return-Path: <linux-kernel+bounces-102417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632B187B1C3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947EB1C28242
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D801C59B64;
	Wed, 13 Mar 2024 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oqeT8VHO"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21AC59B56
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357662; cv=none; b=jPgSD+rlsm+eKJ1MQcRngAA9NgOidXBwXSQpLH1JNsnErfAJTMIyi5qbzOrueZKB66G5FjbcZmBK4asffO5QB0yVg3NIdGvSrxLHvrdiFqmVCUac+VN+XR1dSU8pZbdp+BCG5oqd7u5HAqQMP3mzemQOWzYaboMzmyHLa6uSzsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357662; c=relaxed/simple;
	bh=sJAi3yRoC641aj/7aZ+N27cqQw6Y+OQSeV/UsdjL9Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbq8pzAMhpkG+mHLxcUIPf7oK2BD5FISdTOT6EcRNC9v69TA6wxGE4D6uI/rOh3gGexh69u3KW7vc/FHbpvxrwDPBSIQqFK38lFwoPS1m+VPrN/K98v/L1gC0Kc8sjBL7HFCwb7g6aUS88U53WSDoqU2VqUb3GJ3SkPiw80uzwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oqeT8VHO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=75WVLbdwI+iDn1zwGEAUGq3py3zyrknBJPOCRtfKgus=; b=oqeT8VHOM5Ys7DVNGOQYq9T/Qa
	pQoxGa3NprcqJtXMbujtg5idZDjeTniP60jiiC2TiCTOx1D4CO5Qt/SajoAHJg+Xk4fQeaxMLJz27
	JgvpxyjHawliDFL+XKyBeh+l3o/Gb1ZeoMoirQv+DpWxk7qb9Is+wOS6kD2hhYGDydLprhJG3An0p
	0NSwjmn/ISlGvXM80dvpc6BXrkuhTpQk1wEukj8RXpsEeCuOEOdiSzPqPh8huOCbiCxv2ez5QgsEj
	vOJp6bQztpJURPz9GtYin1eeRQmwj4Q6NAu1dAxO2ioQ2FZvlggyYD3H54s/ZoNaEblA/+7623R2e
	V61Gn5xA==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkU9p-0000000BZfK-0aN9;
	Wed, 13 Mar 2024 19:20:57 +0000
Message-ID: <f0fe1d62-ee99-4576-ad27-62de98f9ad39@infradead.org>
Date: Wed, 13 Mar 2024 12:20:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/16] drm/vkms: Add YUV support
Content-Language: en-US
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net,
 Jonathan Corbet <corbet@lwn.net>, pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com,
 nicolejadeyee@google.com
References: <20240313-yuv-v5-0-e610cbd03f52@bootlin.com>
 <20240313-yuv-v5-11-e610cbd03f52@bootlin.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240313-yuv-v5-11-e610cbd03f52@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/13/24 10:45, Louis Chauvet wrote:
> From: Arthur Grillo <arthurgrillo@riseup.net>
> 

> 
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> [Louis Chauvet:
> - Adapted Arthur's work
> - Implemented the read_line_t callbacks for yuv
> - add struct conversion_matrix
> - remove struct pixel_yuv_u8
> - update the commit message
> - Merge the modifications from Arthur]
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.h     |  22 ++
>  drivers/gpu/drm/vkms/vkms_formats.c | 431 ++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_formats.h |   4 +
>  drivers/gpu/drm/vkms/vkms_plane.c   |  17 +-
>  4 files changed, 473 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 23e1d247468d..f3116084de5a 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -99,6 +99,27 @@ typedef void (*pixel_read_line_t)(const struct vkms_plane_state *plane, int x_st
>  				  int y_start, enum pixel_read_direction direction, int count,
>  				  struct pixel_argb_u16 out_pixel[]);
>  
> +/**
> + * CONVERSION_MATRIX_FLOAT_DEPTH - Number of digits after the point for conversion matrix values

This should be

+ * define CONVERSION_MATRIX_FLOAT_DEPTH - Number of digits after the point for conversion matrix values

to conform to kernel-doc format.

> + */
> +#define CONVERSION_MATRIX_FLOAT_DEPTH 32
> +

> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 1449a0e6c706..edbf4b321b91 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c

> +/**
> + * get_conversion_matrix_to_argb_u16() - Retrieve the correct yuv to rgb conversion matrix for a
> + * given encoding and range.
> + *
> + * If the matrix is not found, return a null pointer. In all other cases, it return a simple
> + * diagonal matrix, which act as a "no-op".
> + *
> + * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
> + * @encoding: DRM_COLOR_* value for which to obtain a conversion matrix
> + * @range: DRM_COLOR_*_RANGE value for which to obtain a conversion matrix
> + */
> +struct conversion_matrix *
> +get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
> +				  enum drm_color_range range)
> +{
> +	static struct conversion_matrix no_operation = {
> +		.matrix = {
> +			{ 4294967296, 0,          0, },
> +			{ 0,          4294967296, 0, },
> +			{ 0,          0,          4294967296, },
> +		},
> +		.y_offset = 0,
> +	};
> +
> +	/*
> +	 * Those matrixies were generated using the colour python framework

	         matrices

> +	 *
> +	 * Below are the function calls used to generate eac matrix, go to

	                                                 each

> +	 * https://colour.readthedocs.io/en/develop/generated/colour.matrix_YCbCr.html
> +	 * for more info:
> +	 *
> +	 * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.601"],
> +	 *                                  is_legal = False,
> +	 *                                  bits = 8) * 2**32).astype(int)
> +	 */

> +
>  /**

Please convert this comment to kernel-doc format or just use "/*" to begin
the comment.

>   * Retrieve the correct write_pixel function for a specific format.
>   * If the format is not supported by VKMS a warn is emitted and a dummy "don't do anything"

> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index 8875bed76410..987dd2b686a8 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c


thanks.
-- 
#Randy

