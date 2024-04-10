Return-Path: <linux-kernel+bounces-139158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE4689FF3F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D49286100
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F0D17F38D;
	Wed, 10 Apr 2024 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SihY/Zf0"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CEF172BBA;
	Wed, 10 Apr 2024 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771811; cv=none; b=pC5kyqS2cIEM1rBrIRNQtV2HAizwCebAGMDk7t+lZXmc0XUSkssYtX/U1rmDTCA7pGlU7SclXE6jIfXibx5yTfa3v8nnbOtKedHspj9qmabR0f/BWUvJTls7OuXZBYs+mwF8TG6iFKF/DCtgVskO6OX89GokY0qGHziUyKRVaKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771811; c=relaxed/simple;
	bh=iEuQdqKd9H5/BlcT+O9gIZxVL7+0ZlEWbRJc2ARTWSw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l6jkaUmKfTa1LxC80gXJkdSFuqC3Lc2egwVwW6+jEFUJRUvk89hfHfxkKUCTzYnuDIvxNBCARRgVfzrkb/Z0GLBii2rzsN5mgajzdee4Uk+t6ENxSmRl+V7XttYFEBTKEavu71t4Qfsw57pdSH4LAkFvHsq/9VlyT9enlyMcJQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SihY/Zf0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iEuQdqKd9H5/BlcT+O9gIZxVL7+0ZlEWbRJc2ARTWSw=;
	t=1712771808; x=1713981408; b=SihY/Zf063sJ9Y6S7UQjjb179Xso7UAQ+xdv86DFZKIST5l
	7nJOEq1Z1IPn0ubF0hYP/o9/ahdnV7S+JNQCnKM/h+p2hq2Z//ytMl4IuKKd5OvtFEXsCjAFdwaKW
	AcWjCSTF+73SaNVYWs+CtwL/CX62wFdNlwcldEqFOsX+ges+aeDh9WQh5RJ99+i0aMOVnFEzyki5/
	dLS7XzvVSqM4+SSBWeI663l4tmWzlQrgicWjg5MebAj+eYp/2ZLt3eR79+JAZ8EicVOISTAyWxos5
	RO/jYPH7ZN1GKZVsYd1Ei+GavTe2L9sb7OTk1kk4kXru9GvIDIjYEAyNFfEC2TnA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rucBh-00000001a9V-1iYv;
	Wed, 10 Apr 2024 19:56:45 +0200
Message-ID: <7af985e13d3254de73f9d68e1ad4ad1f81b5fd59.camel@sipsolutions.net>
Subject: Re: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support
 host mlme
From: Johannes Berg <johannes@sipsolutions.net>
To: David Lin <yu-hao.lin@nxp.com>, Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, "kvalo@kernel.org"
 <kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, 
 "rafael.beims" <rafael.beims@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>
Date: Wed, 10 Apr 2024 19:56:44 +0200
In-Reply-To: <DU0PR04MB96366A0E1FEBD7440F7536D0D1062@DU0PR04MB9636.eurprd04.prod.outlook.com>
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
	 <DU0PR04MB96365F2B6AFD856655D6A66CD1062@DU0PR04MB9636.eurprd04.prod.outlook.com>
	 <5cf6b243c3967cd5a630f8f8e5bf17f7c9010f01.camel@sipsolutions.net>
	 <DU0PR04MB96366A0E1FEBD7440F7536D0D1062@DU0PR04MB9636.eurprd04.prod.outlook.com>
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

On Wed, 2024-04-10 at 10:33 +0000, David Lin wrote:
>=20
>=20
> Take Rx data path as an example,
> In current FW, BA stream setup and de-ampdu are handled in FW. Packet is =
converted to 802.3 before passing to host. Ampdu reordering is handled in h=
ost driver (Mwifiex) due to memory consideration. We used to work on a driv=
er that uses RX_FLAG_8023. It was on an older Wi-Fi part which has more mem=
ory and powerful processor. But with this chip buffer required for reorderi=
ng doesn=E2=80=99t fit FW memory.=20
>=20
> Ampdu reordering needs MAC 802.11 header, FW keeps the MAC header in pack=
et descriptor since packet already 802.3 when arrive at driver. As packet d=
escriptor only accessible in the driver, Mwifiex handles the reordering ins=
tead of using mac80211 reordering.=20
>=20
> With current FW design, to apply mac802.11 we either change FW to pass pa=
cket in 802.11 format or driver needs to do the conversion back to 802.11 (=
which I think doesn=E2=80=99t make sense)=20
>=20
> Given existing FW design, we think it=E2=80=99s difficult to apply mac802=
11.

Hmm, I don't think so? If you have a mac80211 driver with RX_FLAG_8023,
then of course mac80211 cannot do reordering, and you have to do it
somewhere below. But that doesn't mean you necessarily _have_ to do it
in hardware/firmware? You could do it in the driver, which you also have
to do in a cfg80211 driver anyway, and that's OK. Due to usage of RSS,
iwlwifi/mvm even does it internally, although it doesn't even have
RX_FLAG_8023.

But that goes into the direction I was talking about: the boundaries are
getting fuzzier all the time, because offloads happen and get supported
in mac80211. So if you have offloads for header conversion and only get
some reordering data "out of band", then you have to handle that in the
driver. Using mac80211 doesn't mean you have to use _all_ of it.
Originally, mac80211 didn't even have RX_FLAG_8023 after all. But
obviously adding something like that also requires more upstream
engagement :)

I think the question is about the design, but I also think the
differences in the association process are much more fundamental, and
you _don't_ (seem to) handle that in the way mac80211 does/expects,
though you also don't seem to handle it in the way most other full-MAC
devices do (which [can] offload even BSS selection.)

The thing I want you to understand is the relative architecture and how
your work fits into this. I'm not telling you have to change it right
now or do this work differently, I just want to make sure you actually
understand it. The above argument goes some way, showing you've actually
looked at the differences mac80211 would imply, where before I felt you
were pretty much handwaving it away as if irrelevant to the discussion.

johannes

