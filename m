Return-Path: <linux-kernel+bounces-36127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A3D839BFE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90916B2A623
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97103537F5;
	Tue, 23 Jan 2024 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nRk88Dcn"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A624F211;
	Tue, 23 Jan 2024 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048289; cv=none; b=W4EF8OHkJjyBZ8TkA5NBVkRcCu0Pn/ICfFjIIhoXDTG0HQ8XKCVlPm/jl73V+iG5ctfjCUGM/P/Rg4gDBzp2gEwOYhF2uI8es8GrvCFTzuTs6/XdlpOIdpWrDP0UgQnAlkpyCu6E/+4nDBrVwx1SuzbXlXV8YH7U8uIJFHhrtaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048289; c=relaxed/simple;
	bh=7pV9x3NQmIGRm7ICc9Pgmv7Nj3R4TIsAeaVRF50Ts9w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qP0D4Fe/88EjuVEKg+iNDXKcBkA/ztNHy+pL5ozG5qpDtDGT/sS/qDrd4qPDUlSmJqfYcD08IsKkaFXUIGLJARY1iLB9keNkcuNK+9ROEHT6DQMNqTlGNpBhQyqPolh5lg4DXkwY3zqNpuJZYCbgOEEPPkPR0SGy7Y30C9V6pRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nRk88Dcn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fb+aJv8HD8MKHoL2qErWawmWGsVeusQx5f3Xw3e0Ow4=;
	t=1706048287; x=1707257887; b=nRk88DcnC13n75FuKAe63hU96apWsfJl4w8TnyjgP35G7PP
	TY/WL+2lgbfHJeCPlEzQFlsg0MrHEJu9lFb8jmdDfKn1POBX4dS/ha6N2t5q/lGcbyyGh1XzT3Emd
	ZctH4x2blgRhwmZFN+4nD0urToLiG2kA6n3BROEjf5s7HD5altIJEAUjZXb+8iHOoxS44wJVGptKC
	9ah9U7pyLWIYAWwU4tkJPmVSILJ1ejYiwxZzzA6BUaZDaL1XOiMTkx5DtNabe8OQoq+IXaDQrHj2J
	tl9iIYTeYQQ5+xj9vYQUsXJqfuYYWxxPZMX+KG027lILe5aAzT5pwtggP7hMO5Xw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rSP5W-0000000FGNa-2A9F;
	Tue, 23 Jan 2024 23:17:46 +0100
Message-ID: <a6adae9df117daab7457260c030cc97d8608eccb.camel@sipsolutions.net>
Subject: Re: [PATCH 0/2] kernel-doc: Remove deprecated kernel-doc option
 'functions'
From: Johannes Berg <johannes@sipsolutions.net>
To: Jonathan Corbet <corbet@lwn.net>, Anna-Maria Behnsen
	 <anna-maria@linutronix.de>, linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, Mike Rapoport
 <rppt@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S.
 Miller" <davem@davemloft.net>,  Marco Elver <elver@google.com>, Alexander
 Potapenko <glider@google.com>, Shuah Khan <shuah@kernel.org>,  Moritz
 Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun
 <yilun.xu@intel.com>,  Dipen Patel <dipenp@nvidia.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 linux-kernel@vger.kernel.org
Date: Tue, 23 Jan 2024 23:17:45 +0100
In-Reply-To: <87y1cfiu2y.fsf@meer.lwn.net>
References: <20240122132820.46633-1-anna-maria@linutronix.de>
	 <c0fd30e8e6d175eab50d7d5212117107e5251e4d.camel@sipsolutions.net>
	 <87y1cfiu2y.fsf@meer.lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-01-23 at 15:05 -0700, Jonathan Corbet wrote:
>=20
> So I feel like I'm missing something; the problem with Sphinx and
> namespacing is separate from whether kernel-doc recognizes "-functions";
> I don't think that taking out this support will make the other problem
> any harder to solve.  Do you see something I'm not?

Well, I was thinking that today, in the rst files, we use

. kernel-doc:: include/net/cfg80211.h
   :functions:
        cfg80211_rx_assoc_resp

(for example).

This clearly references the *function* cfg80211_rx_assoc_resp(), at
least it makes that intent clear.

We also had a *struct* called cfg80211_rx_assoc_resp, until we removed
it recently because of the sphinx namespacing issues.


Now if we change the reference to the function to be just

. kernel-doc:: include/net/cfg80211.h
   :identifiers:
        cfg80211_rx_assoc_resp

then how do you know that it's actually referencing the function vs. the
struct? I mean, OK, today it can only reference the single "thing" (**)
that sphinx accepts ...  but hoping that some day the sphinx namespacing
issue will be solved, we'd need a way to actually reference the
different namespaces from the rst files, no? So it seemed to me that
just unconditionally referencing an "identifier" makes that harder, not
easier?

We have 'struct class' for example, and use

. kernel-doc:: include/linux/device/class.h
   :identifiers: class

to refer to it. At least you know it's not a function, though if you
also had an 'enum class' you'd not be able to figure it out.


(**) Also, I think a struct or enum name isn't actually called an
identifier in C? So maybe that's a bad term regardless of the
namespacing. But I guess even if I'm right (and I'm not really sure)
then that's too late now.

johannes

