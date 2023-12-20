Return-Path: <linux-kernel+bounces-6904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEEA819F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906B81F276A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BED124B35;
	Wed, 20 Dec 2023 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="pUSOCUyw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p3ozTPuX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0318219EF;
	Wed, 20 Dec 2023 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwcx.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id CFF673200A5F;
	Wed, 20 Dec 2023 07:39:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 20 Dec 2023 07:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1703075953;
	 x=1703162353; bh=iFuGp9+YglG9+WeND0DvLC6xEDiN9ijquxV/NP8YOZw=; b=
	pUSOCUywYhIezLCr7rkV7bW99UTKo3XX7u8eMfbmlpqkiy2IQjWDYoYXDZXP+2Ux
	lbO3JyCKENCwHrghYXd/kZBUg7h2L0X9dg74hDbcarFEa87IoKNbs7XVCwF6rB8H
	bDJxlbAR1DmvqQQACQ8Mv73/K2zsaxj1D3ArFBEYxbiap7YBiesedA1wmmICX4Nm
	WFn0R3jbkwXd/9nn3AHgaRwxyplseRn4zsfuYlluzzLsyekvEBR8+Dxt7D1G0r8N
	+3GYupaQCoep8Pu/bv158dgLdHF7+c04b9M7JLXLXtDCpcnmgT8CASoM6Oh84jbx
	CvvWk43JciJAenrvfKdBVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703075953; x=
	1703162353; bh=iFuGp9+YglG9+WeND0DvLC6xEDiN9ijquxV/NP8YOZw=; b=p
	3ozTPuX+HSTM5nIZq8bX4pE+/4OjLCbXejA0khQCwyk9IXAVGXa6GB4J80yA6FAz
	VqHOaXYgZyhAqGv+lC6rYhCRma31gmy8dbIvhu5h9hg6S6pjhXP2Lxhj2vdZ6hQr
	EQVb35FYyEezfVusM859u5GVjKTIZfCmgPLTH3rRVmNpOYQa1I5gPTbZaEFXaLxB
	jYC7ebWGFGfzAo0ChsI6JOooaAVeyGtXoJ0QAPxYZe746zhQJ8rfS7H4pzLRubQa
	xkf/6Uf5ZN+ETyD+FbUgMGUB7//yELSN/Uo9pkvVhxKgWAH3M9I99FslNt/VMiCM
	l+tO6boqg+Q7lVmqBIRcg==
X-ME-Sender: <xms:b-CCZVh6iYSSUG__lMVdbHAtugrv6GVoSZRbikE-lD4dO-AalhCk6Q>
    <xme:b-CCZaBDilOTuh6qMHWBNZ4cylvLAIgRicnv5xMC32F0fCTU_PEEL0dXKJjifI714
    v5qeDoi2O_YdpNWrms>
X-ME-Received: <xmr:b-CCZVHjgNn--lEAwHoi6a-tKnEstVmBKQaegzkOvOE0GoiXU0Czm4vKs5cqzcu1_J9PgIKoowB2QRc0Y69g5Qu0uya-j9e6ZMX1cnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpegtgffhggfufffkfhevjgfvofesthhqmhdt
    hhdtjeenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkh
    esshhtfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepvddutdeuteegvefhueevgeef
    geeiudefkeekleeiveduueevtdeujeelfefffeetnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:b-CCZaT7qnkBYEqhnjbgzMeZHcmWiWCjQeB4aRK8n-EgI-KzaRr4Hg>
    <xmx:b-CCZSxBVtuhjjxa_XB-UyRYK_nKgr6TsC4Wu1v1qvmsvcyu1NzIYA>
    <xmx:b-CCZQ7kvZ8NtglNkNqts9xHk1Jxn7HdJ_SWuyVJhO_iqUpyJZaSEQ>
    <xmx:ceCCZWdNxt3VcUjHdPnWvPeyI4c9N23sUbOVieEwD1PDgFf-YqPqqw>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Dec 2023 07:39:10 -0500 (EST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Patrick Williams <patrick@stwcx.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v8] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Date: Wed, 20 Dec 2023 06:38:59 -0600
Message-Id: <F444BFCC-1D44-4AF6-A0E1-B153A217FFE3@stwcx.xyz>
References: <20231220080733.GA30641@wunner.de>
Cc: Howard Chiu <howard10703049@gmail.com>, robh+dt@kernel.org,
 joel@jms.id.au, andrew@aj.id.au, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, potin.lai@quantatw.com,
 Howard Chiu <howard.chiu@quantatw.com>
In-Reply-To: <20231220080733.GA30641@wunner.de>
To: Lukas Wunner <lukas@wunner.de>
X-Mailer: iPhone Mail (21B101)


---
Patrick Williams

> On Dec 20, 2023, at 2:07=E2=80=AFAM, Lukas Wunner <lukas@wunner.de> wrote:=

>=20
> =EF=BB=BFOn Tue, Dec 07, 2021 at 05:49:24PM +0800, Howard Chiu wrote:
>> Initial introduction of Facebook Bletchley equipped with
>> Aspeed 2600 BMC SoC.
> [...]
>> +        tpmdev@0 {
>> +            compatible =3D "tcg,tpm_tis-spi";
>=20
> What's the chip used on this board?  Going forward, the DT schema for TPMs=

> requires the exact chip name in addition to the generic "tcg,tpm_tis-spi".=


Why is this a requirement?  This assumes there is exactly one chip. TPMs are=
 often placed on a pluggable module in which multiple vendors could be used.=
 There is no way in the DTS to specify multiple compatible chips.=20

>> +            spi-max-frequency =3D <33000000>;
>> +            reg =3D <0>;
>> +        };
>> +    };


