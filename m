Return-Path: <linux-kernel+bounces-119409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF3888C853
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB4132377C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD8A13D25B;
	Tue, 26 Mar 2024 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q85Qfhmn"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9205013C8EC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468634; cv=none; b=TVcLkWoJxMS+x9b4x+InP2ZOPI1zW3wt6tDWOs62Cw4t4/aeVFW+Kl7IQNcDRr9nLRWutDcc7X6gcvaxdJI6p4yeNe6eiTsNl6/N3TPA6Y8QFvX71TZLk/fq3rpfmTgjQglwSCs8YLGoBnm91k7vsCVJfjrE1+EHMIS7mw8zXPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468634; c=relaxed/simple;
	bh=/86P2xRlq6dzqzFLUaNHlwgY9i+1+hEvS45HNU8ds/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbFRfmqARZbkkxw4jdvEg//asww9RVz0oo+Ko0GNrx3PaAglSG3/m8inA/ODpKG60HbNBEB7O9EIOpGmZmc7qUSvaUHtT3IooUGgfVCncEwkTJA13V8ieaKCBR2B14l8OZ8gXVWKLQsg8/yKmrk45UCXXbiudFGzEXhFcZUBThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q85Qfhmn; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52F291BF209;
	Tue, 26 Mar 2024 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711468624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q1uJ/RBI+EkkLIUGkhABf9Eh5HJHwMfNRGz85xDYfxU=;
	b=Q85Qfhmn63Gr9VJy1jvFJFWp7zCfZf7FFYjAio0Zx9nFnDWqTJvE7hebKmLJX9NRoGlDe4
	X9KhqxgHqTAffeh8H2wRTfYg0F4zETt/PJQBEHqkNcnRgCuzrdlIpT5aIPfcdTJVj6EyiF
	mkJLSXxrDRb3ifYnwgF6rKewqm9odzf6Jk6gdRj3H5nrFqhzB6f39pQgI04uxhCoVrVebY
	yRfkKxjlgbARfrqbslPoFNgdAn4+LdzAm60xT2M9aEOLEm+wHOQ2X/Ncx7dDSGB8YsssMO
	hPCCtPsFSyJhADVFBGPrQ7QhrxlhzT4zD/YclPq8g5drsemMxlmQE2fVHopFeA==
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
Subject: Re: [PATCH v5 08/16] drm/vkms: Avoid computing blending limits
 inside pre_mul_alpha_blend
Message-ID: <ZgLwTNsehDG4z6Bo@localhost.localdomain>
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
 <20240313-yuv-v5-8-e610cbd03f52@bootlin.com>
 <20240325144101.6d9fcf7e.pekka.paalanen@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325144101.6d9fcf7e.pekka.paalanen@collabora.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 25/03/24 - 14:41, Pekka Paalanen a écrit :
> On Wed, 13 Mar 2024 18:45:02 +0100
> Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> 
> > The pre_mul_alpha_blend is dedicated to blending, so to avoid mixing
> > different concepts (coordinate calculation and color management), extract
> > the x_limit and x_dst computation outside of this helper.
> > It also increases the maintainability by grouping the computation related
> > to coordinates in the same place: the loop in `blend`.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_composer.c | 40 +++++++++++++++++-------------------
> >  1 file changed, 19 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> > index da0651a94c9b..9254086f23ff 100644
> > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> > @@ -24,34 +24,30 @@ static u16 pre_mul_blend_channel(u16 src, u16 dst, u16 alpha)
> >  
> >  /**
> >   * pre_mul_alpha_blend - alpha blending equation
> > - * @frame_info: Source framebuffer's metadata
> >   * @stage_buffer: The line with the pixels from src_plane
> >   * @output_buffer: A line buffer that receives all the blends output
> > + * @x_start: The start offset to avoid useless copy
> 
> I'd say just:
> 
> + * @x_start: The start offset
> 
> It describes the parameter, and the paragraph below explains the why.
> 
> It would be explaining, that x_start applies to output_buffer, but
> input_buffer is always read starting from 0.

I will change it to:

 * Using @x_start and @count information, only few pixel can be blended instead of the whole line
 * each time. @x_start is only used for the output buffer. The staging buffer is always read from
 * the start (0..@count in stage_buffer is blended at @x_start..@x_start+@count in output_buffer).

> > + * @count: The number of byte to copy
> 
> You named it pixel_count, and it counts pixels, not bytes. It's not a
> copy but a blend into output_buffer.

Oops, fixed in v6.
 
> >   *
> > - * Using the information from the `frame_info`, this blends only the
> > - * necessary pixels from the `stage_buffer` to the `output_buffer`
> > - * using premultiplied blend formula.
> > + * Using @x_start and @count information, only few pixel can be blended instead of the whole line
> > + * each time.
> >   *
> >   * The current DRM assumption is that pixel color values have been already
> >   * pre-multiplied with the alpha channel values. See more
> >   * drm_plane_create_blend_mode_property(). Also, this formula assumes a
> >   * completely opaque background.
> >   */
> > -static void pre_mul_alpha_blend(struct vkms_frame_info *frame_info,
> > -				struct line_buffer *stage_buffer,
> > -				struct line_buffer *output_buffer)
> > +static void pre_mul_alpha_blend(const struct line_buffer *stage_buffer,
> > +				struct line_buffer *output_buffer, int x_start, int pixel_count)
> >  {
> > -	int x_dst = frame_info->dst.x1;
> > -	struct pixel_argb_u16 *out = output_buffer->pixels + x_dst;
> > -	struct pixel_argb_u16 *in = stage_buffer->pixels;
> > -	int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst),
> > -			    stage_buffer->n_pixels);
> > -
> > -	for (int x = 0; x < x_limit; x++) {
> > -		out[x].a = (u16)0xffff;
> > -		out[x].r = pre_mul_blend_channel(in[x].r, out[x].r, in[x].a);
> > -		out[x].g = pre_mul_blend_channel(in[x].g, out[x].g, in[x].a);
> > -		out[x].b = pre_mul_blend_channel(in[x].b, out[x].b, in[x].a);
> > +	struct pixel_argb_u16 *out = &output_buffer->pixels[x_start];
> > +	const struct pixel_argb_u16 *in = stage_buffer->pixels;
> > +
> > +	for (int i = 0; i < pixel_count; i++) {
> > +		out[i].a = (u16)0xffff;
> > +		out[i].r = pre_mul_blend_channel(in[i].r, out[i].r, in[i].a);
> > +		out[i].g = pre_mul_blend_channel(in[i].g, out[i].g, in[i].a);
> > +		out[i].b = pre_mul_blend_channel(in[i].b, out[i].b, in[i].a);
> >  	}
> >  }
> >  
> > @@ -183,7 +179,7 @@ static void blend(struct vkms_writeback_job *wb,
> >  {
> >  	struct vkms_plane_state **plane = crtc_state->active_planes;
> >  	u32 n_active_planes = crtc_state->num_active_planes;
> > -	int y_pos;
> > +	int y_pos, x_dst, x_limit;
> >  
> >  	const struct pixel_argb_u16 background_color = { .a = 0xffff };
> >  
> > @@ -201,14 +197,16 @@ static void blend(struct vkms_writeback_job *wb,
> >  
> >  		/* The active planes are composed associatively in z-order. */
> >  		for (size_t i = 0; i < n_active_planes; i++) {
> > +			x_dst = plane[i]->frame_info->dst.x1;
> > +			x_limit = min_t(size_t, drm_rect_width(&plane[i]->frame_info->dst),
> > +					stage_buffer->n_pixels);
> 
> Are those input values to min_t() really of type size_t? Or why is
> size_t here?

n_pixel is size_t, drm_rect_width is int. I will change everything to int. 
Is there a way to ask the compiler "please don't do implicit conversion 
and report them as warn/errors"?

> >  			y_pos = get_y_pos(plane[i]->frame_info, y);
> >  
> >  			if (!check_limit(plane[i]->frame_info, y_pos))
> >  				continue;
> >  
> >  			vkms_compose_row(stage_buffer, plane[i], y_pos);
> > -			pre_mul_alpha_blend(plane[i]->frame_info, stage_buffer,
> > -					    output_buffer);
> > +			pre_mul_alpha_blend(stage_buffer, output_buffer, x_dst, x_limit);
> 
> I thought it was a count, not a limit?
> 
> "Limit" sounds to me like "end", and end - start = count.

It is effectively a pixel count. I just took those naming from the 
original pre_mul_alpha_blend. I will change it to pixel_count.

Thanks,
Louis Chauvet

> >  		}
> >  
> >  		apply_lut(crtc_state, output_buffer);
> > 
> 
> The details aside, this is a good move.
> 
> 
> Thanks,
> pq



-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

