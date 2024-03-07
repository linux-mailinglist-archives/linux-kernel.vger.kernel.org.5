Return-Path: <linux-kernel+bounces-94763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873368744F1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FD51C224ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DFA1C32;
	Thu,  7 Mar 2024 00:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oxW6sYPZ"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A615D0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769820; cv=none; b=HpriR76ge39TSdqlHZUAv5ipz6sCQ8Yjc/ZqNyx/JsVY3AFHvEB9jKpo8ZA4HmDjBJhWRWNNudZUrpkoRMvACWKH0Nc4VCS5F29ZczQw1B7HTZkCWIWo0CpI7Kz+rq5IUDPd/eIXwv+ear3u3A0EFmJ4idVbPo51apFZ8cHYFW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769820; c=relaxed/simple;
	bh=vyEvtLO5fAxKSnS/5+3b3Emxls/yPZU+HSovgA2nzgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIbXDhnMSwqES9IRDDGU3ZA4iQsfkwACqFL7BUuvvVM76xuDBxUnFTop//cRhU8AuZkQnkHjhrbFzImTwT4od8HP/E46rfXdZqcjL3HQ5mUwQgcwnr7msiVe6kOEs1s0N/OLaaAJXJEomZirVFSC9rrorPGOvJ37DalYsXWmddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oxW6sYPZ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75658C0005;
	Thu,  7 Mar 2024 00:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709769816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSCVwRBqqpIFk80Ndvwhk2GhpYykGyN7ek/hm0Pe3Nw=;
	b=oxW6sYPZZ/MWrDkustYOSq/f4GUYIvFBdKIvGEvQSNQHbb+dKpAzGZaGZcw6cIxumpTQow
	cKG6rf9UvLgefQ+BwhZ1Fo7vIe4nt7JgtvksQdYeAASuizgMYFWdt0hmL4nat1ja8JgFEI
	D3UOEAU5yDn3G1CLV57Dt56KQgte9PFR0/Svddpl8s3HVUWpOvR60BUSh9Gv932/0w5Vov
	KG2Ia04l91eQnOoxxR9SHKaJ30V2E4vKnlBqJHEHyelLKiRzeyrXzz/VjXz3celS9j6ny5
	l4IQBEx7kkGQhBY2/W3IGgg+4taSCRjWKP4JF1mV1Fug9yrXAvR6/0h8OjLphA==
Date: Thu, 7 Mar 2024 01:03:32 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Arthur Grillo <arthurgrillo@riseup.net>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2 6/9] drm/vkms: Add YUV support
Message-ID: <ZekEVOz6NHHnu0Yj@localhost.localdomain>
Mail-Followup-To: Arthur Grillo <arthurgrillo@riseup.net>,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com
References: <20240226141916.1627bbbd.pekka.paalanen@collabora.com>
 <Zd35c_CJbhY46TjQ@localhost.localdomain>
 <b23da076-0bfb-48b2-9386-383a6dec1868@riseup.net>
 <8fc07f0f-f14d-4878-9884-2bc4b4c6f426@riseup.net>
 <20240229141238.51891cad.pekka.paalanen@collabora.com>
 <ZeXoo4DJxlzhuK4W@localhost.localdomain>
 <fde6b1d5-56c9-43d0-9ccc-87683b700734@riseup.net>
 <ZeXtWAM1XDEhxWOM@localhost.localdomain>
 <a1de0c95-cb5f-456d-8831-684b4e5573db@riseup.net>
 <b8bf9fb9-ea1b-468d-8d56-81c6a9ea6466@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8bf9fb9-ea1b-468d-8d56-81c6a9ea6466@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 06/03/24 - 17:09, Arthur Grillo a écrit :
> 
> 
> On 04/03/24 13:51, Arthur Grillo wrote:
> > 
> > 
> > On 04/03/24 12:48, Louis Chauvet wrote:
> [...]
> >>>
> >>>> Regarding the YUV part, I don't feel confortable adressing Pekka's 
> >>>> comments, would you mind doing it?
> >>>
> >>> I'm already doing that, how do you want me to send those changes? I reply to
> >>> your series, like a did before?
> >>
> >> Yes, simply reply to my series, so I can rebase everything on the 
> >> line-by-line work.
> > 
> > OK, I will do that.
> 
> Hi,
> 
> I know that I said that, but it would be very difficult to that with my
> b4 workflow. So, I sent a separate series based on the v4:
> 
> https://lore.kernel.org/all/20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net/
> 
> I hope that it does not difficult things for you.

Thanks for this work!

I completly understood, and a "real" patch is even better as I 
can fetch them through patchwork. The v5 is (almost, see my comment)
ready, but I want to wait for Pekka's comments/replies on the v4 before 
sending it. 

Kind regards,
Louis Chauvet

> Best Regards,
> ~Arthur Grillo
> 
> > 
> > Best Regards,
> > ~Arthur Grillo
> > 
> >> Kind regards,
> >> Louis Chauvet
> >>
> >>> Best Regards,
> >>> ~Arthur Grillo
> >>>
> >>>>
> >>>> Kind regards,
> >>>> Louis Chauvet
> >>>>
> >>>> [...]
> >>>>
> >>

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

