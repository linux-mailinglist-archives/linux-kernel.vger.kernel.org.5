Return-Path: <linux-kernel+bounces-83468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C397B8699D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778E8287A08
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700F414EFEA;
	Tue, 27 Feb 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S5S8wzPZ"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDF414CAAB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046143; cv=none; b=AZjHzZg0inHdTOkTP4dEGcJq8GAuShzFfVMuRgt7Mq3e2+y9zsLnC/AwJhuLmd0ZUZyL/RbX07PZxbe1F50pn3f0wRIG/BA3Ny5Qf4n4c46ztcd4x+ofPHQlCGW/hQey9Lqdh3eJ/iVa5r7ZO1k2y9921E0xWNIvfWMDGK3uqyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046143; c=relaxed/simple;
	bh=VcmHARxCTfpmttLyfdAWI77rYXCBMJ5BgfJh3npQ1Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWXwLsmg30/cEZ5JDPVyM6lPNU+dvV047j9MWyxlXlXoRB9dySMTTVcvKwvwuj0ei9xypXDrIATzUQCVLwO7aH7CFFfIJGi9CV2ycjHWMBtZx97gsc9PsgmcpaNf33a1GR+9gXdHIuKgYtf9M7IeI0kIWQgZrMCjgv94fA6pvNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S5S8wzPZ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1025860014;
	Tue, 27 Feb 2024 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709046134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wD53UKuw4zxoHOpXnQGMSfTDv9JExg1coPAv+jx4svI=;
	b=S5S8wzPZTwAnzhPdNHgvBSpPuxeFMNddFlI5FAvIXkIC0bw7wE2XCOGWOPB6c/l0WaAtqB
	Vap+q7sezl/pplwp2lQcyef0WDcrVNuKR32vUa3PDa1ZG3j2wVuca5GDHV3bHeHvyyautT
	qFN2zChzidAtscR/dxNmGhZc3JWylWv70vnrY/zDcoVY8GhZXrWIkKbLM4di3gDPSaBb3m
	mpjTVRBBchwaDTfxdScq7JQl4aBwkpELhdziP118IQJi9WzcxIyWercVM7JE6Z59kA5Wv2
	0qW/bQyNVRg8csjClDzQW9wvJf5hf/gcFwEsLunYuGxwUAg9RfUe6NCEq83TqQ==
Date: Tue, 27 Feb 2024 16:02:11 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Arthur Grillo <arthurgrillo@riseup.net>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	pekka.paalanen@haloniitty.fi, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH v3 4/9] drm/vkms: Add typedef and documentation for
 pixel_read and pixel_write functions
Message-ID: <Zd35c1dTf8AAxen4@localhost.localdomain>
Mail-Followup-To: Arthur Grillo <arthurgrillo@riseup.net>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	pekka.paalanen@haloniitty.fi, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
References: <20240226-yuv-v3-0-ff662f0994db@bootlin.com>
 <20240226-yuv-v3-4-ff662f0994db@bootlin.com>
 <848f2690-2f20-4a92-82ff-64cdee8cb2ee@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <848f2690-2f20-4a92-82ff-64cdee8cb2ee@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

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
> s/inchanged/unchanged/

Thanks for this correction. See my answer to [1], I changed the message a 
bit.
[1]: https://lore.kernel.org/dri-devel/20240226133646.174d3fb2.pekka.paalanen@collabora.com/

Kind regards,
Louis Chauvet

> > +		return;
> > +	}
> > +
> >  	vkms_plane_state = to_vkms_plane_state(new_state);
> >  	shadow_plane_state = &vkms_plane_state->base;
> >  
> > @@ -124,7 +131,7 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
> >  	drm_rect_rotate(&frame_info->rotated, drm_rect_width(&frame_info->rotated),
> >  			drm_rect_height(&frame_info->rotated), frame_info->rotation);
> >  
> > -	vkms_plane_state->pixel_read = get_pixel_conversion_function(fmt);
> > +	vkms_plane_state->pixel_read = pixel_read;
> >  }
> >  
> >  static int vkms_plane_atomic_check(struct drm_plane *plane,
> > diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> > index c8582df1f739..c92b9f06c4a4 100644
> > --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> > +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> > @@ -140,6 +140,13 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
> >  	if (!conn_state)
> >  		return;
> >  
> > +	pixel_write_t pixel_write = get_pixel_write_function(wb_format);
> > +
> > +	if (!pixel_write) {
> > +		DRM_WARN("Pixel format is not supported by VKMS writeback. State is inchanged\n");
> 
> Same here
> 
> Best Regards,
> ~Arthur Grillo
> 
> > +		return;
> > +	}
> > +
> >  	vkms_set_composer(&vkmsdev->output, true);
> >  
> >  	active_wb = conn_state->writeback_job->priv;
> > @@ -150,7 +157,7 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
> >  	crtc_state->wb_pending = true;
> >  	spin_unlock_irq(&output->composer_lock);
> >  	drm_writeback_queue_job(wb_conn, connector_state);
> > -	active_wb->pixel_write = get_pixel_write_function(wb_format);
> > +	active_wb->pixel_write = pixel_write;
> >  	drm_rect_init(&wb_frame_info->src, 0, 0, crtc_width, crtc_height);
> >  	drm_rect_init(&wb_frame_info->dst, 0, 0, crtc_width, crtc_height);
> >  }
> > 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

