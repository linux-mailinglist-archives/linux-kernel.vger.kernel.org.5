Return-Path: <linux-kernel+bounces-103418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7898387BF26
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6261C21079
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E023C6FE17;
	Thu, 14 Mar 2024 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gwmj34g1"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DB65D756
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427304; cv=none; b=LcUQSU/tRmx+58Pmz3IUbI85sxsCRWi/QLGaY7EN5Rgblkp108+MWE5lU/kqiJiSw/WNV1E6w/erpOT51SKNG3ua/YAaBxSQqNcARR2Uj5/DY7Ds/pjKGZeC9OWTng1pbghxynkkrB9KtQo5UZIUGzTfETyZDmyGycZfR/Ldy3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427304; c=relaxed/simple;
	bh=AH2gn8sYO0u58HUJkx+dHZAPKY98xrahxZtlF92svLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiWrCgie5OG85BHUb51v+TjA8+5ehCHHi2iFNz30/KQ0oMbz6K3duQ31oLGVK6fek3iVlV1l+uvZ895v7Hb97fC6nlk7Suw28yDqAb6/59rwyLqtVvSDNjlEhl2hnD4kI0UZ8+HbiuLRk0uw8uxvqy+OwinuEuJwfwAajSNe55A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gwmj34g1; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 84466C0003;
	Thu, 14 Mar 2024 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710427299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CaQ3Grl+GGtG3YQqjJt14dHIPYaUr4sfdmJsm0ExNcM=;
	b=Gwmj34g1VJmVJ+P4ykMUrBx5VCih/NHAbtegphigbxSF9mVDMXiGNbJxQ6Ok0LTMMW7RLM
	RY5hGiPBpOph1C2GsAQ3UbN8E5KGTxDMGpu4hpHs3ieg9eMAgwxhGEdXSoYWrnuGlWTwbg
	DhLz+R6kNJBp/LM4wdHJObC7+Ux01cSFg8Cs3jeMiiEBqYTyBh2iDy24yBo0raXRTynh8Y
	3ndrC2c2l+eJM3ucgtaoX/JPvGqS2VwPag6qXdUH0YYQYk3EiDlu3Esxzq8XrOZ/3KP1QH
	jNuhiZ5c3O5lKAmdbQRrdQkCI+nPSPNyqMHWbYTMfgcxEQIgm9cN7nypnik4MQ==
Date: Thu, 14 Mar 2024 15:41:35 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
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
Subject: Re: [PATCH v5 11/16] drm/vkms: Add YUV support
Message-ID: <ZfMMnx0Y5qr1Vgle@localhost.localdomain>
Mail-Followup-To: Randy Dunlap <rdunlap@infradead.org>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
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
 <20240313-yuv-v5-11-e610cbd03f52@bootlin.com>
 <f0fe1d62-ee99-4576-ad27-62de98f9ad39@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0fe1d62-ee99-4576-ad27-62de98f9ad39@infradead.org>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 13/03/24 - 12:20, Randy Dunlap a écrit :
> Hi,
> 
> On 3/13/24 10:45, Louis Chauvet wrote:
> > From: Arthur Grillo <arthurgrillo@riseup.net>
> > 
> 
> > 
> > Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> > [Louis Chauvet:
> > - Adapted Arthur's work
> > - Implemented the read_line_t callbacks for yuv
> > - add struct conversion_matrix
> > - remove struct pixel_yuv_u8
> > - update the commit message
> > - Merge the modifications from Arthur]
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_drv.h     |  22 ++
> >  drivers/gpu/drm/vkms/vkms_formats.c | 431 ++++++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/vkms/vkms_formats.h |   4 +
> >  drivers/gpu/drm/vkms/vkms_plane.c   |  17 +-
> >  4 files changed, 473 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > index 23e1d247468d..f3116084de5a 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > @@ -99,6 +99,27 @@ typedef void (*pixel_read_line_t)(const struct vkms_plane_state *plane, int x_st
> >  				  int y_start, enum pixel_read_direction direction, int count,
> >  				  struct pixel_argb_u16 out_pixel[]);
> >  
> > +/**
> > + * CONVERSION_MATRIX_FLOAT_DEPTH - Number of digits after the point for conversion matrix values
> 
> This should be
> 
> + * define CONVERSION_MATRIX_FLOAT_DEPTH - Number of digits after the point for conversion matrix values
> 
> to conform to kernel-doc format.
> 
> > + */
> > +#define CONVERSION_MATRIX_FLOAT_DEPTH 32
> > +

Hi Randy,

Thanks for your feedback.

I missed it while squashing Arthur's work, but this constant is not needed 
anymore, it will be removed in v6.

For all other kernel-doc formatting (PATCHv5 03/16, PATCH V5 05/16), I 
will correct them in the v6.

Kind regards,
Louis Chauvet

> > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > index 1449a0e6c706..edbf4b321b91 100644
> > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> 
> > +/**
> > + * get_conversion_matrix_to_argb_u16() - Retrieve the correct yuv to rgb conversion matrix for a
> > + * given encoding and range.
> > + *
> > + * If the matrix is not found, return a null pointer. In all other cases, it return a simple
> > + * diagonal matrix, which act as a "no-op".
> > + *
> > + * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
> > + * @encoding: DRM_COLOR_* value for which to obtain a conversion matrix
> > + * @range: DRM_COLOR_*_RANGE value for which to obtain a conversion matrix
> > + */
> > +struct conversion_matrix *
> > +get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
> > +				  enum drm_color_range range)
> > +{
> > +	static struct conversion_matrix no_operation = {
> > +		.matrix = {
> > +			{ 4294967296, 0,          0, },
> > +			{ 0,          4294967296, 0, },
> > +			{ 0,          0,          4294967296, },
> > +		},
> > +		.y_offset = 0,
> > +	};
> > +
> > +	/*
> > +	 * Those matrixies were generated using the colour python framework
> 
> 	         matrices
> 
> > +	 *
> > +	 * Below are the function calls used to generate eac matrix, go to
> 
> 	                                                 each
> 
> > +	 * https://colour.readthedocs.io/en/develop/generated/colour.matrix_YCbCr.html
> > +	 * for more info:
> > +	 *
> > +	 * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.601"],
> > +	 *                                  is_legal = False,
> > +	 *                                  bits = 8) * 2**32).astype(int)
> > +	 */
> 
> > +
> >  /**
> 
> Please convert this comment to kernel-doc format or just use "/*" to begin
> the comment.
> 
> >   * Retrieve the correct write_pixel function for a specific format.
> >   * If the format is not supported by VKMS a warn is emitted and a dummy "don't do anything"
> 
> > diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> > index 8875bed76410..987dd2b686a8 100644
> > --- a/drivers/gpu/drm/vkms/vkms_plane.c
> > +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> 
> 
> thanks.
> -- 
> #Randy

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

