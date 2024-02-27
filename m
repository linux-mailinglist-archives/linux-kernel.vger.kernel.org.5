Return-Path: <linux-kernel+bounces-83469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8803D8699F5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 461E8B2A643
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF35B14A08F;
	Tue, 27 Feb 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RrfO2EL7"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED8B14CAA9;
	Tue, 27 Feb 2024 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046143; cv=none; b=qgGub+t3tftdVfdfvLsq/GyX4wN14ixn5O5yHU94pAMs7gUR6128AQk1Ymaj4BK47HaCPHIj/VbpG9m6HobMMguYRY1j++sNdJQbSCterHwlUVMnjp7E8NuSoC6p0GTzVdBV0dwqubzsaLQQozIwxgLNNm9XDPxv6VKjGhN0qkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046143; c=relaxed/simple;
	bh=4qVm3us+Sfxczu0Xf/pdA5CwlojidJdRpadimZaDyKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8ODisnwl4Czs7FQbKILDRCsJXaQQwE1xSgg7oinrK3XrwYFJDPT+M1+Oj+UhB6v2eOL9k+WFiF6E+vDlYLuJIKqpll5r1nvbthtzHzLs+C/NGDw1rzQUUZ0ztbSCyfzQdc5rp9ou9BabP9lRzGIAQoXfl28wAAjfjs34Ey08Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RrfO2EL7; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76F63FF80E;
	Tue, 27 Feb 2024 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709046134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JNtXj8btr6ZXcKUJn2VlnNEyAxe3orLsIqZIYppH3/k=;
	b=RrfO2EL76ErJEz4mcELQOUW9PBv8nvs2QhLqMC5NU3tH8ikZcoaDNfmei8rmLfJDqFR2c7
	lkuM5n5CABHegTvPTs+hvgUyk6H8wKSylR6ZBv3AV/a5DYpqBKDozmnmP1SnBavr2DG7xJ
	3fHCcNYPVUeXzjfn5OAEKYTqGQzbG3l94+TLIaRKY3q9OSn5ND3piP882T/V1nzK8qUA+4
	Czx6J5yH3xg+L2GHC+MtpogwUPScm9qhpJ8biQr/DnhbnsE1YA9mtKPTjehLfDSCuFDUC+
	CXFnB6lKA6pfgpFqk+qbKYpy022Aiwy1jZNnr2pUkQPB/f07NbCNFtdHJfLkaA==
Date: Tue, 27 Feb 2024 16:02:11 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Arthur Grillo <arthurgrillo@riseup.net>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Add information on how to benchmark
Message-ID: <Zd35c5TLS6ygc_Pr@localhost.localdomain>
Mail-Followup-To: Pekka Paalanen <pekka.paalanen@collabora.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240226-bench-vkms-v1-1-515ef91b11c8@riseup.net>
 <20240227111941.061a2892.pekka.paalanen@collabora.com>
 <8ac7bf91-fbce-4403-a801-9dfee39ea802@riseup.net>
 <20240227135545.62dd5f57.pekka.paalanen@collabora.com>
 <0892593d-0fd9-4381-b2bd-843627bd2723@riseup.net>
 <20240227152639.6426c401.pekka.paalanen@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227152639.6426c401.pekka.paalanen@collabora.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 27/02/24 - 15:26, Pekka Paalanen a écrit :
> On Tue, 27 Feb 2024 09:29:58 -0300
> Arthur Grillo <arthurgrillo@riseup.net> wrote:
> 
> > On 27/02/24 08:55, Pekka Paalanen wrote:
> > > On Tue, 27 Feb 2024 08:44:52 -0300
> > > Arthur Grillo <arthurgrillo@riseup.net> wrote:
> > >   
> > >> On 27/02/24 06:19, Pekka Paalanen wrote:  
> > >>> On Mon, 26 Feb 2024 17:42:11 -0300
> > >>> Arthur Grillo <arthurgrillo@riseup.net> wrote:
> > >>>     
> > >>>> Now that we have a defined benchmark for testing the driver, add
> > >>>> documentation on how to run it.
> > >>>>
> > >>>> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> > >>>> ---
> > >>>>  Documentation/gpu/vkms.rst | 6 ++++++
> > >>>>  1 file changed, 6 insertions(+)
> > >>>>
> > >>>> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> > >>>> index ba04ac7c2167..6d07f79f77ff 100644
> > >>>> --- a/Documentation/gpu/vkms.rst
> > >>>> +++ b/Documentation/gpu/vkms.rst
> > >>>> @@ -89,6 +89,12 @@ You can also run subtests if you do not want to run the entire test::
> > >>>>    sudo ./build/tests/kms_flip --run-subtest basic-plain-flip --device "sys:/sys/devices/platform/vkms"
> > >>>>    sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/kms_flip --run-subtest basic-plain-flip
> > >>>>  
> > >>>> +If you are developing features that may affect performance, you can run the kms_fb_stress    
> > >>>
> > >>> s/can/must/
> > >>>     
> > >>>> +benchmark::    
> > >>>
> > >>> before and after, and report the numbers.    
> > >>
> > >> Did you mean to write the benchmarks logs here?  
> > > 
> > > I mean people should be required tell their before and after numbers in
> > > either commit message (my preference) or in series cover letter (if
> > > benchmarking commits is not useful).
> > > 
> > > With the addition of YUV support in VKMS, maybe the benchmark needs to  
> > 
> > With the upcoming addition, I've sent a patch to arbitrarily change the
> > formats on the benchmark via command-line options. It's not adding a new
> > case, but maybe just this could already help.
> > 
> > https://lore.kernel.org/all/20240226-kms_fb_stress-dev-v1-0-1c14942b1244@riseup.net/
> 
> In that case you would need to document exactly what command line
> options to use, and ask people to report the numbers of each test
> case.
> 
> That works. Alternatively or additionally, the test cases could be
> built in to the benchmark, and it just reports numbers for all of them
> in a single invocation. Then people running the standard benchmark do
> not need to worry about getting the command line options right, or
> running multiple cases. And reviewers do not need to ask to re-run with
> the correct options.
> 
> I suppose rotations might get added, too.
> 
> Or maybe you'd provide a script that covers all the standard
> performance test cases?

I agree with Pekka, it would be nice to have a simple "bench everything" 
tool. Like kms_rotation is a test for all rotations, kms_plane for color 
conversions... kms_fb_test can run a few combinations (rgb+norotation, 
rgb+yuv, rgb+rotation...) and report a "global result" (this way it's easy 
to spot a regression not related directly to your changes).

I don't know the IGT benchmark API, but I think there is a way to create 
"sub-benchmarks" so you can run a specific benchmark when developping and 
the whole thing before pushing your series.

Kind regards,
Louis Chauvet

> 
> Thanks,
> pq
> 
> > > start printing YUV numbers separately as a new case.
> > > 
> > > 
> > > Thanks,
> > > pq
> > >   
> > >>  
> > >>>     
> > >>>> +
> > >>>> +  sudo ./build/benchmarks/kms_fb_stress --device "sys:/sys/devices/platform/vkms"
> > >>>> +  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/benchmarks/kms_fb_stress    
> > >>>
> > >>> Do people need to run both commands?    
> > >>
> > >> No, they don't, just two options.
> > >>
> > >> Best Regards,
> > >> ~Arthur Grillo
> > >>  
> > >>>
> > >>> Anyway, a good idea.
> > >>>
> > >>> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> > >>>
> > >>>
> > >>> Thanks,
> > >>> pq
> > >>>     
> > >>>> +
> > >>>>  TODO
> > >>>>  ====
> > >>>>  
> > >>>>
> > >>>> ---
> > >>>> base-commit: eeb8e8d9f124f279e80ae679f4ba6e822ce4f95f
> > >>>> change-id: 20240226-bench-vkms-5b8b7aab255e
> > >>>>
> > >>>> Best regards,    
> > >>>     
> > >   
> 



-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

