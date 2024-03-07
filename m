Return-Path: <linux-kernel+bounces-96305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD83B8759F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7B8B2552F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A0813E7F1;
	Thu,  7 Mar 2024 22:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="sv1JvYcv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BJ3dNEaW"
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8782713DBBC;
	Thu,  7 Mar 2024 22:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849185; cv=none; b=QFV4bQWW5I46g9MZIxVzY4XiANHsO+hIk/qWJ8VmXqqLCexRrncaq1VOINQJrNx31tnn3XrAdvjIEEsLm8kDIYNAl71oubsMIv6w5xyOXFM9FvUhG4Gmr7pD31D5pMyVq7knHq3R/r94w4KfW0PUCdKtqupKTo7wxfVw4SZxbbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849185; c=relaxed/simple;
	bh=/gVMBcmDrRWuOB15otVwYpdVarOgptuKw4FJ05t65dI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=YnMIuBOdLtoh44lRB/EG/0lAQ682Jbn3m3icbGwaj/DA7AOWIkfeLfgyrWLUnDrW+G+E0VN8/WHbjO903M2cUoeyc15dWGsyZFSHxBqLpt/blE+Jq2tJdPTgT79BNYTiHxUlp6HlB3iibxdZYbe6UaRdX9OAofw4uQNPVAjiuDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=sv1JvYcv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BJ3dNEaW; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id CDE801C00084;
	Thu,  7 Mar 2024 17:06:21 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 17:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709849181; x=1709935581; bh=/gVMBcmDrR
	WuOB15otVwYpdVarOgptuKw4FJ05t65dI=; b=sv1JvYcvPbefD5MVGu1SqeJFVB
	yo6Gsb77EDC55Ry4UPgyA91Dc8U6r1FHDtjudNE8pt/CTsed8K0ehMZiNP4FvKEz
	wvgAZAO9rdH1viqhCPeIsv1NNV8sw4TjvPYnkKeh346uXivIR6VY3mPRqw80kUeZ
	y/YGHu/XtXTGeLeWRLy4rUuQauTBVNBi5yZYMZLNWCH/FHnNPSKGVuNd6dBNwTY/
	JUJRWEFCyQNOW6+dusRArjynNsTA488CQOLYqINhpvyjhD4SIq7M8XuDnGIkNs0r
	lm9psakGHtnOgAPJZMMO2Bfgal7jkkM17NaRprt8+v7A7iDOjmpcjJX1hY0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709849181; x=1709935581; bh=/gVMBcmDrRWuOB15otVwYpdVarOg
	ptuKw4FJ05t65dI=; b=BJ3dNEaWKUEfse6lE2ThTnQG6nsUL3lBWRt3WPuPUgfu
	iGooG6/x0AjstBIr2oi1qoXfFes6liUWuEwczthnOpRUscwMBVw1IhReHhEKrTn4
	EGjHN/xUeZSzKPjCY64S9lMzUpRpO967BGmP/qAaAjagCAe1reYodcZ2w4OJUOH2
	mAJA1Kozlxa+xB3bd+4DqYQkaHruWAUfcCvP/kZ7g84cXW3LuN7HFwjURgQ9nIAP
	c6xLF2XtomC6PpIDRy6AD5ZcAn9XJMAEV0CjMbvTmPJG/2mY7fIS/RoVB2dvKlct
	EH7Uw/e7HHjtE3o35A8b2T7TV0XZd6noUuSpqdNHZg==
X-ME-Sender: <xms:XDrqZYxFFMgJBHYl-awJtGFaFgeBrlsnL9ajYDW3Zh7SGCM7QQ-Kfw>
    <xme:XDrqZcSAIzS_oF_UNj3SGD3_qdFTs-tTcAIkqbxjF7Dkv1MHffCI_Dw9EvdFheaqQ
    QgH8Q_rl3Z-74qP_5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdduheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:XDrqZaVD3rzTlVvSmZJg3Vn-C4NvWYUmAAxcacgOrc2dPMss8VFfaw>
    <xmx:XDrqZWh3aNIHrsq9aWk6t8C-ddAnO2UxN-6xsUs35ekEoEk_WJJ_NA>
    <xmx:XDrqZaAL5vFzYpaXfZqmytBYj-aQ8S5QF0hyiCIBNmlmwOGP9Wj2Gg>
    <xmx:XTrqZW1faW-AUgwOnmZfhMZvqjr9vMtaMZWHT5EX4tZnJWbERXppG8SHNxY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AF28FB6008F; Thu,  7 Mar 2024 17:06:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3cb1ae25-c660-4182-afe6-ded010fd4129@app.fastmail.com>
In-Reply-To: <20240307170441.3884452-4-andriy.shevchenko@linux.intel.com>
References: <20240307170441.3884452-1-andriy.shevchenko@linux.intel.com>
 <20240307170441.3884452-4-andriy.shevchenko@linux.intel.com>
Date: Thu, 07 Mar 2024 23:06:00 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Cc: "Daniel Mack" <daniel@zonque.org>,
 "Haojian Zhuang" <haojian.zhuang@gmail.com>,
 "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Russell King" <linux@armlinux.org.uk>, "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] spi: pxa2xx: Use proper SSP header in soc/pxa/ssp.c
Content-Type: text/plain

On Thu, Mar 7, 2024, at 18:03, Andy Shevchenko wrote:
> There is nothing from pxa2xx_spi.h used by soc/pxa/ssp.c.
> Replace it with pxa2xx_ssp.h.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

