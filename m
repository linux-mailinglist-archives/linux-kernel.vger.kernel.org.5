Return-Path: <linux-kernel+bounces-131528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B03889890E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B241F22377
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420A6128385;
	Thu,  4 Apr 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZpVvBkg+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uQJCVPyk"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85389127B51;
	Thu,  4 Apr 2024 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238399; cv=none; b=YhbhwHpN/Z5vRFxLqKab89P4v86WVkcdTBVzN6awZ884aceenorjYFl4r6PgQPESjKRoqF0ldfDgnLCEb4sVcOklxyTc2+FZoeHmsFDh7FCBJgJvJQapPQy8A2xSmOCfxvQ1Ey0r6DyzXVWQ9+7IgAPOJPijVnN3xiTdWJIyFWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238399; c=relaxed/simple;
	bh=7GTmuvd/g+2kjXHqewtOzOMzM8ZbfD3h4Rj0AmhRtZ0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=e2eopoQS6RdxTk5uuGpic/tHS9H2NFjyHSavdihzhHbo622S5XHIR5mWB1vK+Jx3mwLPcX3ZXsnodFwJlkTBa2shUhLvvy7FU7fpTjcqhsSmyLyeu1teN9ZK37smJZNvi2++qF0hUWqYpAg4MkBZcr9PFOH7nqwlp/HnR5Ho9Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZpVvBkg+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uQJCVPyk; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id CE3C5180013B;
	Thu,  4 Apr 2024 09:46:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 09:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1712238395; x=1712324795; bh=xoNE/g7sSR
	Ax9OKw6TErtL84rFmYT06tsQn/3tBy+mE=; b=ZpVvBkg+bK5HcrZb/FV7XSBBEd
	Sy2kdiKrJB//Lv75+BTO767OD5xIOIikxRkiZ+MC8ljVG1NqvYhm3BeghFG5lk/b
	4MUUPDiqkUCxkIh50O6j7mBwtWKqR+w4Rk4eXm2pYS/VUwcqEmEX0Es2OXdR9tKv
	moDn2Mn9UG75tuYgOFccgs3wqNXnlIpJR/hMUNpsNmLa8jrmZ/r/iYNBtal5LvD6
	duqq9MYGSWDMKMICzxAj8MvoPVD/mY/7Tqh/ew4cdEbcutfwANMyeZFGMR6W8Bqo
	F9wZZxo5OC6mQg8rI/07l4XZ4AXLsDUSoquWRhCyBK6pMi5JhrQPQ/QGHwUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712238395; x=1712324795; bh=xoNE/g7sSRAx9OKw6TErtL84rFmY
	T06tsQn/3tBy+mE=; b=uQJCVPyki2c5EEiyPfqTBlnKfhLMbg5YRqFDGw3Bx/Rl
	vrppxL+kFBj3gdnerE5glOsriYa+tb8kX1HOMhKTjgOgeYRnoL2zHL1oa4SYjCi4
	S7gSsfbzxcyl9DPXoXwQCsOcbmYJpHQHE9lvp7lxEtAkv1vvaQxPCjyKxtBDxl9z
	pDAmEaLL9LyABs6cCWgLDBY5MM2JNe++P10hxs8AB31I87WHfHkqMeRbmCOoi2dD
	oKCJDMdi5TgFvqbApEHGtJTTsah3cjVHA25YfFYOgW4rP/5ovw7LBlF9+fPLq7CF
	r8ACgKPyUGBrZDv6Yxx5Py2EOtK9KiBaEfuOlvZcmg==
X-ME-Sender: <xms:Oq8OZpmNEphzUfcfcrmhgWt8A4L4Nnk5YhINKHdhdd9r5SazKP1kSA>
    <xme:Oq8OZk3cH-oKfcEAw8_DDMgwEMeuohUDg2oD8y37JvZC_NLoY6b1MEuGEbVorOLRF
    tB9_WidU-jJCYizlEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Oq8OZvpS2iMCIrpBX7i6G2Y1Ozp0-i1WaL8I7yh8eGBP_qFayflewg>
    <xmx:Oq8OZplc3fnIXXLrv5t4-17emZiZhRjVg3wgD0tCW5-49B9L1zG1pA>
    <xmx:Oq8OZn2nwYu25M3rFFDq5mhJlsZhjs16FtEop4KRiMjacaD4GqtS8w>
    <xmx:Oq8OZos6Ecw3VpRWfyfv43-cFdmNajbx3FytOXLdFuT4tT3nUwmdSQ>
    <xmx:O68OZgLuC2CpCM8enjn8KVUzNFEAuxjWxF0p38abnoR33b57Ruk8XTQ8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 669BAB6008D; Thu,  4 Apr 2024 09:46:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0046b207-0f81-4fb9-b8d7-42cd69db9273@app.fastmail.com>
In-Reply-To: <20240404153026.2aaa3797@booty>
References: <20240404095755.650364-1-arnd@kernel.org>
 <20240404153026.2aaa3797@booty>
Date: Thu, 04 Apr 2024 15:46:03 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Mark Brown" <broonie@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: rk3308: fix building without CONFIG_OF
Content-Type: text/plain

On Thu, Apr 4, 2024, at 15:30, Luca Ceresoli wrote:
> On Thu,  4 Apr 2024 11:57:34 +0200
>
> Thanks for your report!
>
> The warning has already been reported by the kernel test robot
> <lkp@intel.com> and I have sent a patch to fix it:
> https://lore.kernel.org/linux-sound/20240403-rk3308-audio-codec-fix-warning-v2-1-816bae4c1dc5@bootlin.com/
>
> The approach I took is different though: I have added __maybe_unused
> instead, which has the advantage of not adding a struct of_device_id
> array to kernel built without CONFIG_OF.
>
> My patch has already been taken by Mark. I hope this is fine as well for
> you.

We can clean it up later. Adding __maybe_unused is completely
pointless here, as the purpose of the of_match_ptr() macro
is just to deal with ID tables that were hidden behind an
#ifdef, which yours is not.

     Arnd

