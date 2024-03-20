Return-Path: <linux-kernel+bounces-108682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC327880E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A55B1F22B88
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299903A1A1;
	Wed, 20 Mar 2024 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uZW7+ZCG"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2838381A1;
	Wed, 20 Mar 2024 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925970; cv=none; b=rny5KatR5E4aShbaBsTaDJ1lTrIwobT9Oa52P+14C3kjXcWwZ0Xx+q00ACs1IiDKeNwFXNm/bZwR+tfFYR/CQQroww7Wqr/L4dWWpL7GXnYZ8L3xHPnh8MFTXrtxYzz1/k2cZCfuBUmR+hdtZWPoOHEzgxkQJbLp8+V0GsYbTgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925970; c=relaxed/simple;
	bh=+cQOlbmIo4jx4EXb7qfz4OBixcqEIrAG4ITC5AbEzzQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s7JzZfR2pq+L0SaXEkulrlnhtVy5qWHxLl4m4cR6p3wuiRiW2E0o7hnvqr9J2rbC5Yw28gm6+ywvHMWAfo93Mh3bRSiN9pAn3fzNImXAhHfJMsIBMWwusWgkzOUKNsZlr13BCkqC4b83TBWFPmFlEu9tPuptjNP/AoURG2FtUNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uZW7+ZCG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+cQOlbmIo4jx4EXb7qfz4OBixcqEIrAG4ITC5AbEzzQ=;
	t=1710925969; x=1712135569; b=uZW7+ZCGBcDkwTsfFtJiyFeYgkVbl5iMuW66g7VGfLex9nh
	g8gkQ2lavOhO0lLQBh1jAALO8ouNlMRhtxa7igiMeRXCpZPo9bhmxC0gxTMAMftHpEbwryKmixXFC
	iwQk8+BV3ufr5dQdLQml6vJfrBJNBjRPK4txH4eyodv0FrjK18PycwalQVue57vLl70+K0rg2IJdB
	s8DrQgb+yRuMEI7ldhnaT391KBvKtJ66iR4zms6An8tUtV2u+L+9QgP4kSByAgNuEDBVFD1b0mv2f
	AgPIVHCLVsk98ZFJQJv9Wa3Ml0Py/Pvc2aU4sHBAX5z4dmcX8frkGJPVQw9fnO1w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rms06-00000006u2O-1aY8;
	Wed, 20 Mar 2024 10:12:46 +0100
Message-ID: <b2d9a7ef53c5ab4212617e8edf202bbafe52e2f8.camel@sipsolutions.net>
Subject: Re: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support
 host mlme
From: Johannes Berg <johannes@sipsolutions.net>
To: David Lin <yu-hao.lin@nxp.com>, Brian Norris <briannorris@chromium.org>,
  Francesco Dolcini <francesco@dolcini.it>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, 
 "rafael.beims" <rafael.beims@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>
Date: Wed, 20 Mar 2024 10:12:45 +0100
In-Reply-To: <PA4PR04MB9638BE73DDBCE1CE8AA32BA8D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
	 <20240315094927.GA6624@francesco-nb> <ZfTspRKFgrO9xCTH@google.com>
	 <969e95ccc4a1d35b45212b7fcb536ee90995e3b5.camel@sipsolutions.net>
	 <PA4PR04MB9638D253189D6DD330B198B2D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <PA4PR04MB9638BE73DDBCE1CE8AA32BA8D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
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

On Wed, 2024-03-20 at 01:10 +0000, David Lin wrote:
> > >=20
> > > Also decl.h should probably _shrink_ rather than grow, a number of
> > > things just replicate ieee80211.h (such as MWIFIEX_MGMT_HEADER_LEN
> > > really is just
> > > sizeof(ieee80211_mgmt) or so? Not quite correctly.)
> > >=20
> >=20
> > This can be done for feature patches.

But this is a feature patch :-)

> > > So yeah, agree with Brian, not only would this be the first, but it's
> > > also something we don't really _want_. All other drivers that want
> > > stuff like this are stuck in staging ...
> > >=20
> > > So why is this needed for a supposedly "firmware does it all" driver,
> > > and why can it not be integrated with mac80211 if it's no longer "fir=
mware
> > does it all"?
> > >=20
> > > Johannes
> >=20
> > Our proprietary driver is cfg80211 driver, it is very hard to create a =
brand new
> > mac80211 driver and still can port all tested stuffs from our proprieta=
ry driver.

That basically doesn't matter for upstream at all.

>=20
> BTW, vendor should have the choice to use cfg80211 or mac80211 for their =
chips, right?

No, that's not how it works. The choice should be what makes sense
architecturally.

johannes

