Return-Path: <linux-kernel+bounces-83463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B3F8699DE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACFB2B2AB3A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7747B149DEE;
	Tue, 27 Feb 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="id7cz+2Y"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B18F1487F0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046138; cv=none; b=sSKwRhSl6j58FgrVIyd0PndFPbM1R1RHUVgq3lS0XVWwkUxO0b8LFFQVmG4trS2kGGSChiTIl16VjS1m0WsKJ3+KHD86lT6KQuxoqH5JY7ZMECXy+oiaavAxAx1U/J41ahDBHcaG/9u2qRBX8PMThXn7tiZibmPRW5ADiV/v5V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046138; c=relaxed/simple;
	bh=OLpthbutP2C2A6Fu0ZsUKf3bnm7e8Nl1D2jO/yNOCZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWix5gRZUSvt1myPtPTAKU34pBa1qmNr3PmO4Zt7HG1QdNh90KW3sc9p+Q7TJzIOmeETfNp886rk/g5dHR3EoVDzq4sIO2SreBqmx3NTg/10hH3fnwRT0chtciZM28Ws9oG5eyIaplSKbnIn3M2TRSPnboEAMeLN+2uAIH56Mjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=id7cz+2Y; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C24A61C0004;
	Tue, 27 Feb 2024 15:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709046135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxX/T5aZao8IAh+tvJ+h1jgz8NA+Qb+ugAuRUGDGBxA=;
	b=id7cz+2Y6DwUH4pY84bMuhCorW2eM7EdsL89UxxR1WAfCzOrFgCfHQM+D/C2zTjCI0ZMeK
	RJ1yQojPN6Z07XLBGxWxAZlYI/64t0gZowYTYMMhxPrzpMpOQlWAiKgJwNCHgSLB5LWg07
	lG/nlHSa9qwqoXa/ZLcY0ZIyzY+ygh3eDaTeIF+41bBY1rnPZOY1Ucdt0tUBW522D4e9XH
	SZM9CoNBc5KK8ZVJs5Pgj3sun2Bv7w0jugfPqxw9Z/PlXfa3Nwa2+BYW68RDpJHd+Lgayh
	fOLaAEE759cCbBgZf78mkT3HvtcTNPZYMXVKXjCBi+66Twum2kPDMUIOoO4guw==
Date: Tue, 27 Feb 2024 16:02:13 +0100
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
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2 9/9] drm/vkms: Create KUnit tests for YUV conversions
Message-ID: <Zd35ddQZbl3frcLm@localhost.localdomain>
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
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com
References: <20240223-yuv-v2-0-aa6be2827bb7@bootlin.com>
 <20240223-yuv-v2-9-aa6be2827bb7@bootlin.com>
 <4406ec1c-fcfc-4d06-bec2-a428058d32cc@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4406ec1c-fcfc-4d06-bec2-a428058d32cc@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 26/02/24 - 13:39, Arthur Grillo a écrit :
> 
> 
> On 23/02/24 08:37, Louis Chauvet wrote:
> > From: Arthur Grillo <arthurgrillo@riseup.net>
> > 
> > Create KUnit tests to test the conversion between YUV and RGB. Test each
> > conversion and range combination with some common colors.
> > 
> > Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> > [Louis Chauvet: fix minor formating issues (whitespace, double line)]
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >  drivers/gpu/drm/vkms/Makefile                 |   1 +
> >  drivers/gpu/drm/vkms/tests/.kunitconfig       |   4 +
> >  drivers/gpu/drm/vkms/tests/Makefile           |   3 +
> >  drivers/gpu/drm/vkms/tests/vkms_format_test.c | 155 ++++++++++++++++++++++++++
> >  drivers/gpu/drm/vkms/vkms_formats.c           |   9 +-
> >  drivers/gpu/drm/vkms/vkms_formats.h           |   5 +
> >  6 files changed, 175 insertions(+), 2 deletions(-)
> 
> You need to add the CONFIG_DRM_VKMS_KUNIT_TESTS config to
> drivers/gpu/drm/vkms/Kconfig, like my previous patch did.

I don't know how I merged your patch, but I missed the Kconfig file, 
it was not intended, sorry.

Kind regards,
Louis Chauvet
 
[...]

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

