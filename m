Return-Path: <linux-kernel+bounces-136629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA59E89D647
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601B7284B46
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DD081727;
	Tue,  9 Apr 2024 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EhDDzU8s"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD4680629
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657173; cv=none; b=i4m7xDcr0WHjrgKxDz91wkvqVoqJX8S4gK497dBjdgjEaoI9sUPeN6JS6y6Nl3OGn2n0Vd4Z/IlVqLbmUJHW6rYG4murKquBLzP9dABaJLy2ARKxgPYzjMxHuygkxu2CTPFQFU599dne3QEJNnLimFyYYrXNcAAZqdQUfgs+V1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657173; c=relaxed/simple;
	bh=mFNJ9GJFypFrzBVHys9OFUZJBSzxvUUASZWHXI5sgdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwX7GQKbnhaNDFp8VuNai3MDb9ND/y3VMe09KkeWlrKLioCqVt2QXY+Z2HVoRR3NQdE9xhGs9xhwkBEfDfaKJvvfn9gYQGzFhJCuk25D4Ad9b3urzHUBwEpTh6+o0j7Bz3rmh9OOGnD+9mYKBq/B675SAEFJqfz4+irx6QQJkkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EhDDzU8s; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D6AD1BF20A;
	Tue,  9 Apr 2024 10:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712657169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqqIhw8jAz1IoeoUfDX7ZgfwWio/XO2e8ETDGPutQoo=;
	b=EhDDzU8sbXO2ORX1BNpoLu25UrKjUEPzb9gNNo8miMT0FPupYk7lY0bAQanUccet26IqAA
	psBd8WSI0zQ52F3Vpp8D0z7YBSorfAiM9JP9EPexHpKShEAdMEQETjIjreZN1sIFTYZt7t
	7/ltiVNI+C4klRoDpshneoU+hPBcRI+GEKJsCE8k3K2qFsgUgOUaVpHYK445VMHIjFZFXa
	qZ6FXEavoyigREs61NNE951CB7nxmJDWUI4mZOMUvi6UrTX/OKwdtAVSNS2iEz0tluLtrY
	OsMOJjfJKtrHobVLsCn3qLAX2a+tkexP7azuvYP8r6dkw+uE3x9SN389tCJI7A==
Date: Tue, 9 Apr 2024 12:06:06 +0200
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
Message-ID: <ZhUTDvdsi2I-7-nE@localhost.localdomain>
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
 <ZhOhupo3bf6Cxasy@louis-chauvet-laptop>
 <20240409103537.44e99854.pekka.paalanen@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409103537.44e99854.pekka.paalanen@collabora.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 09/04/24 - 10:35, Pekka Paalanen a écrit :
> On Mon, 8 Apr 2024 09:50:18 +0200
> Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> 
> > Le 27/03/24 - 14:16, Pekka Paalanen a écrit :
> > > On Tue, 26 Mar 2024 16:57:00 +0100
> > > Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> > >   
> > > > Le 25/03/24 - 15:11, Pekka Paalanen a écrit :  
> > > > > On Wed, 13 Mar 2024 18:45:03 +0100
> > > > > Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> > > > >     
> > > > > > The pixel_read_direction enum is useful to describe the reading direction
> > > > > > in a plane. It avoids using the rotation property of DRM, which not
> > > > > > practical to know the direction of reading.
> > > > > > This patch also introduce two helpers, one to compute the
> > > > > > pixel_read_direction from the DRM rotation property, and one to compute
> > > > > > the step, in byte, between two successive pixel in a specific direction.
> > > > > > 
> > > > > > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > > > ---
> > > > > >  drivers/gpu/drm/vkms/vkms_composer.c | 36 ++++++++++++++++++++++++++++++++++++
> > > > > >  drivers/gpu/drm/vkms/vkms_drv.h      | 11 +++++++++++
> > > > > >  drivers/gpu/drm/vkms/vkms_formats.c  | 30 ++++++++++++++++++++++++++++++
> > > > > >  3 files changed, 77 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> > > > > > index 9254086f23ff..989bcf59f375 100644
> > > > > > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > > > > > +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> 
> > > > > I hope IGT uses FB patterns instead of solid color in its tests of
> > > > > rotation to be able to detect the difference.    
> > > > 
> > > > They use solid colors, and even my new rotation test [3] use solid colors.  
> > > 
> > > That will completely fail to detect rotation and reflection bugs then.
> > > E.g. userspace asks for 180-degree rotation, and the driver does not
> > > rotate at all. Or rotate-180 getting confused with one reflection.  
> > 
> > I think I missunderstood what you means with "solid colors".
> > 
> > The tests uses a plane with multiple solid colors:
> > 
> > +-------+-------+
> > | White | Red   |
> > +-------+-------+
> > | Blue  | Green |
> > +-------+-------+
> > 
> > But it don't use gradients because of YUV.
> >
> 
> Oh, that works. No worries then.
> 
> > > > It is mainly for yuv formats with subsampling: if you have formats with 
> > > > subsampling, a "software rotated buffer" and a "hardware rotated buffer" 
> > > > will not apply the same subsampling, so the colors will be slightly 
> > > > different.  
> > > 
> > > Why would they not use the same subsampling?  
> > 
> > YUV422, for each pair of pixels along a horizontal line, the U and V 
> > components are shared between those two pixels. However, along a vertical 
> > line, each pixel has its own U and V components.
> > 
> > When you rotate an image by 90 degrees:
> >  - Hardware Rotation: If you use hardware rotation, the YUV subsampling 
> >    axis will align with what was previously the "White-Red" axis. The 
> >    hardware will handle the rotation.
> >  - Software Rotation: If you use software rotation, the YUV subsampling 
> >    axis will align with what was previously the "Red-Green" axis.
> 
> That would be a bug in the software rotation.

Yes, but it is very complex to fix I think, so I did not chose 
this path :)
 
> > Because the subsampling compression axis changes depending on whether 
> > you're using hardware or software rotation, the compression effect on 
> > colors will differ. Specifically:
> >  - Hardware rotation, a gradient along the "White-Red" axis may be 
> >    compressed (i.e same UV component for multiple pixels along the 
> >    gradient).
> >  - Software rotation, the same gradient will not be compressed (i.e, each 
> >    different color in the gradient have dedicated UV component)
> > 
> > The same reasoning also apply for "color borders", and my series [3] avoid 
> > this issue by choosing the right number of pixels.
> 
> What is [3]?

I don't know why I put [3] here, I probably mixed references between mails

[3]: https://lore.kernel.org/all/20240313-new_rotation-v2-0-6230fd5cae59@bootlin.com/
 
> I've used similar tactics in the Weston test suite, when I have no
> implementation for chroma siting: the input and reference images
> consist of 2x2 equal color pixel groups, so that chroma siting makes no
> difference. When chroma siting will be implemented, the tests will be
> extended.
> 
> Is there a TODO item to fix the software rotation bug and make the
> tests more sensitive?
> 
> I think documenting this would be an ok intermediate solution.
> 
> > > The framebuffer contents are defined in its natural orientation, and
> > > the subsampling applies in the natural orientation. If such a FB
> > > is on a rotated plane, one must account for subsampling first, and
> > > rotate second. 90-degree rotation does not change the encoded color.
> > > 
> > > Getting the subsampling exactly right is going to be necessary sooner
> > > or later. There is no UAPI for setting chroma siting yet, but ideally
> > > there should be.
> > >   
> > > > > The return values do seem correct to me, assuming I have guessed
> > > > > correctly what "X" and "Y" refer to when combined with rotation. I did
> > > > > not find good documentation about that.    
> > > > 
> > > > Yes, it is difficult to understand how rotation and reflexion should 
> > > > works in drm. I spend half a day testing all the combination in drm_rect_* 
> > > > helpers to understand how this works. According to the code:
> > > > - If only rotation or only reflexion, easy as expected
> > > > - If reflexion and rotation are mixed, the source buffer is first 
> > > >   reflected and then rotated.  
> > > 
> > > Now that you know, you could send a documentation patch. :-)  
> > 
> > And now I'm not sure about it :)
> 
> You'll have people review the patch and confirm your understanding or
> point out a mistake. A doc patch it easier to notice and jump in than
> this series.

I just send it [4], you are in copy.

[4]: https://lore.kernel.org/all/20240409-google-drm-doc-v1-0-033d55cc8250@bootlin.com/

> > I was running the tests on my v6, and for the first time ran my new 
> > rotation [3] on the previous VKMS code. None of the tests for 
> > ROT_90+reflexion and ROT_270+reflexion are passing...
> > 
> > So, either the previous vkms implementation was wrong, or mine is wrong :)
> > 
> > So, if a DRM expert can explain this, it could be nice.
> > 
> > To have a common example, if I take the same buffer as above 
> > (white+red+blue+green), if I create a plane with rotation = 
> > ROTATION_90 | REFLECTION_X, what is the expected result?
> > 
> > 1 - rotation then reflection 
> > 
> > +-------+-------+
> > | Green | Red   |
> > +-------+-------+
> > | Blue  | White |
> > +-------+-------+
> > 
> > 2 - reflection then rotation (my vkms implementation)
> > 
> > +-------+-------+
> > | White | Blue  |
> > +-------+-------+
> > | Red   | Green |
> > +-------+-------+
> > 
> 
> I wish I knew. :-)
> 
> Thanks,
> pq
> 
> 
> > > For me as a userspace developer, the important place is
> > > https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#standard-plane-properties
> > >   



