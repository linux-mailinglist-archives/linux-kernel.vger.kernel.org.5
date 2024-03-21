Return-Path: <linux-kernel+bounces-110036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237A2885925
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8676B22681
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D22383CB9;
	Thu, 21 Mar 2024 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yotsuba.nl header.i=@yotsuba.nl header.b="DFaTq9Qp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XiGJ5Jj/"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB71CA98;
	Thu, 21 Mar 2024 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024413; cv=none; b=r6U2OIdaYAW/hF5ReWGqSRuzU/r85ukOyA0aRKFlHLq4aNjt96JE35gC8tUGNZwNgT7w6zczE17t1s4+V7n2WMYDVO98RZXzm7IRisJ7xuHcXwb8IFzTB99MwKTjRpbHkBYQJUsWllgHTx/R3qOby8pvYmYpJyyKfqWCyd8rYTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024413; c=relaxed/simple;
	bh=q5IfiyaueGM8Q4RRN24o4rSaqoE85hMKqBJB+BrvQeU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EzgDfEfpsaUhxxrWzjS1aiBxK0HgOdbeY2VfvmRKKFASplEaQAEzJ4T4s/iIfnENbh5vtZGW7AZYAgXANQooaVCESMIx0dgBGvCKX/AITabVJXV8u5nRfYd2d6hAM3+M7ZSFRDkot6xa5EJ04s9XjcNfDhGo7Pr9YrPUzh6Vv9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yotsuba.nl; spf=pass smtp.mailfrom=yotsuba.nl; dkim=pass (2048-bit key) header.d=yotsuba.nl header.i=@yotsuba.nl header.b=DFaTq9Qp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XiGJ5Jj/; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yotsuba.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yotsuba.nl
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9531A11400F6;
	Thu, 21 Mar 2024 08:33:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 21 Mar 2024 08:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yotsuba.nl; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711024410;
	 x=1711110810; bh=fG/X16PKF1cEznvYesAB8B6aZcrt7Z18W0ByBUINONs=; b=
	DFaTq9QpmSbuVItJ7aQTwmdbofl+SJ1NulYtgG05HfQv74eHa7ixjW1dEnyR4YF6
	gMNggU9swb1zNxcA7Q2X3MRD4qyQDHWhzGLUeOAa1oN/1JrBD9d8h2V7NSbAaZfw
	Ruyt7pm7JmnsBbhmfXECibrP3AwOOuqixzE/HGI3Re08ZsagmDymoLQwbjxfK+Nz
	X3DLtFX1enVGHdABUlvEbstzl0QenLdZ0YB1gD1VNXDS1H89iRGthO7FHlrsYH8N
	8mnqgzsLMcXatfXeD45hzbhQjjJt8/SO4r6gXcB4JkbZc6GWlNXpBfJCdm6Zs/zH
	YnKnvXY3Q932j3kL1QLg8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711024410; x=
	1711110810; bh=fG/X16PKF1cEznvYesAB8B6aZcrt7Z18W0ByBUINONs=; b=X
	iGJ5Jj/+7vFQJEWGtOHUdBu8KVQQZepnxO/5K2w4G/5Vtz3NTfzTRi406aZuXgSU
	6gRLdFbOI6GQAQ4+Dyp/2o8Eg4BJjGODXjgS/Htf6dw5GHygiEEIOBTaix5ZQA5Y
	AZlFLtkU42gAsdDUDyRB9G+NhAM41zWvtMOWnSBWwebmGnXchw+Qevj7p8joBVTm
	Pp7IPDFQyMM9QkiqPK+vMI3P/xFgSgZITdEjepaORHm4jPUwbJC4oyVRfRj6DsK+
	tiM/mVhYcpQB9o0809CYqgcW7zgy+w/MlVHdK+04jOzlkOhQV8Ly0Aql/P8RvJNp
	upo2oENv4T1TUxIQxBNug==
X-ME-Sender: <xms:Gin8ZTCyewktql1a89yzON0hH5neUIJOP-E2-oxrbCq_2UkPITSRDw>
    <xme:Gin8ZZga-FeMkFHWkERvKL7MKKYMIfhNRgA0NiU-JTSD3ZFKRtPSyyweCYgoStmgC
    i8pKfFIxnXXsEd--2c>
X-ME-Received: <xmr:Gin8Zek6CKgPXuzyEO4i_AwCohX72PLDJyNHFy6zUltoIQS_WtGH92qd9kU3ZXk4A7bOxRUreQmklwO2ARz3WsEhlbfAZl6DNVFaTHc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomhepofgrrhhk
    uceomhgrrhhkseihohhtshhusggrrdhnlheqnecuggftrfgrthhtvghrnhepfefgfeevie
    efueelffekffevhfeufeduuddugeekuefhiedvieelfeelteduvdeinecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmrghrkheshihothhsuhgsrgdrnhhl
X-ME-Proxy: <xmx:Gin8ZVzXHZIxNxwT4TyvPpGcKmxhLZz-U-f-Xpio4KsWp8OLTtIwvA>
    <xmx:Gin8ZYQeRZOwxcJtVpeRJcN69EwLiXou_hcZQopQbIHVC7Wal35KZQ>
    <xmx:Gin8ZYYyb-icqesBF2AZG4jPeIDtBxBtIFLIXiihT_KIN0DCyMp24w>
    <xmx:Gin8ZZR44hjn0Nz4LBXuo1AgK7Ee8KWNfd9e__K9HgDAvVr4tltGPw>
    <xmx:Gin8Zcby7kVQjF53VvZNgJt5_2JYClpAWe82dPEFL1b7GzirUO2MtQ>
Feedback-ID: i85e1472c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 08:33:29 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [EXTERNAL] [PATCH] netpoll: support sending over raw IP
 interfaces
From: Mark <mark@yotsuba.nl>
In-Reply-To: <MWHPR1801MB191845C94DD80E4CD6C8C962D32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
Date: Thu, 21 Mar 2024 13:33:17 +0100
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4ACBB9C7-EFF5-47CA-9A8A-114209AE7953@yotsuba.nl>
References: <20240313124613.51399-1-mark@yotsuba.nl>
 <20240313133602.GA1263314@maili.marvell.com>
 <7C42FC4B-D803-4194-8FBB-19A432D37124@yotsuba.nl>
 <MWHPR1801MB1918F15413BA4766F29A8581D3292@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <57AE2A31-257C-4702-A571-C590A5DD234A@yotsuba.nl>
 <MWHPR1801MB191845C94DD80E4CD6C8C962D32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Ratheesh,

> Op 18 mrt 6 Reiwa, om 15:06 heeft Ratheesh Kannoth =
<rkannoth@marvell.com> het volgende geschreven:
>=20
>> [=E2=80=A6]
> Is below network topology possible ? =20
> Netpoll()- ------> netdev A ----> raw interface=20
> Where netdev A's  netdev->header_ops !=3D NULL

I believe so, this is not uncommon in tunnel devices like gretap.
However, those fully encapsulate the link layer header in the packet
to the lower interface. I am not aware of a interface driver that =
removes
a header upon xmit, so to speak. However, I have just posted a v2 that
instead uses the documented `dev_has_header()` API, which seems to fit =
the
check exactly, here:

https://lore.kernel.org/netdev/20240321122003.20089-1-mark@yotsuba.nl/T/

I hope this change manages to mitigate your concerns. :-)

> [=E2=80=A6]

Thanks and regards,
Mark


