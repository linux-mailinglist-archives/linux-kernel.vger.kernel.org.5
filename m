Return-Path: <linux-kernel+bounces-16364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951C6823D5A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4561C21033
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7262031E;
	Thu,  4 Jan 2024 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="CuxMj0Yh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cQByYA58"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF0B2030A;
	Thu,  4 Jan 2024 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 7E7363200B6C;
	Thu,  4 Jan 2024 03:23:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 04 Jan 2024 03:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1704356601; x=1704443001; bh=rz7t4L7SKYLUwAKIGyc8115AY3LogDAT
	d1ChHOD/0oc=; b=CuxMj0YhgZgVN9nQlbqv3g8O25QP8c+q1hw0w+1UCP7cRpON
	tAgmiiyEt9adMomTbE6qKlpNGA4nzSLuSj755y6s/OFFL85a70r/wCB/4Sm9PQcl
	HZSLArZJq077/V4pagBmFPhw0EmD+3aGmgp6W6xh/5pFTk04ZV1wKCNzK3VahFm0
	ZbolZjpMQdkGPWNtctCeDQaodfzTme20DCxO+93RnfAN+3QgC3p9JXh8vC1fHBwY
	M6/bks/2MOJMhNdmoZkX+02J0zTHILTQPBdcGRu8aTK7gPjMClNEuLCCBXY9Okk8
	Y6ir2gZCE8XTVemZZ5jhh/94V6z16MHFwrogLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704356601; x=
	1704443001; bh=rz7t4L7SKYLUwAKIGyc8115AY3LogDATd1ChHOD/0oc=; b=c
	QByYA58xbiVKL++txKhgK+9GfySSwu7RVubvk6l00OXBzK6Sb7a4SwhHnq23vbee
	8d/JYJ5Y/Mh8wkHdRsNv8/NY3Fi/58OS+g7Qoc9JV2O8Miz3eRSPVyOZQuLhekFM
	xj7/D41hgOBi7k0JS1sCAM9zn0Krg1XpSg51EBkuhEYZVti1Uhy0nV6c40yL7O4N
	gX2jkJVFPFqpS43BKHOKX30zb1+f+OKWNJ6HbEWiT3jXZE1I8A/6dCNnj3mZ0Dgz
	Glp8dOwHFFiD7AIx7nR7qqkLEN6N/xJzxIpo+a3LkvZof37ddtpvCUMy6yjpkwil
	vmYvllIHwpKpqhitnzG9A==
X-ME-Sender: <xms:-GqWZZJNDhyFrMjBDOd86NgueDtUTeYByGjd6jv-jlhAUuZMuJklwA>
    <xme:-GqWZVJPVjJJpBog9Azkzewkeea5MFuBByWv7oOmgFRtZmb-3_X1lAOP8DuBe1vyp
    J1CLicfc1eHuWIn1cE>
X-ME-Received: <xmr:-GqWZRvK-yx9eQF_Lbtl7fGe4RaG7yrBpvFWk-spIkEtzOYqmpe1Mxn6gH2i_BrUj7MdXdQdryJCWYHuW66yzFjYqoyYt9DJAMGgOxPkS2vy6RIyAs9J44z_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegiedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpegtgffhggfufffkfhevjgfvofesthhqmhdthhdtjeenucfhrhhomhepufhv
    vghnucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpedvhfdtudduvdeujeeufffgudekvdefvefgueeiiedvledtheegieevffdt
    teekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:-GqWZaa7kF7AmepnONSOQJp4Sj4bpHiQbV1Nv7qBQriNTEJOxg0LJA>
    <xmx:-GqWZQbOgnkVDRMyDiaF4VIFK0jjKZ7NCA5L6h8yBKZ4CjXtOCEYsA>
    <xmx:-GqWZeC4OeQsNCJDyYb5YzxH0KEv3RjV3FmVv58-8d_mZMR4A_VxCw>
    <xmx:-WqWZath5Qm2XCq50Kn2MYIhOhKECOUNQa2_bGp7cFf8jkvgM9srCA>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 03:23:20 -0500 (EST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Sven Peter <sven@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel MacBooks
Date: Thu, 4 Jan 2024 09:23:08 +0100
Message-Id: <4D53181A-F6AC-4571-9E84-3B19AB37ADFE@svenpeter.dev>
References: <ZZZqgsjeY3R4YlVG@hovoldconsulting.com>
Cc: Aditya Garg <gargaditya08@live.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Felix Zhang <mrman@mrman314.tech>,
 linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>, Hector Martin <marcan@marcan.st>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Orlando Chamberlain <orlandoch.dev@gmail.com>, kekrby@gmail.com,
 admin@kodeit.net, Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
 linux-kernel@vger.kernel.org
In-Reply-To: <ZZZqgsjeY3R4YlVG@hovoldconsulting.com>
To: Johan Hovold <johan@kernel.org>
X-Mailer: iPhone Mail (21C66)


>=20
> On 4. Jan 2024, at 09:21, Johan Hovold <johan@kernel.org> wrote:
>=20
> =EF=BB=BFOn Thu, Jan 04, 2024 at 08:50:19AM +0100, Sven Peter wrote:
>>> On 4. Jan 2024, at 08:47, Aditya Garg <gargaditya08@live.com> wrote:
>>>> On 28-Dec-2023, at 5:41=E2=80=AFPM, Johan Hovold <johan@kernel.org> wro=
te:
>=20
>>>> Ok, good, then this patch and the one I posted are mostly equivalent
>>>> assuming that the BCM4378/4387 return an invalid address during setup.
>>>>=20
>>>> This patch may be preferred as it does not need to rely on such
>>>> assumptions, though.
>=20
>>> So what's the final take on this? Which one is gonna be merged upstream?=

>>=20
>> I would=E2=80=99ve preferred this one (possibly with a better commit mess=
age)
>> since it=E2=80=99s more explicit and doesn=E2=80=99t rely on additional a=
ssumptions
>> but it looks like Johan=E2=80=99s version was already merged.
>=20
> Which addresses do BCM4378/4387 return before they are configured?
> Should be easy enough to verify that the current check for invalid
> addresses catches those or otherwise add them to the list.
>=20
> Johan

I think the check used to work for BRCM4378 when I originally wrote the driv=
er but I don=E2=80=99t have any BRCM4387 hardware so can=E2=80=99t test that=
 myself.


Sven



