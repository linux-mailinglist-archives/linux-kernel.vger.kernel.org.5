Return-Path: <linux-kernel+bounces-98519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 967CD877B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E907C281676
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D6310A0A;
	Mon, 11 Mar 2024 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b="jpeIk9MG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GT3M6dXY"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652A1101E2;
	Mon, 11 Mar 2024 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710142521; cv=none; b=qz2jwQp8mV4KnhYnhJrrDNJ/cbwllv4PG4fp/s3H89pvF2hCyzclx4GuX5hRExPxYEwQBshYcu3lvGM9gK8TugnIDiTO2EQEWIoPUjgkezkMwqBFwVRJU4pUGUHgfeb1p+n+RQsPLl9VmXpotgS5/Gd33F3BIyiASwQZcJQOKAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710142521; c=relaxed/simple;
	bh=AT63euh9nACAA8FpxKTo0+f5ix3COISncDmz7k86aZw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=DD8a75HMV7Kv2xsxyetlAooSdXVyc48mLZ7nc5UYkmh7pBQ9EUGrcZ/3wOYVtZN3EKwz7A0YG2W7L6DvFJehmyrv1GArKuA5J6B17XcAlRE6iF5sugr8s7SSKsW75/dyJbLow8qc4tgwpAd9AG0NjqLMVFVXp8YD2vswv21k9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com; spf=pass smtp.mailfrom=testtoast.com; dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b=jpeIk9MG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GT3M6dXY; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=testtoast.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 6E7FB1C000A7;
	Mon, 11 Mar 2024 03:35:17 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Mon, 11 Mar 2024 03:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1710142516; x=
	1710228916; bh=pgvUHd9qCUHGtOhpSeo2XbBXlkhAYOe42MvkFSOBuY0=; b=j
	peIk9MG6MJ5Ovje7dA2BWAxvx55K8T8/ukYRHDrajaRNg8UC4pzu7xFIHWQ8diSx
	gPR+VzveRw0dTiPfp9Ij+zqX9IZz4djwKs3Hy/agKG+CYhgA8PW//nqclBUfmxZy
	oIY5jm2EwnwTy5LWCKFrWZIxpM06TQA+tejFGPrbIFAMpcP3gQUhEJyHsrn7eeRV
	sHSfxirMwZBsU0Qik6oqnH+zzKow79eH3SwA7bHZfndNPbkQ836LC1p4KmK/GAqJ
	Jvs5JzGBgHm272Ly1JkgNTzVnEVZooobpC2dlFdZNUXqdnO8m/8xTioICvR0Y/CD
	59Eot6wJ37UInXifoXNKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710142516; x=1710228916; bh=pgvUHd9qCUHGtOhpSeo2XbBXlkhA
	YOe42MvkFSOBuY0=; b=GT3M6dXYCI0nHt3+PNcBWCgfl7GiaGUV26XnprUB3oef
	vHT8VSvgSCPw2HiI1te36/ox9ysb/Yq9p1jQfhrOtWayo5HxYqFBWG4dJJLzYD2q
	iWK055k472jUFtisyZ0LMwdagim46XOCLOWPo9ACj0xJj6wuTsjHe3dRxv3P2fG3
	QQnV8Yp811krNW8BO3+I479HGkA+m/9vN5EgNzwjGkEK/P8QncT8QZubqSSLee04
	noZs8wUgcWuFompph9wcCd/Gyvc3MQxCVMNPMmwYVxSBgqUgGK3epxAzcNbBaRiZ
	Wc6iGEwILGJPL36Gc+veW2iaM1sJJSkPk1T9k8adlw==
X-ME-Sender: <xms:NLTuZWfkLel_CWAQgk_1v1FAblokO1uschh3sos-uuJbQtcfmcTcfQ>
    <xme:NLTuZQPmqKwQ94cujAAoD6_UVp6CPGgeacISV99jPKGF-IPij_Qn1jsVCZX2wRW9q
    rCwdvznI82b0FTBag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedtgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftfih
    rghnucghrghlkhhlihhnfdcuoehrhigrnhesthgvshhtthhorghsthdrtghomheqnecugg
    ftrfgrthhtvghrnhephedvveeigedujeeufeegffehhfffveduhfeijefgtdffteelgfet
    ueevieduieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprhihrghnsehtvghsthhtohgrshhtrdgtohhm
X-ME-Proxy: <xmx:NLTuZXj5tN4129KaVMHgiegce3SzTeEcJ_IMscP6_eVgnmF3rk0A_A>
    <xmx:NLTuZT90s7raiV40515gEd5jp2LjUGnJNomYCj_NkZida1qWaecTmg>
    <xmx:NLTuZSvdMMFK5Q020QhDunAL8G_5yNz7DoKEwAvRYfDJBlfELGXtCw>
    <xmx:NLTuZXMC0HKkjPpTVGVGA5Lx19nJ1bIdIrirmomUoIA6EGTnB2FmQdQ6Wp0>
Feedback-ID: idc0145fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 02E82A60078; Mon, 11 Mar 2024 03:35:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d6a3c20c-f2d8-44e9-be63-d27dfafacba8@app.fastmail.com>
In-Reply-To: <20240310010211.28653-1-andre.przywara@arm.com>
References: <20240310010211.28653-1-andre.przywara@arm.com>
Date: Mon, 11 Mar 2024 20:34:54 +1300
From: "Ryan Walklin" <ryan@testtoast.com>
To: "Andre Przywara" <andre.przywara@arm.com>,
 "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 "Chen-Yu Tsai" <wens@csie.org>, "Lee Jones" <lee@kernel.org>,
 "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 "Conor Dooley" <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, "Samuel Holland" <samuel@sholland.org>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Chris Morgan" <macromorgan@hotmail.com>, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 0/4] regulator: Add X-Powers AXP717 PMIC support
Content-Type: text/plain

On Sun, 10 Mar 2024, at 2:02 PM, Andre Przywara wrote:
> This patch series adds support for the X-Powers AXP717 PMIC, which is 
> used recently on new boards with Allwinner SoCs.

> Please note that I could not test this driver myself, but had success
> messages from others. It would be good to hear from Ryan and Chris
> here on the list, with a Tested-by: tag.

Thanks Andre, tested on an Allwinner H700-based board (Anbernic RG35XX+) with successful bringup of DRAM, boot and regulator reporting via /sys/kernel/debug/regulator/regulator_summary. 

Battery charging not tested but according to vendor datasheet this functionality is internal to the PMIC and can complete without reference to the host, with informational reporting and charging parameters optionally modified by host over I2C or RSB.

Ryan

Tested-by: Ryan Walklin <ryan@testtoast.com>


