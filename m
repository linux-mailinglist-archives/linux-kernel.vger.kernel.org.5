Return-Path: <linux-kernel+bounces-52343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD468496F0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68F8DB2728D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD77134B2;
	Mon,  5 Feb 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JVQQRWEe"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E11134AD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126524; cv=none; b=NmucKSP/0LrXgnYExuVPnOOUseUQrCKqQfTP4XRx6onK6H/nuXqYjxwW8FqWBXb4uUpRWmdlHlyWZ6Vmr5evtzLOYzad4GO+9vazsZrumE8tzIHmeeusSgtOtpboSahqnR1hANZqcgLAv72CjqYtsGnQpZIh/+BgnENmd1StGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126524; c=relaxed/simple;
	bh=Hf4odG5wn7R54sc/WswXFwxztiof6WIDGhFtOxaGJzc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i132xNf1F5XrQ4Rg35aQTQbZPJuLSpxwMeV+RI4FyNIxSBIue32hIlMQPofgEkSvDowS0hLdR4rduGfe/70dNiC3R5QT0jQ511Hdknpq0wPliTQJitvhQHErk2REiPMC5unNhum1sII0kI8NPYoMXY40lk8MGa5o1b1vCtUcm2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JVQQRWEe; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 95CBB5C0112;
	Mon,  5 Feb 2024 04:48:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 05 Feb 2024 04:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707126520; x=1707212920; bh=4HXHrHNRaH/IGLDh84/hJNfQKsbt
	Ooowjsd4egH2tFE=; b=JVQQRWEeOYnEhibTNuIBXSMWoBRVPo9jQIn5cPeafI9B
	t2aqtg/oyijjW33uoMbiCMaiPTVr0nx07m5RPDE1WnkpYpFDga8RilOqjh0S6zU6
	TxjgKabtOx+vNkMTnA0czdlykdQKLIkNFpT1b0sp5TE6YbWDyElhf3LiNP0ls9KE
	IcdzWpSeGKC9fztMKc9lNF9i8d9pdZWqYXN1tKLYtSSPecCdeIrjy99+9n9s5/Kp
	HUfYyx0L4nq3KGkIqVamdn0aD/TSauVorrkyLz65RhSlKnOGgOcEU27Jc/J7+WKD
	ckAR2DuhVzxooOymrNpUI1twU74iaJa9jg4q1Ips7w==
X-ME-Sender: <xms:967AZRIUg7WFtLxi5TS-MvjElePolX1QJzDGFXN5axAWvkPR9OCT2Q>
    <xme:967AZdLTZXHJ3SbZcYmqfj2E4fRigq6SbKcb_hA6PZpUn0HpyyqGX4JROsSxgi2Vx
    b7sZXYrQ9Md1TevomE>
X-ME-Received: <xmr:967AZZs0oh07aXjL-pfl4gZoWbG7Hn7oNFQhSfMDDxqAt3xuAjN2zYxbwcpWIZFD9uiRsKDU0fW-GjcEfNRIsY-AvwfOJJl4VSI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvtddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:967AZSYUG4cMTnsSNelO9mbuPgrtrV6GemDreiAoalUGxJu00gKjCw>
    <xmx:967AZYZ87Z3Ytff1-xBzqLFWMC5by-if_CHhN824ahT-hDSR0PyNHg>
    <xmx:967AZWAFbRw-Q53LURCgAix7aAd3w9ZM6_PRh9HkR3BAlA8wITB2EQ>
    <xmx:-K7AZVIGGQkwvzSxWmKB3L5DnOspGn7cwf2jAqPpMOuYz7ODSMWcFw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Feb 2024 04:48:37 -0500 (EST)
Date: Mon, 5 Feb 2024 20:48:52 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
cc: David Laight <David.Laight@aculab.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    Yury Norov <yury.norov@gmail.com>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Douglas Anderson <dianders@chromium.org>, 
    Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>, 
    Randy Dunlap <rdunlap@infradead.org>, 
    Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
    Geert Uytterhoeven <geert+renesas@glider.be>, 
    Marco Elver <elver@google.com>, Brian Cain <bcain@quicinc.com>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Matthew Wilcox <willy@infradead.org>, 
    "Paul E . McKenney" <paulmck@kernel.org>, 
    "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH v4 2/5] m68k/bitops: use __builtin_{clz,ctzl,ffs} to
 evaluate constant expressions
In-Reply-To: <CAMZ6RqKx=EO9kcOmxRyBuhULdDyTCeAXz25j_uF7TSy72Jahpw@mail.gmail.com>
Message-ID: <00a7e866-23ff-fc63-b6df-364580f69c78@linux-m68k.org>
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr> <20240128050449.1332798-1-mailhol.vincent@wanadoo.fr> <20240128050449.1332798-3-mailhol.vincent@wanadoo.fr> <c47fedaf-cdc9-f970-460f-d2ee7e806da4@linux-m68k.org>
 <CAMZ6RqKj207uv5AF_fvb65nhCM32V=VAQXsUGLNmbeXYKPvZJg@mail.gmail.com> <9d9be9dbe92f43d2a95d11d6b2f434c1@AcuMS.aculab.com> <CAMZ6Rq+RnY16sREhAZ6AFn3sz1SuPsKqhW-m0TrrDz1hd=vNOA@mail.gmail.com> <77831c6f-7fc9-c42d-b29b-c3b2f3f5e687@linux-m68k.org>
 <CAMZ6RqLyRxvUiLKZLkQF1cYFkdOqX73V2K=dGbNROMDj61OKLw@mail.gmail.com> <002675b0-6976-9efa-6bc5-b8bad287a1d2@linux-m68k.org> <CAMZ6RqKx=EO9kcOmxRyBuhULdDyTCeAXz25j_uF7TSy72Jahpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Mon, 5 Feb 2024, Vincent MAILHOL wrote:

> 
> This is why I am asking whether or not clang support is important or not 
> for m68k. If you tell me it is not, then fine, I will remove all the asm 
> (by the way, the patch is already ready). But if there are even a few 
> users who care about clang for m68k, then I do not think we should 
> penalize them and I would not sign-off a change which negatively impacts 
> some users.
> 

If clang support is important then clang's builtins are important. So why 
not improve those instead? That would resolve the issue in a win-win.

