Return-Path: <linux-kernel+bounces-17945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E64D6825579
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C82A284E72
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C429F2D7AB;
	Fri,  5 Jan 2024 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AQt5b4Tj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4r1fPsMF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219F72E637
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id EFAA75C0231;
	Fri,  5 Jan 2024 09:38:49 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 05 Jan 2024 09:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704465529; x=1704551929; bh=PuOOcZVM21
	gvZ/ZF8zREl/JKU6SeL7edQiXakF+8FHU=; b=AQt5b4TjoaXbIqqk+EIOMW3nQF
	1OcKuXI4BGV7jzrmJthiTnnHKnrKWuceIG0GdPIcS7Mcm9IPXB0rMoVzzcu4UDLa
	D7QPJeYD43bo/oxgA8TGSw9DNPq8yl4UMdjYTwd0YqIF+adIS8bgsISYYkFrIig8
	ul4YIeGGqb4gFapfgO4elo/XaE8GNwL7FJMstTFsZqPea6xkB/s5TNhnyUGaAuyP
	ld/qZ58QjkR6Bo9hEanLlGyjIiQM/4yp7RPCt/cPAI+kud6izBfyHBHujjN8oe6J
	fvZ+2AbNFS5/e9baqyhG0y50v50OGZ7Fb1j3bNmcqLzJL1kGhaUGP9mTm/4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704465529; x=1704551929; bh=PuOOcZVM21gvZ/ZF8zREl/JKU6Se
	L7edQiXakF+8FHU=; b=4r1fPsMF4dW2iF6HVH/EQsinrQBd693Tq0Sj/tdhj+lb
	AFEkVyANLWrneduMVfeiIU740wFd1SXM/NuhC3LaUtGUUGi9k5AfnRWOkGgCFZdZ
	7ceeYow6GXMi5i2QRaUCkXFodAdjJmtJEsmuVUS4JnLATyj9/DJ5CbQ+tQhF8GV7
	wHVzDaRyo7w03GWZ9y4O9MZfenMrk+qxIhey+qSDEL2fHfHxsQZB0vLeUpi53wzT
	kj4mNaqi2Y8hMWLVawdAzmFLvVbfM2qifM9D7RXfcWcVrbbM86znvoUFWs892/WS
	maLObG1REGIqR3sw0TDyW1xJMa+rekwLtG5c62yhlQ==
X-ME-Sender: <xms:eRSYZfccVNA6w5utR-zSp8ohxATnxxTZMGKftE5JBsOnhnJqiKH40g>
    <xme:eRSYZVNbgHNeT5hX8Ji07oQCvk2NRlpas7cGbgE-mNC3FXsjeFzZWMIw1VeDuddBp
    XxC6Yi4BPfRQAuskok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegledgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:eRSYZYjMl6HS3vJS3Iftm9EstMyWxjAyuNj6GT9f7AHQ40EMKF-bXQ>
    <xmx:eRSYZQ-yp_HBlOCup457FhcaL5pmJWKpBAYw5fYZ3IBwP3EXq3bXaQ>
    <xmx:eRSYZbsOePL8E4QEwL2tobFRjH93RXVZw4mhLA5F3_hexmqdxn1big>
    <xmx:eRSYZU9gU8gw7xJFlGqHD4oQ_md2edAdoZRTXWJDZyfmzMO3sS6r4A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5FB43B6008F; Fri,  5 Jan 2024 09:38:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <112ae7d5-61b2-4887-a56f-35ea7c3b1bfa@app.fastmail.com>
In-Reply-To: <ZZgAtntCQFKbsGiW@FVFF77S0Q05N>
References: <20240105041458.126602-3-leobras@redhat.com>
 <ZZgAtntCQFKbsGiW@FVFF77S0Q05N>
Date: Fri, 05 Jan 2024 15:38:05 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Rutland" <mark.rutland@arm.com>,
 "Leonardo Bras" <leobras@redhat.com>
Cc: "Oleg Nesterov" <oleg@redhat.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Mark Brown" <broonie@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Guo Hui" <guohui@uniontech.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] arm64: remove unnecessary ifdefs around is_compat_task()
Content-Type: text/plain

On Fri, Jan 5, 2024, at 14:14, Mark Rutland wrote:
> On Fri, Jan 05, 2024 at 01:15:00AM -0300, Leonardo Bras wrote:
> arch/arm64/kernel/ptrace.c:2121:25: note: each undeclared identifier is 
> reported only once for each function it appears in
> arch/arm64/kernel/ptrace.c:2123:25: error: 'user_aarch32_ptrace_view' 
> undeclared (first use in this function)
>  2123 |                 return &user_aarch32_ptrace_view;
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~
> make[4]: *** [scripts/Makefile.build:243: arch/arm64/kernel/ptrace.o] 
> Error 1
> make[3]: *** [scripts/Makefile.build:480: arch/arm64/kernel] Error 2
> make[2]: *** [scripts/Makefile.build:480: arch/arm64] Error 2
> make[1]: *** [/home/mark/src/linux/Makefile:1911: .] Error 2
> make: *** [Makefile:234: __sub-make] Error 2
>
> ... and looking at the code, user_aarch32_view and user_aarch32_ptrace_view are
> both defined under ifdeffery for CONFIG_COMPAT, so that's obviously not going
> to work...

I suspect it's enough to remove all of the other
"#ifdef CONFIG_COMPAT" checks in this file and rely on
dead code elimination to remove the rest, but there might
be additional problems if some extern declarations are
hidden in an #ifdef as well.

    Arnd

