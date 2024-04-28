Return-Path: <linux-kernel+bounces-161329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B928B4ABF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14281F217DF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C1254BC3;
	Sun, 28 Apr 2024 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b="HxZkDkvp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HvzgjPbQ"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1B04F894;
	Sun, 28 Apr 2024 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714293695; cv=none; b=VG643VHwYTUxcX6S1ND/avtYQtIWAl+bMPkaG2FA2ZgGJUdDB4YJM9RjPdH2ZKQ/H2S73qqOXPsaQRdgIA1rfmGYQpLDMhUFLJNMWbO+JeY8hj2pydBRvj6nUo/F1/vfIJsZcmIJ33Adu8oaG1LjhaqGT1e69Jwb8rNvcwbJlK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714293695; c=relaxed/simple;
	bh=lkK4uPbqGbrBOS0JE9U2l/zksGsHzDvqTknalrJj0Fs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=g3lMqpwADXwMC1D1eBXBwKoxnoQIyx8Ch/f+ACDwqt4zdvI/pJjFDwQOSpfLrwf1gDWfKjdO/+/a2cw/guQTU10hzS5YRh5tHhk9wE974t2XG1z+T9UuPHfKb+9jqZTylM1utYx3pb/sAFtqFKYutXRE6o60Y+Zk75PKCpmoiiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com; spf=pass smtp.mailfrom=testtoast.com; dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b=HxZkDkvp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HvzgjPbQ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=testtoast.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4D3D111400B2;
	Sun, 28 Apr 2024 04:41:32 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Sun, 28 Apr 2024 04:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714293692; x=
	1714380092; bh=HLOUbLQEM816UDtN/Z+3niss/HQf6m2iH7S3MerGxMU=; b=H
	xZkDkvpPbYOcwgcgz6S2ONRuilhMMukIvZFzCHfkQziCb+7IAQnhRjomeB9rXdR9
	1B2e8ZAqI2e0h86cpU9Gz5ZrHUKWyJo+lIV0lzbEkZdolFVQi5yfJ2fCrMl847SP
	ZcGSdpVxz+lYV/T4xhKjOyQKz3mEBOedEvjxn6P2k8FVQpN6Oy83x6JtPre6ye6f
	wQ+Cve1KMLwiUpZm/UGRcZpAOSmvvAIlgwAWrCDLfAmenCPOyVw1KRt6q0dfyJZR
	ICCWSFnYTNFn9UvEbc0dwivcyzAkvWu+Z/HLWtZhRluRQ0XT03+MUlqkFjoI6tPI
	J8c9ARQjUkMaGFHfDEApg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714293692; x=1714380092; bh=HLOUbLQEM816UDtN/Z+3niss/HQf
	6m2iH7S3MerGxMU=; b=HvzgjPbQstttBLtvZ+IeOVlyGpj1Yaza9Mqg2Q38qbsu
	iPs5dirPK00X5zJdW5VrW7aFfLgTf0/Z5u61DXVJhqhxHvVb5V7db5FssDIrnX1f
	Iuhf5s2ZjxCPERJpF5mKPBYi/2rcVy1DKLSvf7eN6mJ4QIS0fy5S9ZHakhXEhsZV
	HbqZCXCvSV8RJVIZjRbOHADcX3cFvy7viJObAIHdCF6SSbf33j7r9ORqiNVWFPrg
	U9RtiwFngaSWzWsK1LUUKg06UHBc+KQu/T+cJPAvT/T8HLjoGFuPBHWF8l3Fsmwr
	s+HYSGuLLV5troz/uWA9OWUKK0mF3zwiwO0lY/FP1A==
X-ME-Sender: <xms:ugsuZvrK1-NBWIB2JyCyh9ADluVaQZiIdC6BCF-O6QhNzynrL4DH4g>
    <xme:ugsuZpokrBWOvW5PbwLDzyqoU2k9kkKPQPP-UGBsu3p74HBNErCali7fCIKw9hOcm
    o0yZlUT4JWVidrzzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftfih
    rghnucghrghlkhhlihhnfdcuoehrhigrnhesthgvshhtthhorghsthdrtghomheqnecugg
    ftrfgrthhtvghrnhephedvveeigedujeeufeegffehhfffveduhfeijefgtdffteelgfet
    ueevieduieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprhihrghnsehtvghsthhtohgrshhtrdgtohhm
X-ME-Proxy: <xmx:ugsuZsNJhiToTnooM0xGudYXA9Cm9LBjP2IHNQlfgI0k4EEhIhDi8w>
    <xmx:ugsuZi4GGpLLEw3zTk3Bhu8PBwuLQLwrG8kJcbddTYvbIacwqrFsug>
    <xmx:ugsuZu65TWkG1d_8NTDBM9VfxLysf25u1r2H4qhvmcqDA1WQgJ4qmQ>
    <xmx:ugsuZqiacvcWDndtGaIgbyx-T1Jl2t_S9rRZSOYu_s_TJHgFaHequw>
    <xmx:vAsuZhKagxFAON1L0uCORbG4aieX2zyruBqPyBxWslAPBld9zBsOUR2g>
Feedback-ID: idc0145fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9CEF4A60078; Sun, 28 Apr 2024 04:41:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-386-g4cb8e397f9-fm-20240415.001-g4cb8e397
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c17d163e-29cc-4049-985e-d1ef91d764cb@app.fastmail.com>
In-Reply-To: <20240418000736.24338-1-andre.przywara@arm.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
Date: Sun, 28 Apr 2024 20:41:10 +1200
From: "Ryan Walklin" <ryan@testtoast.com>
To: "Andre Przywara" <andre.przywara@arm.com>, "Chen-Yu Tsai" <wens@csie.org>,
 "Lee Jones" <lee@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>,
 "Mark Brown" <broonie@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 "Conor Dooley" <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Samuel Holland" <samuel@sholland.org>,
 "Chris Morgan" <macroalpha82@gmail.com>
Subject: Re: [PATCH v2 0/5] regulator: Fix AXP717 PMIC support
Content-Type: text/plain

On Thu, 18 Apr 2024, at 12:07 PM, Andre Przywara wrote:
> This is v2 of the fixes to the AXP717 PMIC support series. 
<snip>
> I don't know if that's still feasible, but those two patches would be a
> good candidate to squash into the patches that they fix.
>
> The other three patches add the "boost" regulator, which is meant to
> provide the 5V USB VBUS power when operating from the battery. It's the
> usual trinity of binding/mfd/regulator patches.
> Again this could be squashed into the respective patches from the
> original series, if people agree.
>
> Please have a look and test!
>
> Based on mfd/ib-mfd-regulator-6.10, as detailed below.

Looks good here, RSB communication, regulator and 5v boost support configured via DT working well on my H700 board, established by a combination of successful device bringup and kernel reporting. Concur with the request to be squashed into the mfd-next tree for 6.10 if possible, thanks!

Ryan

Tested-by: Ryan Walklin <ryan@testtoast,com>

