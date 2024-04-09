Return-Path: <linux-kernel+bounces-136877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7544389D94F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D78B1F22FA6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF8712D755;
	Tue,  9 Apr 2024 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Mkp1pZBc"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687771A5A2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712666312; cv=none; b=Zon0EjC4FBVG7dPmhNwjXSUUxFs2PW79j5wc8/2VBnEaBb6w9capa/jTeTZJZZMnJAeQpUNzz3FF5gMu+Lz2Gi1SO7ec1UFrI1knpBb7HF4V9cqLgHlsKkgLZ31Ws7+IKHVdRrFTBoS3hEQ5kbdYAwgjXxYxx/GcaY+WA08fkLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712666312; c=relaxed/simple;
	bh=m5swuDZ2wL+wqUbOeNpYoCoR3TYjPHsYFwfsm6pAJ/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6Zfyihz6KbMesvaqwOAU/2/Mx8UJ712/JupEJJtgaEQXG2h0YJAdqaR+pOpVU+t/dhZgllXE/FX1Z7tO3fhMm8KMs51PpKK378hwBFTgRc3rcB0pxB7IQvIUEqBdcKZhFZPvFvASe6xZHmRt9r0ciT2K7v1pXYpIM9VFJ+fhwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Mkp1pZBc; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B5300C0010;
	Tue,  9 Apr 2024 12:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712666308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDC9y8yg1w7TUtcR7cDgK9v1QjlEuUY3vT4zIP9tPKc=;
	b=Mkp1pZBc5NPA8ktwgX7l0wIa2yX3BVpVfn2dD+MBazWv3JwvSjyA9lOBu61J+DKyy+/lRl
	Jj3ZKU44PgeZCXk6Wxv5Dd6vejHxWo7y4IhDevpd4tq/p66svxzZZRhONDFceXhDJN3vOG
	eSn1YBIdcoh1TSqjBnE5eB0HBViKxVeCZdXTnPNWHfMDvi+zlYhWGuDt62DiSuvBn8yZZj
	VVdM1d+cnFSoKBS8Jz4qqY+GkL0WUUScGPIkEgVypd635QGUlt0s2Qa7ODPSOR0CiBkpbg
	7NTZ5vsFtSZ2bAOi9SH6WYMTTaFmad7O+98tR3LRNOr4q/g3c6aKDfk7KIrmmQ==
Date: Tue, 9 Apr 2024 14:38:26 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	pekka.paalanen@collabora.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 0/3] drm: Multiple documentation update
Message-ID: <ZhU2wuD7whR06ijf@louis-chauvet-laptop>
Mail-Followup-To: Jani Nikula <jani.nikula@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	pekka.paalanen@collabora.com, thomas.petazzoni@bootlin.com
References: <20240409-google-drm-doc-v1-0-033d55cc8250@bootlin.com>
 <87msq296w7.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msq296w7.fsf@intel.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 09/04/24 - 13:18, Jani Nikula a écrit :
> On Tue, 09 Apr 2024, Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> > PATCH 1 and PATCH 2 focus on the rotation property. The rotation property 
> > can be challenging to understand, especially when it is combined with 
> > reflections. These patches aim to provide clearer explanations and 
> > examples to aid in comprehension.
> >
> > Patch 3 relates to the fourcc property. It includes additional details 
> > about block and char_per_block to provide a more comprehensive 
> > understanding of this feature.
> >
> > Regarding PATCH 1, I would appreciate some feedback on the expected 
> > behavior. During a recent VKMS refactor, I used drm_rect_rotate as a 
> > reference for the rotation. However, during my testing phase, I noticed 
> > that the original VKMS implementation interpreted the rotation 
> > differently. Therefore, I kindly request that someone validate or 
> > invalidate my interpretation before proceeding with the merge.
> 
> Did you run 'make htmldocs' and check the results after your changes?
> I'm almost certain this botches up the layout.

I did not think about htmldocs. I have a new version ready where the 
layout is fixed. Sorry about that.

I'll wait for more reviews before submitting it.

Thanks,
Louis Chauvet
 
> BR,
> Jani.
> 
> >
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> > Louis Chauvet (3):
> >       drm: drm_blend.c: Add precision in drm_rotation_simplify kernel doc
> >       drm: drm_blend.c: Improve drm_plane_create_rotation_property kernel doc
> >       drm/fourcc: Add documentation around drm_format_info
> >
> >  drivers/gpu/drm/drm_blend.c | 57 ++++++++++++++++++++++++++++++++++-----------
> >  include/drm/drm_fourcc.h    | 45 +++++++++++++++++++++++++++++------
> >  2 files changed, 81 insertions(+), 21 deletions(-)
> > ---
> > base-commit: e495e523b888a6155f82c767d34c8d712a41ee54
> > change-id: 20240327-google-drm-doc-cd275291792f
> >
> > Best regards,
> 
> -- 
> Jani Nikula, Intel

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

