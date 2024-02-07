Return-Path: <linux-kernel+bounces-56748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A4F84CE8B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384BE28BAFB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E90B8005B;
	Wed,  7 Feb 2024 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EMZwGDA6"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0033780045
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321815; cv=none; b=hEsuJLmIXJoh0GLyK4iJ6WB+usUbsQwq1RuDmqernwf18V6BPYS4qSwsEZSl5agVNaQWA8gvSqA3/N1ia92/1zqgpUPwLDK+dl214ThAvDTDokaKuCtgV2hvzp95Ln25QkmQZymwvpkco4Gp930sG8ppgAgyC2tOT785dml27J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321815; c=relaxed/simple;
	bh=PPznGmhkXlUq37eNefw13UOZ4Md4/hqYu3L9ybT6LHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCeltmPScil1QVr1gXDmUrHE6HkbG4M7MPWsM7b/f0e5EMfa7+I8swbIYWT0uSIHywBBA6FLQeBIb2n/69z3an0alV00bZSickEEWv61UFkCJmuhEzv2YR6uxpXGR14KZnSktw+jDLQ27kv7jq8YjyW9nBYQOVxSnaNsVii5hog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EMZwGDA6; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71B90E0003;
	Wed,  7 Feb 2024 16:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707321808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DMJ2m5Th6qWplrx0t7J61CsGhja3NucIGbS+faRx7/A=;
	b=EMZwGDA6xV2r8cVWsFXSq1IiR7L2EciyAfg1wFvIjlXguHqiOjtrEAuJ361956hIiDzjlY
	U6pV95ybBs2RWWLJeiZE0qntjU/v5WWuzIWumx1fxOE5PWV2+7l88ypMx1qfrbrDgWllLT
	gXtiijL8UBi5/z3E1gWHUJitUullmH63jmuLbmH9I+L0Y11OQ+f6NfEH/cddjF2ZvAuhyR
	9EpM0iK8bWEf7MmVPwfpMT4O9YW20gwbhtOI2kr8Z8yTxcgMo7juZwb843+FLT4EW3c9Ov
	CE7Kv1jxMOE82e8+7dgmMc1FhYhCRCXTSljAkjoS1w+M+VaiKkscNZrTajVVBQ==
Date: Wed, 7 Feb 2024 17:03:26 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Pekka Paalanen <pekka.paalanen@haloniitty.fi>
Cc: Arthur Grillo <arthurgrillo@riseup.net>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Maxime Ripard <mripard@kernel.org>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, marcheu@google.com,
	seanpaul@google.com, nicolejadeyee@google.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 2/2] drm/vkms: Use a simpler composition function
Message-ID: <ZcOpzszyR49_MlqB@localhost.localdomain>
Mail-Followup-To: Pekka Paalanen <pekka.paalanen@haloniitty.fi>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Maxime Ripard <mripard@kernel.org>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, marcheu@google.com,
	seanpaul@google.com, nicolejadeyee@google.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
References: <20240201-yuv-v1-2-3ca376f27632@bootlin.com>
 <20240202105522.43128e19@eldfell>
 <20240202102601.70b6d49c@xps-13>
 <3nofkwzgnf4yva2wfogdbii47ohpi2wm5vp6aijtg3emxyoowt@twyreqz7ai3g>
 <20240202131322.5471e184@xps-13>
 <20240202174913.789a9db9@eldfell>
 <20240202170734.3176dfe4@xps-13>
 <20240202214527.1d97c881@ferris.localdomain>
 <d258c8dc-78e9-4509-9037-a98f7f33b3a3@riseup.net>
 <20240207104407.7b06bac2@eldfell>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207104407.7b06bac2@eldfell>
X-GND-Sasl: louis.chauvet@bootlin.com

Hello Pekka, Arthur,

[...]

> > > Would it be possible to have a standardised benchmark specifically
> > > for performance rather than correctness, in IGT or where-ever it
> > > would make sense? Then it would be simple to tell contributors to
> > > run this and report the numbers before and after.
> > > 
> > > I would propose this kind of KMS layout:
> > > 
> > > - CRTC size 3841 x 2161
> > > - primary plane, XRGB8888, 3639 x 2161 @ 101,0
> > > - overlay A, XBGR2101010, 3033 x 1777 @ 201,199
> > > - overlay B, ARGB8888, 1507 x 1400 @ 1800,250
> > > 
> > > The sizes and positions are deliberately odd to try to avoid happy
> > > alignment accidents. The planes are big, which should let the pixel
> > > operations easily dominate performance measurement. There are
> > > different pixel formats, both opaque and semi-transparent. There is
> > > lots of plane overlap. The planes also do not cover the whole CRTC
> > > leaving the background visible a bit.
> > > 
> > > There should be two FBs per each plane, flipped alternatingly each
> > > frame. Writeback should be active. Run this a number of frames, say,
> > > 100, and measure the kernel CPU time taken. It's supposed to take at
> > > least several seconds in total.
> > > 
> > > I think something like this should be the base benchmark. One can
> > > add more to it, like rotated planes, YUV planes, etc. or switch
> > > settings on the existing planes. Maybe even FB_DAMAGE_CLIPS. Maybe
> > > one more overlay that is very tall and thin.
> > > 
> > > Just an idea, what do you all think?  
> > 
> > Hi Pekka,
> > 
> > I just finished writing this proposal using IGT.
> > 
> > I got pretty interesting results:
> > 
> > The mentioned commit 8356b97906503a02125c8d03c9b88a61ea46a05a took
> > around 13 seconds. While drm-misc/drm-misc-next took 36 seconds.
> > 
> > I'm currently bisecting to be certain that the change to the
> > pixel-by-pixel is the culprit, but I don't see why it wouldn't be.
> > 
> > I just need to do some final touches on the benchmark code and it
> > will be ready for revision.
> 
> Awesome, thank you very much for doing that!
> pq

I also think it's a good benchmarks for classic configurations. The odd 
size is a very nice idea to verify the corner cases of line-by-line 
algorithms.

When this is ready, please share the test, so I can check if my patch is 
as performant as before.

Thank you for this work.

Have a nice day,
Louis Chauvet

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

