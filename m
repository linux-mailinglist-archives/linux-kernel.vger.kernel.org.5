Return-Path: <linux-kernel+bounces-56740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33E984CE64
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F203CB2677C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502287FBC6;
	Wed,  7 Feb 2024 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RXPbneMJ"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5637FBBD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321009; cv=none; b=KwXHo8MPuGkc2ev0UwLF9V1TU3TZjtk7361GRqzXouYcb8CKjLCS9z5ICxzhZ372tElwZLdFDDlKYZwcUB7RLPc5a2c9B1VoWd1Xb1UmQ/fmCNmWg3EF1yeDoHAZO9lJ7u1/yg99Swc5JWHgP0Q/qZdZ9MHVwMj3V201onw9ZCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321009; c=relaxed/simple;
	bh=t3LzMpiMUXY8/8NNI5n+ZWvSwQU1WX1EumGBV7Vh4TI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BNEyBMU2BFDOdxUo62D+FhP5A9pqHIQSRBpDuhBPNpQuSjRtFqHeMZ2b9ooMTf1WBIQTlqPZMOpW2dv2RzTt4RpJHIU+dkYCguwhs8TYZfwSlHl/cSI/b03AwHNI9DZ0AyYZRQ7psdzGpSZdbkWtjqBcvLzOipcC2hNryU/OeuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RXPbneMJ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7AA7C1C0007;
	Wed,  7 Feb 2024 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707320999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=IgUqJ/ZpSpiNgM2NB3/So8WhTfIp2W01eIEfzU7tjV8=;
	b=RXPbneMJhFuWoOD2sNxKG/clyb61OrnVU7MTXgWm4mivyW0MiIRZvVlI4bisAOZCI6v6Lp
	MB7MwV2ZIFrJcFZfBL4ockmh9vOpxml+2n0bginGT98Qr+Y7e8UL5dNjlnI+qnTmk8kWKy
	Gm/sIsHcP8Vlsjuq+xnpEYCOINQnOz4CdLCQR/x2dSgkvTRY6T8hpXqpcEADAFyUDzmr0p
	9gH+AOrQ8VbSCZJlb/O1GNRiC0wmHuvjN2IKUpHSCqaxu45+ab6rVoCI44H6hSNYSW/NIo
	fd4SK5lvNiZDvBsS8+xDGyS5cFelqh50X0BBKOcJWLPRgWBz5jOPwDLaPfNI4A==
Date: Wed, 7 Feb 2024 16:49:56 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: pekka.paalanen@haloniitty.fi
Cc: arthurgrillo@riseup.net, miquel.raynal@bootlin.com, mripard@kernel.org,
	louis.chauvet@bootlin.com, rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com, mairacanal@riseup.net,
	hamohammed.sa@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
	airlied@gmail.com, marcheu@google.com, seanpaul@google.com,
	nicolejadeyee@google.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 2/2] drm/vkms: Use a simpler composition function
Message-ID: <ZcOmpInszAOVeKes@localhost.localdomain>
Mail-Followup-To: pekka.paalanen@haloniitty.fi, arthurgrillo@riseup.net,
	miquel.raynal@bootlin.com, mripard@kernel.org,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	mairacanal@riseup.net, hamohammed.sa@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
	airlied@gmail.com, marcheu@google.com, seanpaul@google.com,
	nicolejadeyee@google.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205121913.379e28a4@eldfell>
X-GND-Sasl: louis.chauvet@bootlin.com

Hello Pekka, Arthur, Maxime,

> > > >>>>>> Change the composition algorithm to iterate over pixels instead of lines.
> > > >>>>>> It allows a simpler management of rotation and pixel access for complex formats.
> > > >>>>>>
> > > >>>>>> This new algorithm allows read_pixel function to have access to x/y
> > > >>>>>> coordinates and make it possible to read the correct thing in a block
> > > >>>>>> when block_w and block_h are not 1.
> > > >>>>>> The iteration pixel-by-pixel in the same method also allows a simpler
> > > >>>>>> management of rotation with drm_rect_* helpers. This way it's not needed
> > > >>>>>> anymore to have misterious switch-case distributed in multiple places.          
> > > >>>>>
> > > >>>>> Hi,
> > > >>>>>
> > > >>>>> there was a very good reason to write this code using lines:
> > > >>>>> performance. Before lines, it was indeed operating on individual pixels.
> > > >>>>>
> > > >>>>> Please, include performance measurements before and after this series
> > > >>>>> to quantify the impact on the previously already supported pixel
> > > >>>>> formats, particularly the 32-bit-per-pixel RGB variants.
> > > >>>>>
> > > >>>>> VKMS will be used more and more in CI for userspace projects, and
> > > >>>>> performance actually matters there.
> > > >>>>>
> > > >>>>> I'm worrying that this performance degradation here is significant. I
> > > >>>>> believe it is possible to keep blending with lines, if you add new line
> > > >>>>> getters for reading from rotated, sub-sampled etc. images. That way you
> > > >>>>> don't have to regress the most common formats' performance.        

I tested, and yes, it's significant for most of the tests. None of them 
timed out on my machine, but I agree that I have to improve this. Do you 
know which tests are the more "heavy"?

> > > >>>> While I understand performance is important and should be taken into
> > > >>>> account seriously, I cannot understand how broken testing could be
> > > >>>> considered better. Fast but inaccurate will always be significantly
> > > >>>> less attractive to my eyes.        
> > > >>>
> > > >>> AFAIK, neither the cover letter nor the commit log claimed it was fixing
> > > >>> something broken, just that it was "better" (according to what
> > > >>> criteria?).      

Sorry Maxime for this little missunderstanding, I will improve the commit 
message and cover letter for the v2.

> > > >> Today's RGB implementation is only optimized in the line-by-line case
> > > >> when there is no rotation. The logic is bit convoluted and may possibly
> > > >> be slightly clarified with a per-format read_line() implementation,
> > > >> at a very light performance cost. Such an improvement would definitely
> > > >> benefit to the clarity of the code, especially when transformations
> > > >> (especially the rotations) come into play because they would be clearly
> > > >> handled differently instead of being "hidden" in the optimized logic.
> > > >> Performances would not change much as this path is not optimized today
> > > >> anyway (the pixel-oriented logic is already used in the rotation case).

[...]

> > > > I think it would, if I understand what you mean. Ever since I proposed
> > > > a line-by-line algorithm to improve the performance, I was thinking of
> > > > per-format read_line() functions that would be selected outside of any
> > > > loops.

[...]

> > > > I haven't looked at VKMS in a long time, and I am disappointed to find
> > > > that vkms_compose_row() is calling plane->pixel_read() pixel-by-pixel.
> > > > The reading vfunc should be called with many pixels at a time when the
> > > > source FB layout allows it. The whole point of the line-based functions
> > > > was that they repeat the innermost loop in every function body to make
> > > > the per-pixel overhead as small as possible. The VKMS implementations
> > > > benchmarked before and after the original line-based algorithm showed
> > > > that calling a function pointer per-pixel is relatively very expensive.
> > > > Or maybe it was a switch-case.    

[...]

> > > But, I agree with Miquel that the rotation logic is easier to implement
> > > in a pixel-based way. So going pixel-by-pixel only when rotation occurs
> > > would be great.  
> > 
> > Yes, and I think that can very well be done in the line-based framework
> > still that existed in the old days before any rotation support was
> > added. Essentially a plug-in line-getter function that then calls a
> > format-specific line-getter pixel-by-pixel while applying the rotation.
> > It would be simple, it would leave unrotated performance unharmed (use
> > format-specific line-getter directly with lines), but it might be
> > somewhat less performant for rotated KMS planes. I suspect that might
> > be a good compromise.
> > 
> > Format-specific line-getters could also be parameterized by
> > pixel-to-pixel offset in bytes. Then they could directly traverse FB
> > rows forward and backward, and even FB columns. It may or may not have
> > a penalty compared to the original line-getters, so it would have to
> > be benchmarked.
> 
> Oh, actually, since the byte offset depends on format, it might be
> better to parametrize by direction and compute the offset in the
> format-specific line-getter before the loop.
> 

I'm currently working on this implementation. The algorithm would look 
like:

    void blend(...) {
        for(int y = 0; y < height; y++) {
		for(int plane = 0; plane < nb_planes; plane++) {
			if(planes[plane].read_line && planes[plane].rotation == DRM_ROTATION_0) {
				[...] /* Small common logic to manage REFLECT_X/Y and translations */
				planes[plane].read_line(....);
			} else {
				[...] /* v1 of my patch, pixel by pixel read */
			}
		}
	}
    }

where read_line is:
  void read_line(frame_info *src, int y, int x_start, int x_stop, pixel_argb16 *dts[])
 - y is the line to read (so the caller need to compute the correct offset)
 - x_start/x_stop are the start and stop column, but they may be not 
   ordered properly (i.e DRM_REFLECT_X will make x_start greater than 
   x_stop)
 - src/dst are source and destination buffers

This way:
- It's simple to read for the general case (usage of drm_rect_* instead of 
  manually rewriting the logic)
- Each pixel format can be quickly implemented with "pixel-by-pixel" 
  methods
- The performances should be good if no rotation is implied for some 
  formats

I also created some helpers for conversions between formats to avoid code 
duplication between pixel and line algorithms (and also between argb and 
xrgb variants).

The only flaw with this, is that most of the read_line functions will 
look like:

    void read_line(...) {
	int increment = x_start < x_stop ? 1: -1;
	while(x_start != x_stop) {
		out += 1;
		[...] /* color conversion */
		x_start += increment;
	}
    }

But as Pekka explained, it's probably the most efficient way to do it.



Is there a way to save the output of vkms to a folder (something like 
"one image per frame")? It's a bit complex to debug graphics without 
seeing them.

I have something which (I think) should work, but some tests are failing 
and I don't find why in my code (I don't find the reason why the they are 
failing and the hexdump I added to debug seems normal).

I think my issue is a simple mistake in the "translation managment" or 
maybe just a wrong offset, but I don't see my error in the code. I think a 
quick look on the final image would help me a lot.

[...]

Have a nice day,
Louis Chauvet


-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

