Return-Path: <linux-kernel+bounces-83461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B92708699DF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D44D1B22807
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E781214900F;
	Tue, 27 Feb 2024 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KwBl9dAR"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D411487E2
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046138; cv=none; b=mK2z/cBcaVgMaWSq5g0RX1D2MQSlrubdlONni7x5bAx49RJgyKGX83wF1+8nGz3Z7RJlaYU33Fc7CsyYrCCjmMHu/aEdrUotzJBQyotZ1jqUA9AO459fIHAcT9fpxETb0Kr32m13TsMow6GzldMnsuspJrO5+2CDYYw8DxlNqww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046138; c=relaxed/simple;
	bh=ybqwmmlcMDOwEul7YMejSqZis3uLTJ1vQCESzmRIbC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOzBnOzOCkphtk5EPqLVVgQgQVtGUGDsdlzbHpcAeLpUsuGkVPF29RqSJDpS1MgTAUOA8heVzO7B458b+Q3ysOtk1SN1I7GlD+c6uNzpkLhiGaFLyCaNGZeaC+EAdX+GVgDVW8xmIyp05959UXLKLcV0CjD8eTtAwkjqpVoRE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KwBl9dAR; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0846B1BF218;
	Tue, 27 Feb 2024 15:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709046132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a4roEWTyexJghfiZAjmtK/V8pQTSB7RZd5sDcW9wIp0=;
	b=KwBl9dARBOfJgfbSY66eU+7u9O1ZVBIAKHtyzsZrPHZIbZ+e/9YDqL3iTz0XABgXUy0SNX
	tmOEYIgAYeRmjkGYkQAdMs+nqTGrGni/UsulFcvK/Mst90tsSr0IeJ5YFd8pcCN41IMi/G
	HpblAwR6rP7HuppExnkCB5dO5luVw5WNxosQhNiBzIOVKvxjutQ2MVwifFS5x4tjaBalHl
	sksi+fGPtCsakpy6ARFqgR11XbHA/56ydcgfBiCiN07g82WYJe0K2v5Eb9Hg9N1j/K74vi
	oPaYJPo0quwHy3jG0ouHRmdAIauWAulQUTSARTDbB9he2m8I+8FsfGfjB/YiIQ==
Date: Tue, 27 Feb 2024 16:02:10 +0100
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
Subject: Re: [PATCH v2 3/9] drm/vkms: write/update the documentation for
 pixel conversion and pixel write functions
Message-ID: <Zd35cimh8BLICUuY@localhost.localdomain>
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
 <20240223-yuv-v2-3-aa6be2827bb7@bootlin.com>
 <20240226133700.3fef91d9.pekka.paalanen@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226133700.3fef91d9.pekka.paalanen@collabora.com>
X-GND-Sasl: louis.chauvet@bootlin.com

[...]

> > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > index 172830a3936a..cb7a49b7c8e7 100644
> > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > @@ -9,6 +9,17 @@
> >  
> >  #include "vkms_formats.h"
> >  
> > +/**
> > + * packed_pixels_offset() - Get the offset of the block containing the pixel at coordinates x/y
> > + * in the first plane
> > + *
> > + * @frame_info: Buffer metadata
> > + * @x: The x coordinate of the wanted pixel in the buffer
> > + * @y: The y coordinate of the wanted pixel in the buffer
> > + *
> > + * The caller must be aware that this offset is not always a pointer to a pixel. If individual
> > + * pixel values are needed, they have to be extracted from the resulting block.
> 
> Just wondering how the caller will be able to extract the right pixel
> from the block without re-using the knowledge already used in this
> function. I'd also expect the function to round down x,y to be
> divisible by block dimensions, but that's not visible in this email.
> Then the caller needs the remainder from the round-down, too?

You are right, the current implementation is only working when block_h == 
block_w == 1. I think I wrote the documentation for PATCHv2 5/9, but when 
backporting this comment for PATCHv2 3/9 I forgot to update it.
The new comment will be:

 * pixels_offset() - Get the offset of a given pixel data at coordinate 
 * x/y in the first plane
   [...]
 * The caller must ensure that the framebuffer associated with this 
 * request uses a pixel format where block_h == block_w == 1.
 * If this requirement is not fulfilled, the resulting offset can be 
 * completly wrong.

And yes, even after PATCHv2 5/9 it is not clear what is the offset. Is 
this better to replace the last sentence? (I will do the same update for 
the last sentence of packed_pixels_addr)

   [...]
 * The returned offset correspond to the offset of the block containing the pixel at coordinates 
 * x/y.
 * The caller must use this offset with care, as for formats with block_h != 1 or block_w != 1 
 * the requested pixel value may have to be extracted from the block, even if they are 
 * individually adressable.
 
> > + */
> >  static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int y)
> >  {
> >  	struct drm_framebuffer *fb = frame_info->fb;
> > @@ -17,12 +28,13 @@ static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int
> >  			      + (x * fb->format->cpp[0]);
> >  }
> >  

[...]

> > +/**
> > + * Retrieve the correct read_pixel function for a specific format.
> > + * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
> > + * pointer is valid before using it in a vkms_plane_state.
> > + *
> > + * @format: 4cc of the format
> 
> Since there are many different 4cc style pixel format definition tables
> in existence with conflicting definitions, it would not hurt to be more
> specific that this is about DRM_FORMAT_* or drm_fourcc.h.

Is this better?

   @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])

> > + */
> >  void *get_pixel_conversion_function(u32 format)
> >  {
> >  	switch (format) {
> > @@ -247,6 +280,13 @@ void *get_pixel_conversion_function(u32 format)
> >  	}
> >  }
> >  
> > +/**
> > + * Retrieve the correct write_pixel function for a specific format.
> > + * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
> > + * pointer is valid before using it in a vkms_writeback_job.
> > + *
> > + * @format: 4cc of the format
> 
> This too.

Ack, I will use the same as above

> > + */
> >  void *get_pixel_write_function(u32 format)
> >  {
> >  	switch (format) {
> > 
> 
> I couldn't check if the docs are correct since the patch context is not
> wide enough, but they all sound plausible to me.

I checked again, I don't see other errors than your first comment.
 
> 
> Thanks,
> pq

Kind regards,
Louis Chauvet

--
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

