Return-Path: <linux-kernel+bounces-49817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08482846FF2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0DB1C25FD2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6621426A;
	Fri,  2 Feb 2024 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gSPXSICc"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A05113EFFF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876009; cv=none; b=mjr5Pu/RUNyk3cf7LCRjQLD6VPxHVsJffOVaUqxaora8UzoDdbs1QljA1TA4NoYWg8TFFvDp0msBEshZNlevLLucVNFpHJ+STNS7Wbw+nkP3ENsM3Rj0A5UdkaNxUfzNSnO+ALDjUsy809LEofT1AW59MPM+d1eOdGYf/p6UxxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876009; c=relaxed/simple;
	bh=heNL6vurGR3zlk9sak8ZdTeGBXsEGFN/FUw2drbVRZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIgHvcwbsZCwoTXp1wsgOR2W2L8FtJ7wxRMeL8h2dGNytUkc9GFq4DfoquHjuZ/SfJzRxCj+aASc9SBcPPGuHYix6yqLO3DfKgkeBHTqM91KOQCJFA5ufR1UNgYpCQ4pHvYk/NMA7ssvZwVoLqhpW0yDLe8YjBBowlRk2pRqbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gSPXSICc; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C4A6E0009;
	Fri,  2 Feb 2024 12:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706876005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBRBUMTBkzgyw1INiZAUKiTvKV7jSrw+yLOhK7wYnQU=;
	b=gSPXSICc9CvNoai5CaYfUZyE0onBH1I5eQdwHq64wND/jDLmTjbfwM2DH0FCF/22tMhdvb
	mEwcDv1vGNp+arOaWz5DCpAr9TdaazFNVO3HcE2sad/91fhUHVhusut+6Fn9Uuv9Z0PbnH
	VGrOCbkcIMbIfbUEKX22CI4P/ssc/7bHrxGCMqMuNLOYTSA6D1vXHHtpHlDUz5ADbiS5cp
	aKeuOFRw/YHJ/UustYxD3jf0dnNNrXEA9zS/+srgOihS6nZpg0EOcE549JcbK0uI/yCdkG
	Vz+F4QUEw2g+emi6njLVT82IE+wCHKkFJFu0K5ng9Wf19jLE04P5ROMJpBlL+w==
Date: Fri, 2 Feb 2024 13:13:22 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Pekka Paalanen <pekka.paalanen@haloniitty.fi>, Louis Chauvet
 <louis.chauvet@bootlin.com>, Rodrigo Siqueira
 <rodrigosiqueiramelo@gmail.com>, Melissa Wen <melissa.srw@gmail.com>,
 =?UTF-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, Haneen Mohammed
 <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 marcheu@google.com, seanpaul@google.com, nicolejadeyee@google.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Arthur Grillo <arthurgrillo@riseup.net>
Subject: Re: [PATCH 2/2] drm/vkms: Use a simpler composition function
Message-ID: <20240202131322.5471e184@xps-13>
In-Reply-To: <3nofkwzgnf4yva2wfogdbii47ohpi2wm5vp6aijtg3emxyoowt@twyreqz7ai3g>
References: <20240201-yuv-v1-0-3ca376f27632@bootlin.com>
	<20240201-yuv-v1-2-3ca376f27632@bootlin.com>
	<20240202105522.43128e19@eldfell>
	<20240202102601.70b6d49c@xps-13>
	<3nofkwzgnf4yva2wfogdbii47ohpi2wm5vp6aijtg3emxyoowt@twyreqz7ai3g>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Maxime,

+ Arthur

mripard@kernel.org wrote on Fri, 2 Feb 2024 10:53:37 +0100:

> Hi Miquel,
>=20
> On Fri, Feb 02, 2024 at 10:26:01AM +0100, Miquel Raynal wrote:
> > pekka.paalanen@haloniitty.fi wrote on Fri, 2 Feb 2024 10:55:22 +0200:
> >  =20
> > > On Thu, 01 Feb 2024 18:31:32 +0100
> > > Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> > >  =20
> > > > Change the composition algorithm to iterate over pixels instead of =
lines.
> > > > It allows a simpler management of rotation and pixel access for com=
plex formats.
> > > >=20
> > > > This new algorithm allows read_pixel function to have access to x/y
> > > > coordinates and make it possible to read the correct thing in a blo=
ck
> > > > when block_w and block_h are not 1.
> > > > The iteration pixel-by-pixel in the same method also allows a simpl=
er
> > > > management of rotation with drm_rect_* helpers. This way it's not n=
eeded
> > > > anymore to have misterious switch-case distributed in multiple plac=
es.   =20
> > >=20
> > > Hi,
> > >=20
> > > there was a very good reason to write this code using lines:
> > > performance. Before lines, it was indeed operating on individual pixe=
ls.
> > >=20
> > > Please, include performance measurements before and after this series
> > > to quantify the impact on the previously already supported pixel
> > > formats, particularly the 32-bit-per-pixel RGB variants.
> > >=20
> > > VKMS will be used more and more in CI for userspace projects, and
> > > performance actually matters there.
> > >=20
> > > I'm worrying that this performance degradation here is significant. I
> > > believe it is possible to keep blending with lines, if you add new li=
ne
> > > getters for reading from rotated, sub-sampled etc. images. That way y=
ou
> > > don't have to regress the most common formats' performance. =20
> >=20
> > While I understand performance is important and should be taken into
> > account seriously, I cannot understand how broken testing could be
> > considered better. Fast but inaccurate will always be significantly
> > less attractive to my eyes. =20
>=20
> AFAIK, neither the cover letter nor the commit log claimed it was fixing
> something broken, just that it was "better" (according to what
> criteria?).

Better is probably too vague and I agree the "fixing" part is not
clearly explained in the commit log. The cover-letter however states:

> Patch 2/2: This patch is more complex. My main target was to solve issues
> I found in [1], but as it was very complex to do it "in place", I choose
> to rework the composition function.
..
> [1]: https://lore.kernel.org/dri-devel/20240110-vkms-yuv-v2-0-952fcaa5a19=
3@riseup.net/

If you follow this link you will find all the feedback and especially
the "broken" parts. Just to be clear, writing bugs is totally expected
and review/testing is supposed to help on this regard. I am not blaming
the author in any way, just focusing on getting this code in a more
readable shape and hopefully reinforce the testing procedure.

> If something is truly broken, it must be stated what exactly is so we
> can all come up with a solution that will satisfy everyone.

Maybe going through the series pointed above will give more context
but AFAIU: the YUV composition is not totally right (and the tests used
to validate it need to be more complex as well in order to fail).

Here is a proposal.

Today's RGB implementation is only optimized in the line-by-line case
when there is no rotation. The logic is bit convoluted and may possibly
be slightly clarified with a per-format read_line() implementation,
at a very light performance cost. Such an improvement would definitely
benefit to the clarity of the code, especially when transformations
(especially the rotations) come into play because they would be clearly
handled differently instead of being "hidden" in the optimized logic.
Performances would not change much as this path is not optimized today
anyway (the pixel-oriented logic is already used in the rotation case).

Arthur's YUV implementation is indeed well optimized but the added
complexity probably lead to small mistakes in the logic. The
per-format read_line() implementation mentioned above could be
extended to the YUV format as well, which would leverage Arthur's
proposal by re-using his optimized version. Louis will help on this
regard. However, for more complex cases such as when there is a
rotation, it will be easier (and not sub-optimized compared to the RGB
case) to also fallback to a pixel-oriented processing.

Would this approach make sense?

Thanks,
Miqu=C3=A8l

