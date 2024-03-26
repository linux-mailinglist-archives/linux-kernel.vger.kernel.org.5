Return-Path: <linux-kernel+bounces-119411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C881E88C874
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31DEDB26EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD4613D29F;
	Tue, 26 Mar 2024 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="la2gUlTb"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FAE13C8F7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468637; cv=none; b=H2dWtrMYrbR+uFQ3cBKztE6p68xD6JnoyGZCRc4vuJZ6fGS/+PJOxOIZZE8JWa5+Ypg3hjMcEikeofHDFYRqEzRqIJ8OGypwF2m9wxFV+fjTskrWxftBnr7ZV35hMz9aJJ7/XLlIK0Crgklp0Eulee1pMv73KGvGsAjFI2JJ6yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468637; c=relaxed/simple;
	bh=WKB9LCUW2NfLckwAjT+xgj+dBckCglG7I/Vs6uyMsgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFz74TsUg2wnCo+18LKyqz7vRyyHFgaHEsPKEeHQxG/Hs634gbXeWZNIMlb43ntfh8FUpFqWoj77ZfUuOECViIy7GTOxgCse5XJNfUxUgDS+HygWUuE46wyOp86UmFz6nktr0DBnfkjw86XTCTZTEM3/RyHH0ZTGy27GYtcZ+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=la2gUlTb; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 794E06000A;
	Tue, 26 Mar 2024 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711468627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpI7AsFFwuwahUd/Ix1I35YDWVAvrwAzlUuyygSJgsQ=;
	b=la2gUlTbrXX0AtB/bHqFWTPBoySL1Isl0U6U6YwWnzNlYiDNXYuvHs1TujbLBT1B2fzQ7m
	Mvhaodv0FqUnHV3lDq9yqr4M/a26MsofopO1RUwvZGvKhsnKe2SJ1inRJR1o3WFQ7Tpv6J
	3RWexpF7y8SivjsviDihAKZvbAmZE8JiRkXR4NA9e1bBkTFjpP37EiD5fVXOvUkonFzhZu
	FNNtrrexdj9slUusBS9NrzIBxA7Woo0J2rXolj1USgv3u1mxE06aL6tkl3PD7M617Tba3b
	4PoVF1LmsmdqzuO1ok25rq3aMtbrWYM8FgEaUOUyFQqVYxzy5EgKKA+lEkECQQ==
Date: Tue, 26 Mar 2024 16:57:01 +0100
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
Subject: Re: [PATCH v5 09/16] drm/vkms: Introduce pixel_read_direction enum
Message-ID: <ZgLwTbd_LHwsDF0I@localhost.localdomain>
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
 <20240313-yuv-v5-9-e610cbd03f52@bootlin.com>
 <ecffe7bd-98bc-444a-bf5b-d8f3ff933a34@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecffe7bd-98bc-444a-bf5b-d8f3ff933a34@igalia.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 25/03/24 - 11:07, Maíra Canal a écrit :
> On 3/13/24 14:45, Louis Chauvet wrote:
> > The pixel_read_direction enum is useful to describe the reading direction
> > in a plane. It avoids using the rotation property of DRM, which not
> > practical to know the direction of reading.
> > This patch also introduce two helpers, one to compute the
> > pixel_read_direction from the DRM rotation property, and one to compute
> > the step, in byte, between two successive pixel in a specific direction.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >   drivers/gpu/drm/vkms/vkms_composer.c | 36 ++++++++++++++++++++++++++++++++++++
> >   drivers/gpu/drm/vkms/vkms_drv.h      | 11 +++++++++++
> >   drivers/gpu/drm/vkms/vkms_formats.c  | 30 ++++++++++++++++++++++++++++++
> >   3 files changed, 77 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> > index 9254086f23ff..989bcf59f375 100644
> > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> > @@ -159,6 +159,42 @@ static void apply_lut(const struct vkms_crtc_state *crtc_state, struct line_buff
> >   	}
> >   }
> >   
> > +/**
> > + * direction_for_rotation() - Get the correct reading direction for a given rotation
> > + *
> > + * This function will use the @rotation setting of a source plane to compute the reading
> > + * direction in this plane which correspond to a "left to right writing" in the CRTC.
> > + * For example, if the buffer is reflected on X axis, the pixel must be read from right to left
> > + * to be written from left to right on the CRTC.
> > + *
> > + * @rotation: Rotation to analyze. It correspond the field @frame_info.rotation.
> 
> A bit unusual to see arguments after the description.

Fixed in v6.
 
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
> > +}
> > +
> >   /**
> >    * blend - blend the pixels from all planes and compute crc
> >    * @wb: The writeback frame buffer metadata
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > index 3ead8b39af4a..985e7a92b7bc 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > @@ -69,6 +69,17 @@ struct vkms_writeback_job {
> >   	pixel_write_t pixel_write;
> >   };
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
> >   /**
> >    * typedef pixel_read_t - These functions are used to read a pixel in the source frame,
> >    * convert it to `struct pixel_argb_u16` and write it to @out_pixel.
> > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > index 649d75d05b1f..743b6fd06db5 100644
> > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > @@ -75,6 +75,36 @@ static void packed_pixels_addr(const struct vkms_frame_info *frame_info,
> >   	*addr = (u8 *)frame_info->map[0].vaddr + offset;
> >   }
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
> 
> Same.

Fixed in v6.

Thanks,
Louis Chauvet
 
> Best Regards,
> - Maíra
> 
> > + */
> > +static int get_step_next_block(struct drm_framebuffer *fb, enum pixel_read_direction direction,
> > +			       int plane_index)
> > +{
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
> > +
> >   static void *get_packed_src_addr(const struct vkms_frame_info *frame_info, int y,
> >   				 int plane_index)
> >   {
> > 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

