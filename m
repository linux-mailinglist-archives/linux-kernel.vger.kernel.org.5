Return-Path: <linux-kernel+bounces-97869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FB68770E7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1FDB211B1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EDD39AD5;
	Sat,  9 Mar 2024 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mqw/Fo2g"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2D381CC
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709985524; cv=none; b=hSF/85e9CIktVAF+QsCPRcAwkHW2275KxFMw6e+/CtAPM6V1Y/NKz6FVOLtoU7Fv78bifwDCmsKH3BF4hD7aCLueX74pBNfdLoQBuYTyEbeCb5J6bqLjnQ3rKctkQ4lwUrQGE87SVy3680MRthyaNnwo9oFqLRDTrmTy26px6rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709985524; c=relaxed/simple;
	bh=QiR6dhAtCK7Jf2Sd7dLo5myKI07Jj97yr4toflmpo6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amEvGaNfu7wRQw4xGu71fsehickE7m7oUpZAqeIKsP3a4OT2L80fKds7T3mljnIobq0u13XxRIROVcpJ71yL6GMoh6VgYSgTEAD1lwT3V5h2zBMcsZvxqLRzvNVTvcNZzn784tNB4Z6YeH4jjxLEF6Q1RknkMAP/GG7ZsOE9ftY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mqw/Fo2g; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2D521BF203;
	Sat,  9 Mar 2024 11:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709985518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeJuGxy7IMp2CtzAyuorWvkKuxtOwV9FaaLvZ5RlJaQ=;
	b=mqw/Fo2gmyLahOaZ3SozUt8O5PlHBXFjoVVfpAARskZd/VWkFBe4x+XmkaLjfJYgHyXWrL
	/IXkANV6aKoqD0HHaJA9DSGsTsoE0OamW+mmiT4kc6g/Afnfh348G1ycgjQja9dm4pfA7f
	ixZ3MD+NmdISNQxEiaPAID+mXiW+4MQkgIUMoos9uO0RwqvsxtHs81d8/lf1/8M+t8bAEh
	fEC+XFitRxfneaISR+sjsYfXTc02xIsVxSdNAWQCXwXjIolap2zGCJP/XWCPoXk9upY4GJ
	2G5mQ17W2cakOZx9SSWbcnN2/ZYmizLN6hQTR+yTZW9VDB/zz+k0q3KswJNVjA==
Date: Sat, 9 Mar 2024 12:58:33 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc: Arthur Grillo <arthurgrillo@riseup.net>,
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
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH 0/7] Additions to "Reimplement line-per-line pixel
 conversion for plane reading" series
Message-ID: <ZexO6SOeQFnYMl_G@localhost.localdomain>
Mail-Followup-To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
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
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net>
 <4b01ba61-9184-4a17-9fe6-59eb88a21214@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b01ba61-9184-4a17-9fe6-59eb88a21214@igalia.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 08/03/24 - 17:38, Maíra Canal a écrit :
> Hi Arthur,

Hi Maíra,

> Would it be possible for you to coordinate with Louis and create a
> single series with all the modification?

This is already the case, [1] contains all our work. But as there were a 
lot of things to change in the YUV part, it was easier for Arthur to send 
a "real" series over [1]. I've already merged everything, and it'll all be 
in v5 (probably Monday or Tuesday).

Kind regards,
Louis Chauvet

> I don't see a reason to submit fixes to a series that it is still
> on review.
>
> Best Regards,
> - Maíra
> 
> On 3/6/24 17:03, Arthur Grillo wrote:
> > These are some patches that add some fixes/features to the series by
> > Louis Chauvet[1], it was based on top of the patches from v4.
> > 
> > Patches #2 and #3 should be amended to "[PATCH v4 11/14] drm/vkms: Add
> > YUV support". To make patch #3 work, we need patch #1. So, please, add
> > it before the patch that #2 and #3 amend to.
> > 
> > Patches #4 to #6 should be amended to "[PATCH v4 14/14] drm/vkms: Create
> > KUnit tests for YUV conversions". While doing the additions, I found
> > some compilation issues, so I fixed them (patch #4). That's when I
> > thought that it would be good to add some documentation on how to run
> > them (patch #7), this patch should be added to the series as new patch.
> > 
> > [1]: https://lore.kernel.org/r/20240304-yuv-v4-0-76beac8e9793@bootlin.com
> > 
> > To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > To: Melissa Wen <melissa.srw@gmail.com>
> > To: Maíra Canal <mairacanal@riseup.net>
> > To: Haneen Mohammed <hamohammed.sa@gmail.com>
> > To: Daniel Vetter <daniel@ffwll.ch>
> > To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > To: Maxime Ripard <mripard@kernel.org>
> > To: Thomas Zimmermann <tzimmermann@suse.de>
> > To: David Airlie <airlied@gmail.com>
> > To: arthurgrillo@riseup.net
> > To: Jonathan Corbet <corbet@lwn.net>
> > To: pekka.paalanen@haloniitty.fi
> > To: Louis Chauvet <louis.chauvet@bootlin.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: jeremie.dautheribes@bootlin.com
> > Cc: miquel.raynal@bootlin.com
> > Cc: thomas.petazzoni@bootlin.com
> > Cc: seanpaul@google.com
> > Cc: marcheu@google.com
> > Cc: nicolejadeyee@google.com
> > 
> > Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> > ---
> > Arthur Grillo (7):
> >        drm: Fix drm_fixp2int_round() making it add 0.5
> >        drm/vkms: Add comments
> >        drm/vkmm: Use drm_fixed api
> >        drm/vkms: Fix compilation issues
> >        drm/vkms: Add comments to format tests
> >        drm/vkms: Change the gray RGB representation
> >        drm/vkms: Add how to run the Kunit tests
> > 
> >   Documentation/gpu/vkms.rst                    |  11 +++
> >   drivers/gpu/drm/vkms/tests/vkms_format_test.c |  81 +++++++++++++++++++--
> >   drivers/gpu/drm/vkms/vkms_drv.h               |   4 +
> >   drivers/gpu/drm/vkms/vkms_formats.c           | 101 +++++++++++++++++++-------
> >   include/drm/drm_fixed.h                       |   2 +-
> >   5 files changed, 165 insertions(+), 34 deletions(-)
> > ---
> > base-commit: 9658aba38ae9f3f3068506c9c8e93e85b500fcb4
> > change-id: 20240306-louis-vkms-conv-61362ff12ab8
> > 
> > Best regards,

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

