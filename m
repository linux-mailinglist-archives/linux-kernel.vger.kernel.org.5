Return-Path: <linux-kernel+bounces-102393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AA887B18A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EA61C27560
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B63959B5A;
	Wed, 13 Mar 2024 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nqJQixae"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B2C225AF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 19:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710356567; cv=none; b=CVTbAU7kAWunUFxaJdrDz1E+rmIyE3UyFYE/jgInfiNBGzw78dmixxg1BHE6uFx3zWmdDfRvjzgiCM0ApP5AjAez0Rk1QB07QxPLQBUSi9hkrAKssmlwLL5wYViqrpNQmcbkENtuOCCEaxjBEKCB7yvqysiZZH5jYmOHmMboPLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710356567; c=relaxed/simple;
	bh=kOETKqj4ms9TeecxQwKc7Q6phMDpAvy8Z6jCiPxe64A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvgRjlFdMkGTs+UxZfYpxAeQVcgJdFKf/i345K7pLbIKSxpe5/xAjuj2IDwJ1iyojfBNgZCcjeJKYLj6ie6s3CeLPs8iXrVSmZDyJyhuaC+qHAjsK9gTQFYz2cjFDT6tLf0h05PeZtR3At0cq+K86yTyPhFkTNNpjvCnDxVD5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nqJQixae; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=rIJP/2UJwo6seYvgvi0OmkEBz55Yak5Htnxi3myTKu8=; b=nqJQixaelhfIlCtIrd1vO8BEV0
	PZDMhh4NiN+/ct17a5eR3LnU4zyGsAWNx6XwhHoUlSiiSqSvHKQqEcMMb3g9QJCBA+WJCSD6HNJDr
	WOaFKLWNb6UZMaGaEy/SwAa9MefGcFxOFMqCbKOgvp7V5VTZLBT/gOUnh1kFvj9eH+BTqxZyg84aj
	t5gCEQYwvGPOt/RL8Wybru6ZnNMJ2LdJeHxT4jE+/quDaREQeut52+AmrTxW/pNTOsvCnI2Q1L+Ks
	2kSHf5pg15e6zpJe+b9iw5/zwUCTLORVlyOcNz+lHH1EBw5YBAgqxnnhz6VqroVbXsS4ihBAtWBhY
	/X9x7byQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkTs6-0000000BUAS-3Dl5;
	Wed, 13 Mar 2024 19:02:38 +0000
Message-ID: <1cda54fb-a61d-4485-b9fe-338a935d7980@infradead.org>
Date: Wed, 13 Mar 2024 12:02:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/16] drm/vkms: write/update the documentation for
 pixel conversion and pixel write functions
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
 <20240313-yuv-v5-3-e610cbd03f52@bootlin.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240313-yuv-v5-3-e610cbd03f52@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/13/24 10:44, Louis Chauvet wrote:
> Add some documentation on pixel conversion functions.
> Update of outdated comments for pixel_write functions.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_composer.c |  7 ++++
>  drivers/gpu/drm/vkms/vkms_drv.h      | 13 ++++++++
>  drivers/gpu/drm/vkms/vkms_formats.c  | 62 ++++++++++++++++++++++++++++++------
>  3 files changed, 73 insertions(+), 9 deletions(-)
> 

> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 172830a3936a..6e3dc8682ff9 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c


> @@ -216,6 +238,14 @@ static void argb_u16_to_RGB565(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
>  	*pixels = cpu_to_le16(r << 11 | g << 5 | b);
>  }
>  
> +/**

This comment is not in kernel-doc format, so either use "/*" to begin the comment
or add the function name in the first comment line, like:


+ * vkms_writeback_row - Generic loop for all supported writeback format. It is executed just after the blending to

> + * Generic loop for all supported writeback format. It is executed just after the blending to
> + * write a line in the writeback buffer.
> + *
> + * @wb: Job where to insert the final image
> + * @src_buffer: Line to write
> + * @y: Row to write in the writeback buffer
> + */
>  void vkms_writeback_row(struct vkms_writeback_job *wb,
>  			const struct line_buffer *src_buffer, int y)
>  {
> @@ -229,6 +259,13 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
>  		wb->pixel_write(dst_pixels, &in_pixels[x]);
>  }
>  
> +/**

Needs function name or don't use "/**" to begin the comment.

> + * Retrieve the correct read_pixel function for a specific format.
> + * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
> + * pointer is valid before using it in a vkms_plane_state.
> + *
> + * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
> + */
>  void *get_pixel_conversion_function(u32 format)
>  {
>  	switch (format) {
> @@ -247,6 +284,13 @@ void *get_pixel_conversion_function(u32 format)
>  	}
>  }
>  
> +/**

Same here.

> + * Retrieve the correct write_pixel function for a specific format.
> + * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
> + * pointer is valid before using it in a vkms_writeback_job.
> + *
> + * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
> + */
>  void *get_pixel_write_function(u32 format)
>  {
>  	switch (format) {
> 

thanks.
-- 
#Randy

