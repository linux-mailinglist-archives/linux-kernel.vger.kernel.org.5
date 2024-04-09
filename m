Return-Path: <linux-kernel+bounces-137554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A83689E3D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3662281C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC15E157A50;
	Tue,  9 Apr 2024 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="EfW+m/MH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rb1V6qJS"
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54B15749E;
	Tue,  9 Apr 2024 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691697; cv=none; b=rXQ+LbPZ6hLvT38m/hnHDKAeEuqJOoAN8xtHAKryp0tLif1teVtPZ5aNFcbXt0694zJGpZYtznbZK7t8jukzNbJ491Pzg0+7DlJjXrqI7F+jMLhKEUflLb+JYc5MF/UxRlMETDAarqinqldLLciFLZ/6Kw4LLUn1AzJaibulvRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691697; c=relaxed/simple;
	bh=mz+ivdvfJu2xvIClgoV0DYYhljRVDMHl7FLu7Sohooc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=o/cJOL8nCFaU/ChqnERJbMKMlPb3uW1I9DkequHddzyi5KcuBtDkbBcYS7mzkLplvamu+MrKnXOAn+GW80uPHu/9e2/p/3ebfYx/KlrEz9XIQGKxPu5VOIpHlOKGUUml7D0gdDm7XT8YO11Yz51UhrGuzNrcQahZgdq1xM5GUYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=EfW+m/MH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rb1V6qJS; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id C91921C00099;
	Tue,  9 Apr 2024 15:41:33 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Apr 2024 15:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712691693; x=1712778093; bh=tr06fHvNZN
	R9qLnaA0dmPX0JUluTiub3QurVgyRyKZs=; b=EfW+m/MHJuGNp7wXiicYMOS8Gv
	We8w+3YSyD4clKI2gkcpD2WNcM0lQ9rd3MZpLFaCfYJG/zaBs1ebm5M36gKoh32W
	m8ZJcu4hezY4WiZYb3o6qwEVNUvpBCHDrkWbW3iCekIOgfB7UgaSRvDaQpWd/eT1
	sfO3+wrjTi8XIaSfXXbtDJSaZD9/zJurHdTgcqF04AtwZ51AOeZxhY3TcBdjVtSv
	uSEOpvZD1vQ4QxdJGvAMTfM1h/FkXk7rUpHnLIGqN880m2sVYRMZskVlQ1eEp9/Y
	F0hGlWQ0lZq53kXiJiT/jTm1nfOXIhA+dpOh5yIY9SOi5PQI0HH1BdEo6hpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712691693; x=1712778093; bh=tr06fHvNZNR9qLnaA0dmPX0JUluT
	iub3QurVgyRyKZs=; b=rb1V6qJSNgbGGdqQQU9F4tJTo59+boX82uQrHnvyee53
	veZDR6VeYq32/e8LTKaRr7pPjNZ4sRR9J3ZeagHdbOsuwPNCJB+i5T6AD02wBzKw
	uS1Onk40A6IKHwti7aQ859+qrruqGLO8rvf+aoTy49lKEOgc5qsup5BVTqoYXIYj
	8XOslqgIJg1aINSMFq4Yu31JdQehXDuDlcNb2MNcspoi8dpIoB+7vBoUAAeRPOR7
	5yBMC0YW1Obp+fRUbQr42UFD1bQls9AcbXAlSJje87gOmhNum4UaBVqJvpQW/gmn
	4CfNu2/KcxrVy+E2y8lCyrnj5L96+LZbC+4NuK3mvQ==
X-ME-Sender: <xms:65kVZuzRHlJqdc8gdCzRnkf8Q5ICABlpTnwB__2u8GKHgUS6o_S3vw>
    <xme:65kVZqSFPx1AOaA9Ahf5D6FhxcO6mVb__3arlEEMbfd5rSJVuxA7OhxWfv8NLrAsp
    rfqUMfSyy6s8tMnZXI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeetiefhjedvhfeffffhvddvvdffgfetvdetiefghefhheduffeljeeuuddv
    lefgnecuffhomhgrihhnpehprghsthgvsghinhdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:65kVZgWXrehyrpr_yQTpXeJMDMlXSa5f93wRP0adgsABvMDmPxO8tA>
    <xmx:65kVZkg3F9scO3itqMlmUro250T6g6FD2KHWCAUPmBb7jcXTNzrZXw>
    <xmx:65kVZgD-MMeK6JG039kFpxTCq9eOS2IsuXw3zwG-6svuTA3ajUKJbQ>
    <xmx:65kVZlLC9nycoVuLJytyvSLwJdZF5wGT69HIPkEJagB0yKXdiv_CXw>
    <xmx:7ZkVZi6U0iWQBsONeDhxJFwA3KH0jkXBGDvxYYDjJukURMTilmxli-Pj>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0176CB6008D; Tue,  9 Apr 2024 15:41:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f94c6943-eb93-4533-8e4d-3645ef38b990@app.fastmail.com>
In-Reply-To: <20240409161517.GA3219862@dev-arch.thelio-3990X>
References: <20240216202657.2493685-1-arnd@kernel.org>
 <202402161301.BBFA14EE@keescook>
 <763214eb-20eb-4627-8d4b-2e7f29db829a@app.fastmail.com>
 <20240409161517.GA3219862@dev-arch.thelio-3990X>
Date: Tue, 09 Apr 2024 21:41:09 +0200
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

On Tue, Apr 9, 2024, at 18:15, Nathan Chancellor wrote:
> On Mon, Apr 08, 2024 at 09:06:21AM +0200, Arnd Bergmann wrote:
>> >
>> > The shorter fix (in the issue) is to explicitly range-check before
>> > the loop:
>> >
>> >        if (xp->xfrm_nr > XFRM_MAX_DEPTH)
>> >                return -ENOBUFS;
>> 
>> I ran into this issue again and I see that Nathan's fix has
>> made it into mainline and backports, but it's apparently
>> not sufficient.
>> 
>> I don't see the warning with my patch from this thread, but
>> there may still be a better fix.
>
> Is it the exact same warning? clang-19 or older?
> What > architecture/configuration? If my change is not sufficient then maybe
> there are two separate issues here? I have not seen this warning appear
> in our CI since my change was applied.

I only see it with clang-19. I've never seen it with arm32 and
currently only see it with arm64, though I had seen it with x86-64
as well in February before your patch.

The warning is the same as before aside from the line number,
which which is now include/linux/fortify-string.h:462:4
where it was line 420, but I think that is just a context
change.

I have a number of configs that reproduce this bug, see
https://pastebin.com/tMgfD7cu for an example with current
linux-next.

     Arnd

