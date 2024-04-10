Return-Path: <linux-kernel+bounces-138107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBCD89ECB6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF911C20753
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BE513D520;
	Wed, 10 Apr 2024 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SyhuHN+o"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E3E13D508;
	Wed, 10 Apr 2024 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735571; cv=none; b=dn78n3I90iiCbCM7KuHMoWCpkJ9OonHhjwEwaBx2m/JpJGroP61P2Go01PuzI9efxW3Dc3TMchkjEaWSL6XIlZgkpMGCiLwtRs7A4Avs98+7gft5Ndvmeazc1p8bID3csZnW1D9y+YEfA7ZHfNhht9CL5nhUOFmAj6oL8o8wPWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735571; c=relaxed/simple;
	bh=vp0mYvsOe1L+tR11/c0oupN6RQ+ZoSvho+l1fJhnP9o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BUZc5pEcXRjO6KpR/PmzX7LoZOIOxxKbhxW5SxAwD6jJKC1U1W2T9fnBIMYel3sEb8g7h4c2ZTrsHYjChmK5Inlix87pPjdyfQPxOLMRERHQY2/PTtai7bjOlD6p1sPToXBjGgt+DJnKz27alYhcP3h6H/7H7oY/nkLQeT89QCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SyhuHN+o; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vp0mYvsOe1L+tR11/c0oupN6RQ+ZoSvho+l1fJhnP9o=;
	t=1712735569; x=1713945169; b=SyhuHN+o8WQxcwxs7H4vCkoViHmTWQVf3iTH76nt3QzEL3j
	vHIrFI3rtcANv0JoSdGHlhPEFvudt6jqKsT8a8ZGV7AVyzbP8hsahBbJJqyk3wbBd9Q6Ym2kty38O
	OA5ChJvV03I+SkEF1+SgQ2Ebs9RQ5DqwRgZECiDl769YQCa82QLzTTk/yWTEo9cr8SJaE4XuodhMA
	kpV7OUfV/VwfKkblhj2NCpzUEpXPCLiChh38j/wXXjmOVXBE68SlRkPjH4PuBil6LsbkG6SBx8C5D
	bLj+ecvVweSXhyVz8RurNS0MhagX5aRC+l/+Fm7WD4q1qn0sczvaGJQWB2Qi7OmA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ruSlC-00000001EZE-04wT;
	Wed, 10 Apr 2024 09:52:46 +0200
Message-ID: <533f8c078f28c0e448005154c08f51518d332640.camel@sipsolutions.net>
Subject: Re: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support
 host mlme
From: Johannes Berg <johannes@sipsolutions.net>
To: Brian Norris <briannorris@chromium.org>, David Lin <yu-hao.lin@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, "kvalo@kernel.org"
 <kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, 
 "rafael.beims" <rafael.beims@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>
Date: Wed, 10 Apr 2024 09:52:44 +0200
In-Reply-To: <ZgxCngq_Rguc4qs8@google.com>
References: <ZfTspRKFgrO9xCTH@google.com>
	 <969e95ccc4a1d35b45212b7fcb536ee90995e3b5.camel@sipsolutions.net>
	 <PA4PR04MB9638D253189D6DD330B198B2D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <PA4PR04MB9638BE73DDBCE1CE8AA32BA8D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <b2d9a7ef53c5ab4212617e8edf202bbafe52e2f8.camel@sipsolutions.net>
	 <ZftaJEIeNfV7YrVo@google.com>
	 <PA4PR04MB9638F5037D1AB9BCF51CC9D9D1322@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <Zf4rDifM6bLuqpX2@google.com>
	 <4e5f3741819e457c5c79d825c6520cb9ee531b95.camel@sipsolutions.net>
	 <PA4PR04MB96386917877832602F221282D13A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <ZgxCngq_Rguc4qs8@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Brian,

> So it seems there's 2 possible sticking points: code duplication, and
> overall trend in the specs and implementation that might increase
> duplication?
>=20
> To me, it seems like the duplication is minimal today, or at least, not
> much as a result of anything in this patch proposal. There's some
> repetition of 802.11 definitions already, but that's probably
> orthogonal.

Agree.

> I have less understanding and foresight on the "trend" questions,
> although David seems to somewhat agree in his response below -- that NXP
> intends to handle modern security features in the host more and more,
> which could indeed mean a bit more framing-related duplication.

We'll see, but I don't _actually_ think this will significantly change
the architecture here.

In any case we can always kick the can further down the road.

> > With this patch Mwifiex still a non-mac80211 implementation.=20
> > Driver communicates with wpa_supplicant/hostapd via cfg80211=20
> > I think how driver/FW communicate each other is proprietary, I don't se=
e a dependency with mac80211 here
>=20
> David, I may have pointed in the wrong direction by claiming "conflict"
> with mac80211. I believe Johannes's concerns are in code duplication.

Partially, yes, but also architecturally it should fit in.

> Pretty much all other actively-maintained Linux WiFi drivers are based
> on mac80211, so that we don't all have to implement the same frame
> construction and parsing code. mwifiex is somewhat of an outlier in
> actively adding new features while remaining a cfg80211-only driver.

I'd say though that "actively maintained" part really is because full-
MAC devices that are supported are very few now with Broadcom having
essentially dropped out. I suspect there are other full-MAC chips and/or
firmwares on the market, but few, if any, supported upstream. There's no
particular reason this must be the case, it's just the way hardware
architecture seems to be going.

And as you said before, mac80211 is doing more and more offloads too, so
the line ends up blurring from both sides.
Which then again is part of my concern, if we blur the line from both
sides we need to be even more careful to not grow into a parallel zone
too much.

> But for myself, I'm not even fully convinced mac80211-style stuff makes
> sense here. Even just looking at the auth() stuff in patch 1, this
> driver is far from a thin layer that allows mac80211 to handle the
> 802.11 details. Just look at the 'priv->host_mlme_reg' and
> HostCmd_CMD_MGMT_FRAME_REG stuff -- it seems that the simple act of
> sending a single 802.11 frame requires opting into some FW-specific
> command mask.

I actually agree.


> This feels "thick", like David mentioned above.

This is kind of getting to the core of the thread: I, for one, don't
think he made that argument. He just *claimed*, without much argument
for that claim, that "Mwifiex is designed based on a "Thick FW"
architecture."

> > I think we are using standard cfg80211 commands. How it's handled
> > between driver/FW is proprietary, it's carefully verified and shall
> > not impact other features or break any architecture.=20
>=20
> David, repeating the "carefully verified" stuff doesn't really help the
> subject at hand, and it's not really a technical argument either,

Nor does "we are using standard cfg80211 commands", FWIW. That doesn't
mean we need to think the architecture is good. Taking this argument to
the extreme, it'd be entirely possible to put a (modified) copy of
mac80211 into a driver and claim "we are using standard cfg80211
commands". It's a non-argument.

And really here we get to the core of the issue: Brian, you have now
mostly done the actual _technical_ analysis (and defence) of this patch
that I was waiting for _David_ to do.

johannes

