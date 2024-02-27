Return-Path: <linux-kernel+bounces-83465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3858699CE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8E61F21AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414BC14DFFD;
	Tue, 27 Feb 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hS0GFSIZ"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEE714AD29
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046142; cv=none; b=pLet+b8b+RYG6GwSz7g8tLnJ1SXMKeRlqCTkmTsqaZ9wAssVVfLIt1xyPrAVsq5WFkiPa5/SPJmMNOViW80l/1JZOeOR45fzQsMVL1Os1+KLQvFZknAk4q+rTvFqiH8eVmPHdthZCcBVNyaw7YTcg5sNbyMEEoH3DYqA+YQGl90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046142; c=relaxed/simple;
	bh=wLFjhWbIJfCsXuA865SUQseEbrHqZh2RwBWAOeqKLP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+78cCq2z3em8C2Mmh1sGVDWGk/ARO+xofYI0QGa3VJTcr8Gia+sNAkl+oRzkTjHDrcYnso7EFAGBan50U4k8A2azBc/XR7yZx3U3LBCq2/oZrKvk1MTnn7s116rNW3/72UamWslWIeG9TvHSLoiL/dQJcyevMBr4QQ7H4gPdh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hS0GFSIZ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77551C0005;
	Tue, 27 Feb 2024 15:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709046132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vR8V0WErYwpzeuyXZR2XstON7tK8EAywBDaXljEOHbM=;
	b=hS0GFSIZEFjR1CcZ98qQIo7wPJVSpoGAlUKPunXp/pnELIr6vI3Nb0Jxr9nZkY8eXTvmku
	A53V7Vq3v15CCCmLA0cNERf7NraoWwTRFa5lz5T7FZRzii8R4F5/cys+sMlkLE8B00I1KT
	o33VNzQfSuAgwUR7ZdcaWUCtqb4P6p6uaUPegpAyC8PN9HMSnvvT/2SYspmjwczV2MbXZS
	le9KaZ41iUYx6jBRzPBWDnHcWELlwZDs3QtZkhd9crChG4BxKp/AeNmIvvmkf9FtmKRknX
	uULmoqih6lkWdxiMOLduq8+tAh61DbpmccTVu7XxZcYCbsSNF0Eu+7Hdzk9nPw==
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
Subject: Re: [PATCH v2 7/9] drm/vkms: Add range and encoding properties to
 pixel_read function
Message-ID: <Zd35cpAID3ea8AFO@localhost.localdomain>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226142343.459f23f7.pekka.paalanen@collabora.com>
X-GND-Sasl: louis.chauvet@bootlin.com

(same as for PATCHv2 6/9, I took the patch from Arthur with no 
modifications)

Le 26/02/24 - 14:23, Pekka Paalanen a écrit :
> On Fri, 23 Feb 2024 12:37:27 +0100
> Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> 
> > From: Arthur Grillo <arthurgrillo@riseup.net>
> > 
> > Create range and encoding properties. This should be noop, as none of
> > the conversion functions need those properties.
> 
> None of the conversion function needs this? How can one say so?
> The previous patch is making use of them already, AFAICT?

It's my fault, I mixed the commits (in Arthur's series, "Add range..." was 
before "Add YUV support"), but for me it makes no sens to have the color 
property without the support in the driver.

Maybe it's better just to merge "Add range..." with "Add YUV support"?

> How is this a noop? Is it not exposing new UAPI from VKMS?

It's not a no-op from userspace, but from the driver side, yes.

Kind regards,
Louis Chauvet

> Thanks,
> pq
> 
> > 
> > Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> > [Louis Chauvet: retained only relevant parts]
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_plane.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> > index 427ca67c60ce..95dfde297377 100644
> > --- a/drivers/gpu/drm/vkms/vkms_plane.c
> > +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> > @@ -228,5 +228,14 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> >  	drm_plane_create_rotation_property(&plane->base, DRM_MODE_ROTATE_0,
> >  					   DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
> >  
> > +	drm_plane_create_color_properties(&plane->base,
> > +					  BIT(DRM_COLOR_YCBCR_BT601) |
> > +					  BIT(DRM_COLOR_YCBCR_BT709) |
> > +					  BIT(DRM_COLOR_YCBCR_BT2020),
> > +					  BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
> > +					  BIT(DRM_COLOR_YCBCR_FULL_RANGE),
> > +					  DRM_COLOR_YCBCR_BT601,
> > +					  DRM_COLOR_YCBCR_FULL_RANGE);
> > +
> >  	return plane;
> >  }
> > 
> 



-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

