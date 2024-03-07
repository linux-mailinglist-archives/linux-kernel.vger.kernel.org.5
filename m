Return-Path: <linux-kernel+bounces-94762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B0D8744F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD5F1F25AC0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F671FA4;
	Thu,  7 Mar 2024 00:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="peexX0AA"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573917F0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 00:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769820; cv=none; b=OplQs96794SUdMHPcavwXe9yVu3dibd78d69T+D84w2c6lYQmb8yWZZiRmZVxVOd+QqLOhU82l26BR3A6o1o+eoaQt2oF+BgNhBm2luUa5o83qv1iUGhN7rP/Ea3ddYwUF1TaQFWOIkRsXR7XRdrwqCkQ6486vFbbdDFORZPdsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769820; c=relaxed/simple;
	bh=RmIaE95j9tGXdTs/a5M9v0UNVZUALUbMvKJoZsyGp6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZjAd6hG9LOUDiFz6zaMuvk176IF0jZLLp7lmIyoA7hVejdXBuQwP1FGxVBQkPqhKUPWjRM43qFwNCPdtV+ovFFnEEFaKTdzpB2vGqAmkW6iOSprRY6kTpvmNkuBksD657iRmJav6tIIR2m9AZpVP/4u1DvsNXczWzgpJlVkc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=peexX0AA; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C5B360003;
	Thu,  7 Mar 2024 00:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709769816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YV8E64LTaxsAW1jsNczlEzcxi3GT245AiC4UGrhHsUI=;
	b=peexX0AANXlwYG/zkq1lh5bvcDkR4fuWupWrXew1xWKDoA2nh9qH4Oa8i4lRKxqiApBJsB
	N3L+NL3g3WU49hDCburHjmTJnN99968AyIp/opJG2aopR1DGib1K2JEFYTHjHdj/6OmM7L
	+86zvJAbY7zYguuiwtGJZiiK8y1Mt0eLmDprVmAknuDLYyc73Iv5vTtpFTBEVvLVlmrF7c
	Mr1MRJEyK1zNiZp8IWnSdpXumwcVAyB6EmMfPQTYDCX0HsvUhAd9KiOlpXh8b/s9rK75Q9
	UYlS25AYWQQZY9RmCRizn6/bLLsOmMZHOIXL8d31GOOWbbCriyTU3/tsRKO6mg==
Date: Thu, 7 Mar 2024 01:03:33 +0100
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
Subject: Re: [PATCH 4/7] drm/vkms: Fix compilation issues
Message-ID: <ZekEVT_HNmZbFWNG@localhost.localdomain>
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
References: <20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net>
 <20240306-louis-vkms-conv-v1-4-5bfe7d129fdd@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240306-louis-vkms-conv-v1-4-5bfe7d129fdd@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 06/03/24 - 17:03, Arthur Grillo a écrit :
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> ---
>  drivers/gpu/drm/vkms/tests/vkms_format_test.c | 2 +-
>  drivers/gpu/drm/vkms/vkms_drv.h               | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> index 4636b013602f..3522ecee960f 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> @@ -113,7 +113,7 @@ static void vkms_format_test_yuv_u8_to_argb_u16(struct kunit *test)
>  	for (size_t i = 0; i < param->n_colors; i++) {
>  		const struct format_pair *color = &param->colors[i];
>  
> -		const struct conversion_matrix *matrix = get_conversion_matrix_to_argb_u16
> +		struct conversion_matrix *matrix = get_conversion_matrix_to_argb_u16
>  			(DRM_FORMAT_NV12, param->encoding, param->range);
>  
>  		argb = argb_u16_from_yuv888(color->yuv.y, color->yuv.u, color->yuv.v, matrix);
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 393b76e7c694..3d62578499ab 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -47,6 +47,10 @@ struct pixel_argb_u16 {
>  	u16 a, r, g, b;
>  };
>  
> +struct pixel_yuv_u8 {
> +	u8 y, u, v;
> +};

Can I move this structure in the test itself? As discussed with Pekka, I 
think it's not a good idea to have such specific `pixel_{fmt}_{size}` for 
each variant. Leaving it in vkms_drv.h give the idea of "for each new kind 
of format we have to create a new structure".

> +
>  struct line_buffer {
>  	size_t n_pixels;
>  	struct pixel_argb_u16 *pixels;
> 
> -- 
> 2.43.0
> 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

