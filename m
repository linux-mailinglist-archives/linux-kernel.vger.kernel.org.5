Return-Path: <linux-kernel+bounces-138110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00CE89ECC2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB61C1C2189D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3042A13D2A8;
	Wed, 10 Apr 2024 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UZ7GNjt1"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0C913D28B;
	Wed, 10 Apr 2024 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735724; cv=none; b=PcxVNNb+NEWxvx7jiY0tllIMlrpm+rHdrbKlaS2q9+PmzWAOo3M0/Z0I/RSmQox0qi/0KW6t92sKMkuAzB7kvEuchp7U8DVeRQP86tsMTxbVGDV00rwWLlsFqR4Uf1hiBWYp2yA7uPw0aXsLQDBGFZ9ApqZ7lpHqp32GuSRb3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735724; c=relaxed/simple;
	bh=HcMcawYwrMbKNcpE8lk7DBbxiVe9ZzPEjbE5Enqe2Bs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tl4uSA1XDt61laQ5F4HbGZjAHKGYDjzozuWaxAdeDZ4wNZ9DQ5mWIosDjxsEvft56Ekj3E2vRGSQRVygBsfnCwGxxPfdisMSUiRaA5n1WhM+KB2xkM4Cd5ZRmzQSrkdgyEbOeGMiBNmEGhofeAgE1LWplj/MaY+9BtCepnmC9Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UZ7GNjt1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ieFT59N5jWL4d5qY/lsIo26kUNWbiudGLqzvxyRefYQ=;
	t=1712735722; x=1713945322; b=UZ7GNjt1n+hgmWpIAFiYMVYTo4RD93nB/nR46flo+52Lvyp
	Wsc10ouQyWrX0ZF+T01njwizykidMARBcnVf1oUM51GJ7kZ/KlK59U+gtVHzB0ezQhg1mQ8iGYG7M
	CZcTuAB65OjCklmKikmUx4jrs93tN/f+hxlgr8nBf2z4cqJnitTHQES5844SBOO6BZC3Fp2JV44ai
	xE+K7HgcLk292mIzaVQiNU9JZUqOjEJNTsUn85vjoJmrQ5TgQYNseI+cES2GnntOPG90IP/PMGASN
	D3DSuxU4dwNgmb0BatE+BmAvTSpZToEiq3HAraPP7KfGRcg62JIsCeFQCDC66iEg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ruSnf-00000001Ees-42vq;
	Wed, 10 Apr 2024 09:55:20 +0200
Message-ID: <5cf6b243c3967cd5a630f8f8e5bf17f7c9010f01.camel@sipsolutions.net>
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
Date: Wed, 10 Apr 2024 09:55:18 +0200
In-Reply-To: <DU0PR04MB96365F2B6AFD856655D6A66CD1062@DU0PR04MB9636.eurprd04.prod.outlook.com>
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

On Wed, 2024-04-10 at 07:30 +0000, David Lin wrote:
> Hi Johannes and Brian,
> =20
>     I think this patch is used to leverage MLME of wpa_supplicant and hos=
tapd. It won't affect the usage of cfg80211 for mwifiex. I wonder if I can =
prepare patch v10.

No. That sentence tells me you've _still_ not understood any of the
technical arguments in the thread, you're _still_ arguing with
completely uninteresting arguments. Where before you had "it's well
tested" and "it uses 'standard' APIs" now you're saying "it doesn't
affect anyone else". All of that is obvious, and also completely besides
the point.

Please go back and actually _understand_ the discussion. Also actually
_participate_ in the discussion too, so far you've pretty much only made
empty arguments. Once you've understood the concerns and can explain why
they don't apply, _then_ you can resend the patch.

johannes

