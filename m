Return-Path: <linux-kernel+bounces-167403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F788BA912
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67B11C20AA8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226C214F9C4;
	Fri,  3 May 2024 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIt7IELV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B214E2CB;
	Fri,  3 May 2024 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725754; cv=none; b=l6kU4aR1HQis4sCaiPdZ1IXK9RVgia0EN2IEwk8hW7SJV5Hv4snq6ZhYlQEJJ0XV8vP7b+GNweDTTmjtZG4Nz+8FH/KVN8cwiRs8RtEw32NHdIDA3VodT1DvHS7vKCo0c4q1nOXbP/k4lWWq2N3ihzdtXSSRdRPj/kY0ZzC31+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725754; c=relaxed/simple;
	bh=MET1Qlb3RINT8Dmpmt3ZV/bGlWPZcEfr50B9DIeHIIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bc0oUQ4VhyHdGFfTPbsfKxmPEOauiYbUCPfLXGeyjpM2E1HKkiGHhkuvttQkGLGbwiCgmJYq8vx0UyWhHazmWZrfYv4DBi7Qp8CpPQ/kbshn5jrNwpYAJwofBeR5fZmPh5FQe3S5LHw6PnPYKutBow5me2wK7I4M6DEONah1FI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIt7IELV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B42C116B1;
	Fri,  3 May 2024 08:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714725753;
	bh=MET1Qlb3RINT8Dmpmt3ZV/bGlWPZcEfr50B9DIeHIIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JIt7IELVzP41blGAllJ9i8j/HS//Q/20ZO9vPGBh8jb46CD6lFpzHqh6QbE6VgOY2
	 rJ0dQ5I+IE0MHPV9U+hn8BD4+lTOpcGpli29Gue6Q+GNcsz3a7uW5wTQIFIANNh+Ih
	 c90B5GxcJU4Cen1jbpOB4Zq19rfVUU6XKR22jYI1ONTpok0fBVYIjBsIR3QRN0ahOE
	 EVgqqfIW5tpxj3/tw0fzx3mKx7ybFh3xANShJf3fLXLHHirdNjAi6igogfygNFNiq/
	 SpV2vQXcG/lvkopazpgf9f7UFEovF26N5XMXxRn63f9Z9ZxfaOK5OjI2Mh6NBcdWM8
	 01uL84MAgn/gw==
Date: Fri, 3 May 2024 09:42:25 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Sebastian Fricke
 <sebastian.fricke@collabora.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
 m.szyprowski@samsung.com, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v15 00/16] Add audio support in v4l2 framework
Message-ID: <20240503094225.47fe4836@sal.lan>
In-Reply-To: <ZjRCJ2ZcmKOIo7_p@finisterre.sirena.org.uk>
References: <1710834674-3285-1-git-send-email-shengjiu.wang@nxp.com>
	<20240430082112.jrovosb6lgblgpfg@basti-XPS-13-9310>
	<ZjEEKyvb02CWz3l4@finisterre.sirena.org.uk>
	<20240430172752.20ffcd56@sal.lan>
	<ZjGhPz-bokg6ZbDJ@finisterre.sirena.org.uk>
	<87sez0k661.wl-tiwai@suse.de>
	<20240502095956.0a8c5b26@sal.lan>
	<20240502102643.4ee7f6c2@sal.lan>
	<ZjRCJ2ZcmKOIo7_p@finisterre.sirena.org.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 3 May 2024 10:47:19 +0900
Mark Brown <broonie@kernel.org> escreveu:

> On Thu, May 02, 2024 at 10:26:43AM +0100, Mauro Carvalho Chehab wrote:
> > Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:  
> 
> > > There are still time control associated with it, as audio and video
> > > needs to be in sync. This is done by controlling the buffers size 
> > > and could be fine-tuned by checking when the buffer transfer is done.  
> 
> ...
> 
> > Just complementing: on media, we do this per video buffer (or
> > per half video buffer). A typical use case on cameras is to have
> > buffers transferred 30 times per second, if the video was streamed 
> > at 30 frames per second.   
> 
> IIRC some big use case for this hardware was transcoding so there was a
> desire to just go at whatever rate the hardware could support as there
> is no interactive user consuming the output as it is generated.

Indeed, codecs could be used to just do transcoding, but I would
expect it to be a border use case. See, as the chipsets implementing 
codecs are typically the ones used on mobiles, I would expect that
the major use cases to be to watch audio and video and to participate
on audio/video conferences.

Going further, the codec API may end supporting not only transcoding
(which is something that CPU can usually handle without too much
processing) but also audio processing that may require more 
complex algorithms - even deep learning ones - like background noise
removal, echo detection/removal, volume auto-gain, audio enhancement
and such.

On other words, the typical use cases will either have input
or output being a physical hardware (microphone or speaker).

> > I would assume that, on an audio/video stream, the audio data
> > transfer will be programmed to also happen on a regular interval.  
> 
> With audio the API is very much "wake userspace every Xms".

