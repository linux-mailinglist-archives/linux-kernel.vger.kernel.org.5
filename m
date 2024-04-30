Return-Path: <linux-kernel+bounces-164041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69608B7798
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF8D0B20E89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56629172794;
	Tue, 30 Apr 2024 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlcO3h30"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A417167F;
	Tue, 30 Apr 2024 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485165; cv=none; b=IioaPlUfO/+u2FXenlpyYJxhULNqpBnJuQyVEQgeUA6TrD7k+7VMy1BB+QXeGlXFBQACOUx+ViBW8h2eb23qBO7xebB/2/M5UXBPkDmzmRJVV1yxFg8w0/c8M5Nq3kryR1l6viwc0Vg0PrU84WrRFh+0Yf3+XJDzZSeMMTTtBww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485165; c=relaxed/simple;
	bh=Uko8HS1g2ylxAZcYhzNrJijEd2kEOyt+s0j1KcTMN7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsYlTAymH57Qe8gUHxcIBif/TICrdMjLHfDaWV7QehbjGaCPM8KkW2Wbw3p0L8GKjgqP0sc3iZwS7W+ob9YsGYn+pJ0/Pj8yd/r0WCa3nCkCJFOWaHZfVSBj/XiJffEon9UGZ1Z0nI8TmVRf26oWkxrB+AE378EKpqNxreiZ12o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlcO3h30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93A8C2BBFC;
	Tue, 30 Apr 2024 13:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714485165;
	bh=Uko8HS1g2ylxAZcYhzNrJijEd2kEOyt+s0j1KcTMN7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tlcO3h30P7SZ7oSLctRoaEeNW1W7XBgT+wj+zgU83zv/UWcg/7/p2i8L0SUN4QGMA
	 h06L7zGqa0MtBw4/BxmQiM433Pb/Sg/OY8/hNd4H+Gkjvvk5ZGi2xZtHpiuqf+BuG3
	 7h3k0+YgBpAiCm+vI7kvSvfUjxLl7o38tWkhbCGoerRwxpSotDKbsGdzhrQ3HFOOTx
	 nyX5qR2eM3/crVpKtjO74t24Rsd2A4TbYY8fcDObkUOMZ6106Yk7mG5PV9ySvLEjOs
	 EbHpa2N9KkyXhXAGZGa1GJ5+PPO4GX29Qo3XFEzfkV5dBfjUN/2ArJTtJiav5UrM66
	 tznsKICFix6nA==
Date: Tue, 30 Apr 2024 14:52:36 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Sebastian Fricke <sebastian.fricke@collabora.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi, tfiga@chromium.org,
 m.szyprowski@samsung.com, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v15 00/16] Add audio support in v4l2 framework
Message-ID: <20240430145236.36febb03@sal.lan>
In-Reply-To: <32d0c83c-4d0c-4d22-b2f1-d03d075f4898@xs4all.nl>
References: <1710834674-3285-1-git-send-email-shengjiu.wang@nxp.com>
	<20240430082112.jrovosb6lgblgpfg@basti-XPS-13-9310>
	<32d0c83c-4d0c-4d22-b2f1-d03d075f4898@xs4all.nl>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 30 Apr 2024 10:47:13 +0200
Hans Verkuil <hverkuil@xs4all.nl> escreveu:

> On 30/04/2024 10:21, Sebastian Fricke wrote:
> > Hey Shengjiu,
> > 
> > first of all thanks for all of this work and I am very sorry for only
> > emerging this late into the series, I sadly didn't notice it earlier.
> > 
> > I would like to voice a few concerns about the general idea of adding
> > Audio support to the Media subsystem.
> > 
> > 1. The biggest objection is, that the Linux Kernel has a subsystem
> > specifically targeted for audio devices, adding support for these
> > devices in another subsystem are counterproductive as they work around
> > the shortcomings of the audio subsystem while forcing support for a
> > device into a subsystem that was never designed for such devices.
> > Instead, the audio subsystem has to be adjusted to be able to support
> > all of the required workflows, otherwise, the next audio driver with
> > similar requirements will have to move to the media subsystem as well,
> > the audio subsystem would then never experience the required change and
> > soon we would have two audio subsystems.
> > 
> > 2. Closely connected to the previous objection, the media subsystem with
> > its current staff of maintainers is overworked and barely capable of
> > handling the workload, which includes an abundance of different devices
> > from DVB, codecs, cameras, PCI devices, radio tuners, HDMI CEC, IR
> > receivers, etc. Adding more device types to this matrix will make the
> > situation worse and should only be done with a plan for how first to
> > improve the current maintainer situation.
> > 
> > 3. By using the same framework and APIs as the video codecs, the audio
> > codecs are going to cause extra work for the video codec developers and
> > maintainers simply by occupying the same space that was orginally
> > designed for the purpose of video only. Even if you try to not cause any
> > extra stress the simple presence of the audio code in the codebase is
> > going to cause restrictions.
> > 
> > The main issue here is that the audio subsystem doesn't provide a
> > mem2mem framework and I would say you are in luck because the media
> > subsystem has gathered a lot of shortcomings with its current
> > implementation of the mem2mem framework over time, which is why a new
> > implementation will be necessary anyway.
> > 
> > So instead of hammering a driver into the wrong destination, I would
> > suggest bundling our forces and implementing a general memory-to-memory
> > framework that both the media and the audio subsystem can use, that
> > addresses the current shortcomings of the implementation and allows you
> > to upload the driver where it is supposed to be.
> > This is going to cause restrictions as well, like mentioned in the
> > concern number 3, but with the difference that we can make a general
> > plan for such a framework that accomodates lots of use cases and each
> > subsystem can add their routines on top of the general framework.
> > 
> > Another possible alternative is to try and make the DRM scheduler more
> > generally available, this scheduler is the most mature and in fact is
> > very similar to what you and what the media devices need.
> > Which again just shows how common your usecase actually is and how a
> > general solution is the best long term solution.
> > 
> > Please notice that Daniel Almeida is currently working on something
> > related to this:
> > https://lore.kernel.org/linux-media/3F80AC0D-DCAA-4EDE-BF58-BB1369C7EDCA@collabora.com/T/#u
> > 
> > If the toplevel maintainers decide to add the patchset so be it, but I
> > wanted to voice my concerns and also highlight that this is likely going
> > to cause extra stress for the video codecs maintainers and the
> > maintainers in general. We cannot spend a lot of time on audio codecs,
> > as video codecs already fill up our available time sufficiently,
> > so the use of the framework needs to be conservative and cause as little
> > extra work as possible for the original use case of the framework.  
> 
> I would really like to get the input of the audio maintainers on this.
> Sebastian has a good point, especially with us being overworked :-)
> 
> Having a shared mem2mem framework would certainly be nice, on the other
> hand, developing that will most likely take a substantial amount of time.
> 
> Perhaps it is possible to copy the current media v4l2-mem2mem.c and turn
> it into an alsa-mem2mem.c? I really do not know enough about the alsa
> subsystem to tell if that is possible.
> 
> While this driver is a rate converter, not an audio codec, the same
> principles would apply to off-line audio codecs as well. And it is true
> that we definitely do not want to support audio codecs in the media
> subsystem.
> 
> Accepting this driver creates a precedent and would open the door for
> audio codecs.
> 
> I may have been too hasty in saying yes to this, I did not consider
> the wider implications for our workload and what it can lead to. I
> sincerely apologize to Shengjiu Wang as it is no fun to end up in a
> situation like this.

I agree with both Sebastian and Hans here: media devices always had
audio streams, even on old PCI analog TV devices like bttv. There
are even some devices like the ones based on usb em28xx that contains
an AC97 chip on it. The decision was always to have audio supported by
ALSA APIs/subsystem, as otherwise we'll end duplicating code and 
reinventing the wheel with new incompatible APIs for audio in and outside
media, creating unneeded complexity, which will end being reflected on
userspace as well.

So, IMO it makes a lot more sense to place audio codecs and processor
blocks inside ALSA, probably as part of ALSA SOF, if possible.

Hans suggestion of forking v4l2-mem2mem.c on ALSA seems a good
starting point. Also, moving the DRM mem2mem functionality to a 
core library that could be re-used by the three subsystems sounds
a good idea, but I suspect that a change like that could be more
time-consuming.

Regards,
Mauro

