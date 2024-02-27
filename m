Return-Path: <linux-kernel+bounces-83467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B468699D0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489161F20E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89C114EFC2;
	Tue, 27 Feb 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c0yxvVGn"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA8314AD06
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046143; cv=none; b=i+T54Gyo8Rzy2xhHEb3ZtPS5sBVblPJQNugToKoNiyekaEcx8YUINPKVo8Jeg/bTjEeVAxBGqzqKL2gDByqQCcGEDH+0lTzLNEBc+zQdftQ7nR4x6owNl6OWdxHnbKalTMfeDj31fxpzYMbWExYrGPsZ9z9zahTA0o+9m6eQBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046143; c=relaxed/simple;
	bh=6Sj+Oj6kjb2jhgnpvZOrjdYYd/X2xH/aPuZPT6+qN9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1xxkkBj4fSMaWrRUcDOuKxSMv9P3n/GgzinrGvSL8/gkDuVxD1PNUo60Unh6PVPfUn1KhD4rAEkEhl9lDTma04Z2imDy8GMuAxfYpRWLlLkj1ZWTi8mcabhIG43vwcTztVAdznsoRUN2E8gLRvUSeaCNR9/JE2LAxUtlSeJID0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c0yxvVGn; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C54CDC000F;
	Tue, 27 Feb 2024 15:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709046133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUOCVxfpOI9uiHHy1Cy0BnVynULM022d0cPPHRoVqbw=;
	b=c0yxvVGn99xoQcWd5VVOwbG+XxEzwO3fuHzxkATT/dylpI9GjiWsbZ0UCJimKTPH1ow6OF
	HL6zNPACnOGa3dZJjYRkRpfGyFOBHx0Rz2KDVvn3vccHuOIwiA5SnD1uWWglxSJKrIJYVX
	8UJ2Kqglz/Pv0f+jAjrtaM3YcJXgu86e5xIbiwVibz/hxN1TRI8TDeGSWZ/oFdoQd9FgWZ
	atPWxkiuyWx+Au40C2o+vxJjzP58kSwoquvZLEVIxGGvA0uVzJ6KmU+m5RZCQEPFp2rcSB
	O5GKBnZgIPAWoZ+vuJ6IOJz9qQ9R+EAMxhga8l5AQoO3d+ZNLxu9tFItJvRf2A==
Date: Tue, 27 Feb 2024 16:02:10 +0100
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
Subject: Re: [PATCH v3 3/9] drm/vkms: write/update the documentation for
 pixel conversion and pixel write functions
Message-ID: <Zd35csjqRMstzElA@localhost.localdomain>
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
 <20240226-yuv-v3-3-ff662f0994db@bootlin.com>
 <406988be-48a4-4762-9c03-7a27c8e7b91e@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <406988be-48a4-4762-9c03-7a27c8e7b91e@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 26/02/24 - 10:07, Arthur Grillo a écrit :
> 
> 
> On 26/02/24 05:46, Louis Chauvet wrote:
> > Add some documentation on pixel conversion functions.
> > Update of outdated comments for pixel_write functions.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_composer.c |  4 +++
> >  drivers/gpu/drm/vkms/vkms_drv.h      | 13 ++++++++
> >  drivers/gpu/drm/vkms/vkms_formats.c  | 58 ++++++++++++++++++++++++++++++------
> >  3 files changed, 66 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> > index c6d9b4a65809..5b341222d239 100644
> > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> > @@ -189,6 +189,10 @@ static void blend(struct vkms_writeback_job *wb,
> >  
> >  	size_t crtc_y_limit = crtc_state->base.crtc->mode.vdisplay;
> >  
> > +	/*
> > +	 * The planes are composed line-by-line. It is a necessary complexity to avoid poor
> > +	 * blending performance.
> 
> At this moment in the series, you have not yet reintroduced the
> line-by-line algorithm yet. Maybe it's better to add this comment when
> you do.

Is it better with this:

	/*
	 * The planes are composed line-by-line to avoid heavy memory usage. It is a necessary
	 * complexity to avoid poor blending performance.
	 *
	 * The function vkms_compose_row is used to read a line, pixel-by-pixel, into the staging
	 * buffer.
	 */
 
> Also, I think it's good to give more context, like:
> "The planes are composed line-by-line, instead of pixel-by-pixel"

And after PATCHv3 5/9:

	/*
	 * The planes are composed line-by-line to avoid heavy memory usage. It is a necessary
	 * complexity to avoid poor blending performance.
	 *
	 * The function pixel_read_line callback is used to read a line, using an efficient 
	 * algorithm for a specific format, into the staging buffer.
	 */

Kind regards,
Louis Chauvet

> Best Regards,
> ~Arthur Grillo

[...]

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

