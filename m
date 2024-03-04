Return-Path: <linux-kernel+bounces-90819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D3887057A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D5728A354
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741F4481D0;
	Mon,  4 Mar 2024 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fUDKbr2J"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967E5481A3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566155; cv=none; b=nuBucX0Th5DqTW1Jl1sh4igy69YU6aMyhaVvqrzbdPgXQ/vrNp+FJRKTByZD5wra7HPp3tB6KUpG8EY3cKSLXMHP3di5DU9kaD4Y+Spy3HGLh3MhgPo7QJ1LLMd8ccJL2kGcnIwh017BLKhpOW9yPBwkb7e5noVjgrsumLr3iZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566155; c=relaxed/simple;
	bh=reu/CxuI7sxVIl5wsN3VWA8DUY1ctAgp+VAngWJYig4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqZ1ylRCg02LNQqHY1RHY1iJBl0XFrmh6mvET68wr7NHdcdGZ1KGWZV5WDutOqRwJs718FtpjyMCuMcecaQh8N9swhgIiqXhTV0EXuxc9gNt5InUDHL08PjcfT3YFZfpXmqdG8tAYb30uMBKjeRmDsGEbQZbTJhmgmBwUM8+9EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fUDKbr2J; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E963220002;
	Mon,  4 Mar 2024 15:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709566151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHCBsLOi2TE/F/MpyV0az3Z7gDeEkKLlFB40S9OqL2A=;
	b=fUDKbr2JWqXWaXdvMufpjmE2aIQjbZ1jDbMoNw7SefeVIUW/fA+J+lG9RtnVmjDOUSdQab
	im1zsGpBccW0uJE2G9uiWDwx6/MbhzibaM3R3MWBtvaUE9txrhpSTYM15vOynuBm/f4PrM
	nMsYkag57/JMFif2MANj5lga5VtT18PI2WdPB6PWjOfEIjv/K262XA7gdN2NL42DRDvcUd
	n3/o0ohI+K9d7o/9P4MsXNXLIhsIs7XfWmTGLueBX4DFDMZyTlLN2vzcGlSpY7n63VzXdX
	N3SVRuAhs3R4Eh9vNGVW/lExs9jYxN7SlFsbJAAYKihWTD8DC+zvLrc/dopHmg==
Date: Mon, 4 Mar 2024 16:29:08 +0100
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
Subject: Re: [PATCH v2 7/9] drm/vkms: Add range and encoding properties to
 pixel_read function
Message-ID: <ZeXoopxVQieA1WCl@localhost.localdomain>
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
 <20240223-yuv-v2-7-aa6be2827bb7@bootlin.com>
 <20240226142343.459f23f7.pekka.paalanen@collabora.com>
 <Zd35cpAID3ea8AFO@localhost.localdomain>
 <20240229142426.274ae199.pekka.paalanen@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229142426.274ae199.pekka.paalanen@collabora.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 29/02/24 - 14:24, Pekka Paalanen a écrit :
> On Tue, 27 Feb 2024 16:02:10 +0100
> Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> 
> > (same as for PATCHv2 6/9, I took the patch from Arthur with no 
> > modifications)
> > 
> > Le 26/02/24 - 14:23, Pekka Paalanen a écrit :
> > > On Fri, 23 Feb 2024 12:37:27 +0100
> > > Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> > >   
> > > > From: Arthur Grillo <arthurgrillo@riseup.net>
> > > > 
> > > > Create range and encoding properties. This should be noop, as none of
> > > > the conversion functions need those properties.  
> > > 
> > > None of the conversion function needs this? How can one say so?
> > > The previous patch is making use of them already, AFAICT?  
> > 
> > It's my fault, I mixed the commits (in Arthur's series, "Add range..." was 
> > before "Add YUV support"), but for me it makes no sens to have the color 
> > property without the support in the driver.
> 
> Ah, so if there was no YUV support, these properties would never affect
> anything. Ok, I see where that is coming from.
>
> > 
> > Maybe it's better just to merge "Add range..." with "Add YUV support"?
> > 
> > > How is this a noop? Is it not exposing new UAPI from VKMS?  
> > 
> > It's not a no-op from userspace, but from the driver side, yes.
> 
> If it all is already hooked up and handled in the driver, then say just
> that?
> 
> "Now that the driver internally handles these quantization ranges and YUV
> encoding matrices, expose the UAPI for setting them."
> 
> And fix the commit summary line too, nothing "pixel_read" here.

Ack
 
Kind regards,
Louis Chauvet

> Thanks,
> pq
> 
> > 
> > Kind regards,
> > Louis Chauvet
> > 
> > > Thanks,
> > > pq
> > >   
> > > > 
> > > > Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> > > > [Louis Chauvet: retained only relevant parts]
> > > > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > ---
> > > >  drivers/gpu/drm/vkms/vkms_plane.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> > > > index 427ca67c60ce..95dfde297377 100644
> > > > --- a/drivers/gpu/drm/vkms/vkms_plane.c
> > > > +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> > > > @@ -228,5 +228,14 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> > > >  	drm_plane_create_rotation_property(&plane->base, DRM_MODE_ROTATE_0,
> > > >  					   DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
> > > >  
> > > > +	drm_plane_create_color_properties(&plane->base,
> > > > +					  BIT(DRM_COLOR_YCBCR_BT601) |
> > > > +					  BIT(DRM_COLOR_YCBCR_BT709) |
> > > > +					  BIT(DRM_COLOR_YCBCR_BT2020),
> > > > +					  BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
> > > > +					  BIT(DRM_COLOR_YCBCR_FULL_RANGE),
> > > > +					  DRM_COLOR_YCBCR_BT601,
> > > > +					  DRM_COLOR_YCBCR_FULL_RANGE);
> > > > +
> > > >  	return plane;
> > > >  }
> > > >   
> > >   
> > 
> > 
> > 
> 



-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

