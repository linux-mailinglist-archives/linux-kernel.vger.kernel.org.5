Return-Path: <linux-kernel+bounces-6771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA26819D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561E11F26FED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DBF21103;
	Wed, 20 Dec 2023 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jygdJwpM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C2A20DCE;
	Wed, 20 Dec 2023 10:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678DEC433C7;
	Wed, 20 Dec 2023 10:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703069295;
	bh=affP7wF8+XMw8uG5v8noirtoXKryiDk9LMZdxtuSBpQ=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=jygdJwpMqP5HaPdqtLr763HT2ZDYZrxZ19woJaNn3MAv/R+EJh9OXdBtNGOBKcPRK
	 VgEegAEhPxLXA999Ua6+XSfynxz286Hjc/w519TvLk3a7lFHOC2m8lXyDxfqgx2H2h
	 GfSwX657HUGr7cZB7VX0uAuplho2Lx2/zyxDhLbbGfd5ArXJdad5QUrGIO5UvB1sTv
	 gS9mhhkayTJRL8smWjguOzRG0JH8KzOduDUv6DZYmGxRvrzGo7b2TQaGZN5m5bKqtx
	 55X6s2/AJ2v5F4fctW2HIBRTotbKnPAzyJjE/5vgE9PA45p+4eoxWYFZLF0/6g0F/E
	 9c3nNxe9gQLOg==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 59CCC27C0061;
	Wed, 20 Dec 2023 05:48:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 20 Dec 2023 05:48:14 -0500
X-ME-Sender: <xms:bcaCZa-dYaDSNN36puMBjYL2UZjPu7XIDmrS9ZbAtZmLOLHzRsRkmQ>
    <xme:bcaCZat5hWRhwFchay4HQaiInMmMJezm4FaDG4D7qWJ-QMer37ZYU0DBDBILQhArg
    4Ew8i-upCvuurJzD3s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepgedtudegtdejhfdtjeeglefhhfduhedtjeejgeegieelgeduudeiueev
    ffetjefgnecuffhomhgrihhnpehqvghmuhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnugeppe
    hkvghrnhgvlhdrohhrghesrghrnhgusgdruggv
X-ME-Proxy: <xmx:bcaCZQDIKCNj7awbmv8GAKA4WgNCD1CdNaOAL918zpCfYGwv1bP6tQ>
    <xmx:bcaCZSeU8EDkSAwPx0LydaLR2A-g-Npf-ECxnOrW3cDEcyCKfKWFCQ>
    <xmx:bcaCZfPiwW0oa83V1FG959Vcn7M1gbIp-lc-37NNQpZjt5Ir6z56Yg>
    <xmx:bsaCZduisMTzT6YuRGasRasp3nG8XGAP5iAFXKnUBRYcf05Nq05azg>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5080DB6008D; Wed, 20 Dec 2023 05:48:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dbb60b13-565f-43b8-8cb8-6f8cd98b06df@app.fastmail.com>
In-Reply-To: 
 <e897e6d5a88ec2f9024c62f7bee5c13bfb2cab55.camel@physik.fu-berlin.de>
References: <20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org>
 <01ea8c41-88cd-4123-95c7-391640845fc3@app.fastmail.com>
 <e897e6d5a88ec2f9024c62f7bee5c13bfb2cab55.camel@physik.fu-berlin.de>
Date: Wed, 20 Dec 2023 10:47:56 +0000
From: "Arnd Bergmann" <arnd@kernel.org>
To: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Sam Ravnborg" <sam@ravnborg.org>, "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>
Cc: "Helge Deller" <deller@gmx.de>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Alan Stern" <stern@rowland.harvard.edu>, "Jaroslav Kysela" <perex@perex.cz>,
 "Takashi Iwai" <tiwai@suse.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH 00/27] sparc32: sunset sun4m and sun4d
Content-Type: text/plain

On Wed, Dec 20, 2023, at 09:54, John Paul Adrian Glaubitz wrote:
> On Wed, 2023-12-20 at 08:36 +0000, Arnd Bergmann wrote:
>> All of these were found through inspection rather than testing,
>> so there is a good chance that other fatal kernel bugs prevent
>> testing in qemu, at least until the fixes from Andreas' tree
>> are included.
>
> Andreas has fixes for these issues?

Not sure, all I know is that

- Andreas has some fixes for Leon in his tree
- Sam is unable to boot mainline in qemu
- There is an unknown set of bugs in sparc32 since it has not
  been tested for many years without Andreas' patches

it appears that the qemu developers are still testing the sun4m
model against old Linux and Solaris installations [1], but
failure to run the leon3 model could still be any combination
of kernel, qemu or configuration problems.

        Arnd

[1] https://wiki.qemu.org/Documentation/Platforms/SPARC#Compatibility

