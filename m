Return-Path: <linux-kernel+bounces-147691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9FB8A77C8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91EC1F23A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE726CDB9;
	Tue, 16 Apr 2024 22:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mVbQBm30"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD301E876
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713306669; cv=none; b=SzdJzTaDKzo4Z85d66gQP6kMHSVcCiOZGqQuWKwgwDSiD2mHdbXIs5RQMBHPKKEq9GZ+jFhHPHK2t8xdhWJbmb3oC6pD0GbDIY9aYn21A+U7wdLvgo+a2judL79UOYxrMHGyHcEonJHIkbZNF2i84VFMZm7Onu4iE+VSsRNafk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713306669; c=relaxed/simple;
	bh=sT9aXckXk/rLKqQXF/MBu3GnIC3SUEGC7k/sMS85e4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4X9h8nC+ZFPbj86Hmgfz2AXGiPxaSo9V0FxsqqrXgwJBPP4DA4ROU1tPE3iFKozN40a7yOzDA9eqewzQmK/nQSeTum2CUOYLg3OS/1f7EYJBpXWqs7lxnoL2QSbqnvGiYyBYsxQbJHa/k0eQ6t6KZhiU6N+GouVg0ZHscZ3WTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mVbQBm30; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5ED29E0006;
	Tue, 16 Apr 2024 22:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713306664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9gPcWpJ1Hy7nug5A+nc0koarB8z3e1g969eocaINfc=;
	b=mVbQBm30oTDEzmV3SVfWmWVeXPGNs2dkzqvitONACdGQ8ejt2ELmTefSoZYx/LKfCj4mgj
	pCNAJgX8/u9WbGjCgBChe5lrsqeZr2LZV79YpCuMX6Jm1mwkDnfCZQab3S5AjrLdWkHqER
	fJ5r6h+EITOLvcsioIj/53CJAOXaiZhIZHohjIBjuqDjyt6M5wlGEgyTZ4vsS4VFiZcWxj
	sazJrDrucf964dGfDwgaaFAoTNYUHsrT7TAL/hielCAeKnc40qSNj2ZbLhF7PJiSXSk0Xc
	4GGrP42ZIzeIkFQfA6PfK577Yy31QcKfr2p/qQv6NYs86EXULUspLr5xbaQC8w==
Date: Wed, 17 Apr 2024 00:30:58 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	pekka.paalanen@collabora.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 2/3] drm: drm_blend.c: Improve
 drm_plane_create_rotation_property kernel doc
Message-ID: <Zh78InZWwvkEqul6@localhost.localdomain>
Mail-Followup-To: Bagas Sanjaya <bagasdotme@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	pekka.paalanen@collabora.com, thomas.petazzoni@bootlin.com
References: <20240409-google-drm-doc-v1-0-033d55cc8250@bootlin.com>
 <20240409-google-drm-doc-v1-2-033d55cc8250@bootlin.com>
 <Zh05hqtB9owzjjez@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zh05hqtB9owzjjez@archie.me>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 15/04/24 - 21:28, Bagas Sanjaya a écrit :
> On Tue, Apr 09, 2024 at 12:04:06PM +0200, Louis Chauvet wrote:
> > @@ -266,8 +257,41 @@ EXPORT_SYMBOL(drm_plane_create_alpha_property);
> >   *
> >   * Rotation is the specified amount in degrees in counter clockwise direction,
> >   * the X and Y axis are within the source rectangle, i.e.  the X/Y axis before
> > - * rotation. After reflection, the rotation is applied to the image sampled from
> > - * the source rectangle, before scaling it to fit the destination rectangle.
> > + * rotation.
> > + *
> > + * Here are some examples of rotation and reflections:
> > + *
> > + * |o  +|  REFLECT_X  |+  o|
> > + * |    |  ========>  |    |
> > + * |    |             |    |
> > + *
> > + * |o   |  REFLECT_Y  |+   |
> > + * |    |  ========>  |    |
> > + * |+   |             |o   |
> > + *
> > + * |o  +|  ROTATE_90  |+   |
> > + * |    |  ========>  |    |
> > + * |    |             |o   |
> > + *
> > + * |o   |  ROTATE_180 |   +|
> > + * |    |  ========>  |    |
> > + * |+   |             |   o|
> > + *
> > + * |o   |  ROTATE_270 |+  o|
> > + * |    |  ========>  |    |
> > + * |+   |             |    |
> > + *
> > + * Rotation and reflection can be combined to handle more situations. In this condition, the
> > + * reflection is applied first and the rotation in second.
> > + *
> > + * For example the expected result for DRM_MODE_ROTATE_90 | DRM_MODE_REFLECT_X is:
> > + *
> > + * |o  +|  REFLECT_X  |+  o|  ROTATE_90  |o   |
> > + * |    |  ========>  |    |  ========>  |    |
> > + * |    |             |    |             |+   |
> > + *
> > + * It is not possible to pass multiple rotation at the same time. (i.e ROTATE_90 | ROTATE_180 is
> > + * not the same as ROTATE_270 and is not accepted).
> 
> Sphinx reports htmldocs warnings on these transformation diagrams:
> 
> Documentation/gpu/drm-kms:389: ./drivers/gpu/drm/drm_blend.c:265: ERROR: Undefined substitution referenced: "o +".
> Documentation/gpu/drm-kms:389: ./drivers/gpu/drm/drm_blend.c:265: ERROR: Undefined substitution referenced: "+ o".
> Documentation/gpu/drm-kms:389: ./drivers/gpu/drm/drm_blend.c:273: ERROR: Undefined substitution referenced: "o +".
> Documentation/gpu/drm-kms:389: ./drivers/gpu/drm/drm_blend.c:277: ERROR: Undefined substitution referenced: "o | ROTATE_180 | +".
> Documentation/gpu/drm-kms:389: ./drivers/gpu/drm/drm_blend.c:277: ERROR: Undefined substitution referenced: "+ | | o".
> Documentation/gpu/drm-kms:389: ./drivers/gpu/drm/drm_blend.c:281: ERROR: Undefined substitution referenced: "o | ROTATE_270 |+ o".
> Documentation/gpu/drm-kms:389: ./drivers/gpu/drm/drm_blend.c:290: ERROR: Undefined substitution referenced: "o +".
> Documentation/gpu/drm-kms:389: ./drivers/gpu/drm/drm_blend.c:290: ERROR: Undefined substitution referenced: "+ o".
> 
> I have to wrap them in literal blocks:
> 
> ---- >8 ----
> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index 6fbb8730d8b022..f2cbf8d8efbbbc 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
> @@ -259,36 +259,36 @@ EXPORT_SYMBOL(drm_plane_create_alpha_property);
>   * the X and Y axis are within the source rectangle, i.e.  the X/Y axis before
>   * rotation.
>   *
> - * Here are some examples of rotation and reflections:
> + * Here are some examples of rotation and reflections::
>   *
> - * |o  +|  REFLECT_X  |+  o|
> - * |    |  ========>  |    |
> - * |    |             |    |
> + *	|o  +|  REFLECT_X  |+  o|
> + *	|    |  ========>  |    |
> + *	|    |             |    |
>   *
> - * |o   |  REFLECT_Y  |+   |
> - * |    |  ========>  |    |
> - * |+   |             |o   |
> + *	|o   |  REFLECT_Y  |+   |
> + *	|    |  ========>  |    |
> + *	|+   |             |o   |
>   *
> - * |o  +|  ROTATE_90  |+   |
> - * |    |  ========>  |    |
> - * |    |             |o   |
> + *	|o  +|  ROTATE_90  |+   |
> + *	|    |  ========>  |    |
> + *	|    |             |o   |
>   *
> - * |o   |  ROTATE_180 |   +|
> - * |    |  ========>  |    |
> - * |+   |             |   o|
> + *	|o   |  ROTATE_180 |   +|
> + *	|    |  ========>  |    |
> + *	|+   |             |   o|
>   *
> - * |o   |  ROTATE_270 |+  o|
> - * |    |  ========>  |    |
> - * |+   |             |    |
> + *	|o   |  ROTATE_270 |+  o|
> + *	|    |  ========>  |    |
> + *	|+   |             |    |
>   *
>   * Rotation and reflection can be combined to handle more situations. In this condition, the
>   * reflection is applied first and the rotation in second.
>   *
> - * For example the expected result for DRM_MODE_ROTATE_90 | DRM_MODE_REFLECT_X is:
> + * For example the expected result for DRM_MODE_ROTATE_90 | DRM_MODE_REFLECT_X is::
>   *
> - * |o  +|  REFLECT_X  |+  o|  ROTATE_90  |o   |
> - * |    |  ========>  |    |  ========>  |    |
> - * |    |             |    |             |+   |
> + *	|o  +|  REFLECT_X  |+  o|  ROTATE_90  |o   |
> + *	|    |  ========>  |    |  ========>  |    |
> + *	|    |             |    |             |+   |
>   *
>   * It is not possible to pass multiple rotation at the same time. (i.e ROTATE_90 | ROTATE_180 is
>   * not the same as ROTATE_270 and is not accepted).
> 
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara

It will be fixed in the next version, thanks!

Louis Chauvet

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

