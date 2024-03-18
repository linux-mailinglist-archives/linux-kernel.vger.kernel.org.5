Return-Path: <linux-kernel+bounces-106091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF0487E8E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21909282A09
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585EF376E1;
	Mon, 18 Mar 2024 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yotsuba.nl header.i=@yotsuba.nl header.b="CDkWvBqy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="asTqP3/k"
Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E5428E0B;
	Mon, 18 Mar 2024 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762485; cv=none; b=J141NtpDdpkn1qawWgksIxJknxOq8VesyZo7B7c8gOdC0YxVlOOtUbXh503zJ57vaFC7sgyZbo72mdQR7W9Dys0Mkh6TedFLdL/Q1sf9a2sMPXM2Jet7WWSvPVcLR3U+LPk+kX68i+2JMrvlD6peD4sG7+DjmAa676uomNx7STk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762485; c=relaxed/simple;
	bh=5IPsSEdz/fp9vQJpZ1KEpT33IKLJun6HJeoTvxotXNE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=prpUT8EiVIewLji++pjuLrNcg4w8hA+S47Loe3OVDIxGDez/9wUcwf4Gv1kj6SiiBnRpbCw6cC4NGG0T1v/lF8Uv0es4aBbndfVsvk/jXXGsL+9hNTEckfmE7hbFQHy9zdpQmHJ7BfxagcpOesksU2hSzwH5JGSywbotziOHtX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yotsuba.nl; spf=pass smtp.mailfrom=yotsuba.nl; dkim=pass (2048-bit key) header.d=yotsuba.nl header.i=@yotsuba.nl header.b=CDkWvBqy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=asTqP3/k; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yotsuba.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yotsuba.nl
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 73DCD18000AB;
	Mon, 18 Mar 2024 07:48:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 18 Mar 2024 07:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yotsuba.nl; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1710762480;
	 x=1710848880; bh=5IPsSEdz/fp9vQJpZ1KEpT33IKLJun6HJeoTvxotXNE=; b=
	CDkWvBqyo1bkd5bcJgZ3nEhjGMO526PRFyNSgfBXdAfyUjLg2+zH87KjBV67SiOS
	6aN+gWQ1JwFK5fMvPGVvdX7sB1YX2oz8aY1Eq1ydqXAfwWnq0QQ6gThsMxF8/vza
	RMRuN/pQak27I0cksCMCFPpdEqdi/bOfyLxfffUS8WU6AKFPwWg2OF47a9RYNF9W
	uNvN1sY4Vy3P7RPfysl8SXA+09s/qF4SxapeVh3Lt9+QtqZm7OXyMXkb7oqhHfF6
	OPtUoXBUIPt8FBcINlYB+vBGyldOngliDVVE1Ug8JSXq7Qi2GNl1Km5ha3sGIqZv
	LNb2INp3dt77tYconsgyEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710762480; x=
	1710848880; bh=5IPsSEdz/fp9vQJpZ1KEpT33IKLJun6HJeoTvxotXNE=; b=a
	sTqP3/kcyn2kaNJ7ypH9+rX13SFIcxyyT2fmvKGNI4WRNAz/q6jY07Guv9HI0Kdy
	QqfkaChkJ6UsE0do5geeh143yJkvv4ojwzPtCK/tBwVV30Dcyc++XSx49Ft2IvJ+
	FPN/51c6G1CAUyCfkGLuPB6ECHypOSnTMilVf/dp9qDGxYeZJaFDU0I3QqtU6D0Z
	p2erDccHRA74dkZR7Pw6IPVC922zIARxEIF1dATJya5LpRcSU75VXS4Px0Qmnf6Q
	l0JjYJk75Rku6/WE8eLhhKfSKOORjGeFkMi+FbFrXfQWbAkySj8I3iLibwcgH2bV
	1k4mbYF3MqOzcHhAizyzQ==
X-ME-Sender: <xms:8Cn4Zec2p6jS7XYYv9pjw5Sb7qXREBjCn0Kb8YiqTxYEn3iL8H-YuA>
    <xme:8Cn4ZYMGcEG5TlMPGCxGXX1HEAtrJ1LGjnFs7-90z8RIhqVNdp4oggq2KR1hlub15
    e7VgmUtmwm4GbLb0Ak>
X-ME-Received: <xmr:8Cn4ZfjPsBSEQUd4A8daFXKwTEaNKKWa8af7T9TviSuOO8E58NtNyUeBm-F99tJiGO48F_R5oSLA0uN0KcgL-OHIY4BQaKSH4ca9Ukc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtvdenucfhrhhomhepofgrrhhk
    uceomhgrrhhkseihohhtshhusggrrdhnlheqnecuggftrfgrthhtvghrnhepueeifeffue
    ekudekieejhedujedtteeggfdtheeuudegvdegueeiudfgueeltedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhkseihohhtshhusg
    grrdhnlh
X-ME-Proxy: <xmx:8Cn4Zb_IpLdAIle_e6Kx8tuNHx3XdRDjP9l2i2NmLzHGDYDHGhOmhw>
    <xmx:8Cn4ZavX3CvteEZVRZIfQCVo75CPM6QMBIg8GMknbH7_p4V_mSgIiA>
    <xmx:8Cn4ZSESVrNJ2fdYSA3bJKjD75r-H3K8jk2HhlW3TInOT9gzWmqT2Q>
    <xmx:8Cn4ZZPv-HZj94k6JTR8kx1Tfuq4E_T1frLsA6r3ZAfTGcrgd_Cf7Q>
    <xmx:8Cn4ZbmqpEZ1ljHUjeGXdY-kZRFet77Gu0mBWLhZBTwFnbuAoDokdkNIOa4>
Feedback-ID: i85e1472c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 07:47:59 -0400 (EDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] netpoll: support sending over raw IP interfaces
From: Mark <mark@yotsuba.nl>
In-Reply-To: <20240314113455.152cebc9@kernel.org>
Date: Mon, 18 Mar 2024 12:47:46 +0100
Cc: netdev@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <93E237FA-9F0B-48E4-8A89-B9C2619B90A5@yotsuba.nl>
References: <20240313124613.51399-1-mark@yotsuba.nl>
 <20240314113455.152cebc9@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Jakub,

> Op 14 mrt 6 Reiwa, om 19:34 heeft Jakub Kicinski <kuba@kernel.org> het =
volgende geschreven:
>=20
> On Wed, 13 Mar 2024 13:46:13 +0100 Mark Cilissen wrote:
>> Currently, netpoll only supports interfaces with an =
ethernet-compatible
>> link layer. Certain interfaces like SLIP do not have a link layer
>> on the network interface level at all and expect raw IP packets,
>> and could benefit from being supported by netpoll.
>>=20
>> This commit adds support for such interfaces by using the network =
device's
>> `hard_header_len` field as an indication that no link layer is =
present.
>> If that is the case we simply skip adding the ethernet header, =
causing
>> a raw IP packet to be sent over the interface. This has been =
confirmed
>> to add netconsole support to at least SLIP and WireGuard interfaces.
>=20
> Would be great if this could come with a simple selftest under
> tools/testing/selftests/net. Preferably using some simple tunnel
> device, rather than wg to limit tooling dependencies ;)

Yes, that makes a lot of sense. I wrote a selftest that tests netconsole
using IPIP and GRE tunnels, and they too seem to work correctly and pass =
(and
more importantly, fail without the patch ;-). Would you prefer me to =
submit
a v2 with that test now, or when net-next reopens in a week?

Thanks and regards,
Mark=

