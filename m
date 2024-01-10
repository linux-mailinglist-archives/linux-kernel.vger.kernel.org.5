Return-Path: <linux-kernel+bounces-22260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6FA829B88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647081F247DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A75F48CD8;
	Wed, 10 Jan 2024 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FSYSViSC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LjMJGc5c"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A18548CC1;
	Wed, 10 Jan 2024 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id B169B3200B40;
	Wed, 10 Jan 2024 08:42:44 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 10 Jan 2024 08:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704894164; x=1704980564; bh=BmHdlujemK
	Tt47oYKjP4mcCwFNBw0dvdYdm7mWMOS1A=; b=FSYSViSC2HmmHEdU8iG/Pm0B7/
	0lVOCBmFGOdxzFynNzEiZvBT8791kHGkqdqHs+89oyxPyMg368ySC5F9AQ5zDkwp
	eyWZf8uk6JVHrewvLbam2aCpBF5K5+epVbNpGOlYgrxTavqZ4i8VcJb6vmxxeUzw
	TdA7VIWudKtw7yNWv+WBRBgouGRg9284T5kKWipb7Y9l0In0ewObfvWrAGdhKWzD
	ZLNj22wVCzlthWStObyo3/KCOCGZwyMs+zdF2GK+jCzWP35V3O0FPonsBQyO90Du
	Pqzrr6YazJwsANqD/VoZVNMDddWKBNycQe5zF0WbTv08AFkC5v1Q8qAlGeIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704894164; x=1704980564; bh=BmHdlujemKTt47oYKjP4mcCwFNBw
	0dvdYdm7mWMOS1A=; b=LjMJGc5c26PEODjc+KnVJFpKLhBmcZ19hhMC4c1gFy1d
	rE/35yB6KiE/dCZQ+muUF4XLzD/hXpNRXMWZKpPRk9zd+SsqaUYbKeE+8UziqxJT
	1NG37LUqmIPdafSVCpj5TjRKK18bG7JR9ynPM6HRBuGIR6iYaFOuufEfDagcVg8u
	VT3sSrYzkho/T988ODuWwRsZrTf4mLReUeHvjLd3aDd43Q6mO3MJYey6iV3941We
	ev3YhRCT2Wuw/UniDSaTx1X3GO4sGrLkj8URVqidhzyc8IilQZvhl5R5Zk9JGX1S
	9Gxxuj9Qhdnm/IMedil8usV3JjCP6P6qxAC6dJGRiQ==
X-ME-Sender: <xms:056eZc6AunfMbpdUJjN1VRHddp9meAu36R5UmmvP5jApnzDbzNlC1A>
    <xme:056eZd4HADRZL2RAV_MPPe3Nfh1gWXqRyYYvofIm9G0ZvZ_sP4llVRJjqAVIY6wi_
    w5LP--bSD4VLQTXcYU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiuddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:056eZbclHecWM0jrjKxsSrRZJQd9uOImluO2miOvuXX4JHqWdBQ1DQ>
    <xmx:056eZRLl4lKvuRBixBM6zg301d2WrCKvqKqvjG6osj_l8S45l9q2jw>
    <xmx:056eZQJ5RSkfi9oxEonFrDhj7qfuIDV8hUlxKgvS_LGptflBErKiLw>
    <xmx:1J6eZXXkMfAn2j5UMtmzXGM2rIUyy_pNzrPcB2z9gYzPEEgPtFoYpQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A3DC5B6008D; Wed, 10 Jan 2024 08:42:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6c82c4b9-297d-44a0-87dc-9413e15fa48a@app.fastmail.com>
In-Reply-To: <20240110130122.3836513-1-nik.borisov@suse.com>
References: <20240110130122.3836513-1-nik.borisov@suse.com>
Date: Wed, 10 Jan 2024 14:42:22 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nikolay Borisov" <nik.borisov@suse.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: linux-api@vger.kernel.org, "Richard Palethorpe" <rpalethorpe@suse.com>
Subject: Re: [PATCH RESEND] x86/entry/ia32: Ensure s32 is sign extended to s64
Content-Type: text/plain

On Wed, Jan 10, 2024, at 14:01, Nikolay Borisov wrote:
>
> This patch has been sent previously by Richard back in 2021 [0]. 
> However it
> seems to have been dropped at some point and never merged. So I'm 
> resending again
> to consider it for merging given that io_pgetevents_time64 LTP test 
> still fails.
>
>
> [0] https://lore.kernel.org/all/20210927161955.28494-1-rpalethorpe@suse.com/

Thank you for resending this, I hadn't noticed that this never
went in, but I also see that I still keep the same patch in
my testing tree.

I think the entire syscall entry logic needs a larger
cross-architecture overhaul to avoid these confusing macros
and make sure we get it right everywhere, but that's not
going to happen overnight, so this patch is what should
get merged and backported to LTS kernels first.

    arnd

