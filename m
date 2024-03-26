Return-Path: <linux-kernel+bounces-119399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53F388C83B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5713C300D59
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8124113C90D;
	Tue, 26 Mar 2024 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DxHJdXDA"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB6613C8E1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468625; cv=none; b=eLapJT/K8xyZeBlo23ZfuubFTLlwa5aZQv5APRyFAm2W64FqKWUsMlnFUUE3VZHXPBrTsiuhYYIy45vOC0Zvgjil208/iF/C36UdnHJx/7VozM83zU86LArf+FMV/C/aCuoWRQKdhu8bW6T1mD0DZYpBx/m9YjydYRsuQyzwbUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468625; c=relaxed/simple;
	bh=BJadlzjF8K7eYLDk/bKPq92BNIsaKdhNyPe7pWPOvJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEPFzpbW5dxFdOGmI159Ho6S9V67PgtGuXqThVHXDXQmINIha4wWg51dYrd+C5Tw64L56rU9dz3nhhOr11t3gLcLCdjN+snsq2i2j3BhM732w7K+Z4/tx2iaWxhIBQTVAxmJ9wkGwM480+q3NeWlDQU0PXJ0gnmltuEMgqtqG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DxHJdXDA; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A9191C000F;
	Tue, 26 Mar 2024 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711468621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zb7M3SYrtEfqRv0afXj1nbXh0UTQ/09F7/oJjZjlRZc=;
	b=DxHJdXDAgmpJkz9RjdEIGI4mugIcJhrykvIe4kC+YbVsw0jsOFN6gzDKwc0RvkiKCb/fMn
	mhLSsuOI3q9isWUDGua7PIh6kytHXPV2oSgXlVSurz5HdFlzM/IaJ8otcov/7R8Y/ft+oF
	m0Ejfpr4tDpYYfGynAmIyKVX82A4tRu0oLkRU/Sou1XgQiuKF0OIpFgMHk5S6hZ0bXQo2X
	cAcrYIpx8jqknTEXU4HE9yJtTKs0s/H5CoOLxqpuXAXOgK6B7+X7AkUjAWZv6Z3Ug+UUdT
	g4A8gq26+5uPnhlGXSNl9o4wodfbHK8ae1ttZ1ozUrsFpY2gaANXoPQs2MZ2JQ==
Date: Tue, 26 Mar 2024 16:56:59 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net,
	Jonathan Corbet <corbet@lwn.net>, pekka.paalanen@haloniitty.fi,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, seanpaul@google.com,
	marcheu@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH v5 05/16] drm/vkms: Add dummy pixel_read/pixel_write
 callbacks to avoid NULL pointers
Message-ID: <ZgLwSz6gosSdNAQH@localhost.localdomain>
Mail-Followup-To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net,
	Jonathan Corbet <corbet@lwn.net>, pekka.paalanen@haloniitty.fi,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, seanpaul@google.com,
	marcheu@google.com, nicolejadeyee@google.com
References: <20240313-yuv-v5-0-e610cbd03f52@bootlin.com>
 <20240313-yuv-v5-5-e610cbd03f52@bootlin.com>
 <d281fb73-5491-4764-b582-7790ccf7fa8d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d281fb73-5491-4764-b582-7790ccf7fa8d@igalia.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 25/03/24 - 10:59, Maíra Canal a écrit :
> On 3/13/24 14:44, Louis Chauvet wrote:
> > Introduce two callbacks which does nothing. They are used in replacement
> > of NULL and it avoid kernel OOPS if this NULL is called.
> > 
> > If those callback are used, it means that there is a mismatch between
> > what formats are announced by atomic_check and what is realy supported by
> > atomic_update.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >   drivers/gpu/drm/vkms/vkms_formats.c | 43 +++++++++++++++++++++++++++++++------
> >   1 file changed, 37 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > index 55a4365d21a4..b57d85b8b935 100644
> > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > @@ -136,6 +136,21 @@ static void RGB565_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
> >   	out_pixel->b = drm_fixp2int_round(drm_fixp_mul(fp_b, fp_rb_ratio));
> >   }
> >   
> > +/**
> > + * black_to_argb_u16() - pixel_read callback which always read black
> > + *
> > + * This callback is used when an invalid format is requested for plane reading.
> > + * It is used to avoid null pointer to be used as a function. In theory, this function should
> > + * never be called, except if you found a bug in the driver/DRM core.
> > + */
> > +static void black_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
> > +{
> > +	out_pixel->a = (u16)0xFFFF;
> > +	out_pixel->r = 0;
> > +	out_pixel->g = 0;
> > +	out_pixel->b = 0;
> > +}
> > +
> >   /**
> >    * vkms_compose_row - compose a single row of a plane
> >    * @stage_buffer: output line with the composed pixels
> > @@ -238,6 +253,16 @@ static void argb_u16_to_RGB565(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
> >   	*pixel = cpu_to_le16(r << 11 | g << 5 | b);
> >   }
> >   
> > +/**
> > + * argb_u16_to_nothing() - pixel_write callback with no effect
> > + *
> > + * This callback is used when an invalid format is requested for writeback.
> > + * It is used to avoid null pointer to be used as a function. In theory, this should never
> > + * happen, except if there is a bug in the driver
> > + */
> > +static void argb_u16_to_nothing(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
> > +{}
> > +
> >   /**
> >    * Generic loop for all supported writeback format. It is executed just after the blending to
> >    * write a line in the writeback buffer.
> > @@ -261,8 +286,8 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
> >   
> >   /**
> >    * Retrieve the correct read_pixel function for a specific format.
> > - * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
> > - * pointer is valid before using it in a vkms_plane_state.
> > + * If the format is not supported by VKMS a warn is emitted and a dummy "always read black"
> 
> "If the format is not supported by VKMS, a warning is emitted and a 
> dummy "always read black"..."

Fixed in v6.
 
> > + * function is returned.
> >    *
> >    * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
> >    */
> > @@ -285,18 +310,21 @@ pixel_read_t get_pixel_read_function(u32 format)
> >   		 * format must:
> >   		 * - Be listed in vkms_formats in vkms_plane.c
> >   		 * - Have a pixel_read callback defined here
> > +		 *
> > +		 * To avoid kernel crash, a dummy "always read black" function is used. It means
> > +		 * that during the composition, this plane will always be black.
> >   		 */
> >   		WARN(true,
> >   		     "Pixel format %p4cc is not supported by VKMS planes. This is a kernel bug, atomic check must forbid this configuration.\n",
> >   		     &format);
> > -		return (pixel_read_t)NULL;
> > +		return &black_to_argb_u16;
> >   	}
> >   }
> >   
> >   /**
> >    * Retrieve the correct write_pixel function for a specific format.
> > - * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
> > - * pointer is valid before using it in a vkms_writeback_job.
> > + * If the format is not supported by VKMS a warn is emitted and a dummy "don't do anything"
> 
> "If the format is not supported by VKMS, a warning is emitted and a 
> dummy "don't do anything"..."

Fixed in v6.

Thanks,
Louis Chauvet

> Best Regards,
> - Maíra
> 
> > + * function is returned.
> >    *
> >    * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
> >    */
> > @@ -319,10 +347,13 @@ pixel_write_t get_pixel_write_function(u32 format)
> >   		 * format must:
> >   		 * - Be listed in vkms_wb_formats in vkms_writeback.c
> >   		 * - Have a pixel_write callback defined here
> > +		 *
> > +		 * To avoid kernel crash, a dummy "don't do anything" function is used. It means
> > +		 * that the resulting writeback buffer is not composed and can contains any values.
> >   		 */
> >   		WARN(true,
> >   		     "Pixel format %p4cc is not supported by VKMS writeback. This is a kernel bug, atomic check must forbid this configuration.\n",
> >   		     &format);
> > -		return (pixel_write_t)NULL;
> > +		return &argb_u16_to_nothing;
> >   	}
> >   }
> > 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

