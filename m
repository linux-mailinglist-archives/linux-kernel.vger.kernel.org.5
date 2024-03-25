Return-Path: <linux-kernel+bounces-117192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF5C88A87E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBEC1F336F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505B613F43C;
	Mon, 25 Mar 2024 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IfMftF9u"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B35B12B141
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375175; cv=none; b=rHFV2xxCJverxWMo8dLL1JRZDeoS8w+Ki59DH1lhlXvRBwZxMwKy0AqYc0w6D7vHY5GBt06b8wp66YJc5lW6IkGwpdAbFAXtXaKck/HZXlvvxOchfB5gsg9lACd3PNYejehMW3XolzcSZ5Kx5tQmOE2VOYdrQHrpBuUXTju+rNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375175; c=relaxed/simple;
	bh=KjgqyNVGdRTpM+b80kBME4KupCYpHOuZwd/ATEa8mXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdgVnfqLCt0h/TO2DJVH/OUdDxWyMvyfafmqaGtqJJi8TKauqxkPPxZutfZrRk4Fr19N/PS1NxhxteP/q8wSEy8wv3FYFkCmC46+iMWZ+zK1I15/u21jlHVdipc4DLDh/zoHvIRPBYkUGX7mXkioZZo/lOx876dHG++klS31eG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=IfMftF9u; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ImUkmTdcElH4c269QxHEf9Y5l2DHO+qtVviBXPkTw6Q=; b=IfMftF9uzXkjFKBgjkZWvk95uI
	2qHzTsKT2glJckG0g5fNRuZG4zi1aUAML+indJefuH4K86aOXHQyNtt+eLKkAftoMXRSb4QetIByU
	nx3xo9zCyot5iiQnnA9s+Zxm0H6TTvaQP4L438nTSuF9hqWu+ioLZ9Gx+iVzol675XOCAiIhCrXyz
	1R4ETzVsAm8Q9dcA/iGBTqD2dOC4Hgm6OZtVQD0IKR0CbeGpIJ82oXE57iJg69HwFR+oB3H1/dGMY
	zBVAAnu4+MxAsjOC5uBG5SKevlaMF8grkDgBkHGylYoFkmVKPkWZJ83GqfGRDA7JxSNZRLKjNgZtp
	/bhD9pQQ==;
Received: from [177.34.169.255] (helo=[192.168.0.139])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rokr7-00F5Ls-JY; Mon, 25 Mar 2024 14:59:17 +0100
Message-ID: <d281fb73-5491-4764-b582-7790ccf7fa8d@igalia.com>
Date: Mon, 25 Mar 2024 10:59:09 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/16] drm/vkms: Add dummy pixel_read/pixel_write
 callbacks to avoid NULL pointers
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
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
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xjMEZIsaeRYJKwYBBAHaRw8BAQdAGU6aY8oojw61KS5rGGMrlcilFqR6p6ID45IZ6ovX0h3N
 H01haXJhIENhbmFsIDxtY2FuYWxAaWdhbGlhLmNvbT7CjwQTFggANxYhBDMCqFtIvFKVRJZQ
 hDSPnHLaGFVuBQJkixp5BQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQNI+cctoYVW5u
 GAEAwpaC5rI3wD8zqETKwGVoXd6+AbmGfZuVD40xepy7z/8BAM5w95/oyPsHUqOsg/xUTlNp
 rlbhA+WWoaOXA3XgR+wCzjgEZIsaeRIKKwYBBAGXVQEFAQEHQGoOK0jgh0IorMAacx6WUUWb
 s3RLiJYWUU6iNrk5wWUbAwEIB8J+BBgWCAAmFiEEMwKoW0i8UpVEllCENI+cctoYVW4FAmSL
 GnkFCQWjmoACGwwACgkQNI+cctoYVW6cqwD/Q9R98msvkhgRvi18fzUPFDwwogn+F+gQJJ6o
 pwpgFkAA/R2zOfla3IT6G3SBoV5ucdpdCpnIXFpQLbmfHK7dXsAC
In-Reply-To: <20240313-yuv-v5-5-e610cbd03f52@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/13/24 14:44, Louis Chauvet wrote:
> Introduce two callbacks which does nothing. They are used in replacement
> of NULL and it avoid kernel OOPS if this NULL is called.
> 
> If those callback are used, it means that there is a mismatch between
> what formats are announced by atomic_check and what is realy supported by
> atomic_update.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>   drivers/gpu/drm/vkms/vkms_formats.c | 43 +++++++++++++++++++++++++++++++------
>   1 file changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 55a4365d21a4..b57d85b8b935 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -136,6 +136,21 @@ static void RGB565_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
>   	out_pixel->b = drm_fixp2int_round(drm_fixp_mul(fp_b, fp_rb_ratio));
>   }
>   
> +/**
> + * black_to_argb_u16() - pixel_read callback which always read black
> + *
> + * This callback is used when an invalid format is requested for plane reading.
> + * It is used to avoid null pointer to be used as a function. In theory, this function should
> + * never be called, except if you found a bug in the driver/DRM core.
> + */
> +static void black_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
> +{
> +	out_pixel->a = (u16)0xFFFF;
> +	out_pixel->r = 0;
> +	out_pixel->g = 0;
> +	out_pixel->b = 0;
> +}
> +
>   /**
>    * vkms_compose_row - compose a single row of a plane
>    * @stage_buffer: output line with the composed pixels
> @@ -238,6 +253,16 @@ static void argb_u16_to_RGB565(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
>   	*pixel = cpu_to_le16(r << 11 | g << 5 | b);
>   }
>   
> +/**
> + * argb_u16_to_nothing() - pixel_write callback with no effect
> + *
> + * This callback is used when an invalid format is requested for writeback.
> + * It is used to avoid null pointer to be used as a function. In theory, this should never
> + * happen, except if there is a bug in the driver
> + */
> +static void argb_u16_to_nothing(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
> +{}
> +
>   /**
>    * Generic loop for all supported writeback format. It is executed just after the blending to
>    * write a line in the writeback buffer.
> @@ -261,8 +286,8 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
>   
>   /**
>    * Retrieve the correct read_pixel function for a specific format.
> - * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
> - * pointer is valid before using it in a vkms_plane_state.
> + * If the format is not supported by VKMS a warn is emitted and a dummy "always read black"

"If the format is not supported by VKMS, a warning is emitted and a 
dummy "always read black"..."

> + * function is returned.
>    *
>    * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
>    */
> @@ -285,18 +310,21 @@ pixel_read_t get_pixel_read_function(u32 format)
>   		 * format must:
>   		 * - Be listed in vkms_formats in vkms_plane.c
>   		 * - Have a pixel_read callback defined here
> +		 *
> +		 * To avoid kernel crash, a dummy "always read black" function is used. It means
> +		 * that during the composition, this plane will always be black.
>   		 */
>   		WARN(true,
>   		     "Pixel format %p4cc is not supported by VKMS planes. This is a kernel bug, atomic check must forbid this configuration.\n",
>   		     &format);
> -		return (pixel_read_t)NULL;
> +		return &black_to_argb_u16;
>   	}
>   }
>   
>   /**
>    * Retrieve the correct write_pixel function for a specific format.
> - * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
> - * pointer is valid before using it in a vkms_writeback_job.
> + * If the format is not supported by VKMS a warn is emitted and a dummy "don't do anything"

"If the format is not supported by VKMS, a warning is emitted and a 
dummy "don't do anything"..."

Best Regards,
- Maíra

> + * function is returned.
>    *
>    * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
>    */
> @@ -319,10 +347,13 @@ pixel_write_t get_pixel_write_function(u32 format)
>   		 * format must:
>   		 * - Be listed in vkms_wb_formats in vkms_writeback.c
>   		 * - Have a pixel_write callback defined here
> +		 *
> +		 * To avoid kernel crash, a dummy "don't do anything" function is used. It means
> +		 * that the resulting writeback buffer is not composed and can contains any values.
>   		 */
>   		WARN(true,
>   		     "Pixel format %p4cc is not supported by VKMS writeback. This is a kernel bug, atomic check must forbid this configuration.\n",
>   		     &format);
> -		return (pixel_write_t)NULL;
> +		return &argb_u16_to_nothing;
>   	}
>   }
> 

