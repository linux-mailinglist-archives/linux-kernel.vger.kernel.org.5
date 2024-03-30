Return-Path: <linux-kernel+bounces-125669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 874EA892A60
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16EE8B21BE8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02BB29424;
	Sat, 30 Mar 2024 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="W/H5UHy8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p0ClvWXu"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AD61C0DD5;
	Sat, 30 Mar 2024 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711794000; cv=none; b=tgiUxWqnZI0E5fqgpa4bkTMUN1k376e3NOWiUAeknQBFSF4TBlKPiTkIBCYaFctc+U/QJQXsJ2E0NUeXyqi19o19qJ7Pn+KSlXYJ6CuEPqb0PHUzhRSRPrMaxiVF45OmumQugtkeHFeCHE7zhsDKo/Ga1Fh8ySAe1e//GK4uecw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711794000; c=relaxed/simple;
	bh=MhKZZ8Mjj6u+jepgsjCGC+XkNcSBwTwz5oCrL8z0nic=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=RzSSW+Sl+hY6n/sNseJ39V6rzkCg50aKZxX/FUfgCmGckUXnD9+yELmAh6/bQvkD+/9bUqs6INEhLL67+wBDDzpMmNnaXaL7tOAtxu6mKiuFlWLt7pbflyDj9A3TgyREK5/Kda7IrtgTAnbzLfA7UnUQhPRy+2j90owSPFIYA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=W/H5UHy8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p0ClvWXu; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id F2F5D13800A1;
	Sat, 30 Mar 2024 06:19:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 30 Mar 2024 06:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711793997; x=1711880397; bh=gYQUywggWk
	t3lojA/q48Eke62WZWW42/D/zhK3t7AWw=; b=W/H5UHy85C1c8XawRzQvt85Lm/
	8h+VMnftbgWUO+MfezKNPAp/pdPG4DehGuvcqax/DhFeRns08LKcMa4QVSkDpmhp
	+9N9UC8+0r12z08Fxqizls1IgRj1NpVmJ5ycMPMHKaKFXrn+tZt0g2et25c61v3l
	tUFlxnn1K74PhE1AnqZwGOWnDzMAMg+E8vRP6oNArmS7Mmk0adSITqnnAF6lu3uh
	w9KP4yhTEjzubH0GLuhDCCGMMK4xz+gGVyT52f2tiD9B1OF9UOS2xDon/l1IOY8Q
	/bSAvJOuDb+bQzwj3bqBew39vZEd0l3AfJq0w7UZVTi/WMfd4s40x0XA99Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711793997; x=1711880397; bh=gYQUywggWkt3lojA/q48Eke62WZW
	W42/D/zhK3t7AWw=; b=p0ClvWXuOzrCt700Nosc8cBW8iYRjph2wMSHS+DHp+W9
	c8xlEfLYXMXjqfyx/h2ZhnbVdx/7zBujVzcVnvFPlZooMiccI8joNbOedFy2qJ0J
	qhXXJ/elB5Qt8kPMiLZxtBz3U//XjOQTTFClkNm7f4pC1Fc3i2KKQjOax6wTuf4j
	dSkTEfb606PDaWb1OlGcLnOMx56yjsHqfU5g/ugpdJf3UfHYWcS5+XRymT9aampo
	Is8jqqj6XetL4cCnANRgZEMHH+zeDzWDwDDvvSvvKSreZP0YTUK02M0JVkDAp+lT
	ytxQ/JyVdNfTWcGrg5LbkLFmHZ2AZ2bMmY7cSz7W6w==
X-ME-Sender: <xms:TecHZoDjf4TNNKEtu6Ai-Q-O7dUMWufKcaqXNum15joB87Ivq6fJ2g>
    <xme:TecHZqj5zlKtThTOD8QSqRU8nUoboGrvflLobQV5K3nmyFltxWD2ugXyrrFKToZX0
    Z2xfurxQzsi6mGjRVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvgedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:TecHZrmUrQS_FaqJzpRHfaNiFce7GSt5lPOh-6ESS4wwPKzxKd3BrQ>
    <xmx:TecHZuz09b75CwNZfFqRl2qmechWqKb0_jRj425tBlUHEOoeuOW6jg>
    <xmx:TecHZtQUmfb0_k3vS9XN7udXCARxjjah20UNTVqAM5tKAsHZalnMKg>
    <xmx:TecHZpbyOhQt5GcIpp3TQo4TA5b5W0KIF1mLzd2Y92apAq6aHCluoQ>
    <xmx:TecHZiKEfk8lbjgeqTt6qCbVaNMxXwecbcdZK4y0_BuiSP0LdR3LvA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AF635B6008D; Sat, 30 Mar 2024 06:19:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4e57929b-1539-4a25-ab05-a2a9e04ecc1d@app.fastmail.com>
In-Reply-To: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
References: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
Date: Sat, 30 Mar 2024 11:19:37 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sam Ravnborg" <sam@ravnborg.org>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: "Nick Bowler" <nbowler@draconx.ca>, linux-kernel@vger.kernel.org,
 "Atish Patra" <atish.patra@oracle.com>, stable@vger.kernel.org,
 "Bob Picco" <bob.picco@oracle.com>, "Vijay Kumar" <vijay.ac.kumar@oracle.com>
Subject: Re: [PATCH 00/10] sparc64: Fix CPU online bug and warning fixes
Content-Type: text/plain

On Sat, Mar 30, 2024, at 10:57, Sam Ravnborg via B4 Relay wrote:
> Nick Bowler reported that sparc64 failed to bring all his CPU's online,
> and that turned out to be an easy fix.
>
> The sparc64 build was rather noisy with a lot of warnings which had
> irritated me enough to go ahead and fix them.
> With this set of patches my arch/sparc/ is almost warning free for
> all{no,yes,mod}config + defconfig builds.

Patches 1-9 look good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

> There is one warning about "clone3 not implemented", which I have ignored.
>
> The warning fixes hides the fact that sparc64 is not yet y2038 prepared,
> and it would be preferable if someone knowledgeable would fix this
> poperly.

The clone3 bug has been around for ages, it's probably not even that
hard to fix and just needs a little bit of testing.

If anyone wants to work on the time64 support for the vdso, I can
explain the details for how it's done.

Both of these are real bugs that should be addressed, unlike
the other warning fixes that are mostly cosmetic aside from
allowing the build with CONFIG_WERROR=y.

     Arnd

