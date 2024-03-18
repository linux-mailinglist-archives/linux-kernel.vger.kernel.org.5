Return-Path: <linux-kernel+bounces-106086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 121D587E8CB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A92D1F23BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7D2374D3;
	Mon, 18 Mar 2024 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yotsuba.nl header.i=@yotsuba.nl header.b="gmSdw2Qc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RHeeDNMH"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B66381A1;
	Mon, 18 Mar 2024 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762217; cv=none; b=ok+bK4AxMOgJHEdvepg6cKtwNbeTbO51qQzabbqHZJPJEOXywkgzm1Ta+9YPaXgaxXksnLY7791FHOfILfH3kqsBKSShIzoVvotjt8QlqR7iQSUM27Xf1RO8BXoCjchmxSR9z7Do6ECAw30nMV5RrtUv/GjCW10MyFIMjoE9mGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762217; c=relaxed/simple;
	bh=H+Ct9EJKuBXxy6FkALq1UJAazffMwumuGhqyxaMkEnc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sbcXms/OVZjvM+WmvvDd7CzNWvA4TSwG8HclTsbsTRzzavWc8cl1sa3BWMyae+LtTVShkI+3ad2lEgnwTekB7q4xgW3uJRqi85gyx9f38A4RhNXVcqXh2CTpyJb64RMSBzLiLIc3cXg76TbvKuqa4aY+UhovbIkOfSmU+TPSxfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yotsuba.nl; spf=pass smtp.mailfrom=yotsuba.nl; dkim=pass (2048-bit key) header.d=yotsuba.nl header.i=@yotsuba.nl header.b=gmSdw2Qc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RHeeDNMH; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yotsuba.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yotsuba.nl
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 0B8D21C0008E;
	Mon, 18 Mar 2024 07:43:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 18 Mar 2024 07:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yotsuba.nl; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1710762210;
	 x=1710848610; bh=y0d2j2d3CaGP3R5RQDy+IW3nY2J08YoFoA0R013PCZg=; b=
	gmSdw2Qc0P1+y5n1u0JhsFQB44HWZw/LHaygvm4OYbvklZdbAkUZuY78kZ+sWcVY
	ppEigYL+7T3F8EGLzYlB1gaSBnq3f+/n1MSeagDEn54O5ogJ8Cpe2J1dnqakKNSH
	QJY31Q+vIQ6l+DP2eYR8V6XgmcyDqFe9ck+yh3OV069ET7MSem1RLTg3QQuj2bTn
	A3ggCFVEin+Z7c4CPMUbwhcOO/ufl9BEi7H2gekQbnKS3GwSIJLIxNt9ThwnVsOG
	9zfKg7O4D6hKDROKVTSyCZRsek8nXaNuVOvz2VKg0ON7vGI6heGIdmxzPUghpCz+
	3r5piqwps98FCNShExLuLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710762210; x=
	1710848610; bh=y0d2j2d3CaGP3R5RQDy+IW3nY2J08YoFoA0R013PCZg=; b=R
	HeeDNMHB10EZrhF3zKDg/HNv2i32WbYy+XI7M65UPMXM9T0X9kp0eZVao5rV7BmE
	7WyGltbmoEzXSWfqmFvuJK/AruUMv8AoY6/ajlq2GYeeqErjLtEAPkuVSHfQCCzD
	ndT1STwguWC4+CEc49dSQEJzehmCtduFpTjCp6ps99zdjX8uKe74scS748uCagO+
	/QnOceh7nqkSiprnZ9qZK2T9XBzEtbTCseEF26ytiR59PpKLDkOxztKSOhJPZRdU
	EXLVRQElXDr9cNrvngY+ZtfI28e6dB5NgiYCR6dGDzBCYhx/u50KfN98TufduxjC
	HTPX/+2nCsIHClSdk6nbQ==
X-ME-Sender: <xms:4ij4ZTtHlSnu59FXsiWdPqPuFIRkXttNvGSypPn-HQuPloDEISMVgw>
    <xme:4ij4ZUdy6O52kGCD4zoLENVKJEr0hW553pd3mtHNXAG-rZV2pQFBgv8lDjC8c0jMI
    R_RDkeHfMIiLgGTuZ0>
X-ME-Received: <xmr:4ij4ZWzKeHK8XSDYzkYXczKmsZmTT6ZoxgdCIIst2muYpFZc62goRJ6wHVoo0wtrLC3xBxgxO4SBy26RTYRCrCR9VAP9pEl129VrxNY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomhepofgrrhhk
    uceomhgrrhhkseihohhtshhusggrrdhnlheqnecuggftrfgrthhtvghrnhephfffjeefje
    eutedvjeekleduteettdehkeeugefgjedvgfevteffffeukefggedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhkseihohhtshhusg
    grrdhnlh
X-ME-Proxy: <xmx:4ij4ZSOkvsthEABwsScDi3GFdQ35moLvqt5RDQUi3xpxtt06ctA44w>
    <xmx:4ij4ZT8ZK-4RQp00QFWPHRAi_RH9YkbZsc22LE1KQKrwdEAJtPWVmw>
    <xmx:4ij4ZSX2AooPT3wAOUhbpGNKkFZFxYRV8U8yEWIlGCcYSLanOb1ZqA>
    <xmx:4ij4ZUedId-KYmwF1PdJBqKHJW8b68zfqiTZ9eu6qjGKyh7T3kBOqw>
    <xmx:4ij4ZSXcBrhDy8el12TQojAegjLRYBhsfwgMd6FAemltp6Il9YeGPLY3j1o>
Feedback-ID: i85e1472c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 07:43:28 -0400 (EDT)
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
In-Reply-To: <MWHPR1801MB1918F15413BA4766F29A8581D3292@MWHPR1801MB1918.namprd18.prod.outlook.com>
Date: Mon, 18 Mar 2024 12:43:16 +0100
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
Message-Id: <57AE2A31-257C-4702-A571-C590A5DD234A@yotsuba.nl>
References: <20240313124613.51399-1-mark@yotsuba.nl>
 <20240313133602.GA1263314@maili.marvell.com>
 <7C42FC4B-D803-4194-8FBB-19A432D37124@yotsuba.nl>
 <MWHPR1801MB1918F15413BA4766F29A8581D3292@MWHPR1801MB1918.namprd18.prod.outlook.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)


Hi Ratheesh,

> Op 14 mrt 6 Reiwa, om 03:46 heeft Ratheesh Kannoth =
<rkannoth@marvell.com> het volgende geschreven:
>=20
>> From: Mark <mark@yotsuba.nl>
>> [=E2=80=A6]
>=20
> Hmm.  That is not my question.   Let me explain it in detail. =
Netconsole is using netpoll_send_udp() to encapsulate the msg over=20
> UDP/IP/ MAC headers. Job well done. Now it calls =
netdev->ops->ndo_start_xmit(skb, dev).  If your driver is well aware =
that you can
> Transmit only from network header, why don=E2=80=99t you dma map from =
network header ? =20

The rest of the network subsystem seems to not add a header to skbs =
submitted
to netdev->ops->ndo_start_xmit() at all, which makes sense considering
netdev->header_ops is either NULL or no-op for these devices.

Following this line of reasoning, from API perspective it made more =
sense
to me for netpoll to not submit =E2=80=98bogus=E2=80=99 skbs that are =
out-of-line with what
the rest of the network subsystem does to ndo_start_xmit() to begin =
with.
It really depends on the API guarantees we want to have for netdev,
but personally I'm wary of introducing an allowance for bogus headers.

Additionally from a practical perspective, this would require changing =
almost
every, if not every, IP interface driver. I took a look at the WireGuard
driver to see what it would entail, and from my limited experience with =
the
networking code it seems like there's some quite annoying interactions =
with
e.g. GSO which would make driver-side handling of such packets quite a =
bit
more complex.

So from my perspective, fixing this in netpoll is both the more =
API-correct
change and introduces the least amount of additional complexity.

> [=E2=80=A6]

Thanks and regards,
Mark=

