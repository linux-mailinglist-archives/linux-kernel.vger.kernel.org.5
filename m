Return-Path: <linux-kernel+bounces-134966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4389A89B969
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A55282705
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F93951C5C;
	Mon,  8 Apr 2024 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ENzP4bmt"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6006A4F8A0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562631; cv=none; b=Kdw6ckv46fLxPKCx8+Ky4XTvRIX0HaSjdhcL9JgjgB1GkbVtXYO/+GcExP2gd4mslHbMdVOlAMljfwHjjYl/LKx0UzZOgQiHEYf6B/x9EUHKOIOZ3vM1n0FIP5WD2z5uBnZeZRAQ++lPRAtBqdlYNqfw6s7vjwvDSoODL993rx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562631; c=relaxed/simple;
	bh=4Zkm1s7RXnnNLLYBkA9LAPeruq+Mr/vRApw//Ls88dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoMa0CunwO7kBPjCMvo5q7IWQBa1ieGkle7UrjcG02+KqPuWwpJrkjbexhDaPrJgTwhmg91PXQbfLb8DDA3S5SIFAFrTT4Cj7S/1i7aootkBg23+lxdlYDGiWf6u9fxoa38prlAEgv0n8Eb7RpbpUTn9Zfr4XyGNjON5r7gHBHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ENzP4bmt; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4ECF91BF204;
	Mon,  8 Apr 2024 07:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712562622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AEJD3OSjACyixRik8hGnxMF3pYou/HReMe01GlqMPOQ=;
	b=ENzP4bmtlShtGEpslWkF37pMHjtQVB1jkjIPugGqmM93CLGD3BMcrW/d5DZIEhE352n8SA
	UtMdo47f3NP/bVyH1Akd/sjriT1xKycIQl6lmhRscG/8zQoMzT4Whqhca4BzEPv3eaEkqk
	hFtHHB9w0uu1bMG6WxheIplnVJ00wVuBpv7yxqPeE596h82jE1y9Pek+ujAhF2l635PPav
	07M8FBqrVKNSc+UJGIlZXZJcqFNsPSvd+pnB8y4VsNsPdnUF/4W991rcTXt17qTXL+gAXJ
	RCU/I+n92qr1T3oeDkj5F6bz25dA8ekFgdCuu6OBCKQojKrNbRII5H+Eg1X4zQ==
Date: Mon, 8 Apr 2024 09:50:19 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
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
Message-ID: <ZhOhu7PVNa_xMkN9@louis-chauvet-laptop>
Mail-Followup-To: Philipp Zabel <p.zabel@pengutronix.de>,
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
 <5f6ab3804baa87f6e2299f668d2ab41be3a13f13.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f6ab3804baa87f6e2299f668d2ab41be3a13f13.camel@pengutronix.de>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 27/03/24 - 13:11, Philipp Zabel a écrit :
> Hi Louis,
> 
> On Mi, 2024-03-13 at 18:45 +0100, Louis Chauvet wrote:
> > From: Arthur Grillo <arthurgrillo@riseup.net>
> > 
> > Add support to the YUV formats bellow:
> > 
> > - NV12/NV16/NV24
> > - NV21/NV61/NV42
> > - YUV420/YUV422/YUV444
> > - YVU420/YVU422/YVU444
> > 
> > The conversion from yuv to rgb is done with fixed-point arithmetic, using
> > 32.32 floats and the drm_fixed helpers.
> 
> s/floats/fixed-point numbers/
> 
> Nothing floating here, the point is fixed.
> 
> [...]
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
> s/CONVERSION_MATRIX_FLOAT_DEPTH/CONVERSION_MATRIX_FRACTIONAL_BITS/
> 
> Just a suggestion, maybe there are better terms, but using "FLOAT" here
> is confusing.
> 
> > + */
> > +#define CONVERSION_MATRIX_FLOAT_DEPTH 32
> > +
> > +/**
> > + * struct conversion_matrix - Matrix to use for a specific encoding and range
> > + *
> > + * @matrix: Conversion matrix from yuv to rgb. The matrix is stored in a row-major manner and is
> > + * used to compute rgb values from yuv values:
> > + *     [[r],[g],[b]] = @matrix * [[y],[u],[v]]
> > + *   OR for yvu formats:
> > + *     [[r],[g],[b]] = @matrix * [[y],[v],[u]]
> > + *  The values of the matrix are fixed floats, 32.CONVERSION_MATRIX_FLOAT_DEPTH
> 
> s/fixed floats/fixed-point numbers/

Thanks for those precision, I will change the wording in v6.

Louis Chauvet
 
> regards
> Philipp

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

