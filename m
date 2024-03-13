Return-Path: <linux-kernel+bounces-102401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF0287B196
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8703429035D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3542C5EE9C;
	Wed, 13 Mar 2024 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BMsm9s2l"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E74E5EE8F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710356898; cv=none; b=kUSWh8KBYspBO80dOVC7ksqBDSq0mkISs0q2XwgqD9AOH3YNhsQZJV5IwECOFik19O55V3D3C5YmPpVuQCtRjsszA839CA6IVZxcHLB2ROzb7aSSnbn/k5L8KGP8R4H6YOiqFDt+LJ/TVxh/izQkxHUZjxoDNNlA8nhkWbvAxd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710356898; c=relaxed/simple;
	bh=3irkkhKNDjSMhkwVPGyQ/DKQYGUmvkBsjc9UH1B2d04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALw4qBzUxOsAjxa1mH4iuUpV48CkGPNOf0CXbAjpXNmrTKlJmI4QqG4jq+i+DpICtvdRDGLr0yK3SR8jHqyoO+uhFDhq1x03IIaZl/JmBVop5dx2M1mHEW+rn49O2+3DCzBTLd2cOvJ8oNEcKOUYAyrLjTpi0vtr2FBCOj6aPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BMsm9s2l; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=S4RVqXzF13y0CJV+kmNbU9l+QECvaduFB2onsfFa8UE=; b=BMsm9s2lN63/CsRPp7HRg/iSHJ
	uFEE4BHSNcctHMSlBioSWDsdjHGP1+0l5c7ULsON17Yhyykcr0Uqf8RCV/MkTNcFd7SlVKCvmu2Zb
	hmpI2fVgp4bOn+zufJ+8CNBmbETd9JvyPOV1pIvyN6FkVyvOWrvnjysMqpa2B0RkP3knmqmdP7r3p
	Mhrir3AwbgNp7NiV4lhVto0G7htl8C7VtQW3MvH6jACifqz5FTppxSm2yAgsL8ymE3Ml0vrGHJHp1
	MmDeW/lWnqGsOXfCMBIheCCGMGXAJlj7NFnEg8/1vs5ia5xIOtODGsQKWJxXF7C35CLRtKB5hKblW
	3jr2/8fQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkTxV-0000000BVpl-1QZv;
	Wed, 13 Mar 2024 19:08:13 +0000
Message-ID: <9c12e240-271a-4bf5-a946-7a2a25d1b18a@infradead.org>
Date: Wed, 13 Mar 2024 12:08:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/16] drm/vkms: Add dummy pixel_read/pixel_write
 callbacks to avoid NULL pointers
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
 <20240313-yuv-v5-5-e610cbd03f52@bootlin.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240313-yuv-v5-5-e610cbd03f52@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/13/24 10:44, Louis Chauvet wrote:
> Introduce two callbacks which does nothing. They are used in replacement
> of NULL and it avoid kernel OOPS if this NULL is called.
> 
> If those callback are used, it means that there is a mismatch between
> what formats are announced by atomic_check and what is realy supported by
> atomic_update.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_formats.c | 43 +++++++++++++++++++++++++++++++------
>  1 file changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 55a4365d21a4..b57d85b8b935 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c


> @@ -261,8 +286,8 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
>  
>  /**

Please mak this comment conform to kernel-doc format or don't use "/**" to
begin the comment.

>   * Retrieve the correct read_pixel function for a specific format.
> - * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
> - * pointer is valid before using it in a vkms_plane_state.
> + * If the format is not supported by VKMS a warn is emitted and a dummy "always read black"
> + * function is returned.
>   *
>   * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
>   */
> @@ -285,18 +310,21 @@ pixel_read_t get_pixel_read_function(u32 format)
>  		 * format must:
>  		 * - Be listed in vkms_formats in vkms_plane.c
>  		 * - Have a pixel_read callback defined here
> +		 *
> +		 * To avoid kernel crash, a dummy "always read black" function is used. It means
> +		 * that during the composition, this plane will always be black.
>  		 */
>  		WARN(true,
>  		     "Pixel format %p4cc is not supported by VKMS planes. This is a kernel bug, atomic check must forbid this configuration.\n",
>  		     &format);
> -		return (pixel_read_t)NULL;
> +		return &black_to_argb_u16;
>  	}
>  }
>  
>  /**

Same here.

>   * Retrieve the correct write_pixel function for a specific format.
> - * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
> - * pointer is valid before using it in a vkms_writeback_job.
> + * If the format is not supported by VKMS a warn is emitted and a dummy "don't do anything"
> + * function is returned.
>   *
>   * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
>   */

thanks.
-- 
#Randy

