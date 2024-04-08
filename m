Return-Path: <linux-kernel+bounces-134963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D33189B964
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608801C220B2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4644A4F5EA;
	Mon,  8 Apr 2024 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XAC/suZQ"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C967D4F1F2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562626; cv=none; b=UH/7C6I7uFI6HNGrnGk9W/hgbQddPvLA+4hgFlBMgUmsxI2FAoBCxujzY2peVKtnb7b9JlpdXykkt2fqzpArgeKHLst5E8HMNtV4b0jBoc4P90pBBxV0tsXZ5ko9Nt8mJpitS9D2B9j6JMT0GHFrG2CsT953blS/eKg3S0UCFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562626; c=relaxed/simple;
	bh=WqdOCdrY/xOmno0//WQBT+1RV9eg4o/bNCEn6yn9ju0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4UEWZQSEdHqOLJS7il9qLwh38kGt2CmKZsGXFYZDka+rkQR+hJMQW+PE6Otp9z6vgErvD0OeZzbaE9n9ZjjeJb6Xo3buFJRjTlIcqwmzuOHLWeNzSvpNIkwgL50ZXCgGECTgvFVRPfDu07D8Zyg1rrTGruPTfZ/jZkpVNNnveE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XAC/suZQ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3784FE000B;
	Mon,  8 Apr 2024 07:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712562622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IAPqJ4g313zE/TlE7dp772NjLJOJwn+82LmIi07EBrY=;
	b=XAC/suZQmLIRPrfczo9z+hTWEqZ18SHKMxnn5Os9F/2zPcMfAqP5GYPKPCuwd5+6gIQEqh
	nInJ1cWtKCmaywyH9GE4N8rsAq6beNi2NzByk+EryKSEK6D6vxPRoCO5KjwTmhaxXhK8ry
	wb94Sf62MQN0R+P84Da8HjULTAringuBUaBfJ5NArPOeGtLnQyLTTko/RzZTv+XD5ziV4b
	L47ZZxNwNsg8c4w4klnx4f60Sd+nI3sUew1bnKPToew9x7IGoHtSjCrhPGMO8wBscG2e0T
	zCpX8qz5pbUKJ4KvplVaze68ZZd+0gUV1mmr85K6N+sxW1YWltqtttCF/j2sPg==
Date: Mon, 8 Apr 2024 09:50:18 +0200
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
Subject: Re: [PATCH v5 10/16] drm/vkms: Re-introduce line-per-line
 composition algorithm
Message-ID: <ZhOhuoVhM2pHbrfm@louis-chauvet-laptop>
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
 <20240313-yuv-v5-10-e610cbd03f52@bootlin.com>
 <20240325174309.28f91bec.pekka.paalanen@collabora.com>
 <ZgLwTvjdzf8KTZsY@localhost.localdomain>
 <20240327142951.192e0b5f.pekka.paalanen@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327142951.192e0b5f.pekka.paalanen@collabora.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 27/03/24 - 14:29, Pekka Paalanen a écrit :
> On Tue, 26 Mar 2024 16:57:02 +0100
> Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> 
> > [...]
> > 
> > > > @@ -215,34 +188,146 @@ static void blend(struct vkms_writeback_job *wb,
> > > >  {
> > > >  	struct vkms_plane_state **plane = crtc_state->active_planes;
> > > >  	u32 n_active_planes = crtc_state->num_active_planes;
> > > > -	int y_pos, x_dst, x_limit;
> > > >  
> > > >  	const struct pixel_argb_u16 background_color = { .a = 0xffff };
> > > >  
> > > > -	size_t crtc_y_limit = crtc_state->base.crtc->mode.vdisplay;
> > > > +	int crtc_y_limit = crtc_state->base.crtc->mode.vdisplay;
> > > > +	int crtc_x_limit = crtc_state->base.crtc->mode.hdisplay;
> > > >  
> > > >  	/*
> > > >  	 * The planes are composed line-by-line to avoid heavy memory usage. It is a necessary
> > > >  	 * complexity to avoid poor blending performance.
> > > >  	 *
> > > > -	 * The function vkms_compose_row is used to read a line, pixel-by-pixel, into the staging
> > > > -	 * buffer.
> > > > +	 * The function pixel_read_line callback is used to read a line, using an efficient
> > > > +	 * algorithm for a specific format, into the staging buffer.
> > > >  	 */
> > > >  	for (size_t y = 0; y < crtc_y_limit; y++) {
> > > >  		fill_background(&background_color, output_buffer);
> > > >  
> > > >  		/* The active planes are composed associatively in z-order. */
> > > >  		for (size_t i = 0; i < n_active_planes; i++) {
> > > > -			x_dst = plane[i]->frame_info->dst.x1;
> > > > -			x_limit = min_t(size_t, drm_rect_width(&plane[i]->frame_info->dst),
> > > > -					stage_buffer->n_pixels);
> > > > -			y_pos = get_y_pos(plane[i]->frame_info, y);
> > > > +			struct vkms_plane_state *current_plane = plane[i];
> > > >  
> > > > -			if (!check_limit(plane[i]->frame_info, y_pos))
> > > > +			/* Avoid rendering useless lines */
> > > > +			if (y < current_plane->frame_info->dst.y1 ||
> > > > +			    y >= current_plane->frame_info->dst.y2)
> > > >  				continue;
> > > >  
> > > > -			vkms_compose_row(stage_buffer, plane[i], y_pos);
> > > > -			pre_mul_alpha_blend(stage_buffer, output_buffer, x_dst, x_limit);
> > > > +			/*
> > > > +			 * dst_line is the line to copy. The initial coordinates are inside the  
> > 
> > [...]
> > 
> > > > +				 */
> > > > +				pixel_count = drm_rect_width(&src_line);
> > > > +				if (x_start < 0) {
> > > > +					pixel_count += x_start;
> > > > +					x_start = 0;
> > > > +				}
> > > > +				if (x_start + pixel_count > current_plane->frame_info->fb->width) {
> > > > +					pixel_count =
> > > > +						(int)current_plane->frame_info->fb->width - x_start;
> > > > +				}
> > > > +			} else {
> > > > +				/*
> > > > +				 * In vertical reading, the src_line height is the number of pixel
> > > > +				 * to read
> > > > +				 */
> > > > +				pixel_count = drm_rect_height(&src_line);
> > > > +				if (y_start < 0) {
> > > > +					pixel_count += y_start;
> > > > +					y_start = 0;
> > > > +				}
> > > > +				if (y_start + pixel_count > current_plane->frame_info->fb->height) {
> > > > +					pixel_count =
> > > > +						(int)current_plane->frame_info->fb->width - y_start;
> > > > +				}  
> > > 
> > > When you are clamping x_start or y_start or pixel_count to be inside
> > > the source FB, should you not equally adjust the destination
> > > coordinates as well?  
> > 
> > I did not think about it. Currently it is not an issue and it will not 
> > read or write outside a buffer because the pixel count is properly 
> > limited. But indeed, there is an issue here. I will fix it in the v6.
> >  
> > > If we take a step back and look at the UAPI, I believe the answer is
> > > "no", but it's in no way obvious. It results from the combination of
> > > several facts:
> > > 
> > > - UAPI checks reject any source rectangle that extends outside of the
> > >   source FB.
> > > 
> > > - The source rectangle stretches to fill the destination rectangle
> > >   exactly.
> > > 
> > > - VKMS does not support stretching (scaling), so its UAPI checks reject
> > >   any commit with source and destination rectangles of different sizes
> > >   after accounting for rotation. (Right?)  
> > 
> > I don't know what are exactly the UAPI contract but as the dst can be 
> > outside the CRTC, I assumed that the src can be outside the source plane. 
> > After thinking it doesn't really make sense.
> 
> The UAPI contract for source and destination rectangles is here:
> https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#standard-plane-properties
> 
> I assume there is some shared (helper?) code in DRM that enforces the
> contract and returns error to userspace if it is violated.
> 
> > > I think this results in the clamping code being actually dead code.
> > > However, I would not delete the clamping code, because it is a cheap
> > > safety net in case something goes wrong.  
> > 
> > If UAPI check that the source rectangle is inside the plane, yes it is 
> > just a safety net. Otherwise, it is required to manage properly the 
> > userspace requests. In the v6, the outside of a source buffer is 
> > transparent.
> > 
> > > If you agree that it's just a safety net, then maybe explain that in a
> > > comment? If the safety net catches anything, the composition result
> > > will be wrong anyway, so it doesn't matter to adjust the destination
> > > rectangle to match.  
> > 
> > I will extract this whole clamping stuff in a function, is this comment 
> > enough?
> > 
> >  * This function is mainly a safety net to avoid reading outside the source buffer. As the
> >  * userspace should never ask to read outside the source plane, all the cases covered here should
> >  * be dead code.
> 
> Sure. Perhaps use a bit more assertive tone about what the UAPI
> contract guarantees. Yes, userspace "should not", but the kernel DRM
> code ensures that it does not.

 * This function is mainly a safety net to avoid reading outside the source buffer. As the
 * userspace can't ask to read outside the source plane, all the cases covered here should
 * be dead code.
 
> > > When the last point is relaxed and VKMS gains scaling support, I think
> > > it won't change the fact that the clamping remains as a safety net. It
> > > just increases the risk of bugs that would be caught by the net.
> > > 
> > > Going outside of FB boundaries is a serious bug and deserves to be
> > > checked. Going outside of the source rectangle would be a bug too,
> > > assuming that partially included pixels are considered fully included,
> > > but it's not serious enough to warrant explicit checks. Ideally IGT
> > > would catch it.  
> > 
> > That was exactly the idea behind all those check and clamping: avoid 
> > access outside the buffers.
> 
> Good.
> 
> To catch a driver using pixels outside of a source rectangle, the test
> FB in IGT should be painted to have a different non-black color outside
> of the source rectangle.

The IGT test kms_plane already does that, you can use an option to ask for 
a border around the framebuffer.

Thanks,
Louis Chauvet

> > > > +			}
> > > > +
> > > > +			if (pixel_count <= 0) {
> > > > +				/* Nothing to read, so avoid multiple function calls for nothing */
> > > > +				continue;
> > > > +			}
> > > > +
> > > > +			/*
> > > > +			 * Modify the starting point to take in account the rotation
> > > > +			 *
> > > > +			 * src_line is the top-left corner, so when reading READ_RIGHT_TO_LEFT or
> > > > +			 * READ_BOTTOM_TO_TOP, it must be changed to the top-right/bottom-left
> > > > +			 * corner.
> > > > +			 */
> > > > +			if (direction == READ_RIGHT_TO_LEFT) {
> > > > +				// x_start is now the right point
> > > > +				x_start += pixel_count - 1;
> > > > +			} else if (direction == READ_BOTTOM_TO_TOP) {
> > > > +				// y_start is now the bottom point
> > > > +				y_start += pixel_count - 1;
> > > > +			}
> > > > +
> > > > +			/*
> > > > +			 * Perform the conversion and the blending
> > > > +			 *
> > > > +			 * Here we know that the read line (x_start, y_start, pixel_count) is
> > > > +			 * inside the source buffer [2] and we don't write outside the stage
> > > > +			 * buffer [1]
> > > > +			 */
> > > > +			current_plane->pixel_read_line(
> > > > +				current_plane, x_start, y_start, direction, pixel_count,
> > > > +				&stage_buffer->pixels[current_plane->frame_info->dst.x1]);
> > > > +
> > > > +			pre_mul_alpha_blend(stage_buffer, output_buffer,
> > > > +					    current_plane->frame_info->dst.x1,
> > > > +					    pixel_count);
> > > >  		}
> > > >  
> > > >  		apply_lut(crtc_state, output_buffer);
> > > > @@ -250,7 +335,7 @@ static void blend(struct vkms_writeback_job *wb,
> > > >  		*crc32 = crc32_le(*crc32, (void *)output_buffer->pixels, row_size);
> > > >  
> > > >  		if (wb)
> > > > -			vkms_writeback_row(wb, output_buffer, y_pos);
> > > > +			vkms_writeback_row(wb, output_buffer, y);
> > > >  	}
> > > >  }
> 
> 
> Thanks,
> pq



-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

