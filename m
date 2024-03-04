Return-Path: <linux-kernel+bounces-90876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CD9870626
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071781C2230E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AC5482D0;
	Mon,  4 Mar 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OTjcR5kw"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20211B273
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567326; cv=none; b=SIS8QMOqSZRrOgmuqI9PKVB+yO6YPYjf7Rfsq7EmhOizUsCEvNPC9pyzyP2hu1o6kbziUhqwB+D1jkssMKwIZ4t2W19dVJH4QUBDR3pbf48LzgjEOolwbOLp/b0ugmVzR0F+TmfD0dPlWc25zhlK9nOP4+Ezss1qUDKU+A+ZiGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567326; c=relaxed/simple;
	bh=a0cRjdk0ThEgDSzZp7SPW5+rePJS8XTi6/rwumhg3uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5c8RFpWx/I5jGwDdjdzfWLL4hZUbj1SFqpOgcht0a9jL6TG7kXPXzzDnEnvgCbYORBk8m0QqNq+8MMQ5G/ca9OYeID03b75alO5SbrxPrMZJuHIb8p9w/Xnij+j5laerpPScuF2JhMPPKVk9IqjJVhW27dMExZ99ewWliEkThU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OTjcR5kw; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A38A0C0003;
	Mon,  4 Mar 2024 15:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709567323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i0Rx6kS4aBKT4TZ4Uy9UR+iMb1g1h163O9nRLaaNYMk=;
	b=OTjcR5kwIY3YRerZd/3Rlvx9nRKePt5/jdKJxCevdagYUuXXF1Y4rd9zDjufno3GUZzYCR
	io+/YROohcglgoAZAk2tOMTBScP0keHzqcyFUCwpfkD/MfPFTZlrDytIFc1CEwHEFZWgze
	0pAtClsvJ4+8MoPpWsVQizCrTqh1vqtl/6oBW/Y8eCp3Kx9qcJ4nlalkIcBVmHCcVDL3kw
	EoF62Ciw9bw0d7q0FKUwFOyruLtvQcEE02iYPItnZQocJiXl3vZyuV2eGHeV3a2nmtMGOr
	0yaU+GTPUsQpwelFhrRDp/LwSFBS2dvou1M7hLTthr/btuvAzILJEIpOKbV5UA==
Date: Mon, 4 Mar 2024 16:48:40 +0100
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
Message-ID: <ZeXtWAM1XDEhxWOM@localhost.localdomain>
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
References: <20240223-yuv-v2-0-aa6be2827bb7@bootlin.com>
 <20240223-yuv-v2-6-aa6be2827bb7@bootlin.com>
 <20240226141916.1627bbbd.pekka.paalanen@collabora.com>
 <Zd35c_CJbhY46TjQ@localhost.localdomain>
 <b23da076-0bfb-48b2-9386-383a6dec1868@riseup.net>
 <8fc07f0f-f14d-4878-9884-2bc4b4c6f426@riseup.net>
 <20240229141238.51891cad.pekka.paalanen@collabora.com>
 <ZeXoo4DJxlzhuK4W@localhost.localdomain>
 <fde6b1d5-56c9-43d0-9ccc-87683b700734@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fde6b1d5-56c9-43d0-9ccc-87683b700734@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

[...]

> > @arthur, I will submit a v4 with this:
> > - matrix selection in plane_atomic_update (so it's selected only once)
> > - s64 numbers for matrix
> > - avoiding multiple loop implementation by switching matrix columns
> 
> This looks good to me.
> 
> > 
> > Regarding the YUV part, I don't feel confortable adressing Pekka's 
> > comments, would you mind doing it?
> 
> I'm already doing that, how do you want me to send those changes? I reply to
> your series, like a did before?

Yes, simply reply to my series, so I can rebase everything on the 
line-by-line work.
 
Kind regards,
Louis Chauvet

> Best Regards,
> ~Arthur Grillo
> 
> > 
> > Kind regards,
> > Louis Chauvet
> > 
> > [...]
> > 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

