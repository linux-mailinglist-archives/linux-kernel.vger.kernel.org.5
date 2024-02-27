Return-Path: <linux-kernel+bounces-83470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ACF8699DC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8FEDB2A772
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4D6150982;
	Tue, 27 Feb 2024 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="noO4C/ke"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE5A14CAB3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046144; cv=none; b=NK+5xD5HV4d9wz1bDYTBX7G09JmipUluYif2TVB0AZyVBqePqBIS1uTuanHZFzL39/qzCI4AADqK5M6kyweQiDOn3xVfm+1ApfvjKd3pPTLreIskgJHOzJA88+mVK9wKTnFsMxn/32QiPTATtl0RuFGDrsejQeYaap3QhbgGnzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046144; c=relaxed/simple;
	bh=n1ZqC4bj49ZLK2I2PpUO9NNaL5hd9mz+TpuxMYBkftE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6HdhjPy5kOMdYRBevrN1flW0qZ/v6OQMby7qmFT40tMAg/FVYzrq8hSDdo6vUFmPxQDFgLG1eoP9DgRK/rIOkhfgpPlyxH8GM45ik5/GPTP40xVcSIWfz70Z31/lN6be/0dTXeMDhr2x4ShJf0NSFlJna1Z+GJo6N4Iw0ukwUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=noO4C/ke; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15F16FF809;
	Tue, 27 Feb 2024 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709046134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBKHDIYPj+HNE9FjAS7zUhjLCkAUsBrQ3SSarFJv+T8=;
	b=noO4C/keFcPEcm5qNDqfLVR7wHUd1AwFvwkjs76jtnZlqTiGbISE19k74HDsgULmfJ/Lq0
	ryjidvXqDOggc3tuX1C/EWp0wfYU8NY2k2uEoVrWsfQgJFBM0Ux3Nf+xp6fx/tlco0opdY
	6DoajmnGEeXyHORWgGY8ZAnhq11s5HEd14DhcaFuV8zVuZ4Lk5GGFB1KCeNjopx9Zosss9
	DCvgmObG8KO0tKLKz+hv/P81QIDTAnPJD3o2xR981d8yTlWbjFTpTQZs1J9Aio8M/bX7tn
	V76lL82skWd35onO3yPzPO/91KaOEe21J24dq5LeiONQvN3c28LkMofCe7S6Rw==
Date: Tue, 27 Feb 2024 16:02:11 +0100
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
Subject: Re: [PATCH v2 6/9] drm/vkms: Add YUV support
Message-ID: <Zd35c_CJbhY46TjQ@localhost.localdomain>
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
 <20240223-yuv-v2-6-aa6be2827bb7@bootlin.com>
 <20240226141916.1627bbbd.pekka.paalanen@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226141916.1627bbbd.pekka.paalanen@collabora.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Hi Pekka,

For all the comment related to the conversion part, maybe Arthur have an 
opinion on it, I took his patch as a "black box" (I did not want to 
break (and debug) it).

Le 26/02/24 - 14:19, Pekka Paalanen a écrit :
> On Fri, 23 Feb 2024 12:37:26 +0100
> Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> 
> > From: Arthur Grillo <arthurgrillo@riseup.net>
> > 
> > Add support to the YUV formats bellow:
> > 
> > - NV12
> > - NV16
> > - NV24
> > - NV21
> > - NV61
> > - NV42
> > - YUV420
> > - YUV422
> > - YUV444
> > - YVU420
> > - YVU422
> > - YVU444
> > 
> > The conversion matrices of each encoding and range were obtained by
> > rounding the values of the original conversion matrices multiplied by
> > 2^8. This is done to avoid the use of fixed point operations.
> > 
> > Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> > [Louis Chauvet: Adapted Arthur's work and implemented the read_line_t
> > callbacks for yuv formats]
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_composer.c |   2 +-
> >  drivers/gpu/drm/vkms/vkms_drv.h      |   6 +-
> >  drivers/gpu/drm/vkms/vkms_formats.c  | 289 +++++++++++++++++++++++++++++++++--
> >  drivers/gpu/drm/vkms/vkms_formats.h  |   4 +
> >  drivers/gpu/drm/vkms/vkms_plane.c    |  14 +-
> >  5 files changed, 295 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> > index e555bf9c1aee..54fc5161d565 100644
> > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> > @@ -312,7 +312,7 @@ static void blend(struct vkms_writeback_job *wb,
> >  			 * buffer [1]
> >  			 */
> >  			current_plane->pixel_read_line(
> > -				current_plane->frame_info,
> > +				current_plane,
> >  				x_start,
> >  				y_start,
> >  				direction,
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > index ccc5be009f15..a4f6456cb971 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > @@ -75,6 +75,8 @@ enum pixel_read_direction {
> >  	READ_RIGHT
> >  };
> >  
> > +struct vkms_plane_state;
> > +
> >  /**
> >  <<<<<<< HEAD
> >   * typedef pixel_read_line_t - These functions are used to read a pixel line in the source frame,
> > @@ -87,8 +89,8 @@ enum pixel_read_direction {
> >   * @out_pixel: Pointer where to write the pixel value. Pixels will be written between x_start and
> >   *  x_end.
> >   */
> > -typedef void (*pixel_read_line_t)(struct vkms_frame_info *frame_info, int x_start, int y_start, enum
> > -	pixel_read_direction direction, int count, struct pixel_argb_u16 out_pixel[]);
> > +typedef void (*pixel_read_line_t)(struct vkms_plane_state *frame_info, int x_start, int y_start,
> > +	enum pixel_read_direction direction, int count, struct pixel_argb_u16 out_pixel[]);
> 
> This is the second or third time in this one series changing this type.
> Could you not do the change once, in its own patch if possible?

Sorry, this is not a change here, but a wrong formatting (missed when 
rebasing).

Do you think that it make sense to re-order my patches and put this 
typedef at the end? This way it is never updated.

> >  
> >  /**
> >   * vkms_plane_state - Driver specific plane state
> > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > index 46daea6d3ee9..515c80866a58 100644
> > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > @@ -33,7 +33,8 @@ static size_t packed_pixels_offset(const struct vkms_frame_info *frame_info, int
> >  	 */
> >  	return fb->offsets[plane_index] +
> >  	       (y / drm_format_info_block_width(format, plane_index)) * fb->pitches[plane_index] +
> > -	       (x / drm_format_info_block_height(format, plane_index)) * format->char_per_block[plane_index];
> > +	       (x / drm_format_info_block_height(format, plane_index)) *
> > +	       format->char_per_block[plane_index];
> 
> Shouldn't this be in the patch that added this code in the first place?

Same as above, a wrong formatting, I will remove this change and keep 
everything on one line (even if it's more than 100 chars, it is easier to 
read).

> >  }
> >  
> >  /**
> > @@ -84,6 +85,32 @@ static int get_step_1x1(struct drm_framebuffer *fb, enum pixel_read_direction di
> >  	}
> >  }
> >  
> > +/**
> > + * get_subsampling() - Get the subsampling value on a specific direction
> 
> subsampling divisor

Thanks for this precision.

> > + */
> > +static int get_subsampling(const struct drm_format_info *format,
> > +			   enum pixel_read_direction direction)
> > +{
> > +	if (direction == READ_LEFT || direction == READ_RIGHT)
> > +		return format->hsub;
> > +	else if (direction == READ_DOWN || direction == READ_UP)
> > +		return format->vsub;
> > +	return 1;
> 
> In this and the below function, personally I'd prefer switch-case, with
> a cannot-happen-scream after the switch, so the compiler can warn about
> unhandled enum values.

As for the previous patch, I did not know about this compiler feature, 
thanks!

> > +}
> > +
> > +/**
> > + * get_subsampling_offset() - Get the subsampling offset to use when incrementing the pixel counter
> > + */
> > +static int get_subsampling_offset(const struct drm_format_info *format,
> > +				  enum pixel_read_direction direction, int x_start, int y_start)
> 
> 'start' values as "increments" for a pixel counter? Is something
> misnamed here?
> 
> Is it an increment or an offset?

I don't really know how to name the function. I'm open to suggestions
x_start and y_start are really the coordinate of the starting reading point.

To explain what it does:

When using subsampling, you have to read the next pixel of planes[1..4] 
not at the same "speed" as plane[0]. But I can't only rely on 
"read_pixel_count % subsampling == 0", because it means that the pixel 
incrementation on planes[1..4] may not be aligned with the buffer (if 
hsub=2 and the start pixel is 1, I need to increment planes[1..4] only 
for x=2,4,6... not 1,3,5...).

A way to ensure this is to add an "offset" to count, which ensure that the 
count % subsampling == 0 on the correct pixel.

I made an error, the switch case must be (as count is always counting up, 
for "inverted" reading direction a negative number ensure that 
%subsampling == 0 on the correct pixel):

	switch (direction) {
	case READ_UP:
		return -y_start;
	case READ_DOWN:
		return y_start;
	case READ_LEFT:
		return -x_start;
	case READ_RIGHT:
		return x_start;
	}

> > +{
> > +	if (direction == READ_RIGHT || direction == READ_LEFT)
> > +		return x_start;
> > +	else if (direction == READ_DOWN || direction == READ_UP)
> > +		return y_start;
> > +	return 0;
> > +}
> > +

[...]

> > +static void yuv_u8_to_argb_u16(struct pixel_argb_u16 *argb_u16, const struct pixel_yuv_u8 *yuv_u8,
> > +			       enum drm_color_encoding encoding, enum drm_color_range range)
> > +{
> > +	static const s16 bt601_full[3][3] = {
> > +		{ 256, 0,   359 },
> > +		{ 256, -88, -183 },
> > +		{ 256, 454, 0 },
> > +	};

[...]

> > +
> > +	u8 r = 0;
> > +	u8 g = 0;
> > +	u8 b = 0;
> > +	bool full = range == DRM_COLOR_YCBCR_FULL_RANGE;
> > +	unsigned int y_offset = full ? 0 : 16;
> > +
> > +	switch (encoding) {
> > +	case DRM_COLOR_YCBCR_BT601:
> > +		ycbcr2rgb(full ? bt601_full : bt601,
> 
> Doing all these conditional again pixel by pixel is probably
> inefficient. Just like with the line reading functions, you could pick
> the matrix in advance.

I don't think the performance impact is huge (it's only a pair of if), but 
yes, it's an easy optimization. 

I will create a conversion_matrix structure:

	struct conversion_matrix {
		s16 matrix[3][3];
		u16 y_offset;
	}

I will create a `get_conversion_matrix_to_argb_u16` function to get this 
structure from a format+encoding+range.

I will also add a field `conversion_matrix` in struct vkms_plane_state to 
get this matrix only once per plane setup.


> > +			  yuv_u8->y, yuv_u8->u, yuv_u8->v, y_offset, &r, &g, &b);
> > +		break;
> > +	case DRM_COLOR_YCBCR_BT709:
> > +		ycbcr2rgb(full ? rec709_full : rec709,
> > +			  yuv_u8->y, yuv_u8->u, yuv_u8->v, y_offset, &r, &g, &b);
> > +		break;
> > +	case DRM_COLOR_YCBCR_BT2020:
> > +		ycbcr2rgb(full ? bt2020_full : bt2020,
> > +			  yuv_u8->y, yuv_u8->u, yuv_u8->v, y_offset, &r, &g, &b);
> > +		break;
> > +	default:
> > +		pr_warn_once("Not supported color encoding\n");
> > +		break;
> > +	}
> > +
> > +	argb_u16->r = r * 257;
> > +	argb_u16->g = g * 257;
> > +	argb_u16->b = b * 257;
> 
> I wonder. Using 8-bit fixed point precision seems quite coarse for
> 8-bit pixel formats, and it's going to be insufficient for higher bit
> depths. Was supporting e.g. 10-bit YUV considered? There is even
> deeper, too, like DRM_FORMAT_P016.

It's a good point, as I explained above, I took the conversion part as a 
"black box" to avoid breaking (and debugging) stuff. I think it's easy to 
switch to s32 bits matrix with 16.16 bits (or anything with more than 16 bits in 
the float part).

Maybe Arthur have an opinion on this?

Just to be sure, the DRM subsystem don't have such matrix somewhere? It 
can be nice to avoid duplicating them.

> > +}
> > +
> >  /*
> >   * The following functions are read_line function for each pixel format supported by VKMS.
> >   *
> > @@ -142,13 +250,13 @@ static void RGB565_to_argb_u16(struct pixel_argb_u16 *out_pixel, const u16 *pixe
> >   * [1]: https://lore.kernel.org/dri-devel/d258c8dc-78e9-4509-9037-a98f7f33b3a3@riseup.net/
> >   */
> >  
> > -static void ARGB8888_read_line(struct vkms_frame_info *frame_info, int x_start, int y_start,
> > +static void ARGB8888_read_line(struct vkms_plane_state *plane, int x_start, int y_start,
> >  			       enum pixel_read_direction direction, int count,
> >  			       struct pixel_argb_u16 out_pixel[])
> >  {
> > -	u8 *src_pixels = packed_pixels_addr(frame_info, x_start, y_start, 0);
> > +	u8 *src_pixels = packed_pixels_addr(plane->frame_info, x_start, y_start, 0);
> >  
> > -	int step = get_step_1x1(frame_info->fb, direction, 0);
> > +	int step = get_step_1x1(plane->frame_info->fb, direction, 0);
> 
> These are the kind of changes I would not expect to see in a patch
> adding YUV support. There are a lot of them, too.

I will put it directly this change in PATCHv2 5/9.

[...]

> > +static void semi_planar_yuv_read_line(struct vkms_plane_state *plane, int x_start, int y_start,
> > +				      enum pixel_read_direction direction, int count,
> > +				      struct pixel_argb_u16 out_pixel[])
> > +{
> > +	u8 *y_plane = packed_pixels_addr(plane->frame_info, x_start, y_start, 0);
> > +	u8 *uv_plane = packed_pixels_addr(plane->frame_info,
> > +					  x_start / plane->frame_info->fb->format->hsub,
> > +					  y_start / plane->frame_info->fb->format->vsub,
> > +					  1);
> > +	struct pixel_yuv_u8 yuv_u8;
> > +	int step_y = get_step_1x1(plane->frame_info->fb, direction, 0);
> > +	int step_uv = get_step_1x1(plane->frame_info->fb, direction, 1);
> > +	int subsampling = get_subsampling(plane->frame_info->fb->format, direction);
> > +	int subsampling_offset = get_subsampling_offset(plane->frame_info->fb->format, direction,
> > +							x_start, y_start); // 0
> > +
> > +	for (int i = 0; i < count; i++) {
> > +		yuv_u8.y = y_plane[0];
> > +		yuv_u8.u = uv_plane[0];
> > +		yuv_u8.v = uv_plane[1];
> > +
> > +		yuv_u8_to_argb_u16(out_pixel, &yuv_u8, plane->base.base.color_encoding,
> > +				   plane->base.base.color_range);
> 
> Oh, so this was the reason to change the read-line function signature.
> Maybe just stash a pointer to the right matrix and the right y_offset
> in frame_info instead?

Yes, that why I changed the signature. I think I will keep this signature 
and put the conversion_matrix inside the vkms_plane_state, for me it make 
more sense to have pixel_read_line and conversion_matrix in the same 
structure.

> > +		out_pixel += 1;
> > +		y_plane += step_y;
> > +		if ((i + subsampling_offset + 1) % subsampling == 0)
> > +			uv_plane += step_uv;
> > +	}
> > +}
> > +
> > +static void semi_planar_yvu_read_line(struct vkms_plane_state *plane, int x_start, int y_start,
> > +				      enum pixel_read_direction direction, int count,
> > +				      struct pixel_argb_u16 out_pixel[])
> > +{
> > +	u8 *y_plane = packed_pixels_addr(plane->frame_info, x_start, y_start, 0);
> > +	u8 *vu_plane = packed_pixels_addr(plane->frame_info,
> > +					  x_start / plane->frame_info->fb->format->hsub,
> > +					  y_start / plane->frame_info->fb->format->vsub,
> > +					  1);
> > +	struct pixel_yuv_u8 yuv_u8;
> > +	int step_y = get_step_1x1(plane->frame_info->fb, direction, 0);
> > +	int step_vu = get_step_1x1(plane->frame_info->fb, direction, 1);
> > +	int subsampling = get_subsampling(plane->frame_info->fb->format, direction);
> > +	int subsampling_offset = get_subsampling_offset(plane->frame_info->fb->format, direction,
> > +							x_start, y_start);
> > +	for (int i = 0; i < count; i++) {
> > +		yuv_u8.y = y_plane[0];
> > +		yuv_u8.u = vu_plane[1];
> > +		yuv_u8.v = vu_plane[0];
> 
> You could swap matrix columns instead of writing this whole new
> function for UV vs. VU. Just an idea.

I was not happy with this duplication too, but I did not think about 
switching columns. That's a good idea, thanks!
 
Kind regards,
Louis Chauvet

[...]

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

