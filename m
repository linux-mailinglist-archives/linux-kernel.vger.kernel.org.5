Return-Path: <linux-kernel+bounces-48606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22580845EBA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50411F20F4A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79C36FBB6;
	Thu,  1 Feb 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YzY1cTmS"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30366FB80;
	Thu,  1 Feb 2024 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809183; cv=none; b=EzEIcqwxCH53OPzyE+kNCO6a6X8QW5Ceu+Mri1iTlKJ08YJDITRwLCegaYSIlhgN8PdlrounEDhStTbc+yhTZRQv3yogUmnxhesWKgRZDQgBgdigzuEygT5/DSpJoRBm5yjSRDNqWBODiTq+26ZlOogn0X6wQrNQLFwiMd7oZmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809183; c=relaxed/simple;
	bh=RWGyUTm81HR0yufwItYXvd5eIRRmFJnLjC1+iy6AijI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3uKrOSrVnCyUl31mIfOyaFXj3EG8z3jIyX4JXuOuOO5jc+WifXt9Fxu4Fl/t/VPC4lP+fvO4TKZD+Wt8eJATj9gdP/TYBimtk46aiAvnE8oGLjgMAV3T4oVgAEcgn8/5Dl8lrkX9f/+ROyJGIr4SVodcphC3VwCS5KMbonZR60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YzY1cTmS; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4896A40006;
	Thu,  1 Feb 2024 17:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706809178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V2KBXwj4NCjvyE4+0IyeJO23YI/n7DqRxLkdLjw4M2I=;
	b=YzY1cTmSdDy0ffIMayCgOBcypcfMFD/Hvvfmyst5xxSR1Vg5PS4+95h2BDc+oz66xWiUgp
	ax/GemPF+x9OGVoXKrtTZkr6Ry4ajL99c58ko7eTVTAsc6dAD2QyZz/IgA6TphbY3iG8rz
	uV5w1IrlTydt64Wo3l3qVM+b8Vu77J7npywQtfl7Vp1WE6RDw9cEpve9UT1dse5ZJWGnN/
	pIXAywFNqRQP6FTcBekTJ0LmmpNrPNSe2y/iWxAIU+myq04SxINmA0ZGEEtzfdSDpkVVl4
	puibyhHuFDpBo756cSN2+AUrNMhhHHuqlfVgW3qKhqqHnFvvkeZl0iqQvnrZLw==
Date: Thu, 1 Feb 2024 18:39:35 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Arthur Grillo <arthurgrillo@riseup.net>
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Melissa Wen <melissa.srw@gmail.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, nicolejadeyee@google.com,
	seanpaul@google.com, thomas.petazzoni@bootlin.com,
	miquel.raynal@bootlin.com
Subject: Re: [PATCH v2 4/7] drm/vkms: Add chroma subsampling
Message-ID: <ZbvXV-1hrfXLcvC3@localhost.localdomain>
Mail-Followup-To: Arthur Grillo <arthurgrillo@riseup.net>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Melissa Wen <melissa.srw@gmail.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, nicolejadeyee@google.com,
	seanpaul@google.com, thomas.petazzoni@bootlin.com,
	miquel.raynal@bootlin.com
References: <20240110-vkms-yuv-v2-0-952fcaa5a193@riseup.net>
 <20240110-vkms-yuv-v2-4-952fcaa5a193@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110-vkms-yuv-v2-4-952fcaa5a193@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

[...]

> @@ -146,18 +149,23 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
>  	for (size_t x = 0; x < limit; x++) {
>  		int x_pos = get_x_position(frame_info, limit, x);
>  
> +		bool shoud_inc = !((x + 1) % frame_format->num_planes);

I think this line will break if the subsampling is not the same as the 
plane count. For NV12 it works only because there are two planes and 
hsub=2/vsub=2, but I believe NV24 will not work because of plane 2, as 
we need to increment x at the same speed on all planes.

I have a proposal to solve this issue (see my patchset applying on top of 
yours). You probably at least need to use .hsub/vsub to 
increment/decrement properly src_pixels pointer.

Currently the tests pass for it because it only use "horizontal 
lines" and "full color" pictures. 

In the series [1] I proposed to change the pattern to detect this kind of 
issue.

[...]

[1]: https://lore.kernel.org/dri-devel/20240201-yuv-v1-0-3ca376f27632@bootlin.com/T/#t

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

