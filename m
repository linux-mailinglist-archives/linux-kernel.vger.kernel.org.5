Return-Path: <linux-kernel+bounces-105295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A147087DB88
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 22:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD64B21190
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 21:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1C21C68D;
	Sat, 16 Mar 2024 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kl4fgSWF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26FE1C29C;
	Sat, 16 Mar 2024 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710625032; cv=none; b=e/4n0Z8OIyWqGOxFV8iH/xnAPGX3Bmuc3IaZ5YJaCZm/CtnL5pCXbPRZjDH9X6oxF2XaIBwo7+/N6eY4v5jyvpLRoJgWLoZrej/S8/I8ZY/ceWUUlCK/EFMo+Uh1Ks6Pfs8ucE63O1rLqOyfFp0aE4ZOyQ7yLz5OUKPXw4zTB44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710625032; c=relaxed/simple;
	bh=GKKge2ecLnpGrZsiljqV2+mUEsMSfr3X5lirRlPQE+k=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ogSmR9o9kTCPT5eAm8QXWT9jGiIUgeyhocTZgJ9GOmLINJih15V3OeJmqFz/HDkSaPpHv0CpYndrign3f2hWyNhu33yO7dMxhB7jMqnlo7mMpesKRVM5Cx30YBPnVqEAtSuIlcPH75T2Oda4f93WA3aKzLeJq0k1T95+st7Fk/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kl4fgSWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6C5C433C7;
	Sat, 16 Mar 2024 21:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710625032;
	bh=GKKge2ecLnpGrZsiljqV2+mUEsMSfr3X5lirRlPQE+k=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=Kl4fgSWFgWtaVAOeHm1HAn//iH9iEyrNUF5aUPW6UOF1jIDY5CtIEqD1IYHKfgTdP
	 pR6hN95eyokzTS0ojBfdov1NBid0Ni3N8w00NZvrxFCb3XvOVMbtHHFNyKrvfYUy2N
	 05lJRMVxypa1q7gfNzrLr8EyU6oBxVJCZRXSuxEHwuMAKeICQOqBESuOo+qzUiWgJ1
	 Eg6TkM2ZyikbJrvG6TkbB2ZmTWmUQs4Rtni8JXoHo9CE3wE8H0tZl0/et6sGgfctzO
	 fwzipZoNv3676sIwo8GmNiApnTAa22L5Rj/EnFhqj1H+E0lXTEj3yknPWETVdo2KJF
	 PGGXoRMpxqaUw==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id C94B11200068;
	Sat, 16 Mar 2024 17:37:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 16 Mar 2024 17:37:10 -0400
X-ME-Sender: <xms:BhH2ZemPk5LCSrTUfoBHrvsrAzb9r8iYilzL1wGunHX_ew0rrF0gdg>
    <xme:BhH2ZV244fw9phq3i96tQU00JJgUp9XLj_WqgCD0W7sIDtRVDw703o0MIThKqZQrR
    dT5vC9JjMuuCGG9Q6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkedvgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepleevgfduieehfeeltdettdfhfffgkedugeeklefftdeivdfgveeiteet
    keehffevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnug
    eppehkvghrnhgvlhdrohhrghesrghrnhgusgdruggv
X-ME-Proxy: <xmx:BhH2Zcpl2woLcQtdi-mH7wrnnwll9EwDMxcqCyAeb1uJ_gX5xV8aHg>
    <xmx:BhH2ZSk_-QPWPf6NYNuSo0ko8xRrZDNd-Hn4AoF2FqEH0THhYBVaUg>
    <xmx:BhH2Zc1-7qN4NjTdcFD16628Zh0gqRTV-XxP1pjAkzoh_mK2ooN1NQ>
    <xmx:BhH2ZZvHWj5L5ISJTH3gxKwZlmEENcjogaxWoB4foyjZ6mgwpNvMJQ>
    <xmx:BhH2ZdJUt4_xLTp5NgMQPpuXm1xcJO4j_zwHsI0A6xO9JXxPHjRv2IW8Yr8>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 365F2B6008D; Sat, 16 Mar 2024 17:37:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dd494544-6dbf-4e83-8060-1f8b7b07a8c4@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wg50AGnzhmOK0TNqDN99T3dWd747h3y-ZFuv4bNZ4Q0tw@mail.gmail.com>
References: <20240303235029.555787150@linutronix.de>
 <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
 <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
 <87y1ajjsv9.ffs@tglx> <87o7bfjeae.ffs@tglx>
 <CAHk-=wiP+XMGHr8NU13sSOG_oasNZN02O9_c1PzCJNG7+O-GPw@mail.gmail.com>
 <877ci3j80k.ffs@tglx>
 <CAHk-=wg50AGnzhmOK0TNqDN99T3dWd747h3y-ZFuv4bNZ4Q0tw@mail.gmail.com>
Date: Sat, 16 Mar 2024 22:34:55 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Linus Torvalds" <torvalds@linuxfoundation.org>,
 "Thomas Gleixner" <tglx@linutronix.de>
Cc: "Guenter Roeck" <linux@roeck-us.net>, LKML <linux-kernel@vger.kernel.org>,
 x86@kernel.org, "Uros Bizjak" <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org, "kernel test robot" <lkp@intel.com>,
 oe-kbuild-all@lists.linux.dev
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
Content-Type: text/plain

On Sat, Mar 16, 2024, at 02:23, Linus Torvalds wrote:
> On Fri, 15 Mar 2024 at 18:11, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> You wish. We still support 486 and some of the still produced 486 clones
>> do not have a local APIC.
>
> Ouch. I was _sure_ we had dropped i486 support too due to cmpxchg8b.
>
> But apparently that was just a discussion, and my wishful thinking,
> and we never actually followed through.

Maciej Rozycki still cares about i486 type hardware, and he was
asking for it to be kept around in the thread following [1]

I think the best suggestion at the time was to make cmpxchg8b
a compile-time feature and I had expected Maciej to follow up with
a patch for that, but this never happend, and nobody sent a patch
to remove support 486 and the early 586 clones either.

I saw recently that there are still distros that advertise 486
support on modern kernels: Tiny Core Linux and Damn Small
Linux. Both ship with a 486 SMP kernel but fail to boot
on qemu unless an APIC is enabled (DSL also requires i686 or
higher to run userspace).

       Arnd

[1] https://lore.kernel.org/all/20220815071332.627393-9-yuzhao@google.com/

