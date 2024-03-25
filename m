Return-Path: <linux-kernel+bounces-117442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B9288AB79
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09AF01F642B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B576A005;
	Mon, 25 Mar 2024 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ctE1BbDJ"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03435762E4;
	Mon, 25 Mar 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383324; cv=none; b=XDmwFVQSAZ8E58LnymLP9smqwEIuE4vGFCvsxActhb5vyFSdUeO9FRS3KzEN+Y7eFnQ4fP5I7HuYuA4/RykSa7DRz9Sen/tbELi4Hl+U+ZMfPS1nc4Exp73JLpWSv+1SbQ9SCsXZg8lUSpUfUrUkg6gbjvg9+RhrXGBEcRkoRUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383324; c=relaxed/simple;
	bh=rjspqZsDWKxvQxYi5AzFtoSi9F2zWzwMbG+B1uCJKOg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AR7eFesJxHAnFuY11ysVY+Ft+j3zR23re6ifIb7+GrKoyDhLeSWevt7EtAZGpsNNZ1QXNd8Gl0nw9Pnw4GN7Mfi51nFc0KAlmoXlVWpgrDOGNGccd1CUNYaxs0SKRcbfjrnS2rai22Gw8mqGDoKhuuIGslQq8UcdCerxbyyCvMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ctE1BbDJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rjspqZsDWKxvQxYi5AzFtoSi9F2zWzwMbG+B1uCJKOg=;
	t=1711383319; x=1712592919; b=ctE1BbDJfe/IZ4XW0ueCfiq0gF4JZ6OeTwB9k1n7QChuVBj
	6x+u5is2EWyP1/wIFdHDyV3DFuiAsL6L/jR+wosHX+uOaBzRb8GUFsMo6m6em2i6LPwGyhrGc8CRi
	FVt9ZBq5y4PXlLZtWM6YeuUUdTI+I48yDvw1lCxoCOsoLSbdtrSXArQjgHe/nDk+BkwUhsYofki3R
	TTMLlg9Xc+QFkPu5AsrRqwdm1vCDlrXWnwWAnRSbhiQDOeeivFLQxeUlKTca9vpDIGdPkHQhKdSyj
	k2j8zA7TNfP8ginAGDFzFnAzjBkewJqfTjjZDCugZuvqmIu1iwgUfKgJu/253gbg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1romye-0000000DwQZ-3Wpf;
	Mon, 25 Mar 2024 17:15:13 +0100
Message-ID: <4e5f3741819e457c5c79d825c6520cb9ee531b95.camel@sipsolutions.net>
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
Date: Mon, 25 Mar 2024 17:15:11 +0100
In-Reply-To: <Zf4rDifM6bLuqpX2@google.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
	 <20240315094927.GA6624@francesco-nb> <ZfTspRKFgrO9xCTH@google.com>
	 <969e95ccc4a1d35b45212b7fcb536ee90995e3b5.camel@sipsolutions.net>
	 <PA4PR04MB9638D253189D6DD330B198B2D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <PA4PR04MB9638BE73DDBCE1CE8AA32BA8D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <b2d9a7ef53c5ab4212617e8edf202bbafe52e2f8.camel@sipsolutions.net>
	 <ZftaJEIeNfV7YrVo@google.com>
	 <PA4PR04MB9638F5037D1AB9BCF51CC9D9D1322@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <Zf4rDifM6bLuqpX2@google.com>
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

On Fri, 2024-03-22 at 18:06 -0700, Brian Norris wrote:
> We appreciate it's well tested, but testing is still orthogonal to the
> architectural questions. Architectural questions are important because
> they affect the future maintainability of the mainline Linux wireless
> stack. If the assumption is that *either* a driver is a cfg80211 driver
> (with firmware-MLME, etc.) or a mac80211 driver (with host MLME), then
> your series is breaking those assumptions.

Maybe, maybe not, actually. The auth command _is_ somewhat special in
that it mostly hands stuff down from userspace via cfg80211, but does
require sending frames. As long as you don't have full offload, at
least.

The way I see it, the issue here isn't necessarily the fact that this
uses the auth command (and then requires assoc, of course), but that we
see here this is "growing" towards a more mac80211-like model, with the
code duplication (albeit little that it is today) implied by that. To
me, it seems like the firmware is moving into the "oh we can't do all
_that_ in firmware" territory, and that brings it closer to mac80211.

At the same time, as you say, mac80211 is doing more and more offload
capability, so it seems like apart from "today the firmware requires an
assoc command rather than assoc frame processing in the host", it's
actually not _that_ far apart any more!

Now that may be an issue in the short term, but I wouldn't be surprised
at all if desiring to implement FILS and other new features in this
space would make the driver move to assoc frame processing in the host
as well, because it's getting more and more complex, just like auth.

At which point - yeah the APIs are still significantly different, but
again we'd end up implementing something that exists in mac80211 today
and taking it into mwifiex?

> It may be harder to add
> future additions to the mac80211 stack [*], if we have to add new
> concerns of a non-mac80211 implementation in the mix.

Not sure that makes a difference for mac80211 in itself, obviously
changes in this space would then affect mwifiex, but that shouldn't be
much of an issue.

I'm less worried about this individual patch than what it says about the
direction this driver and firmware are taking, and I fear we'll end up
in a situation where over time this driver actually gets to a point
where it should be using mac80211, but because it's such a piece-meal
affair (auth frames now, etc.) and large architectural change, they'd
never actually do that.

To be fair, that might also require firmware API changes in some way. I
used to think that was something we should never require, but I'm not so
sure now any more - certainly we've changed our (Intel) FW API in
support of Linux architecture many times, and overall that's for a
better product (on Linux at least.)

Also: David, I'd appreciate if you actually took this discussion
seriously; so far you've not really contributed any technical arguments.

johannes

