Return-Path: <linux-kernel+bounces-164369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C708B7CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0594A1C2322C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6B317B4ED;
	Tue, 30 Apr 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCiswKJN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F780179659;
	Tue, 30 Apr 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494480; cv=none; b=PQbrgpJ7H6dar3JhOx1S86bIMtqnAUlPFGkANY76DrI00xH+kyElK60wMNVBJjJKtoAqpWkkWVbFoEiz80bGnEWK+8ztIXK0zUTNxx1JmwKBP0iKoOYVMcnXiA4CgS31yIj8y+F7TqF/lOvVg1Lu/dSuRreDbbvFgB2hDWxG3aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494480; c=relaxed/simple;
	bh=u27bGd4V0G96pi8D9gvQaaGAkmUp7bSeoFGhoO/A8XE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFr67aXHytL/BgtQups7G56pT1dnJsOl8yuQZdRD4cIXGDlO1o+Y2eROY9gZIME5OkBp3GUBKgKzEteZ0w6M0/iGTEb2q58//FPMTJb4Ufro+xHG6l5KeflqzprLzhSXqOI8yGt2f4C0tSyUCa8Gr0GI1fvi3wrRUcQE3DAjQUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCiswKJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2C0C2BBFC;
	Tue, 30 Apr 2024 16:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714494479;
	bh=u27bGd4V0G96pi8D9gvQaaGAkmUp7bSeoFGhoO/A8XE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OCiswKJNOu0sfl6Oov4FuPcbIbdEIAUmabyt1qX3yut7X6jtOUtNez6dT2UiSY6rd
	 UmyD5qSfJyubO8kEyMTErYCZFFaSEvieHPnBf/O2A4ovxK9v590e5J/L2+RHeaDufu
	 3aLtZ/r7wpN+MjcKfycQd3ZruzmmING/5cJxi/GHSRw/rwljtTiMnDsS3wfXBynfUg
	 B4fyEoVTtsQN7u/8lKgsS41p9O3Kp948p3GmD1zd0hA8sXXiyo/YefgCGzFrpWqMJ/
	 rBedlv16kTuD1X+QNkL5ru7Fpfk26uvfe2RSEm1+a4lgLtmlZkk9sQ1OLC8jaC+EHZ
	 oFr1SVAafVguA==
Date: Tue, 30 Apr 2024 17:27:52 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sebastian Fricke <sebastian.fricke@collabora.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>, hverkuil@xs4all.nl, sakari.ailus@iki.fi,
 tfiga@chromium.org, m.szyprowski@samsung.com, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v15 00/16] Add audio support in v4l2 framework
Message-ID: <20240430172752.20ffcd56@sal.lan>
In-Reply-To: <ZjEEKyvb02CWz3l4@finisterre.sirena.org.uk>
References: <1710834674-3285-1-git-send-email-shengjiu.wang@nxp.com>
	<20240430082112.jrovosb6lgblgpfg@basti-XPS-13-9310>
	<ZjEEKyvb02CWz3l4@finisterre.sirena.org.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 30 Apr 2024 23:46:03 +0900
Mark Brown <broonie@kernel.org> escreveu:

> On Tue, Apr 30, 2024 at 10:21:12AM +0200, Sebastian Fricke wrote:
> 
> > first of all thanks for all of this work and I am very sorry for only
> > emerging this late into the series, I sadly didn't notice it earlier.  
> 
> It might be worth checking out the discussion on earlier versions...
> 
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
> 
> The discussion around this originally was that all the audio APIs are
> very much centered around real time operations rather than completely
> async memory to memory operations and that it's not clear that it's
> worth reinventing the wheel simply for the sake of having things in
> ALSA when that's already pretty idiomatic for the media subsystem.  It
> wasn't the memory to memory bit per se, it was the disconnection from
> any timing.

The media subsystem is also centered around real time. Without real
time, you can't have a decent video conference system. Having
mem2mem transfers actually help reducing real time delays, as it 
avoids extra latency due to CPU congestion and/or data transfers
from/to userspace.

> 
> > So instead of hammering a driver into the wrong destination, I would
> > suggest bundling our forces and implementing a general memory-to-memory
> > framework that both the media and the audio subsystem can use, that
> > addresses the current shortcomings of the implementation and allows you
> > to upload the driver where it is supposed to be.  
> 
> That doesn't sound like an immediate solution to maintainer overload
> issues...  if something like this is going to happen the DRM solution
> does seem more general but I'm not sure the amount of stop energy is
> proportionate.

I don't think maintainer overload is the issue here. The main
point is to avoid a fork at the audio uAPI, plus the burden
of re-inventing the wheel with new codes for audio formats,
new documentation for them, etc.

Regards,
Mauro

