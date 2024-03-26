Return-Path: <linux-kernel+bounces-119407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0802988C85C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63383B2A051
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF9113CC74;
	Tue, 26 Mar 2024 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q5jIzjLO"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C8C13C9CC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468631; cv=none; b=B6rWPPqcNTZiWBRpFbW1jdlnTm6VNbOR5Z46Tr0nRFCEfXTu/HfiaQBrS9wgq/usmij/yl3Ojwb9+o3Vg/iRkdA+i3CJtExVC8SsRzXap+3pX9Q0MdJYnRAU9CMiF4nP21zfQ88roQ3L4ZwrG9t1kG5cxbrPy31ad8DgrweXEas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468631; c=relaxed/simple;
	bh=Ixn1BFCknWB7tvXw/AFPlKu1mya2EmyRqOPQcH/8OUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giGckMLZ4XrTSaogVNydRO7scHPJaKBzxoitIRPed/pnJvP/noOLbit8VnjpnM77R7iKMUPXaLkdazoOnOiX7/XgyvAWUlZfBZ/MHO4OqbsQkFQYAApACt81N1xGRwULN+7Z90nqca3FYRmfeC0yZ0V53286auacR7teyGYsJJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q5jIzjLO; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CBCD51BF204;
	Tue, 26 Mar 2024 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711468621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bjha3IHwTqiFPh1YwXj/d0XZavZm48VG4oaRQvqaQ50=;
	b=Q5jIzjLODfk+39W+JGKprCVbfEgbLo+GihhcqM29at94QzoVWtkyOQWPipQfmlXimAySYm
	L+HwAdtKGADAi1+2sEt3W3OaeecrLWZQRVKKVFibb7XluRcUc7TmjrWRIvSJO6513wDQVa
	+ecaSBYrm9ecirZH+A5Ltq5QgWeh25rGB7BHxtAj8S/FOTTFqajmCBJ0+pUy4vQGQqGE6C
	GFJWinfj85OFszmaJsugYvsATHEuwSYR0PIA4RvuU64ASIkC6tbbE8PtokuQJmuodVepR3
	6MGshyHgjOdITY0mKdBR3jHj/79xOuQeKv7HjvDsHsBrp+ZBiQb203oPxAQZ1A==
Date: Tue, 26 Mar 2024 16:56:58 +0100
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
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH v5 05/16] drm/vkms: Add dummy pixel_read/pixel_write
 callbacks to avoid NULL pointers
Message-ID: <ZgLwSl1GC1jq1mDb@localhost.localdomain>
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
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
References: <20240313-yuv-v5-0-e610cbd03f52@bootlin.com>
 <20240313-yuv-v5-5-e610cbd03f52@bootlin.com>
 <20240325140542.4fffd42c.pekka.paalanen@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325140542.4fffd42c.pekka.paalanen@collabora.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 25/03/24 - 14:05, Pekka Paalanen a écrit :
> On Wed, 13 Mar 2024 18:44:59 +0100
> Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> 
> > Introduce two callbacks which does nothing. They are used in replacement
> > of NULL and it avoid kernel OOPS if this NULL is called.
> > 
> > If those callback are used, it means that there is a mismatch between
> > what formats are announced by atomic_check and what is realy supported by
> > atomic_update.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_formats.c | 43 +++++++++++++++++++++++++++++++------
> >  1 file changed, 37 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > index 55a4365d21a4..b57d85b8b935 100644
> > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > @@ -136,6 +136,21 @@ static void RGB565_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
> >  	out_pixel->b = drm_fixp2int_round(drm_fixp_mul(fp_b, fp_rb_ratio));
> >  }
> >  
> > +/**
> > + * black_to_argb_u16() - pixel_read callback which always read black
> > + *
> > + * This callback is used when an invalid format is requested for plane reading.
> > + * It is used to avoid null pointer to be used as a function. In theory, this function should
> > + * never be called, except if you found a bug in the driver/DRM core.
> > + */
> > +static void black_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
> > +{
> > +	out_pixel->a = (u16)0xFFFF;
> > +	out_pixel->r = 0;
> > +	out_pixel->g = 0;
> > +	out_pixel->b = 0;
> > +}
> > +
> >  /**
> >   * vkms_compose_row - compose a single row of a plane
> >   * @stage_buffer: output line with the composed pixels
> > @@ -238,6 +253,16 @@ static void argb_u16_to_RGB565(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
> >  	*pixel = cpu_to_le16(r << 11 | g << 5 | b);
> >  }
> >  
> > +/**
> > + * argb_u16_to_nothing() - pixel_write callback with no effect
> > + *
> > + * This callback is used when an invalid format is requested for writeback.
> > + * It is used to avoid null pointer to be used as a function. In theory, this should never
> > + * happen, except if there is a bug in the driver
> > + */
> > +static void argb_u16_to_nothing(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
> > +{}
> > +
> >  /**
> >   * Generic loop for all supported writeback format. It is executed just after the blending to
> >   * write a line in the writeback buffer.
> > @@ -261,8 +286,8 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
> >  
> >  /**
> >   * Retrieve the correct read_pixel function for a specific format.
> > - * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
> > - * pointer is valid before using it in a vkms_plane_state.
> > + * If the format is not supported by VKMS a warn is emitted and a dummy "always read black"
> > + * function is returned.
> >   *
> >   * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
> >   */
> > @@ -285,18 +310,21 @@ pixel_read_t get_pixel_read_function(u32 format)
> >  		 * format must:
> >  		 * - Be listed in vkms_formats in vkms_plane.c
> >  		 * - Have a pixel_read callback defined here
> > +		 *
> > +		 * To avoid kernel crash, a dummy "always read black" function is used. It means
> > +		 * that during the composition, this plane will always be black.
> >  		 */
> >  		WARN(true,
> >  		     "Pixel format %p4cc is not supported by VKMS planes. This is a kernel bug, atomic check must forbid this configuration.\n",
> >  		     &format);
> > -		return (pixel_read_t)NULL;
> > +		return &black_to_argb_u16;
> 
> Hi Louis,
> 
> I'm perhaps a bit paranoid in these things, but I'd make this not
> black. Maybe something more "screaming" like magenta. There is a slight
> chance that black might sometimes be expected, or not affect the
> result. After all, blending something into black with pre-multiplied
> alpha is equivalent to no-blending (a copy). The kernel warning is
> good, the magenta is more like an assurance.

Changed to 0xFF/0x00/0XFF in the V6.

Thanks,
Louis Chauvet
 
> Anyway,
> 
> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> 
> 
> Thanks,
> pq
> 
> 
> >  	}
> >  }
> >  
> >  /**
> >   * Retrieve the correct write_pixel function for a specific format.
> > - * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
> > - * pointer is valid before using it in a vkms_writeback_job.
> > + * If the format is not supported by VKMS a warn is emitted and a dummy "don't do anything"
> > + * function is returned.
> >   *
> >   * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
> >   */
> > @@ -319,10 +347,13 @@ pixel_write_t get_pixel_write_function(u32 format)
> >  		 * format must:
> >  		 * - Be listed in vkms_wb_formats in vkms_writeback.c
> >  		 * - Have a pixel_write callback defined here
> > +		 *
> > +		 * To avoid kernel crash, a dummy "don't do anything" function is used. It means
> > +		 * that the resulting writeback buffer is not composed and can contains any values.
> >  		 */
> >  		WARN(true,
> >  		     "Pixel format %p4cc is not supported by VKMS writeback. This is a kernel bug, atomic check must forbid this configuration.\n",
> >  		     &format);
> > -		return (pixel_write_t)NULL;
> > +		return &argb_u16_to_nothing;
> >  	}
> >  }
> > 
> 



-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

