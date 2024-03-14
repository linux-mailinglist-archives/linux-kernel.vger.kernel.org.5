Return-Path: <linux-kernel+bounces-103305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C6687BDC0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52556281FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F1A55C35;
	Thu, 14 Mar 2024 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="klcVKh1w"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D955A4E0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710423121; cv=none; b=RGcJXR4q/Tq+T36QqYq4wMAIZ5jewrPLPhdrdEa2L4hyVvdaCeBOY7NGeyLiY6cwSnC38LqOfPtUWc4U3AkN4fSS/E8ZMVQBz/Y5494xdTXeSi0rnGrIQFPcom7IypWWN1fuvM4d6Dluhb2lMg1R/RF2SsTNUbefA5MKIJc2wPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710423121; c=relaxed/simple;
	bh=jOWUOUdqrMqCL7G4jj9TfumdyGMfKnGMtDE29PbjJ4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXqcmBBOeufqn5CquQXJnVZ7jmgJn5MnGjUE7eVbtilnZkMBVWR5ey0JgDFLaeFIQmQHmRBgL/P31U4hMJll3CPlAMBgleWSRRp7hr8Ua6nnMqFmzSlOsR9FuPDZnSlN2bDOuU+M4RdmMLPjPozCKWXw8r63o6aTn4M9xxIiGxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=klcVKh1w; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=s/0FdWk5XGUyqBACzBKt0C5ouVnbDInJpotxpm6FY0U=; b=klcVKh1wMlvaqagVsgKd3o91I7
	Wzzz8EZCgUdZFgi72k8zovFPFxQ+KluyMxWKm+39aEBa3x2L6/bk07soevl3sC+qZ/ONgTWzZTYgF
	jfrfaLroef/2JlWo97lbWUN9UiaQ1FlBV9KxhFoZ4vwynxkxv4YLbIXM6Kr/FGgLYhp05nsASPL1G
	OmX0hZAq5oox7Atd3KWNi9KBvE29xRAVGjde0FuIs20JuSeESN+gPn876fmW+1PeyuzMYfPLRTLqb
	SA3WfQe+j4PIq0tTU/a5vPSWjLoYsxPqyaQUGQXfc92W7nv87EcFiZQ+rWN+GH7rKSgrmRbV50Qsd
	U115Jzbw==;
Received: from [189.6.17.125] (helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rklBI-00AMX3-BG; Thu, 14 Mar 2024 14:31:36 +0100
Date: Thu, 14 Mar 2024 10:31:13 -0300
From: Melissa Wen <mwen@igalia.com>
To: Arthur Grillo <arthurgrillo@riseup.net>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
	Melissa Wen <melissa.srw@gmail.com>, =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, 
	Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, pekka.paalanen@haloniitty.fi, 
	Louis Chauvet <louis.chauvet@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
	Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH 1/7] drm: Fix drm_fixp2int_round() making it add 0.5
Message-ID: <qabkvxajmothdzi4x6p56sehs4tmqgpniki5vyzu55gz6ogkmt@mypwkdofe2kt>
References: <20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net>
 <20240306-louis-vkms-conv-v1-1-5bfe7d129fdd@riseup.net>
 <yyrvbqpmqplwtqfdsjkhzmx7wrk4h67kn5443bdou7c7uciouy@hac7zfxiff7t>
 <16f8867c-147a-4149-ba96-ae70f8eaf903@riseup.net>
 <nzce3m2okiqdd6iqj6ynymus64vjcpdep3jwqgs4uw3rvkvqkz@tz4i34w7b6es>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nzce3m2okiqdd6iqj6ynymus64vjcpdep3jwqgs4uw3rvkvqkz@tz4i34w7b6es>

On 03/14, Melissa Wen wrote:
> On 03/13, Arthur Grillo wrote:
> > 
> > 
> > On 12/03/24 15:27, Melissa Wen wrote:
> > > On 03/06, Arthur Grillo wrote:
> > >> As well noted by Pekka[1], the rounding of drm_fixp2int_round is wrong.
> > >> To round a number, you need to add 0.5 to the number and floor that,
> > >> drm_fixp2int_round() is adding 0.0000076. Make it add 0.5.
> > >>
> > >> [1]: https://lore.kernel.org/all/20240301135327.22efe0dd.pekka.paalanen@collabora.com/
> > >>
> > > Hi Arthur,
> > > 
> > > thanks for addressing this issue.
> > > 
> > > Please, add a fix tag to the commit that you are fixing, so we can
> > > easily backport. Might be this commit:
> > > https://cgit.freedesktop.org/drm/drm-misc/commit/drivers/gpu/drm/vkms?id=ab87f558dcfb2562c3497e89600dec798a446665
> > >> Suggested-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> > >> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> > >> ---
> > >>  include/drm/drm_fixed.h | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
> > >> index 0c9f917a4d4b..de3a79909ac9 100644
> > >> --- a/include/drm/drm_fixed.h
> > >> +++ b/include/drm/drm_fixed.h
> > >> @@ -90,7 +90,7 @@ static inline int drm_fixp2int(s64 a)
> > >>  
> > >>  static inline int drm_fixp2int_round(s64 a)
> > >>  {
> > >> -	return drm_fixp2int(a + (1 << (DRM_FIXED_POINT_HALF - 1)));
> > > Also, this is the only usage of DRM_FIXED_POINT_HALF. Can you also
> > > remove it as it won't be used anymore?
> > > 
> > >> +	return drm_fixp2int(a + DRM_FIXED_ONE / 2);
> > > Would this division be equivalent to just shifting 1ULL by 31 instead of
> > > 32 as done in DRM_FIXED_ONE?
> > 
> > Yes, but I think the division makes it easier to understand what is
> > going on.
> 
> Right. I was thinking about slightly better performance, but I don't
> have any data. We can go with this since you consider more readable,
> anyway.

Just checked that Harry proposed in another patch[1] this:
`#define DRM_FIXED_HALF		0x80000000ll` for the 0.5 const

Doesn't it sounds better?

[1] https://lore.kernel.org/dri-devel/20240226211100.100108-4-harry.wentland@amd.com/
> 
> Can you send another version addressing the other comments? Then I can
> cherry-pick and already apply the fix.
> 
> Thanks,
> 
> Melissa
> 
> > 
> > Best Regards,
> > ~Arthur Grillo
> > 
> > > 
> > > Melissa
> > > 
> > >>  }
> > >>  
> > >>  static inline int drm_fixp2int_ceil(s64 a)
> > >>
> > >> -- 
> > >> 2.43.0
> > >>

