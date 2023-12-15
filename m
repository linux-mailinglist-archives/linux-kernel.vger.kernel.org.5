Return-Path: <linux-kernel+bounces-1627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61985815111
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3BD2868E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4319445BF6;
	Fri, 15 Dec 2023 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="ME9/fD+m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xfY1N2X0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6026246424;
	Fri, 15 Dec 2023 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 398955C00D1;
	Fri, 15 Dec 2023 15:30:06 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Fri, 15 Dec 2023 15:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1702672206;
	 x=1702758606; bh=SMhiooOVHbhcDiASdTNN0KIdx/qyCgOzg/2GaHwtpJ4=; b=
	ME9/fD+mMDJp4xyddXE1x6welE1pdOSZW9gdeW15WUEXX0jK7thCcVr9fRXbXZUa
	pp2VOxuvMWRMc+qUVLwaNtftHAjyj2vqLABAQXhAxO+zINsnlb+eMGCzVEhPw7y0
	flgC8s+twEU4i0onOVJqROLmlenyHMeAceKVkoryFHL8GCfqEeg71dB0voz3S/Md
	8kD06lunS9oT4hLpxNtyNfCdjuL1+rAgj+fhTxeLWW7dL/1XVP8YueuWhE2C4yTI
	Vvx+bUyMSxysXedFBe7QFFtewK9GYLLc/pRS0nGjKdVmI5SITj+/d7rOTkHSmJSy
	dupQnfGRPrjRPBZiLsyxxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702672206; x=
	1702758606; bh=SMhiooOVHbhcDiASdTNN0KIdx/qyCgOzg/2GaHwtpJ4=; b=x
	fY1N2X0ZIRzJg+HXAodeQgdNKcMZ/mcPG8lai9vP/CsRj58nb7JOH6QrWxi02EAk
	93g8yOPrKVeDfhpH6AykjFtvEsdFkQd0iZWnDAI4oD4VGnsWpaTfOjVJJfTvPI4i
	Y3/YEzsP56bBOB6GQw12foD2hy6wceRWdmsFfZddXRSVaUJHJcK7zD1cNGAMG24W
	depf/waZtORtw2EHNOcPaojUxSCFQ+LU6wUI4dnHxtnE1Qs3yXJ8o/p4uMsNeLXl
	zGMGGM3aH3nthskZ75np9jAsrNXsADfGZVAhDaRSMPguNTBWSGMR3NMRJEGVATMk
	cHeVz0eciSPJAUpaZtb/Q==
X-ME-Sender: <xms:Tbd8ZfBKeBJ6PfOpbtFms89mSQ79lZ8GXdoErwz-Zi4XZNrfsPct-Q>
    <xme:Tbd8ZVikwW17RC1KJEdHq3cYcwSkgH6oQus--NV5ouL55vdq2wcKKbv7g30QYWV4Q
    7NPzcF3T8bJbnj1FHY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtvddgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    lfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
    homheqnecuggftrfgrthhtvghrnheptdeludffieeiffejtdeivdejheefvdetuefhleev
    hffhvdehueeggfffgeelteelnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhn
    rdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:Tbd8Zalhmn1f8qjce_Gk5LXNSN4UlGooVq_VNW5GATruBoH8MhRLQQ>
    <xmx:Tbd8ZRzXKAmmo_PaA0ahQ5QgW3KPUZpKw0hoRq-Rj__qJG-zbWyG5Q>
    <xmx:Tbd8ZUSDumkV2yJErSoAvHWYp3KPn3ea-hRFyvCGGBeDDcG_wH_nig>
    <xmx:Trd8ZZJumNgIFaDLJIbdhLqg20Z9EOdYzcm_wtv7ZWg3FxW_Ip8XWg>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 63DDD36A0076; Fri, 15 Dec 2023 15:30:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a4b2dbe5-4d14-418d-bd91-2ad4109bdb86@app.fastmail.com>
In-Reply-To: <875y0zcssc.fsf@BL-laptop>
References: <20231212163459.1923041-1-gregory.clement@bootlin.com>
 <20231212163459.1923041-22-gregory.clement@bootlin.com>
 <6b747f3b-f0d7-4e40-a331-8d2323e4874c@app.fastmail.com>
 <875y0zcssc.fsf@BL-laptop>
Date: Fri, 15 Dec 2023 20:29:48 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Gregory CLEMENT" <gregory.clement@bootlin.com>,
 "paulburton@kernel.org" <paulburton@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
 "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 21/22] MIPS: generic: Add support for Mobileye EyeQ5
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82023=E5=B9=B412=E6=9C=8815=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =
=E4=B8=8B=E5=8D=884:52=EF=BC=8CGregory CLEMENT=E5=86=99=E9=81=93=EF=BC=9A
[...]
>>
>> ^ I still think by doing this you are risking overriding starting add=
ress
>> for all other generic systems. make 32r6_defconfig will load config f=
iles
>> of all boards.
>
> I think at a point you mentioned a way to remove the eyeq5 config board
> from the 32r6_defconfig. It would be indeed a good solution.
Unfortunately we don't have such mechanism for now :-(

>
>>
>> Perhaps just provide an eqm5_defconfig will work better?
>
> So you mean a defconfig in direclty in arch/mips/configs/ and not
> anymore in arch/mips/configs/generic ?
Yep. I think that's the only fesiable way.

Thanks
>
> Gregory
>
>>
>> Thanks.
>> --=20
>> - Jiaxun
>
> --=20
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com

--=20
- Jiaxun

