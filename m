Return-Path: <linux-kernel+bounces-117423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B3388AB3C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AE81C2613C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6DF5102B;
	Mon, 25 Mar 2024 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="O7jgELFi"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4412B79;
	Mon, 25 Mar 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382324; cv=none; b=ROAuRKHzTF2JPn14CqCuwOTO8Qrh2oToK/7l7Oe7kAM6GJxsmZDvWdwqRiorl5dHzI0ACUJ4/oHdzXsC3B3KNFc4BM/dsiUlEEP87mLP/1vM2hZjO0ek2b8+0ct+6tbWf2kQYbWvcpJn33FxPmVs5ouaKT69+yZRFGJJHzQZaZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382324; c=relaxed/simple;
	bh=yCNGsEK58w4zTJGaxQNMT90lxquB4Gp/F+iGwvH7dqk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dfupiYTvWRQbJfr0ik1n9iNLusKArOWtZAb0gtfQHfNAoLvfQ9ivBR02OM61UB/IT8EXYwstgNWliC3QrYoy3Lc6FxBZUvUGQ2qKJ8Ac5We0Z43nkoULxeKZ7XX7S1/Ca+oRqJKzK695uu0wYAjplLlPVxmFA6IXYYiACGa5dSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=O7jgELFi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yCNGsEK58w4zTJGaxQNMT90lxquB4Gp/F+iGwvH7dqk=;
	t=1711382321; x=1712591921; b=O7jgELFiCu5Bs3LWvdfcGED2x2DBZz2rrxMw09Dx8R+hUsS
	RUaT891yfw73/w0tZ3KpcTLGuJFlIt/Jr2nineajOrFFyqR3WVtvxYeTKxx8Dzaihld2T08D3Mmdy
	lEJXoeksgVdotK384ZrZAsUDCx5KuD6+VdYOdfOL4py1S0yACQiA7sosPDusASEFQO6SLjYQmeI5b
	sQTEecRyB8vV8fChGGCQr33V2uj9uFoVxs5DgYQzANLdX89gLY/bEuTOuoPO9Hm2PXUfwsBdrrlDZ
	igohNPuR2AIZ9J/AhPvm+shIz22tPAD8GZDR3CRguD0s7LOf21SYfMgiP7qHQljA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1romic-0000000Dvhd-3poE;
	Mon, 25 Mar 2024 16:58:39 +0100
Message-ID: <283623e0b227d843a83f8fcd6e9302b1f9f6995a.camel@sipsolutions.net>
Subject: Re: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support
 host mlme
From: Johannes Berg <johannes@sipsolutions.net>
To: Brian Norris <briannorris@chromium.org>
Cc: David Lin <yu-hao.lin@nxp.com>, Francesco Dolcini
 <francesco@dolcini.it>,  "kvalo@kernel.org" <kvalo@kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pete Hsieh
 <tsung-hsien.hsieh@nxp.com>,  "rafael.beims" <rafael.beims@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Date: Mon, 25 Mar 2024 16:58:37 +0100
In-Reply-To: <ZftaJEIeNfV7YrVo@google.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
	 <20240315094927.GA6624@francesco-nb> <ZfTspRKFgrO9xCTH@google.com>
	 <969e95ccc4a1d35b45212b7fcb536ee90995e3b5.camel@sipsolutions.net>
	 <PA4PR04MB9638D253189D6DD330B198B2D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <PA4PR04MB9638BE73DDBCE1CE8AA32BA8D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <b2d9a7ef53c5ab4212617e8edf202bbafe52e2f8.camel@sipsolutions.net>
	 <ZftaJEIeNfV7YrVo@google.com>
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

On Wed, 2024-03-20 at 14:50 -0700, Brian Norris wrote:
>=20
> AFAICT, mwifiex firmware still isn't allowing "parsing and generation of
> 802.11 wireless frames" in any general form -- everything I see is still
> wrapped in custom firmware command protocols. I do see that the AUTH
> frame looks like it's essentially duplicating the standard mgmt format,
> and uses the driver's TX path for it, but there isn't a corresponding
> ASSOC management frame that I can see...

Fair point, I didn't really look beyond "auth creates auth frames and
sends them normally like any other frame" ...

> ...so I really can't tell how much control this firmware *does* give the
> host regarding arbitrary 802.11 frame management.

Perhaps indeed FW does require the assoc to be done with that command.

> But that's pretty much business as usual for anybody but the vendor in
> priorietary firmware land; I can't answer pretty much any question,
> other than what I can glean from a driver.

:)

johannes

