Return-Path: <linux-kernel+bounces-63376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6ED852E61
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F71E1C22B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBE628DCF;
	Tue, 13 Feb 2024 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hdWJrUS8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G02pROHA"
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFC422636;
	Tue, 13 Feb 2024 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821598; cv=none; b=WL6K0LxBcFkZ8GedHKnzeEqBAGTGOpXLR3ev93/9N0XIe0zqRTTkbzul7T3WKP6B7vGLWPZXOD7OHak8I+5g65yV5+Yd/E4YAVf0i1q8TaYguOA9WzR7p3L2sy9rxjeSTfBcQKdMCRbohCBjYBGurbP6+FUOQ7NZl1zybycXpvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821598; c=relaxed/simple;
	bh=+JnBgDGOZAp2YbrH6cwJtYEtXr9eH6MJ20r1BkDzDXE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=BcLAnGt3JZVKZyCsvc7CUKY/bbqDfKIfarhIcZthGOI46CjrlNHk8CbDJ4Nga71rV9pjyG2+Gkhpt5d6zGyUkFxdIWfef2r9h3Wgbmv0fOT91Cha/QufJMlUrMMAbumzghtc5SeGtA1RiveV6YTPCVqNCJyboiA7YpO6lm16TO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hdWJrUS8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G02pROHA; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id DE8C01C00087;
	Tue, 13 Feb 2024 05:53:13 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 13 Feb 2024 05:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707821593; x=1707907993; bh=6dv3XkVpsh
	WAdzS8Nc4Xo0CoQTmrm60p1TUc7YC2Dao=; b=hdWJrUS8Cd51e7g6sHyMhMiCxv
	IDWxmxNLFPEiqY+2GMkGyjR8B8XSgya46SGAtMuyBQ/eW2An26StdfkpA6wC8S6g
	LuJTGDhGXLsntq83AcJAOtuW98rfnCbKxncDN3QVgRbDxMvaPmCq57xQwVgR2I7H
	+UlLZ7ltgGP14MFBIcNnSK/dS7wb4+Fi72zXXwTBbOxaVaot+dbzoa4ScEVZGF3w
	gSxd5R5MMAG38ir1USb5rRVnvmlzFvdPU6idyu6sNe9GkY2HAl2MNhEmDSwnux4Q
	VmGCD7B9Ruxsgy8d4UdVCKlPPG6k0z3ndm78tVLasKcstligOWQlDT3eEbbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707821593; x=1707907993; bh=6dv3XkVpshWAdzS8Nc4Xo0CoQTmr
	m60p1TUc7YC2Dao=; b=G02pROHA+7jjMd7tHb5W9Mk1RHyKHtv+aGTn41ZLW0fH
	TeDGVYBX5dqUePSIxI0FC/zSx8psmAhZsU2w2xqEZpYNMKtCAqUppnDdcxNKd/Gq
	t7v7HDGf+wTfHKW1oIRp6dTsyFDFkIRBYLeHpQbB1dDWdAtwyFaa3Od+5wWJq/y4
	YHhUPnHwW4mbW4LM/+uL4x21bUnKQya075BRbFDcNy3bqfseqZn4J+EZ8HMwvQqe
	PUeKkR8Ve8iedu7wfp4NfaMD9/aiHMqWwUB8UdvLekkwgqMFJbu6IAnZOAIWOjYW
	Vw7e7GDFqI6KFb/+a/V/Ofa27HmNYxUzVwGh1D7xYA==
X-ME-Sender: <xms:F0rLZb_1q4NKRMH-XXweuv45E4i6FkWcds3C1qZ80Ws1TMhlCedt-w>
    <xme:F0rLZXtYCwVkCjihBn9E_icVc9UEUFEBcYTprGOvxx8x770weQ-EuImCYvFjUiE70
    vTv3049MW5pipRXSvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:F0rLZZCGF4p3x0Tli4MvIOHCz3GP44OMlMiAIBqdkgchzB1cmvLNvQ>
    <xmx:F0rLZXcXjSCXz4H84WVOn0iFRqU4fNWpZD2PIwaO0L4RzJF_UJ1o4g>
    <xmx:F0rLZQOsH68J5cLPZ8MzFdW_2JYHAoCTzJJ6bmTQV3gsg88zA7cFDA>
    <xmx:GUrLZRxiq9tjm-VczEMhcII7VaYv9BO8Xu8yf6vQZFSyb0aOzroxWDV57V4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6BDE7B6008D; Tue, 13 Feb 2024 05:53:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c61d7daf-1b13-4ff8-aeae-7dcd8dd02131@app.fastmail.com>
In-Reply-To: <1jbk8kk5pk.fsf@starbuckisacylon.baylibre.com>
References: <20240213101220.459641-1-arnd@kernel.org>
 <1jbk8kk5pk.fsf@starbuckisacylon.baylibre.com>
Date: Tue, 13 Feb 2024 11:52:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jerome Brunet" <jbrunet@baylibre.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Stephen Boyd" <sboyd@kernel.org>
Cc: "Mark Brown" <broonie@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Kevin Hilman" <khilman@baylibre.com>,
 "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] ASoC: meson: add helpers for clk_disable_unprepare
Content-Type: text/plain

On Tue, Feb 13, 2024, at 11:36, Jerome Brunet wrote:
> On Tue 13 Feb 2024 at 11:11, Arnd Bergmann <arnd@kernel.org> wrote:

> This probably pre-dates the introduction of devm_clk_get_enabled()
> It would probably be better to use that instead of duplicating helper
> functions which do the same thing.

Ah, I had not thought of that interface either, so you are probably
right that this is the best way to do it.
Can you send a replacement patch then and add my Reported-by?

I also sent the same patch for drivers/nvmem/meson-efuse.c, which
I guess will also need the same treatment. I also checked and saw
that all three files already had this code in linux-6.0 when
devm_clk_get_enabled() got added.

> If for any reason it is not possible, a common helper in clk.h would
> preferable I think.

I can't think of anything that prevents us from using
devm_clk_get_enabled() here.

    Arnd

