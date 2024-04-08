Return-Path: <linux-kernel+bounces-134962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD00189B963
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D4F1F20CAA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3AF3C48D;
	Mon,  8 Apr 2024 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kH7xxpV5"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252704F1EB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562625; cv=none; b=BOqHQ8Ai1PF1nNoVCFSiWS2G1/aUHXpRxNI+7yv9i5dZFiAn8gAQcq939gs76mWR/0k0T7TI/z1jAkTnVXPy6FAFYZB+QKaGf5SY4SuHvuksholu+4YhLwTpXED0beyAnCyayka5BokiLfG094w05L6DvR8+iusyoVGSZMxKyP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562625; c=relaxed/simple;
	bh=RjYRTDvzTcTKvXloWUm+Og7kf8w/nybMo/cGCHzJppU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuDArzm2OTH5Jg88VhhYBCmBix5sALcC3RoIzhbWbNrKhhEdRbwa9G40cp9WQbQwsxwBvc4pJFJF9k+J63ugrlOWqeaa0h9t7jlm20AS6OGYJRRZ6/EfI+HvcRuzANPjIon7+gxNyJmjvDKPBXDfvsALMCgZey/XWMeRs0A4Hq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kH7xxpV5; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B8889E0005;
	Mon,  8 Apr 2024 07:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712562621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7J4B7uFncGNc/REWUGl1tz0b0N7yc6POe9VIZOkYi9g=;
	b=kH7xxpV5mrUdtwyCqApHyEsUATMVVPSr9NoZImWMFnY7ChJ1qcAeUjDmFhEvWwg3Tj3y2M
	tHacVtLlhlKVrVAqDQ/wUe0UC44hoBtRg1m9dZOSxoWdHtHBWMt/8K3F96Ulp5EqZOd8MM
	sv9ucffpb7tMvZvL1pc8s+MrYpZUPmHcc8D3qYrXJreYMlGvqu3FsnUUX8cseHuA2DXcid
	IhPHfkgorzQ1RmlT9za1Ep0rA+8SnAzQcfYv7+agXCESiOfScAmulfCXu2RodwCtMYti2+
	ZEf6461m4hOH7raJLR1UexBsfkXDLXuC8yOL5+U2eFL8d+g7uUVAMgWZ3Qsx2g==
Date: Mon, 8 Apr 2024 09:50:18 +0200
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
Subject: Re: [PATCH v5 09/16] drm/vkms: Introduce pixel_read_direction enum
Message-ID: <ZhOhupo3bf6Cxasy@louis-chauvet-laptop>
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
 <20240313-yuv-v5-9-e610cbd03f52@bootlin.com>
 <20240325151103.0a5f7112.pekka.paalanen@collabora.com>
 <ZgLwTJVb_Z_MHuCp@localhost.localdomain>
 <20240327141629.48ec16f2.pekka.paalanen@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327141629.48ec16f2.pekka.paalanen@collabora.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 27/03/24 - 14:16, Pekka Paalanen a écrit :
> On Tue, 26 Mar 2024 16:57:00 +0100
> Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> 
> > Le 25/03/24 - 15:11, Pekka Paalanen a écrit :
> > > On Wed, 13 Mar 2024 18:45:03 +0100
> > > Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> > >   
> > > > The pixel_read_direction enum is useful to describe the reading direction
> > > > in a plane. It avoids using the rotation property of DRM, which not
> > > > practical to know the direction of reading.
> > > > This patch also introduce two helpers, one to compute the
> > > > pixel_read_direction from the DRM rotation property, and one to compute
> > > > the step, in byte, between two successive pixel in a specific direction.
> > > > 
> > > > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > ---
> > > >  drivers/gpu/drm/vkms/vkms_composer.c | 36 ++++++++++++++++++++++++++++++++++++
> > > >  drivers/gpu/drm/vkms/vkms_drv.h      | 11 +++++++++++
> > > >  drivers/gpu/drm/vkms/vkms_formats.c  | 30 ++++++++++++++++++++++++++++++
> > > >  3 files changed, 77 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> > > > index 9254086f23ff..989bcf59f375 100644
> > > > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > > > +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> > > > @@ -159,6 +159,42 @@ static void apply_lut(const struct vkms_crtc_state *crtc_state, struct line_buff
> > > >  	}
> > > >  }
> > > >  
> > > > +/**
> > > > + * direction_for_rotation() - Get the correct reading direction for a given rotation
> > > > + *
> > > > + * This function will use the @rotation setting of a source plane to compute the reading
> > > > + * direction in this plane which correspond to a "left to right writing" in the CRTC.
> > > > + * For example, if the buffer is reflected on X axis, the pixel must be read from right to left
> > > > + * to be written from left to right on the CRTC.  
> > > 
> > > That is a well written description.  
> > 
> > Thanks
> >  
> > > > + *
> > > > + * @rotation: Rotation to analyze. It correspond the field @frame_info.rotation.
> > > > + */
> > > > +static enum pixel_read_direction direction_for_rotation(unsigned int rotation)
> > > > +{
> > > > +	if (rotation & DRM_MODE_ROTATE_0) {
> > > > +		if (rotation & DRM_MODE_REFLECT_X)
> > > > +			return READ_RIGHT_TO_LEFT;
> > > > +		else
> > > > +			return READ_LEFT_TO_RIGHT;
> > > > +	} else if (rotation & DRM_MODE_ROTATE_90) {
> > > > +		if (rotation & DRM_MODE_REFLECT_Y)
> > > > +			return READ_BOTTOM_TO_TOP;
> > > > +		else
> > > > +			return READ_TOP_TO_BOTTOM;
> > > > +	} else if (rotation & DRM_MODE_ROTATE_180) {
> > > > +		if (rotation & DRM_MODE_REFLECT_X)
> > > > +			return READ_LEFT_TO_RIGHT;
> > > > +		else
> > > > +			return READ_RIGHT_TO_LEFT;
> > > > +	} else if (rotation & DRM_MODE_ROTATE_270) {
> > > > +		if (rotation & DRM_MODE_REFLECT_Y)
> > > > +			return READ_TOP_TO_BOTTOM;
> > > > +		else
> > > > +			return READ_BOTTOM_TO_TOP;
> > > > +	}
> > > > +	return READ_LEFT_TO_RIGHT;  
> > > 
> > > I'm a little worried seeing REFLECT_X is supported only for some
> > > rotations, and REFLECT_Y for other rotations. Why is an analysis of all
> > > combinations not necessary?  
> > 
> > I don't need to manage all the combination because this is only about 
> > the "horizontal writing".
> > 
> > So, if you want to write a line in the CRTC, with:
> > - ROT_0 || REF_X => You need to read the source line from right to left
> > - ROT_0 => You need to read source buffer from left to right
> > - ROT_0 || REF_Y => You need to read the source line from left to right
> 
> That is true, indeed.
> 
> > In this case, REF_Y only have an effect on the "column reading". It is not 
> > needed here because the new version of the blend function will use the 
> > drm_rect_* helpers to compute the correct y coordinate.
> > 
> > If you think it's clearer, I can create a big switch(rotation) like this:
> > 
> > 	switch (rotation) {
> > 	case ROT_0:
> > 	case ROT_0 || REF_X:
> > 		return L2R;
> > 	case ROT_0 || REF_Y:
> > 		return R2L;
> > 	case ROT_90:
> > 	case ROT_90 || REF_X:
> > 		return T2B;
> > 	[...]
> > 	}
> > 
> > So all cases are clearly covered?
> 
> I think that would suit my personal taste better. It would not raise
> questions nor need a comment. It does become a long function, but I
> tend to favour long and clear more than short and needs thinking to
> figure out if it works, everything else being equivalent.

I will change it to switch case.
 
> I wonder how DRM maintainers feel.
> 
> > > I hope IGT uses FB patterns instead of solid color in its tests of
> > > rotation to be able to detect the difference.  
> > 
> > They use solid colors, and even my new rotation test [3] use solid colors.
> 
> That will completely fail to detect rotation and reflection bugs then.
> E.g. userspace asks for 180-degree rotation, and the driver does not
> rotate at all. Or rotate-180 getting confused with one reflection.

I think I missunderstood what you means with "solid colors".

The tests uses a plane with multiple solid colors:

+-------+-------+
| White | Red   |
+-------+-------+
| Blue  | Green |
+-------+-------+

But it don't use gradients because of YUV.
 
> > It is mainly for yuv formats with subsampling: if you have formats with 
> > subsampling, a "software rotated buffer" and a "hardware rotated buffer" 
> > will not apply the same subsampling, so the colors will be slightly 
> > different.
> 
> Why would they not use the same subsampling?

YUV422, for each pair of pixels along a horizontal line, the U and V 
components are shared between those two pixels. However, along a vertical 
line, each pixel has its own U and V components.

When you rotate an image by 90 degrees:
 - Hardware Rotation: If you use hardware rotation, the YUV subsampling 
   axis will align with what was previously the "White-Red" axis. The 
   hardware will handle the rotation.
 - Software Rotation: If you use software rotation, the YUV subsampling 
   axis will align with what was previously the "Red-Green" axis.

Because the subsampling compression axis changes depending on whether 
you're using hardware or software rotation, the compression effect on 
colors will differ. Specifically:
 - Hardware rotation, a gradient along the "White-Red" axis may be 
   compressed (i.e same UV component for multiple pixels along the 
   gradient).
 - Software rotation, the same gradient will not be compressed (i.e, each 
   different color in the gradient have dedicated UV component)

The same reasoning also apply for "color borders", and my series [3] avoid 
this issue by choosing the right number of pixels.

> The framebuffer contents are defined in its natural orientation, and
> the subsampling applies in the natural orientation. If such a FB
> is on a rotated plane, one must account for subsampling first, and
> rotate second. 90-degree rotation does not change the encoded color.
> 
> Getting the subsampling exactly right is going to be necessary sooner
> or later. There is no UAPI for setting chroma siting yet, but ideally
> there should be.
> 
> > > The return values do seem correct to me, assuming I have guessed
> > > correctly what "X" and "Y" refer to when combined with rotation. I did
> > > not find good documentation about that.  
> > 
> > Yes, it is difficult to understand how rotation and reflexion should 
> > works in drm. I spend half a day testing all the combination in drm_rect_* 
> > helpers to understand how this works. According to the code:
> > - If only rotation or only reflexion, easy as expected
> > - If reflexion and rotation are mixed, the source buffer is first 
> >   reflected and then rotated.
> 
> Now that you know, you could send a documentation patch. :-)

And now I'm not sure about it :)

I was running the tests on my v6, and for the first time ran my new 
rotation [3] on the previous VKMS code. None of the tests for 
ROT_90+reflexion and ROT_270+reflexion are passing...

So, either the previous vkms implementation was wrong, or mine is wrong :)

So, if a DRM expert can explain this, it could be nice.

To have a common example, if I take the same buffer as above 
(white+red+blue+green), if I create a plane with rotation = 
ROTATION_90 | REFLECTION_X, what is the expected result?

1 - rotation then reflection 

+-------+-------+
| Green | Red   |
+-------+-------+
| Blue  | White |
+-------+-------+

2 - reflection then rotation (my vkms implementation)

+-------+-------+
| White | Blue  |
+-------+-------+
| Red   | Green |
+-------+-------+

Thanks a lot,
Louis Chauvet

> For me as a userspace developer, the important place is
> https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#standard-plane-properties
> 
> >  
> > > Btw. if there are already functions that are able to transform
> > > coordinates based on the rotation bitfield, you could alternatively use
> > > them. Transform CRTC point (0, 0) to A, and (1, 0) to B. Now A and B
> > > are in plane coordinate system, and vector B - A gives you the
> > > direction. The reason I'm mentioning this is that then you don't have
> > > to implement yet another copy of the rotation bitfield semantics from
> > > scratch.  
> > 
> > You are totaly right. I will try this elegant method. Yes, there are some 
> > helpers (drm_rect_rotate_inv), so I will try to do something.

It works fine, a bit more tricky to get the right implementation. It will 
be in the v6.
 
> Cool, thanks,
> pq
> 
   
[...]


-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

