Return-Path: <linux-kernel+bounces-140049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5528A0ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0075328764E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F353213F004;
	Thu, 11 Apr 2024 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eoxRiwBa"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C692EAE5;
	Thu, 11 Apr 2024 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822590; cv=none; b=ZKiYbTdRaZR5Sib7jqeERgegMfbsclPSTGHzn6hIX4L5cXauS6q6pk930ekh+AZKTxoBYf+WKK8Ju8Sjl4RcqFhioH3dJvoHadG8oJtlZG+mtc+KSVBWrnf044OxhrCyD6ka1BNrv/z1cFYh4fHdh5nUuoZBZItBj0v6T/IvVow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822590; c=relaxed/simple;
	bh=7d+YFrPF5NU+Ft84ySgP2b1As8CzocHhN5TNwq4vytc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qTU4qahHlMI3hjxJB5l1tS7CSN4UTleVUd93gcKY+8TRUwt5LxHvHLYjNxTi/MA/NvNQ/ZLVSXeQpCyQCDk1CIEsAJqMO7d/0Hnrdm/v/JlmmOCguZnF1k1S05odwwfvJOqaHm155BVss6gT3kJtXFgQM6Ae9ETVaN4FYPPT8Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eoxRiwBa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7d+YFrPF5NU+Ft84ySgP2b1As8CzocHhN5TNwq4vytc=;
	t=1712822587; x=1714032187; b=eoxRiwBavMMYjYSr8xHV7MajWCSxSHTN52b1k990sMSR9q2
	k9+M6nNueYKUgmjXHjjqh5CI6pEMXk2WADsa14BVKZgx4eXsgdd5lg1rmh21rmG54D6CZwS/75hzj
	Rj62EuG7Oaqa+74hSsEtO1iQOqrN6eLs4w2uzqjlvE0ICqT+z1dzfmqnkc5aK2LDiZL13zuLVFtwd
	TGEt1Yai6pQ+QfCA5L0K4x/we/r7R8jcSsHb13Swz6abYhgt00x+hU6q11QHgFzgFqq6BnL3wsV44
	NYu983Ki18/nT15PNtmVkdh4r0Y/JGJGL2awG+8KBZv6g64edBCSNYO77gSREV4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rupOc-00000002ZGO-4B5A;
	Thu, 11 Apr 2024 10:02:59 +0200
Message-ID: <7a08dbcaded25ec0d32865647d571afbd66062fe.camel@sipsolutions.net>
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
Date: Thu, 11 Apr 2024 10:02:58 +0200
In-Reply-To: <DU0PR04MB9636AF728C818073435A0E90D1052@DU0PR04MB9636.eurprd04.prod.outlook.com>
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
	 <7af985e13d3254de73f9d68e1ad4ad1f81b5fd59.camel@sipsolutions.net>
	 <DU0PR04MB9636AF728C818073435A0E90D1052@DU0PR04MB9636.eurprd04.prod.outlook.com>
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

On Thu, 2024-04-11 at 07:57 +0000, David Lin wrote:
>=20
>=20
> Following jobs are done by FW:
>=20
> 1. MAC 802.11 Rx processes except for BA buffering/reordering and AMSDU.
> 2. Convert 802.11 frame to 802.3 frame.
> 3. Embedded MAC 802.11 header information to Rx descriptor for driver to =
do BA buffering/reordering.
>=20
> If this FW wants to leverage mac80211:
>=20
> 1. Use 802.11 frame:
> =C2=A0=C2=A0Driver should restructure 802.11 frame and mac80211 will redo=
 jobs done by FW. I think this does not make sense.
> 2. Use 802.3 frame:
> =C2=A0=C2=A0Driver still needs to do BA buffering/reordering (mac80211 ca=
n help with AMSDU with flag IEEE80211_RX_AMSDU,
> =C2=A0=C2=A0but cfg80211 also supports function ieee80211_amsdu_to_8023s(=
) to help this job).
> =C2=A0=C2=A0If this is the case, it becomes redundant to pass 802.3 frame=
 to kernel stack via mac80211.
>=20
> So I think cfg80211 will be more suitable for existing FW.

I agree with most of the above, but I don't really think this is an
argument either way. It just means the datapath won't be hugely
different between such two drivers, and we have to look for details to
make a decision elsewhere.

> > I think the question is about the design, but I also think the differen=
ces in the
> > association process are much more fundamental, and you _don't_ (seem to=
)
> > handle that in the way mac80211 does/expects, though you also don't see=
m to
> > handle it in the way most other full-MAC devices do (which [can] offloa=
d even
> > BSS selection.)
> >=20
>=20
> FW only supports add station command for AP mode. Association command is =
used to request and add client station to FW.
> FW will help to connect to AP and reply result to driver.
> This is another reason that we need to use cfg80211 instead of mac80211. =
For mac80211, management frames are passed
> through ieee80211_ops.tx and station is added via ieee80211_ops.sta_add.=
=20
> This way can't work with FW for client mode, FW can't not be bypassed for=
 association process for client mode.

Right, this is the important distinction here, and indeed that leave
pretty much no choice other than doing a cfg80211 driver, and I don't
think it'd make sense in mac80211 to support offloading that either.

> Thanks for your comments and suggestions. I wonder can I prepare patch v1=
0 to let this patch be accepted?

Yes please.

johannes

