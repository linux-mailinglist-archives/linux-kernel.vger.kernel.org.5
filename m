Return-Path: <linux-kernel+bounces-140346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F00F8A1322
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D971C217AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98E1149C59;
	Thu, 11 Apr 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bnMNR991";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QG58MyLn"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2246441;
	Thu, 11 Apr 2024 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835348; cv=none; b=lP7T3gnCnMgDLUQAq2NKoqbICcGdS8NTU9a8BR+jbNUgAKBCmIfW7ZJ0a86X7HjPwohffO2Be9ozWwtjYcBLXUw7ARq6l0c/bHaNPQ8G7JpsxMsV6CR46y4PI1cAVACHGd9OzLAS548BBTPrBt4vSI2rgAdGA/FXzZV5Bo503Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835348; c=relaxed/simple;
	bh=ajeu2BiA/YKzCiQqdIEBCBbdqVTBmASd7P1eQEFpois=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=K7GM90/Sc1X9PfeVvNl9eeGuVZ9a2AAxx1zaWYcp5zVhLXp3XOfjkGdMVvdYfabRPnP7LweFPGM1Rjw6Z70zTjGgrtWzyhbigaFtbBEgL+jHtEhWvIZzCdXSfvSpAjjK4440FVuuYWvUUjKHHZc0jk/O8/TwGyj41PDAMq9Ut04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bnMNR991; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QG58MyLn; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id CE96D1C000EC;
	Thu, 11 Apr 2024 07:35:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Apr 2024 07:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712835343; x=1712921743; bh=P8MYPGxCIj
	Ne3mVE8A2eowCiRlrk81aBVzAF/rIv8g0=; b=bnMNR991EO/fzRUIlUsUo7ahiu
	qb62PceZ1wtjdl6FRbzcBmg7gFKzadUuGlBJRE0bV15wwLKm31vrzNuFWULKPCwl
	wcjQkawx67wTb/vAIZBFLbLNN0aOe2hBT7QVwO/lL3E/LV/Kuvrfmdt5A+SNBPAc
	DM1PVXuSmOW/0GD2h44GXCT8IghgC93UuE/9icOuJ5Y4kiJSdgqRqs39Z+W7mM0d
	SG/0Rt1Yc0jjGXTZxVZtt3PnVAfICd4d9LgxhVNVVkmweh9dLQzllb7ZUE4SY8P3
	fe+obljMws0wxnjnM1XOTyc8mBbPd8HwG9s2pEbR7bL0G8yD6FGhzuQIf8Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712835343; x=1712921743; bh=P8MYPGxCIjNe3mVE8A2eowCiRlrk
	81aBVzAF/rIv8g0=; b=QG58MyLniWrPS1pdKGAzLbuZ/TMSc3cMAvJv6fC9qIg7
	n0vdzSKsiFVeknrN8QzmosqFxkasJ9yfsPdf5Q5DzWoLxl6XnbfVAeje1BRbLyEP
	fzwKAJMzIkA0hCtoXPOnbksd20x/1APdjag3kZ3/CeGRglyVhIlClPiAUAGIBmdk
	c8o1bACgadLuXbZhaBlv2Me1FomnUpIsYwcU5V0M6eFB+5Q1QGSezFN6O950F7LE
	1/RTJHMWizr3dtkOitvzACSaWG7m9Mhb/vVpN0mSMoQlRIrut9oUQPmU6Kgj6RuW
	i4o6tT2Eixnf01w+L6NMzF1HvUKKDQUUUTU8JgLSoQ==
X-ME-Sender: <xms:DcsXZt7SkqQZSNWmueqinwpbscul48mRYAMyLY3VfUjPy9efgIJBlQ>
    <xme:DcsXZq5YlSx_V8WPlJ1vH7Qekn40x1A1rIahz3v-uBDKDdtWRPpUbbkI9ffbCZKLE
    ATjmHxLUaOh5RfGSug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:DcsXZkduC8UpNHqOK7fnOZGUq8yg-pUvpzwLsPmoK57GIKC94wMTow>
    <xmx:DcsXZmIqSavaJkn4HcDrg3W0wAAHEC_PQgARIaDE8Bwsy9K32XLtrg>
    <xmx:DcsXZhLc1vQcYkF-vFu4UeFeRUocPM2P8q9hCe30iyPNnGummM9_Xw>
    <xmx:DcsXZvx7ska2iapcMuhquoLJjrVHZ7KHN3uLSWJ04-WcC57EeatfzQ>
    <xmx:D8sXZqguWQrev3ZMooMwLrx0i47WEB3gReRZL-o4riD8eSXOTLqE79i3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E7849B60092; Thu, 11 Apr 2024 07:35:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <773febee-ace3-4ad6-8ff6-04563dbbb759@app.fastmail.com>
In-Reply-To: <20240410174540.GB3649628@dev-arch.thelio-3990X>
References: <20240216202657.2493685-1-arnd@kernel.org>
 <202402161301.BBFA14EE@keescook>
 <763214eb-20eb-4627-8d4b-2e7f29db829a@app.fastmail.com>
 <20240409161517.GA3219862@dev-arch.thelio-3990X>
 <f94c6943-eb93-4533-8e4d-3645ef38b990@app.fastmail.com>
 <20240410174540.GB3649628@dev-arch.thelio-3990X>
Date: Thu, 11 Apr 2024 13:35:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nathan Chancellor" <nathan@kernel.org>
Cc: "Kees Cook" <keescook@chromium.org>, "Arnd Bergmann" <arnd@kernel.org>,
 "Steffen Klassert" <steffen.klassert@secunet.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Leon Romanovsky" <leon@kernel.org>, "Lin Ma" <linma@zju.edu.cn>,
 "Simon Horman" <horms@kernel.org>, "Breno Leitao" <leitao@debian.org>,
 "Tobias Brunner" <tobias@strongswan.org>, "Raed Salem" <raeds@nvidia.com>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] [RFC] xfrm: work around a clang-19 fortifiy-string false-positive
Content-Type: text/plain

On Wed, Apr 10, 2024, at 19:45, Nathan Chancellor wrote:

> Unfortunately, I have no idea why it is complaining nor why your patch
> resolves it but the combination of FORTIFY_SOURCE and KASAN certainly
> seems like a reasonable place to start looking. I will see if I can come
> up with a smaller reproducer to see if it becomes more obvious why this
> code triggers this warning.

I know at least why my patch avoids the warning -- it removes the
call to memset() that contains the check. Unfortunately that still
doesn't explain what caused it.

      Arnd

