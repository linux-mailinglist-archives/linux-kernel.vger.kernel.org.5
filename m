Return-Path: <linux-kernel+bounces-48609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6231845ECC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01EDD1C24F4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE90C7C6D9;
	Thu,  1 Feb 2024 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kOW6lnTv"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985A67C6C9;
	Thu,  1 Feb 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809427; cv=none; b=LtJwKDSY8bP6v/QuxRdoThBB1huzjh3aP2jqmhLLmJNg9JLQj+JR72iJm24R9L1wiX8LQgKp7qG0kGy2cj4MwEbgb1ru7IpXqf+DLyw1eWvRCsWdVlkASbsD86A2t97PapR1s08wWhM9aqlmxfeRXMdBuUqbte2inTsjM+rPuHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809427; c=relaxed/simple;
	bh=zNaI67gQwGY7XBmNa5Jg7GH30q48/1KPhw6uF+V0oKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqmVez6fT/zeJqK8j3PJMZSKwr3ZU0CPTkbkiuGgF5W1God2nb1uW53LiZgFCh0XHcDYXHE2cndPk8+p9ek0cHGnlvbRhB7vPnk9Fz14aQ2BzK9NJX26gy+sv4NFFsIVbFHwjJCyl/ak0kaSVj0RD4m0WNeWuBk3ESh4RfA13qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kOW6lnTv; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 10C37E0002;
	Thu,  1 Feb 2024 17:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706809417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2GjarAU0/4cvseSJWv/5fwzExnbqC46sAfI2wFgFzc=;
	b=kOW6lnTvVzPDeiy/lu4wSWZFBzJst7yBqhhQNvBp2ArqbalQRIOwZxuSqh5TMGTfA/PfPP
	KcdpV8U86DHKrlfUSsVWBszNXSwFFsN6Vl1yUA00iVJR1ZlGJ7wdaKodmuzbN93cQhemP2
	4DswGWCuLp5kt584AqHDjfLeCrq/74mKpM5Ty1uRh6eLajEWLA6XPL/uCRrVcLmo4wgoG+
	2yLdqMZLiWPc45VPQjInhUxohzWopaG6ZZvYR2v3PwO/VELnm6jHobsbrdV67xI6hhkxbD
	/PE3dFqJpnuzXYpK2l/eapTEE032S5zVBz+SO3R0EFAUDVp/6cFc+iDnTNiiPw==
Date: Thu, 1 Feb 2024 18:43:34 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Arthur Grillo <arthurgrillo@riseup.net>
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Melissa Wen <melissa.srw@gmail.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/7] drm/vkms: Use drm_frame directly
Message-ID: <ZbvYRss3UuSlCSdW@localhost.localdomain>
Mail-Followup-To: Arthur Grillo <arthurgrillo@riseup.net>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Melissa Wen <melissa.srw@gmail.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org
References: <20240110-vkms-yuv-v2-0-952fcaa5a193@riseup.net>
 <20240110-vkms-yuv-v2-1-952fcaa5a193@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240110-vkms-yuv-v2-1-952fcaa5a193@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 10/01/24 - 14:44, Arthur Grillo a écrit :
> Remove intermidiary variables and access the variables directly from
> drm_frame. These changes should be noop.
> 
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.h       |  3 ---
>  drivers/gpu/drm/vkms/vkms_formats.c   | 12 +++++++-----
>  drivers/gpu/drm/vkms/vkms_plane.c     |  3 ---
>  drivers/gpu/drm/vkms/vkms_writeback.c |  5 -----
>  4 files changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 8f5710debb1e..b4b357447292 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -31,9 +31,6 @@ struct vkms_frame_info {
>  	struct drm_rect rotated;
>  	struct iosys_map map[DRM_FORMAT_MAX_PLANES];
>  	unsigned int rotation;
> -	unsigned int offset;
> -	unsigned int pitch;
> -	unsigned int cpp;
>  };
>  
>  struct pixel_argb_u16 {
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 36046b12f296..172830a3936a 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -11,8 +11,10 @@
>  
>  static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int y)
>  {
> -	return frame_info->offset + (y * frame_info->pitch)
> -				  + (x * frame_info->cpp);
> +	struct drm_framebuffer *fb = frame_info->fb;
> +
> +	return fb->offsets[0] + (y * fb->pitches[0])
> +			      + (x * fb->format->cpp[0]);
>  }
>  
>  /*
> @@ -131,12 +133,12 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
>  	u8 *src_pixels = get_packed_src_addr(frame_info, y);
>  	int limit = min_t(size_t, drm_rect_width(&frame_info->dst), stage_buffer->n_pixels);
>  
> -	for (size_t x = 0; x < limit; x++, src_pixels += frame_info->cpp) {
> +	for (size_t x = 0; x < limit; x++, src_pixels += frame_info->fb->format->cpp[0]) {
>  		int x_pos = get_x_position(frame_info, limit, x);
>  
>  		if (drm_rotation_90_or_270(frame_info->rotation))
>  			src_pixels = get_packed_src_addr(frame_info, x + frame_info->rotated.y1)
> -				+ frame_info->cpp * y;
> +				+ frame_info->fb->format->cpp[0] * y;
>  
>  		plane->pixel_read(src_pixels, &out_pixels[x_pos]);
>  	}
> @@ -223,7 +225,7 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
>  	struct pixel_argb_u16 *in_pixels = src_buffer->pixels;
>  	int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst), src_buffer->n_pixels);
>  
> -	for (size_t x = 0; x < x_limit; x++, dst_pixels += frame_info->cpp)
> +	for (size_t x = 0; x < x_limit; x++, dst_pixels += frame_info->fb->format->cpp[0])
>  		wb->pixel_write(dst_pixels, &in_pixels[x]);
>  }
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index e5c625ab8e3e..8f2c6ea419a3 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -125,9 +125,6 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
>  	drm_rect_rotate(&frame_info->rotated, drm_rect_width(&frame_info->rotated),
>  			drm_rect_height(&frame_info->rotated), frame_info->rotation);
>  
> -	frame_info->offset = fb->offsets[0];
> -	frame_info->pitch = fb->pitches[0];
> -	frame_info->cpp = fb->format->cpp[0];
>  	vkms_plane_state->pixel_read = get_pixel_conversion_function(fmt);
>  }
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index bc724cbd5e3a..c8582df1f739 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -149,11 +149,6 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
>  	crtc_state->active_writeback = active_wb;
>  	crtc_state->wb_pending = true;
>  	spin_unlock_irq(&output->composer_lock);
> -
> -	wb_frame_info->offset = fb->offsets[0];
> -	wb_frame_info->pitch = fb->pitches[0];
> -	wb_frame_info->cpp = fb->format->cpp[0];
> -
>  	drm_writeback_queue_job(wb_conn, connector_state);
>  	active_wb->pixel_write = get_pixel_write_function(wb_format);
>  	drm_rect_init(&wb_frame_info->src, 0, 0, crtc_width, crtc_height);
> 
> -- 
> 2.43.0
> 

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

