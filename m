Return-Path: <linux-kernel+bounces-119402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8455488C84A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FAD1F81782
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0D313CA90;
	Tue, 26 Mar 2024 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hi6HOHr4"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3376E13C8FD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468628; cv=none; b=f6UXV49EKoQzXk0qcECL36g63NXiv/E41yMdQUhcBkvVhec8AgCxobehrMxRn1zxpG4MD520RMoRHLZhWjlE316lM/TSLnStxf21exjRC0/7bLwxJTfYu1pHIWkxYe8NMkDFE6L/rSU6Tq8hoHo4fBwA829ix2WK2MKXmPM1qxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468628; c=relaxed/simple;
	bh=EBI+9tMYCLipOCpwjKvp3IlEV+Hwyx5KQBxjQl3objQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VriKSv1FSVDfL1ztIRvPaXx9iqM5n+EwP67x/LRnNMMTG46gr/9Q00Pep/MiooSyHA68QMmt6h8oLEFUFdTNwNlMs8H+V4UNTVOAQ2yA+LcYGQXjWFWOxMF8mdMlPO+dtPgFukLoO8nTSAZwjNan0LEB7T7u2wzAMK6NDslPfd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hi6HOHr4; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C38DFF807;
	Tue, 26 Mar 2024 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711468624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=17dLP5EusXNy1SINOT7PIRcGQ1Dhr5aZaHALIW3uHc4=;
	b=hi6HOHr4Zwxu4QA1aIWWZM9mkieeAZUAr6vBEAkJpnknehdu2DQtP7Ho3k9YBJ3LCbq7pi
	wyllsDk4R8rCg9eAGyYurGYIfUPDRFe6b0BbApl0q+o6Bbm0CMtI6lZvXYGKtB9VpICCXs
	tNcyESRC3jgEUKmaig1YJS9ZgZ7WEPCjRuFcPoO2Xota5mLhxk0QLZ2vjqIRtBjoIjz7qU
	oe/LvojH9OANFMcz2zYjbJaqMCA7IFIft10EmaYl7IDXjX5EBhdYK2c88PUcy2/919PTS+
	60EJ7VfdMGE30Y4usygzm9r+G5VO3uBVWGTBqHiYFobehK0H4edTPxmkCNs1mA==
Date: Tue, 26 Mar 2024 16:57:00 +0100
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
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH v5 09/16] drm/vkms: Introduce pixel_read_direction enum
Message-ID: <ZgLwTJVb_Z_MHuCp@localhost.localdomain>
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
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
References: <20240313-yuv-v5-0-e610cbd03f52@bootlin.com>
 <20240313-yuv-v5-9-e610cbd03f52@bootlin.com>
 <20240325151103.0a5f7112.pekka.paalanen@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325151103.0a5f7112.pekka.paalanen@collabora.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 25/03/24 - 15:11, Pekka Paalanen a écrit :
> On Wed, 13 Mar 2024 18:45:03 +0100
> Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> 
> > The pixel_read_direction enum is useful to describe the reading direction
> > in a plane. It avoids using the rotation property of DRM, which not
> > practical to know the direction of reading.
> > This patch also introduce two helpers, one to compute the
> > pixel_read_direction from the DRM rotation property, and one to compute
> > the step, in byte, between two successive pixel in a specific direction.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_composer.c | 36 ++++++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/vkms/vkms_drv.h      | 11 +++++++++++
> >  drivers/gpu/drm/vkms/vkms_formats.c  | 30 ++++++++++++++++++++++++++++++
> >  3 files changed, 77 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> > index 9254086f23ff..989bcf59f375 100644
> > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> > @@ -159,6 +159,42 @@ static void apply_lut(const struct vkms_crtc_state *crtc_state, struct line_buff
> >  	}
> >  }
> >  
> > +/**
> > + * direction_for_rotation() - Get the correct reading direction for a given rotation
> > + *
> > + * This function will use the @rotation setting of a source plane to compute the reading
> > + * direction in this plane which correspond to a "left to right writing" in the CRTC.
> > + * For example, if the buffer is reflected on X axis, the pixel must be read from right to left
> > + * to be written from left to right on the CRTC.
> 
> That is a well written description.

Thanks
 
> > + *
> > + * @rotation: Rotation to analyze. It correspond the field @frame_info.rotation.
> > + */
> > +static enum pixel_read_direction direction_for_rotation(unsigned int rotation)
> > +{
> > +	if (rotation & DRM_MODE_ROTATE_0) {
> > +		if (rotation & DRM_MODE_REFLECT_X)
> > +			return READ_RIGHT_TO_LEFT;
> > +		else
> > +			return READ_LEFT_TO_RIGHT;
> > +	} else if (rotation & DRM_MODE_ROTATE_90) {
> > +		if (rotation & DRM_MODE_REFLECT_Y)
> > +			return READ_BOTTOM_TO_TOP;
> > +		else
> > +			return READ_TOP_TO_BOTTOM;
> > +	} else if (rotation & DRM_MODE_ROTATE_180) {
> > +		if (rotation & DRM_MODE_REFLECT_X)
> > +			return READ_LEFT_TO_RIGHT;
> > +		else
> > +			return READ_RIGHT_TO_LEFT;
> > +	} else if (rotation & DRM_MODE_ROTATE_270) {
> > +		if (rotation & DRM_MODE_REFLECT_Y)
> > +			return READ_TOP_TO_BOTTOM;
> > +		else
> > +			return READ_BOTTOM_TO_TOP;
> > +	}
> > +	return READ_LEFT_TO_RIGHT;
> 
> I'm a little worried seeing REFLECT_X is supported only for some
> rotations, and REFLECT_Y for other rotations. Why is an analysis of all
> combinations not necessary?

I don't need to manage all the combination because this is only about 
the "horizontal writing".

So, if you want to write a line in the CRTC, with:
- ROT_0 || REF_X => You need to read the source line from right to left
- ROT_0 => You need to read source buffer from left to right
- ROT_0 || REF_Y => You need to read the source line from left to right

In this case, REF_Y only have an effect on the "column reading". It is not 
needed here because the new version of the blend function will use the 
drm_rect_* helpers to compute the correct y coordinate.

If you think it's clearer, I can create a big switch(rotation) like this:

	switch (rotation) {
	case ROT_0:
	case ROT_0 || REF_X:
		return L2R;
	case ROT_0 || REF_Y:
		return R2L;
	case ROT_90:
	case ROT_90 || REF_X:
		return T2B;
	[...]
	}

So all cases are clearly covered?

> I hope IGT uses FB patterns instead of solid color in its tests of
> rotation to be able to detect the difference.

They use solid colors, and even my new rotation test [3] use solid colors. 
It is mainly for yuv formats with subsampling: if you have formats with 
subsampling, a "software rotated buffer" and a "hardware rotated buffer" 
will not apply the same subsampling, so the colors will be slightly 
different.

> The return values do seem correct to me, assuming I have guessed
> correctly what "X" and "Y" refer to when combined with rotation. I did
> not find good documentation about that.

Yes, it is difficult to understand how rotation and reflexion should 
works in drm. I spend half a day testing all the combination in drm_rect_* 
helpers to understand how this works. According to the code:
- If only rotation or only reflexion, easy as expected
- If reflexion and rotation are mixed, the source buffer is first 
  reflected and then rotated.
 
> Btw. if there are already functions that are able to transform
> coordinates based on the rotation bitfield, you could alternatively use
> them. Transform CRTC point (0, 0) to A, and (1, 0) to B. Now A and B
> are in plane coordinate system, and vector B - A gives you the
> direction. The reason I'm mentioning this is that then you don't have
> to implement yet another copy of the rotation bitfield semantics from
> scratch.

You are totaly right. I will try this elegant method. Yes, there are some 
helpers (drm_rect_rotate_inv), so I will try to do something.

> 
> > +}
> > +
> >  /**
> >   * blend - blend the pixels from all planes and compute crc
> >   * @wb: The writeback frame buffer metadata
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > index 3ead8b39af4a..985e7a92b7bc 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > @@ -69,6 +69,17 @@ struct vkms_writeback_job {
> >  	pixel_write_t pixel_write;
> >  };
> >  
> > +/**
> > + * enum pixel_read_direction - Enum used internaly by VKMS to represent a reading direction in a
> > + * plane.
> > + */
> > +enum pixel_read_direction {
> > +	READ_BOTTOM_TO_TOP,
> > +	READ_TOP_TO_BOTTOM,
> > +	READ_RIGHT_TO_LEFT,
> > +	READ_LEFT_TO_RIGHT
> > +};
> > +
> >  /**
> >   * typedef pixel_read_t - These functions are used to read a pixel in the source frame,
> >   * convert it to `struct pixel_argb_u16` and write it to @out_pixel.
> > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > index 649d75d05b1f..743b6fd06db5 100644
> > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > @@ -75,6 +75,36 @@ static void packed_pixels_addr(const struct vkms_frame_info *frame_info,
> >  	*addr = (u8 *)frame_info->map[0].vaddr + offset;
> >  }
> >  
> > +/**
> > + * get_step_next_block() - Common helper to compute the correct step value between each pixel block
> > + * to read in a certain direction.
> > + *
> > + * As the returned offset is the number of bytes between two consecutive blocks in a direction,
> > + * the caller may have to read multiple pixel before using the next one (for example, to read from
> > + * left to right in a DRM_FORMAT_R1 plane, each block contains 8 pixels, so the step must be used
> > + * only every 8 pixels.
> > + *
> > + * @fb: Framebuffer to iter on
> > + * @direction: Direction of the reading
> > + * @plane_index: Plane to get the step from
> > + */
> > +static int get_step_next_block(struct drm_framebuffer *fb, enum pixel_read_direction direction,
> > +			       int plane_index)
> > +{
> 
> I would have called this something like get_block_step_bytes() for
> example. That makes it clear it returns bytes (not e.g. pixels). "next"
> implies to me that I tell the function the current block, and then it
> gets me the next one. It does not do that, so I'd not use "next".

Nice name, I will took it for the v6.

Thanks,
Louis Chauvet

> > +	switch (direction) {
> > +	case READ_LEFT_TO_RIGHT:
> > +		return fb->format->char_per_block[plane_index];
> > +	case READ_RIGHT_TO_LEFT:
> > +		return -fb->format->char_per_block[plane_index];
> > +	case READ_TOP_TO_BOTTOM:
> > +		return (int)fb->pitches[plane_index];
> > +	case READ_BOTTOM_TO_TOP:
> > +		return -(int)fb->pitches[plane_index];
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Looks good.
> 
> 
> Thanks,
> pq
> 
> > +
> >  static void *get_packed_src_addr(const struct vkms_frame_info *frame_info, int y,
> >  				 int plane_index)
> >  {
> > 
> 



-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

