Return-Path: <linux-kernel+bounces-101563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0368387A8B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A527328703E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B44241C7F;
	Wed, 13 Mar 2024 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OgW22M8N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IXlb1e7i"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641735894
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337899; cv=none; b=BLL+kGOt/EmyakF1K9Ri9dpQndUyJBuv9uJbewmsTpTlaQDrFtonbE/uVPjfwKbD9e39oXv0aR6o9KNbKiY0KAMk+ovkLEfZKqn3cMbuN4FYTKCDlXI3JCz95/AkNkTJlIFPkRXwsAZfmUgpZuON2CYyIw0tZxOwft/rjHZEhlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337899; c=relaxed/simple;
	bh=XfodRi+g2MAHEbvaL6rJMGAilrpUe8XvghzMd8UayVI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HuY8psh92IpnALE9zWTPB0nVxpBrkIujfPq74D/FANW3NdZqzW0ZOUv/RWSp08xNUSPfJfhvq6w1M7z0G3sPtIZTst1ddNcXJa1XYy5u+579xSZ8NxBgzt2xwHUb2csr5OTKy8Vt6LEGzj06RDYzd1PDerpU/+n9WN4reftPN0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=OgW22M8N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IXlb1e7i; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3788C13800C4;
	Wed, 13 Mar 2024 09:51:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 13 Mar 2024 09:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1710337896;
	 x=1710424296; bh=UF33/biTEk+qguK6UgC6G5DzkRWJpdJ3TPt8FCcXrto=; b=
	OgW22M8NJ5eWiAaCNYCPbbSMKZhr3yN8z3+VjSy410ClcDv5i7z8CZsFaDgxqMn5
	pgoV1h45tTvUOlsLK6zmDmWnmhbwUhH8SbtsZeazwUB8G+cDlST/vsqArttL47i5
	trONPg+Tad2vw5CfbUWVr9GADXMHTmagizAsrQ1axinvklQHm4N4xwI6yMjNIo2n
	ExZN+RNBI5BrlGPyjl20ep3Pl7oZXcAKn/rIsqD+LKaefX41v78jqPNseU3ElXn5
	/aRSb1/sCw6hTrtK9WsvwFpJCmv9lemvfohH11UuKjTD13n45fg3spg8uyPmVdoC
	2lX5AGTN0as5oG31/5c2HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710337896; x=
	1710424296; bh=UF33/biTEk+qguK6UgC6G5DzkRWJpdJ3TPt8FCcXrto=; b=I
	Xlb1e7iaQ9sB1Gh28/aRIyf91fDvFf/FQU2hbkk1TWs/vZf9zgZBRlXH0giCrmwl
	AR2wFmmdH5pSAOft9/cr+/dBRLbuHifafZY6IXWMkbPmDlk+6Xdb8P2Teqn6W5oo
	/0r35KJjQAMJrH7gNwoEthHva3ciPgsEUx7LFBtRuUzQSRtkjpEmh1OINmZ0xkSW
	NiEE+i5X+bLKaqRb8H5vc3gkzSFe9V0PubjJkun8C6bytlmW/RhQVH1Af6s4MO/C
	02g/H7ynvqV4rDwnWXlLnymSQbXx5aivauR60MFg5JpVg1d+KVEi9vzlGvqy715o
	7iS8tITxYSgvxUvZlOGvw==
X-ME-Sender: <xms:Zq_xZQ6YcqwjbX8cpD0MWJwABF5FhoQCfz0XPLpIZTwgSDMUsEGw-w>
    <xme:Zq_xZR5uRfpGHMkWAQJVg7LRVXt1T25X3Ko_sKnxI6xRV1Taw3y_05LtLN8ZSV3fQ
    b0a-lrbFvfDRhqYw-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeehgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Zq_xZfcuh2-c0LS5sXsSce9JHykwNIph3tccVuz6FZkoc6RzRgDJXg>
    <xmx:Zq_xZVJVWLMuACqtXw0sbVnqj5o6tkC__Yac1SvW4jJChN8i4cQ5iQ>
    <xmx:Zq_xZULEH7kh3YQyNbQ9-J13UCD_0iuxsp3AimTkgNUFq5YGDhfVYQ>
    <xmx:Zq_xZWx4mAZXPvXa0uBBF6pyJaG5Q44Z17gyBwrv0TZftlpSRNF6BQ>
    <xmx:aK_xZT_DS3-L1O6zcIQnJk9OmvxiXiV3CPLyEIhn9vUIgo6nXNUBIA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A6AD1B6008D; Wed, 13 Mar 2024 09:51:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1ee86ea9-fa91-4795-b5f8-2e57609ae65e@app.fastmail.com>
In-Reply-To: <ecc5d070-a773-1180-b50c-59088b23695e@huawei.com>
References: <20240313084707.3292300-1-arnd@kernel.org>
 <4f945f4a-ac29-3ef7-9e15-123962f2a0e9@huawei.com>
 <e0684202-6926-4bd1-86f6-2bb682524712@app.fastmail.com>
 <1a12c8ed-0cb5-5650-24a2-84b021c444c3@huawei.com>
 <b08aaae4-8c69-47eb-9658-5f3f5c8e4056@app.fastmail.com>
 <610231c3-c3ee-e543-1a8a-8e1098ee6a7c@huawei.com>
 <21cd0f32-c94b-4b2b-8fa6-ebe12756b0c4@app.fastmail.com>
 <ecc5d070-a773-1180-b50c-59088b23695e@huawei.com>
Date: Wed, 13 Mar 2024 14:51:14 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Zhihao Cheng" <chengzhihao1@huawei.com>,
 "Arnd Bergmann" <arnd@kernel.org>, "Richard Weinberger" <richard@nod.at>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Daniel Golle" <daniel@makrotopia.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: ubi: avoid expensive do_div() on 32-bit machines
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024, at 14:43, Zhihao Cheng wrote:
> =E5=9C=A8 2024/3/13 21:39, Arnd Bergmann =E5=86=99=E9=81=93:
>
>>> Thanks for explaination, which means that do_div is used for 64-bit
>>> division to solve the link failure caused by missed libgcc. Since
>>> parameter 'from' is u32, there is no need to invoke do_div on a 32-b=
it
>>> platform, you just want to stop the wasting behavior on a 32-bit
>>> platform. Do I understand right?
>>=20
> How do you find it? I mean there are so many types and many do_div=20
> callers, do you have a static check tool?

I had a local fix with the same effect that I applied when
the code originally broke, but had not gotten around to
sending my fix.

After b8a77b9a5f9c ("mtd: ubi: fix NVMEM over UBI volumes on
32-bit systems") introduced a different workaround, I got the
link error because I had removed the do_div().

     Arnd

