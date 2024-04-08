Return-Path: <linux-kernel+bounces-134968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F51189B96A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8317C1C217C0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93421651BD;
	Mon,  8 Apr 2024 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l4h3fT1u"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD145102E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562633; cv=none; b=UC1icUopq0ZkTn0zI6RKFk8lwiiEViWBgQTobIm49Rz05T95elkRTfclv3NMBOY1pbUGVbo+o0AmOvVwGOdPH0A49H0Ey11tsJFyFOBrYjV3vlI67c+dXLVKj0NVl9qNh3ZHw5A2zRBVxExyh/voQBeA9CRjyQIEkPpb5fT0BrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562633; c=relaxed/simple;
	bh=4uT8574jrXqGl3Mk8U15PxTT/xWEA9S9REpaOJQWxl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/EXMwa4hgLXoSCplibtXmDWwylreJBYWl0o+vISc53VLw2VfHnYQ9htZysdAgA3aj4ISfRv/Z/uM5Ac+1XrhUEspF7JWB+oDfdd5lyB9dlGXKkjHLDE9GgVDMff4NusinyqH81bQBXJdKpUMDrE+lHsamZKH1dtISkIWEXt7Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l4h3fT1u; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F7451C0004;
	Mon,  8 Apr 2024 07:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712562624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZgL3Haw2vhk+So2PUMpdKZ20Ta46A6hxHdBDETU+YM=;
	b=l4h3fT1u0a9ZEkJXpRsZa6EebSaLcY50eK3b60yCoFZzv6KvnCR/bx5FmL3LjLO+VoAOFS
	vL65BYLnt6KHGFV1BjckEjFps5oxPoFMsedOHLqJTDSPRMCEdbDOWamwqlxG+JgXWPQr+Y
	mEfTgUh2FAiFC/tpzXvLKc4QkIeR9pk7G8kxgFq2SgUIT5oE3XdXo8u9OW5eycthhKlyNS
	ndxnQKPRyL0qGDWHyBYLkKIICTpeKvR25uimKngsOKzNhN73xaqmdQ0MHn46NsunJ8S3AG
	4hbdMdR7eXXhnz6EfpUZiYLrOUqKvx+kLy9yn3HvS3RwG49sW7THHmdpn8+6bw==
Date: Mon, 8 Apr 2024 09:50:19 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
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
Subject: Re: [PATCH v5 11/16] drm/vkms: Add YUV support
Message-ID: <ZhOhuwYDJECUE1y2@louis-chauvet-laptop>
Mail-Followup-To: Pekka Paalanen <pekka.paalanen@collabora.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
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
 <20240313-yuv-v5-11-e610cbd03f52@bootlin.com>
 <e5d8297f-3e1f-459f-bef2-3a91f2caf94f@igalia.com>
 <ZgLwT2Kkax8cJEhz@localhost.localdomain>
 <20240327145916.6a9d9998.pekka.paalanen@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327145916.6a9d9998.pekka.paalanen@collabora.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 27/03/24 - 14:59, Pekka Paalanen a écrit :
> On Tue, 26 Mar 2024 16:57:03 +0100
> Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> 
> > Le 25/03/24 - 11:26, Maíra Canal a écrit :
> > > On 3/13/24 14:45, Louis Chauvet wrote:  
> > > > From: Arthur Grillo <arthurgrillo@riseup.net>
> > > > 
> > > > Add support to the YUV formats bellow:
> > > > 
> > > > - NV12/NV16/NV24
> > > > - NV21/NV61/NV42
> > > > - YUV420/YUV422/YUV444
> > > > - YVU420/YVU422/YVU444
> > > > 
> > > > The conversion from yuv to rgb is done with fixed-point arithmetic, using
> > > > 32.32 floats and the drm_fixed helpers.
> > > > 
> > > > To do the conversion, a specific matrix must be used for each color range
> > > > (DRM_COLOR_*_RANGE) and encoding (DRM_COLOR_*). This matrix is stored in
> > > > the `conversion_matrix` struct, along with the specific y_offset needed.
> > > > This matrix is queried only once, in `vkms_plane_atomic_update` and
> > > > stored in a `vkms_plane_state`. Those conversion matrices of each
> > > > encoding and range were obtained by rounding the values of the original
> > > > conversion matrices multiplied by 2^32. This is done to avoid the use of
> > > > floating point operations.
> > > > 
> > > > The same reading function is used for YUV and YVU formats. As the only
> > > > difference between those two category of formats is the order of field, a
> > > > simple swap in conversion matrix columns allows using the same function.
> > > > 
> > > > Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> > > > [Louis Chauvet:
> > > > - Adapted Arthur's work
> > > > - Implemented the read_line_t callbacks for yuv
> > > > - add struct conversion_matrix
> > > > - remove struct pixel_yuv_u8
> > > > - update the commit message
> > > > - Merge the modifications from Arthur]  
> > > 
> > > A Co-developed-by tag would be more appropriate.  
> > 
> > I am not the main author of this part, I only applied a few simple 
> > suggestions, the complex part was done by Arthur.
> > 
> > I will wait for Arthur's confirmation to change it to Co-developed by if
> > he agrees.
> 
> Co-developed-by is an additional tag, and does not replace S-o-b. To my
> understanding, the kernel rules and Developers' Certificate of Origin
> require S-o-b to be added by anyone who has taken a patch and
> re-submitted it, regardless of who the original author is, and
> especially if the patch was modified.
> 
> Personally I also like to keep the list of changes like Louis added, to
> credit people better.

I will keep everything, don't worry!
 
> > > > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > > ---
> > > >   drivers/gpu/drm/vkms/vkms_drv.h     |  22 ++
> > > >   drivers/gpu/drm/vkms/vkms_formats.c | 431 ++++++++++++++++++++++++++++++++++++
> > > >   drivers/gpu/drm/vkms/vkms_formats.h |   4 +
> > > >   drivers/gpu/drm/vkms/vkms_plane.c   |  17 +-
> > > >   4 files changed, 473 insertions(+), 1 deletion(-)
> > > > 
> 
> ...
> 
> > > >   };
> > > >   
> > > >   static struct drm_plane_state *
> > > > @@ -117,12 +129,15 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
> > > >   	drm_framebuffer_get(frame_info->fb);
> > > >   	frame_info->rotation = drm_rotation_simplify(new_state->rotation, DRM_MODE_ROTATE_0 |
> > > >   									  DRM_MODE_ROTATE_90 |
> > > > +									  DRM_MODE_ROTATE_180 |  
> > > 
> > > Why do we need to add DRM_MODE_ROTATE_180 here? Isn't the same as
> > > reflecting both along the X and Y axis?  
> > 
> > Oops, I had no intention of putting that change here. I will move it to 
> > another patch.
> > 
> > I don't understand why DRM_MODE_ROTATE_180 isn't in this list. If I read 
> > the drm_rotation_simplify documentation, it explains that this argument 
> > should contain all supported rotations and reflections, and ROT_180 is 
> > supported by VKMS. Perhaps this call is unnecessary because all 
> > combinations are supported by vkms?
> 
> If you truly handle all bit patterns that the rotation bitfield can
> have, then yes, the call seems unnecessary.
> 
> However, as documented, the bitfield contains redundancy: the same
> orientation can be expressed in more than one bit pattern. One example
> is that ROTATE_180 is equivalent to REFLECT_X | REFLECT_Y.
> 
> Since it's a bitmask, userspace can give you funny values like
> ROTATE_0 | ROTATE_90 | ROTATE_180. That is a valid orientation of
> 270-degree rotation (according to UAPI doc), but it is very awkwardly
> expressed, hence the need to normalise it into a minimal bit pattern.

The userspace can't set multiple bit, if you look at [1]:

	if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK)) {
		drm_dbg_atomic(plane->dev,
			       "[PLANE:%d:%s] bad rotation bitmask: 0x%llx\n",
			       plane->base.id, plane->name, val);
		return -EINVAL;
	}

I have a series ready for improving the drm documentation, you will be in 
copy.

[1]: https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/drm_atomic_uapi.c#L527
 
> It does not look like drm_rotation_simplify() actually does this
> minimisation!

drm_rotation_simplify() apply an additionnal 
REFLECT_X|REFLECT_Y|ROTATE_180, it is a "no-op" operation, but it 
transform ROT_90|REF_X into ROT_270|REF_Y, so you have eliminated REF_X 
and ROT_90. I will create a patch to document a bit more this function.

In the current vkms code, it will just remove the 180° rotation. I 
think we can just delete this call as everything is supported. I will add 
the patch in the v6 (I don't know why it was there at the first place, 
and I don't want to introduce regression).

> I was not able to tell if DRM common code actually stops userspace from
> combining multiple ROTATE bits in the same value. I suspect it must
> stop them, or perhaps all code dealing with rotation is actually broken.

See [1], and yes, drm helpers are broken with multiple bit sets, they 
expect only one rotation bit.

> drm_rotation_simplify() is useful for cases where your hardware does
> not have exactly the same flexibility. Maybe it cannot do REFLECT_Y but
> it can do everything else? Then drm_rotation_simplify() gives you a bit
> pattern that you can use directly, or fails if the orientation is not
> representable with what your hardware can do.
> 
> At least, that's my understanding of quickly glancing over it.
> 
> IOW, if you wanted to never have to deal with REFLECT_Y bit, you could
> leave it out here. Or, if you never want to deal with ROTATE_180, leave
> that out - you will get REFLECT_X | REFLECT_Y instead. In theory.
> 
> 
> Thanks,
> pq



-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

