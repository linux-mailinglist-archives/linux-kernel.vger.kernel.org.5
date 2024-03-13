Return-Path: <linux-kernel+bounces-101565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBB787A8C3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13301C22110
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2A043ACA;
	Wed, 13 Mar 2024 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yotsuba.nl header.i=@yotsuba.nl header.b="Z4/lruuK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kTiGgZnV"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D5D3FB96;
	Wed, 13 Mar 2024 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338022; cv=none; b=dczPnopUrW2W+Hdyjp3zeEE/9MsA/xYnPmsKyAdzYLqbhvFKqa5XWwn7cctklKGYdQiKRKCewb/JWNF4x0ABG/y2aEXH7yQmbuPPDHj9PLxSV1YM/PcOPJ/dscglHgCDLbOIJdwOruEDI7MtuwJagGAsI4npmeMsfMCLO2GQWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338022; c=relaxed/simple;
	bh=jOmLX9ygpmZOCRGB3UnwkgJ3dC6PNOA9d5iZ5hUwSno=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eKDCQS7S5x12fVXR8zM25EyURfhjschq5FgEVO/5pIfluaT0CMaYxvuKDyAuxIf8DpoMYhNi0tDV23RynEbrqtgUoXoqHdSgnm5bfwPmFVPlsHr1T7KRbGaD5GUACRcVCOSdc+r90A8iOqkbyPorkfrA6WbUZZx2DMyOZFYE3zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yotsuba.nl; spf=pass smtp.mailfrom=yotsuba.nl; dkim=pass (2048-bit key) header.d=yotsuba.nl header.i=@yotsuba.nl header.b=Z4/lruuK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kTiGgZnV; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yotsuba.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yotsuba.nl
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9D0291800179;
	Wed, 13 Mar 2024 09:53:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 13 Mar 2024 09:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yotsuba.nl; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1710338017;
	 x=1710424417; bh=hlJNMnPDZ47iGewL2R5tNcfmY0Ncoyko7ICHGM78HtI=; b=
	Z4/lruuKIlDPERzDJJKOi47zVhtM07JblQBSOg/x1KOj64WuSuVs+ZwEHwaNKVCE
	PvBcH1atP8EzMsH/I6L2OHwOdyYiR6HRFlzeoGGNd5NlW/SeJhNPQH2Iw1QAuQNm
	RJS61lGMLY30GfbbQHln0yu2wdF98lwH0mBFcvWBukALOhtk3IRRsLN+DlhYLjHb
	qFWoVbjOlZobQTQ1ckABWDZNQun5//NhQuEBTAuMFWsYknHoGnf0ZFT9U+fmCMXa
	GlqjxLkXHcbGBekRzD0L2djv+I9NlqUsdJBlIRe2uDaoh1rldsQqr4Zj4jfap52W
	5DX7ELjKEykC6bxH2YHr6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710338017; x=
	1710424417; bh=hlJNMnPDZ47iGewL2R5tNcfmY0Ncoyko7ICHGM78HtI=; b=k
	TiGgZnVa9MBX8K1GO3PvlKjJz9UvRRqGLnzhq78PKh27BZ/2dI9Pgs79lzkADe8I
	2vcCnYb2MeN5weAgd3MVepWVKXEusr/pp4iIojp9ZuwPA28wwoidFNbCbil2tJ20
	gGitIXS7OgnUmK82WUTZ4lSDnagfJmxpmflL0gLzBL+GIRIDV5UrHYgl+ZuopMmv
	A6MQRvGkjdmtHAJjyIetLUck8TruyNvZwdl/7X8k9+cDGzi1woMPhY3hg6VfecAf
	j+ka1/UEkRnOqaQtIbjSg4l4X5FM1+S1Myrkg1G2jkd4FzZ7YXOdM8G5Zu0qgjEm
	ld/xatpNm7BX7Akx5dn2w==
X-ME-Sender: <xms:4K_xZTuBcXi8RVwvkv5ZCsJhwtiR80on4mi3EGDb-VqFBqOAXxFtvw>
    <xme:4K_xZUckydZDVAk1OpUXsXCQYsnkbphL8ijyrGhuoCg5GW5YUonBQW86PExvY9yR_
    3nNUiMl4IH8LkjA6RM>
X-ME-Received: <xmr:4K_xZWyUECXhLI52dhlvPSPiee9Vy8FmhPZe1URMcCvSkOwS9srSdMbwlAyB43tcS_5BW1GxnYb8Swgho6US9EdCHLd3wrqlz9J1EEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeehgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomhepofgrrhhk
    uceomhgrrhhkseihohhtshhusggrrdhnlheqnecuggftrfgrthhtvghrnhephfffjeefje
    eutedvjeekleduteettdehkeeugefgjedvgfevteffffeukefggedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhkseihohhtshhusg
    grrdhnlh
X-ME-Proxy: <xmx:4K_xZSOm220sVy8E_uXhX_wepleI3WNqGeJ0ny-L4oB0PaJ2dRww_g>
    <xmx:4K_xZT_zUNygdaO7A1-689aCqaHBF7N5jV0eADHaywsjbbJwwQZaTA>
    <xmx:4K_xZSXI_OmVhTIZuBhxZls1nSwgrU6YUVL5kjcAIP6F7E--QNoNZg>
    <xmx:4K_xZUcHLMdobRnn0h0j0_EkPupyAuDoPhxlsARFQvUPipztqo-GYw>
    <xmx:4a_xZSUuGTJQgYIcedNWuZR87CNUwLq561iZq36G-QQhWnpTjkREfUdPXF8>
Feedback-ID: i85e1472c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Mar 2024 09:53:35 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] netpoll: support sending over raw IP interfaces
From: Mark <mark@yotsuba.nl>
In-Reply-To: <20240313133602.GA1263314@maili.marvell.com>
Date: Wed, 13 Mar 2024 14:53:23 +0100
Cc: netdev@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7C42FC4B-D803-4194-8FBB-19A432D37124@yotsuba.nl>
References: <20240313124613.51399-1-mark@yotsuba.nl>
 <20240313133602.GA1263314@maili.marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Ratheesh,

> Op 13 mrt 6 Reiwa, om 14:36 heeft Ratheesh Kannoth =
<rkannoth@marvell.com> het volgende geschreven:
>=20
> On 2024-03-13 at 18:16:13, Mark Cilissen (mark@yotsuba.nl) wrote:
>> [=E2=80=A6]
> Taking an assumption based on dev=E2=80=99s lower layer does not look =
to be good.
> why not transmit packet from skb_network_header() in your driver (by =
making
> changes in your driver)

There=E2=80=99s two assumptions at play here:
- The lower layer is ethernet: this has always been present in netpoll, =
and is even
  documented in netconsole.rst. This comment just mentions it because we =
add a way
  to bypass the assumption; it is not an assumption this patch adds to =
the code.
- hard_header_len=3D=3D0 means that there is no exposed link layer: this =
is a rather
  conservative assumption in my opinion, and is also mentioned in the =
definition
  of LL_RESERVED_SPACE:

> * Alternative is:
> *   dev->hard_header_len ? (dev->hard_header_len +
> *                            (HH_DATA_MOD - 1)) & ~(HH_DATA_MOD - 1) : =
0

  The same assumption is also made in more places in the core network =
code, like af_packet:

>   - If the device has no dev->header_ops->create, there is no LL =
header
>     visible above the device. In this case, its hard_header_len should =
be 0.
>     The device may prepend its own header internally. In this case, =
its
>     needed_headroom should be set to the space needed for it to add =
its
>     internal header.

I could change it to, like af_packet, check `dev->header_ops` instead if =
that is preferred,
but I don=E2=80=99t think that patching every single raw IP driver to =
deal with skbs that managed
to somehow have link layer data would be preferred here, especially =
since netpoll is kind
of a special case to begin with. I am open to suggestions and ideas, =
though.

> [=E2=80=A6]

Thanks and regards,
Mark=

