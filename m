Return-Path: <linux-kernel+bounces-90816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43864870567
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBF51F25A82
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A17B481AA;
	Mon,  4 Mar 2024 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LBp/ntE7"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3D84654E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566119; cv=none; b=Cx0seW4SaZSPyMLmUuybdPFcjwaRDOgTrZAsf7A+ic+pEhioxzwtFRq3WNnvVxYC4lqKBKnhMvo1Xt3QdMnIAJf6VtSMDW9+zu4GyIzORxp+dJ1z+iXcZHb3UGkiSz2jCoBWW/63FKdLWO+sKCSnXn1MIntqeV6oBpnmxAybq+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566119; c=relaxed/simple;
	bh=3dDcnXbku+Z27ViRbBROCPmutzCnVSXDVXSXJUywoTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwgiFU8VFpKh3JgO5xunHpnWxRj4c8dz7nMeGM0NNwwjjiZNZT79iVvRnvrK8oBGnyIC4xnBWodDqC5bj/xEsdbDD61NKzroh3HE0P2VUiagXVW1XR+ITIUvrWqcjR8qqvEcKm4mgSxh9jqQTciaTtA9Hg+TQeo2Sckun3xTb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LBp/ntE7; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D5C824000A;
	Mon,  4 Mar 2024 15:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709566115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aI3n8d1YGiT9gHLQYdUrdxkKidF5d2P9k5U07rkaydA=;
	b=LBp/ntE7NGrS55I8dk57MpXv+Qbv9II5moe8TqKu1vg2wRw42ayMkkhiE8TC/PCzdieskq
	MeH00UrXWnPzBsx7Mm2OrRjMoenGm8hsrnv5qutjdEq9yDbna0r5Pn2Orul2X46qdLqjco
	qtc/lKFhpRSQ+pZ5F3xGAZAHtgEOxvGk7+BU/QqwOKxmrdulukYGqaT083RWhzFJxVzl6U
	0b3gD/C++OMsqfKTU7pxWWkN9wO08AZVexOtu0sAcXZ48BnYg1Yw/M817SyCZxaKCU5O+U
	i3+ihTaEN42XvqU/P2H5Ikx1VlYgfqEU0YTK5b3A486Wgq5CgzM0Ht5ZYaJJ+g==
Date: Mon, 4 Mar 2024 16:28:32 +0100
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
Subject: Re: [PATCH v2 4/9] drm/vkms: Add typedef and documentation for
 pixel_read and pixel_write functions
Message-ID: <ZeXooEmBN2HHxcCC@localhost.localdomain>
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
 <20240223-yuv-v2-4-aa6be2827bb7@bootlin.com>
 <20240226133646.174d3fb2.pekka.paalanen@collabora.com>
 <Zd35ddrlHduMq3_Y@localhost.localdomain>
 <20240229110737.27f03450.pekka.paalanen@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229110737.27f03450.pekka.paalanen@collabora.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 29/02/24 - 11:07, Pekka Paalanen a écrit :
> On Tue, 27 Feb 2024 16:02:13 +0100
> Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> 
> > Le 26/02/24 - 13:36, Pekka Paalanen a écrit :
> > > On Fri, 23 Feb 2024 12:37:24 +0100
> > > Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> > >   
> > > > Introduce two typedefs: pixel_read_t and pixel_write_t. It allows the
> > > > compiler to check if the passed functions take the correct arguments.
> > > > Such typedefs will help ensuring consistency across the code base in
> > > > case of update of these prototypes.
> > > > 
> > > > Introduce a check around the get_pixel_*_functions to avoid using a
> > > > nullptr as a function.
> > > > 
> > > > Document for those typedefs.
> > > > 
> > > > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > ---
> > > >  drivers/gpu/drm/vkms/vkms_drv.h       | 23 +++++++++++++++++++++--
> > > >  drivers/gpu/drm/vkms/vkms_formats.c   |  8 ++++----
> > > >  drivers/gpu/drm/vkms/vkms_formats.h   |  4 ++--
> > > >  drivers/gpu/drm/vkms/vkms_plane.c     |  9 ++++++++-
> > > >  drivers/gpu/drm/vkms/vkms_writeback.c |  9 ++++++++-
> > > >  5 files changed, 43 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > > > index 18086423a3a7..886c885c8cf5 100644
> > > > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > > > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > > > @@ -53,12 +53,31 @@ struct line_buffer {
> > > >  	struct pixel_argb_u16 *pixels;
> > > >  };
> > > >  
> > > > +/**
> > > > + * typedef pixel_write_t - These functions are used to read a pixel from a
> > > > + * `struct pixel_argb_u16*`, convert it in a specific format and write it in the @dst_pixels
> > > > + * buffer.
> > > > + *
> > > > + * @dst_pixel: destination address to write the pixel
> > > > + * @in_pixel: pixel to write
> > > > + */
> > > > +typedef void (*pixel_write_t)(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel);  
> > > 
> > > There are some inconsistencies in pixel_write_t and pixel_read_t. At
> > > this point of the series they still operate on a single pixel, but you
> > > use dst_pixels and src_pixels, plural. Yet the documentation correctly
> > > talks about processing a single pixel.  
> > 
> > I will fix this for v4.
> >  
> > > I would also expect the source to be always const, but that's a whole
> > > another patch to change.  
> > 
> > The v4 will contains a new patch "drm/vkms: Use const pointer for 
> > pixel_read and pixel_write functions"
> 
> Sounds good!
> 
> > 
> > [...]
> > 
> > > > diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> > > > index d5203f531d96..f68b1b03d632 100644
> > > > --- a/drivers/gpu/drm/vkms/vkms_plane.c
> > > > +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> > > > @@ -106,6 +106,13 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
> > > >  		return;
> > > >  
> > > >  	fmt = fb->format->format;
> > > > +	pixel_read_t pixel_read = get_pixel_read_function(fmt);
> > > > +
> > > > +	if (!pixel_read) {
> > > > +		DRM_WARN("Pixel format is not supported by VKMS planes. State is inchanged\n");  
> > > 
> > > DRM_WARN() is the kernel equivalent to userspace assert(), right?  
> > 
> > For the DRM_WARN it is just a standard prinkt(KERN_WARN, ...) (hidden 
> > behind drm internal macros).
> 
> My concern here is that does hitting this cause additional breakage of
> the UAPI contract? For example, the UAPI contract expects that the old
> FB is unreffed and the new FB is reffed by the plane in question. If
> this early return causes that FB swap to be skipped, it could cause
> secondary unexpected failures or misbehaviour for userspace later. That
> could mislead debugging to think that there is a userspace bug.
>
> Even if you cannot actually read FB due to an internal bug, it would be
> good to still apply all the state changes that the UAPI contract
> mandates.
> 
> Unless, this is a kernel bug kind of thing which explodes very
> verbosely, but DRM_WARN is not that.

You are right. In this case I maybe can just create a dummy 
"pixel_read" which always return black? (The v4 will have it so you can 
see how it look)

This way, I can:
- keep the check and avoid null function pointers (and OOPS);
- log (WARN, DRM_WARN, DRM_ERROR or whatever suggested by DRM maintainers 
to warn very loudly);
- Apply the requested change from userspace (and don't break the UAPI 
contract).

The resulting behavior will be "the virtual plane is black", which is, I
think, not very important. As the primary usage of VKMS is testing, it
will just broke all the tests, and a quick look at the kernel logs will
show this bug.
 
> > > In that failing the check means an internal invariant was violated,
> > > which means a code bug in kernel?
> > >
> > > Maybe this could be more specific about what invariant was violated?
> > > E.g. atomic check should have rejected this attempt already.  
> > 
> > I'm not an expert (yet) in DRM, so please correct me:
> > When atomic_update is called, the new state is always validated by 
> > atomic_check before? There is no way to pass something not validated by 
> > atomic_check to atomic_update? If this is the case, yes, it should be an 
> > ERROR and not a WARN as an invalid format passed the atomic_check 
> > verification.
> 
> I only know about the UAPI, I'm not familiar with kernel internals.
> 
> We see that atomic_update returns void, so I think it simply cannot
> return errors. To my understanding, atomic_check needs to ensure that
> atomic_update cannot fail. There is even UAPI to exercise atomic_check
> alone: the atomic commit TEST_ONLY flag. Userspace trusts that flag, and
> will not expect an identical atomic commit to fail without TEST_ONLY
> when it succeeded with TEST_ONLY.

That my understanding of the UAPI/DRM internals too, is my suggestion 
above sufficient? It will always succeed, no kernel OOPS.

> > If so, is this better?
> > 
> > 	if (!pixel_read) {
> > 		/*
> > 		 * This is a bug as the vkms_plane_atomic_check must forbid all unsupported formats.
> > 		 */
> > 		DRM_ERROR("Pixel format %4cc is not supported by VKMS planes.\n", fmt);
> > 		return;
> > 	}
> > 
> > I will put the same code in vkms_writeback.c.
> 
> Maybe maintainers can comment whether even DRM_ERROR is strong enough.
> 
> As for the message, what you wrote in the comment is the most important
> part that I'd put in the log. It explains what's going on, while that
> "format not supported" is a detail without context.
> 

Is something like this better?

	/*
	 * This is a bug in vkms_plane_atomic_check. All the supported 
	 * format must:
	 * - Be listed in vkms_formats
	 * - Have a pixel_read_line callback
	 */
	WARN(true, "Pixel format %4cc is not supported by VKMS planes. This is a kernel bug. Atomic check must forbid this configuration.\n", fmt)

> Thanks,
> pq

[...]

Kind regards,
Louis Chauvet

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

