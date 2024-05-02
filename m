Return-Path: <linux-kernel+bounces-166166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BB68B9705
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135211C20FAA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB82B52F92;
	Thu,  2 May 2024 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLBAfjSh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E55150A65;
	Thu,  2 May 2024 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640407; cv=none; b=lvkCnJ8evpNqnyTFcl0HFlEPmih8aqUE3695gQVzHq6gC4FxYg4iscslKthZCw936XF51s+GJsODpGfb+MmngkX3t+JbRlcDcXh6GsiXAyvihTpN0+mGQpfHhN4S4Eod1J/8vVymjhycDG8nzXSSNpQ1ykzZ61OD0GRrFeuI0z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640407; c=relaxed/simple;
	bh=F5Z3CegIuDz1KYzRsgzmDjZXhBZBJKlckcG9UPbVRbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVVItcaR0NwDXXtv+wgMJWRX74cBdfh0e12k/YsbstcnEbRv6RNdBq7/k9pnzeT7UkC32j/M1OSB0qy98UT+JDDq7b+mh6KwQ0W3iWTyVRpTVfFyJmBiZKNPTIq8zu/c2t/cXOxk4K5txX5wSf3Z+OV5EffBnq3UxAGFoIKQ/Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLBAfjSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645ECC113CC;
	Thu,  2 May 2024 09:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714640406;
	bh=F5Z3CegIuDz1KYzRsgzmDjZXhBZBJKlckcG9UPbVRbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DLBAfjShKr935qgIqx23bWiHXrn7CRnEUkn38ngre0YYP1eJiKj4vTQh/m1B/a8Ms
	 wbTE3rPt4rsZAk69+U5zgpWlqXdpgnJtWpC3+DUZK5shSYpaFSfrgmGys00QN9axic
	 jLmhK6fkJbRaU1NnP5sghmMr3paAiADobp1W6l/iCV30A96r94qCfGDUsrIq0b79x6
	 P7lU4qdM+qiWFUfEeEvlOuwCB4Wb68fO+sXeqiDrp/dcO5nG+mk9fxUG7XjtW1eN2S
	 OUyKULESIuqRiPvyV8LOA3bqHE4x+BCRfsNgCiJnKRbcnguykfNdTAD44sAJ0chiOa
	 GeVN/aj3vjbqA==
Date: Thu, 2 May 2024 09:59:56 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>, Sebastian Fricke
 <sebastian.fricke@collabora.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
 m.szyprowski@samsung.com, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v15 00/16] Add audio support in v4l2 framework
Message-ID: <20240502095956.0a8c5b26@sal.lan>
In-Reply-To: <87sez0k661.wl-tiwai@suse.de>
References: <1710834674-3285-1-git-send-email-shengjiu.wang@nxp.com>
	<20240430082112.jrovosb6lgblgpfg@basti-XPS-13-9310>
	<ZjEEKyvb02CWz3l4@finisterre.sirena.org.uk>
	<20240430172752.20ffcd56@sal.lan>
	<ZjGhPz-bokg6ZbDJ@finisterre.sirena.org.uk>
	<87sez0k661.wl-tiwai@suse.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 02 May 2024 09:46:14 +0200
Takashi Iwai <tiwai@suse.de> escreveu:

> On Wed, 01 May 2024 03:56:15 +0200,
> Mark Brown wrote:
> > 
> > On Tue, Apr 30, 2024 at 05:27:52PM +0100, Mauro Carvalho Chehab wrote:  
> > > Mark Brown <broonie@kernel.org> escreveu:  
> > > > On Tue, Apr 30, 2024 at 10:21:12AM +0200, Sebastian Fricke wrote:  
> >   
> > > > The discussion around this originally was that all the audio APIs are
> > > > very much centered around real time operations rather than completely  
> >   
> > > The media subsystem is also centered around real time. Without real
> > > time, you can't have a decent video conference system. Having
> > > mem2mem transfers actually help reducing real time delays, as it 
> > > avoids extra latency due to CPU congestion and/or data transfers
> > > from/to userspace.  
> > 
> > Real time means strongly tied to wall clock times rather than fast - the
> > issue was that all the ALSA APIs are based around pushing data through
> > the system based on a clock.
> >   
> > > > That doesn't sound like an immediate solution to maintainer overload
> > > > issues...  if something like this is going to happen the DRM solution
> > > > does seem more general but I'm not sure the amount of stop energy is
> > > > proportionate.  
> >   
> > > I don't think maintainer overload is the issue here. The main
> > > point is to avoid a fork at the audio uAPI, plus the burden
> > > of re-inventing the wheel with new codes for audio formats,
> > > new documentation for them, etc.  
> > 
> > I thought that discussion had been had already at one of the earlier
> > versions?  TBH I've not really been paying attention to this since the
> > very early versions where I raised some similar "why is this in media"
> > points and I thought everyone had decided that this did actually make
> > sense.  
> 
> Yeah, it was discussed in v1 and v2 threads, e.g.
>   https://patchwork.kernel.org/project/linux-media/cover/1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com/#25485573
> 
> My argument at that time was how the operation would be, and the point
> was that it'd be a "batch-like" operation via M2M without any timing
> control.  It'd be a very special usage for for ALSA, and if any, it'd
> be hwdep -- that is a very hardware-specific API implementation -- or
> try compress-offload API, which looks dubious.
> 
> OTOH, the argument was that there is already a framework for M2M in
> media API and that also fits for the batch-like operation, too.  So
> was the thread evolved until now.

M2M transfers are not a hardware-specific API, and such kind of
transfers is not new either. Old media devices like bttv have
internally a way to do PCI2PCI transfers, allowing media streams
to be transferred directly without utilizing CPU. The media driver
supports it for video, as this made a huge difference of performance
back then.

On embedded world, this is a pretty common scenario: different media
IP blocks can communicate with each other directly via memory. This
can happen for video capture, video display and audio.

With M2M, most of the control is offloaded to the hardware.

There are still time control associated with it, as audio and video
needs to be in sync. This is done by controlling the buffers size 
and could be fine-tuned by checking when the buffer transfer is done.

On media, M2M buffer transfers are started via VIDIOC_QBUF,
which is a request to do a frame transfer. A similar ioctl
(VIDIOC_DQBUF) is used to monitor when the hardware finishes
transfering the buffer. On other words, the CPU is responsible
for time control.

On other words, this is still real time. The main difference
from a "sync" transfer is that the CPU doesn't need to copy data
from/to different devices, as such operation is offloaded to the
hardware.

Regards,
Mauro

