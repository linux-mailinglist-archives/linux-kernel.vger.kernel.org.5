Return-Path: <linux-kernel+bounces-96306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281AE8759F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85CC28385E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A3F13DB92;
	Thu,  7 Mar 2024 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HSh9V+Xu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KtaWx8hJ"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F561F5FF;
	Thu,  7 Mar 2024 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849277; cv=none; b=md4hTmcXZcj6pmTkb0+5Vob9UqZR72CsO+rGnpsS/21ZdNYVndqlyvQSgJI6J0FH2FSs24sQ7fvz3jG1kePyaKU8HSFTBkhkVBxs8IFimQT9McOqN8rFUlKC49mH6zKbcKepDJgBK3g33DQkv7gjOJDPou9wELht5ImBI+vAig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849277; c=relaxed/simple;
	bh=2cOFINydz+QUDPwlqrR24hyoqQ9ZryhE3141ZGd4Bis=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ayv5iI66252QVbMtB5DaAsC+jEAFBshtWSmidEosrP1zmlmAnp/Bk3a5kpXTSjZTGXEa6N0cIkVHzlOpbTfyKDnSYHZhboCw21kguKn4VY5h/DOp3tvbVcOaT+aBfYpAYlFaz0O4I+ML7CYw3aA0ntObRA+gAt5J6L4aaQPy3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HSh9V+Xu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KtaWx8hJ; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3B5F21800097;
	Thu,  7 Mar 2024 17:07:54 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 17:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709849273; x=1709935673; bh=2cOFINydz+
	QUDPwlqrR24hyoqQ9ZryhE3141ZGd4Bis=; b=HSh9V+XuWVqQ3fPUQHmblYRNug
	Zpck01QwI8tDvFyHocbqbvh+22IXUVXe6tM9w0Bmm4Qlofcu44lcpsuilCDenXwd
	ImYwc5BjoxtUruOkVe2nFBxTMFJLMv5eonVlV8cAOWx/g9bQ5U9SbSjVzmRzw6X2
	Fxq2zyQT5v7MtXcC1m1VJ1S5UIr7xE/a4Zmp/PiX3z2NP5uHOPx1m1+vPoIESPZV
	+aKL4/JS+KOCDw92iXMPvvIPnGDIb0VSTWfuZhBownI3nAdlQKWLyYzIY9Au8HA5
	xqVbwQFCXmYcjZssx3MJFGLL3jH7JDJzu8NCUMaspOOqL/5v2qCVnmTvAGeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709849273; x=1709935673; bh=2cOFINydz+QUDPwlqrR24hyoqQ9Z
	ryhE3141ZGd4Bis=; b=KtaWx8hJaJNWRZ/IHGEa3WJTIcWKBwRwWAWNAgcN54nf
	3ZH3Ft3OJsaOZhUu8Fc1mFPatulkxA3jaVu9mci+GHul/3J30x5kvxCD5+v/6xz4
	2Couhz/GXoxitq7Dkc2dzfYKk1ylkjQ3IWbCXTudSfHAPlQMWusPIyBFPcWK7Vme
	/kVSIUMMc+TuHYPYA/kB/blGoMVM1+snK4GBqJgM29+T+VLe/KbSZ+YOpPWESZVS
	vdpwQvu7iVwrz0yQ1q+KnH/3T18GnLK60Sa8tKAWkE2Hvz7RC2dI50YzJCk/W/0Y
	smNx1J+D5Tl6qeEa1WpFBEBVa3F2+TD2lOAnNJhrPA==
X-ME-Sender: <xms:uTrqZeg4dTqwwCiBeYm3Bbbw9QwByP32wIx4WJhrpEiLHp0ZreggSg>
    <xme:uTrqZfDG3yJofICA-m0_pUn9nfc16E-As0clH0F-eW-4WlVsNEfwCMhr4C4zYa8vH
    Ggg-zsZyFzRU1TYo7o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdduheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:uTrqZWGso2ImHs83L91blDf4wHroy3frY3rCAc3iR1qPH_VAwCZe3g>
    <xmx:uTrqZXT33liuXoOgtMhMzPSkyu_U15dzjS0Xl_8QoHDr5171K0n6Lg>
    <xmx:uTrqZbxYdRza_qxMg6-hzIG5HK1LL5ZpgTZtq1PnPtlhxp1yRh6XlA>
    <xmx:uTrqZSlvigYW7RFpRIn9lkNc5dDVvk0kBFE63LLp1pQ_E5yX3stGfEPRuUk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4D78BB6008D; Thu,  7 Mar 2024 17:07:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2381bd91-d514-4cce-acb1-fda862f64105@app.fastmail.com>
In-Reply-To: <20240307195056.4059864-2-andriy.shevchenko@linux.intel.com>
References: <20240307195056.4059864-1-andriy.shevchenko@linux.intel.com>
 <20240307195056.4059864-2-andriy.shevchenko@linux.intel.com>
Date: Thu, 07 Mar 2024 23:07:32 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: "Mark Brown" <broonie@kernel.org>, "Daniel Mack" <daniel@zonque.org>,
 "Haojian Zhuang" <haojian.zhuang@gmail.com>,
 "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Russell King" <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 1/3] spi: pxa2xx: Kill pxa2xx_set_spi_info()
Content-Type: text/plain

On Thu, Mar 7, 2024, at 20:47, Andy Shevchenko wrote:
> There is the only one user of the pxa2xx_set_spi_info(). Unexport it
> and inline to the actual user.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>

