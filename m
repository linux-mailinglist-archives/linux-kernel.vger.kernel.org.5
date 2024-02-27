Return-Path: <linux-kernel+bounces-83466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C61D8699CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7BF1F21B71
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D4914E2D1;
	Tue, 27 Feb 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n49clMpp"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD1C14C58C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046142; cv=none; b=CEDvzBoFo8i8XY1ANuej60hNTJj2qvQq+wqoSfH/x9BALkIAoRZkS0m8kUfZxT1iOeKT7xDDa+VG756iilcoPcd4lb6YIls9Jfd1ccbOi8OuvCGDOOgwLup8xKC2qRJkA7cB+Q79QUd9+k50jafelcURC6/bXCwQ3VsN3UCyt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046142; c=relaxed/simple;
	bh=VkxTprc+NaWGhw2zRwYaj73Dmeeaa18I5uOQVCjomns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpY+Dci/m8q94Q8nxhp1iMkRHAzJN1UaAfFYMx6shbmIBpQeTAkVfe6TAkCiLg7fi9anlBogTtsxAuGNWCCXTnm2E/S/mO6NbE+zaX328rXdewfhXrOkxM6uWACayQ5zBYzqOSuG1ggsmiiciES9irfUkEwuswGijBbvPItyK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n49clMpp; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E012AC0006;
	Tue, 27 Feb 2024 15:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709046138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6vmRJBmi+ZC6wYqBjXwE3XAwhFeg/+dRhI35CFa/hVU=;
	b=n49clMpplySaqVcRnkEStW63nCBewgFvphdIswr9GpoOV7XuGaTT00pFB2IketLgsVAiWX
	qrrs32gsxh/C+WrzD3L6+1zd8MI/190gzF/5gFAzBY7GXUcAm2NQyM7aRKSXOgIVB7oeFJ
	EVV0dqnHdA8Lor4vXWV87CMFirUDl3vMGsVohbVOzIx58mtydIuFCpF/V+nhTjMuPgNjms
	xNbNR8Qp/kMzPnZrjbTefd4tHlw6ip1Q2xT7gaPZ3fBlVyGMHcYz/PIm+Wm0zgkUS34O2z
	jy4oAAMcI7510paUj5fsds8vusUZZOBj56n1gXsH8pFlzRqAjaF7lykKEChQFw==
Date: Tue, 27 Feb 2024 16:02:13 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net,
	Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2 4/9] drm/vkms: Add typedef and documentation for
 pixel_read and pixel_write functions
Message-ID: <Zd35ddrlHduMq3_Y@localhost.localdomain>
Mail-Followup-To: Pekka Paalanen <pekka.paalanen@collabora.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net,
	Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com
References: <20240223-yuv-v2-0-aa6be2827bb7@bootlin.com>
 <20240223-yuv-v2-4-aa6be2827bb7@bootlin.com>
 <20240226133646.174d3fb2.pekka.paalanen@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226133646.174d3fb2.pekka.paalanen@collabora.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 26/02/24 - 13:36, Pekka Paalanen a écrit :
> On Fri, 23 Feb 2024 12:37:24 +0100
> Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> 
> > Introduce two typedefs: pixel_read_t and pixel_write_t. It allows the
> > compiler to check if the passed functions take the correct arguments.
> > Such typedefs will help ensuring consistency across the code base in
> > case of update of these prototypes.
> > 
> > Introduce a check around the get_pixel_*_functions to avoid using a
> > nullptr as a function.
> > 
> > Document for those typedefs.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_drv.h       | 23 +++++++++++++++++++++--
> >  drivers/gpu/drm/vkms/vkms_formats.c   |  8 ++++----
> >  drivers/gpu/drm/vkms/vkms_formats.h   |  4 ++--
> >  drivers/gpu/drm/vkms/vkms_plane.c     |  9 ++++++++-
> >  drivers/gpu/drm/vkms/vkms_writeback.c |  9 ++++++++-
> >  5 files changed, 43 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > index 18086423a3a7..886c885c8cf5 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > @@ -53,12 +53,31 @@ struct line_buffer {
> >  	struct pixel_argb_u16 *pixels;
> >  };
> >  
> > +/**
> > + * typedef pixel_write_t - These functions are used to read a pixel from a
> > + * `struct pixel_argb_u16*`, convert it in a specific format and write it in the @dst_pixels
> > + * buffer.
> > + *
> > + * @dst_pixel: destination address to write the pixel
> > + * @in_pixel: pixel to write
> > + */
> > +typedef void (*pixel_write_t)(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel);
> 
> There are some inconsistencies in pixel_write_t and pixel_read_t. At
> this point of the series they still operate on a single pixel, but you
> use dst_pixels and src_pixels, plural. Yet the documentation correctly
> talks about processing a single pixel.

I will fix this for v4.
 
> I would also expect the source to be always const, but that's a whole
> another patch to change.

The v4 will contains a new patch "drm/vkms: Use const pointer for 
pixel_read and pixel_write functions"

[...]

> > diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> > index d5203f531d96..f68b1b03d632 100644
> > --- a/drivers/gpu/drm/vkms/vkms_plane.c
> > +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> > @@ -106,6 +106,13 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
> >  		return;
> >  
> >  	fmt = fb->format->format;
> > +	pixel_read_t pixel_read = get_pixel_read_function(fmt);
> > +
> > +	if (!pixel_read) {
> > +		DRM_WARN("Pixel format is not supported by VKMS planes. State is inchanged\n");
> 
> DRM_WARN() is the kernel equivalent to userspace assert(), right?

For the DRM_WARN it is just a standard prinkt(KERN_WARN, ...) (hidden 
behind drm internal macros).

> In that failing the check means an internal invariant was violated,
> which means a code bug in kernel?
>
> Maybe this could be more specific about what invariant was violated?
> E.g. atomic check should have rejected this attempt already.

I'm not an expert (yet) in DRM, so please correct me:
When atomic_update is called, the new state is always validated by 
atomic_check before? There is no way to pass something not validated by 
atomic_check to atomic_update? If this is the case, yes, it should be an 
ERROR and not a WARN as an invalid format passed the atomic_check 
verification.

If so, is this better?

	if (!pixel_read) {
		/*
		 * This is a bug as the vkms_plane_atomic_check must forbid all unsupported formats.
		 */
		DRM_ERROR("Pixel format %4cc is not supported by VKMS planes.\n", fmt);
		return;
	}

I will put the same code in vkms_writeback.c.

[...]

Kind regards,
Louis Chauvet


-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

