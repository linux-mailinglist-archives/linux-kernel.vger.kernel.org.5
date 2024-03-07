Return-Path: <linux-kernel+bounces-95572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D6E874F9D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B4D7B22968
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BA712BF0C;
	Thu,  7 Mar 2024 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ErmKsbBx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LPltvXx+"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0176A12BEB7;
	Thu,  7 Mar 2024 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709816832; cv=none; b=FAf2Fvzcc1bmoqXYoInjBwnOjJjrGdyJ7tmw1rd6cYpWNo7DVvnzQuXYyM4YNpR1RqpiF+SX6Ub6b0/HF1EjPVSEnu4XAF4LKU4GWQfo6KWXJiRZ3wZZXgeUJex6DgxLPAN4T0IvdNTB23E1ix8KEv76kaMhvW44iY4ph4q45mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709816832; c=relaxed/simple;
	bh=cjI8HdcqWfSzb4EPROgu3kbBICUTAibkbIw37DdMKZQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=BXjSz5bex/Ay9TTo+JVqRYNYcuTUp+EXumcuzfeNDuIZzbCzIlcHia328BxW9xMhSoQ/dUAvhz18ChK3QOfmLr6C1r8yFaPyMoZYwN/Ne+g6mHXPVi60tT8vBaL2UjKSxPIGGFiL/i6epuS8Z/d6o3cq2MxBM12Pf2OoLzAFwKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ErmKsbBx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LPltvXx+; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id A76811C00096;
	Thu,  7 Mar 2024 08:07:07 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 08:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709816827; x=1709903227; bh=KIlJ9/MMoQ
	ydcaKrNuZHiK1uGjrE3/F6Od5LC7tnK/8=; b=ErmKsbBxBCZtoosoVThwRby/dF
	JJDWd4x2cfSFm/U4sxOMSsJ3B3NKY/vZcwX38EDm94XUTrx0YiEBDlWtdNXrrQQQ
	obzgn9C9h7tWbnDOobbNqEhGUWHwn2VY1y98KoLe2RvHOHHU7SuLdAUmk8JR9h4z
	uca3qn9pxZWe7rb6fM6CRq9M2BL3ngerFlxczb0Zd7kiOySP9AMsr0l6i8hfhgI9
	clsMc26SIRI0mIVMg9m+hm30YTq1XqXLIg75cCuLz2uW0gXjkPuQmLwfceiv7TiM
	dc2aEoV0kYbRQD6ExMiP1pw/C0gPvPE/BVxSTlKRO/wqqCewShI55QggpsKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709816827; x=1709903227; bh=KIlJ9/MMoQydcaKrNuZHiK1uGjrE
	3/F6Od5LC7tnK/8=; b=LPltvXx+FmwRg1QDk6r3n8KsXSO580DsxXXlNXHXJ9EB
	3GigYEwMG44CsYmTF8WWgKEEM0iQ7ADuX3GzaGaggWXY9IQfEmxgr/JGjPD1GLz4
	+j4ySIBU1Plcrglm0nO0723jmpzw1gbSEa48FD6tHO9XVQH/iylBXWDXvlHjOlGX
	dgT8ZpRLi6RxoMNtgo1rF3RXGqJYpqlJZk2W8P5+lQPESoXu7yW1hB9TtEy23ur4
	yrotVVAB8G9fj5Vtdfkx436O0G7ijQ0eg2AR4qDaeTSGWKY7BVOyg1NGgutSLCGd
	kuosSFRvTxcVrNVCoDO4zx+OHfI4LFFC/3dVSCAiaw==
X-ME-Sender: <xms:-rvpZXt5qaX3lQhx_3cdRmxnViimUF_YOeQlhfuCLMDFLpjwb8I4oQ>
    <xme:-rvpZYdXp7vU9MtQ9OAEuMWvPRZpGhCyo3i9zBi50NebA7tMY2AGDHC_lzjNJyH4i
    Nvsqbg99sqjOQEmR3o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:-rvpZazmt_gDXWLXGhdnIQAVmHd29HpaweYr7FQ9nL2Hj8ALP44Ffg>
    <xmx:-rvpZWMr_zKd-w8ntmcHo9ZjQkvSU2QGWcmpESbSd5e4S8dIoZPCmQ>
    <xmx:-rvpZX8vKA2X6zxV2dK-zbrvOnOkSNzMc8EDgQsvpt6m7FKEbah5ig>
    <xmx:-7vpZTTSHdQFYM5aj0AFPAubartSoU6aMikV8g_3FT7BWcHkxg7JazWyOGk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 25551B6008D; Thu,  7 Mar 2024 08:07:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fd7d8c88-5832-4179-890a-3b3af88a83a9@app.fastmail.com>
In-Reply-To: <74afd65d-85ed-4ee9-b5f2-a6702f9bc01c@gaisler.com>
References: 
 <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
 <8d5780f5-1047-48d7-a9c9-09b95c7b5604@gaisler.com>
 <5648dca0-4853-4dfb-91cf-282a656beb1e@app.fastmail.com>
 <bc33b608-e0b5-4dff-aa05-8513dce409b3@gaisler.com>
 <75a4a08d-85c2-4a60-9cbd-90dd50f765a8@app.fastmail.com>
 <5d97d50a-9d40-4651-8071-073dee5f9aa8@gaisler.com>
 <001ba36a-9d4c-45c4-b1f2-448824848afc@app.fastmail.com>
 <5568f26d-9e1a-4530-a086-564659b21666@app.fastmail.com>
 <74afd65d-85ed-4ee9-b5f2-a6702f9bc01c@gaisler.com>
Date: Thu, 07 Mar 2024 14:06:45 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andreas Larsson" <andreas@gaisler.com>,
 "Sam Ravnborg" <sam@ravnborg.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 sparclinux@vger.kernel.org, "Randy Dunlap" <rdunlap@infradead.org>
Cc: "Miquel Raynal" <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S . Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] sparc32: Do not select ZONE_DMA
Content-Type: text/plain

On Thu, Mar 7, 2024, at 13:42, Andreas Larsson wrote:
> On 2024-03-06 19:19, Arnd Bergmann wrote:
>
>> I still don't know the history behind this choice, but I
>> see this was already configured the same when arch/sparc/
>> was originally merged. You can probably change it to a more
>> sensible 0xc0000000 or 0x80000000 like on other
>> architectures and run without highmem on anything with
>> less than 2GB of total RAM.
>> 
>> How much RAM do Leon machines have typically, or at the
>> maximum?
> The amount of RAM can vary greatly between systems, from less that
> 128 MiB up to 2 GiB. An upcoming design uses the entire 36-bit
> physical address space and have the possibility of having up to 60
> GiB memory.

If the current maximum is 2GiB, that would be easily handled
by making PAGE_OFFSET configurable the same way that x86 or
arm do, where the common CONFIG_VMSPLIT_3G would extend lowmem
from 192MiB to a little under 1GiB, with PAGE_OFFSET 0xc0000000,
and VMSPLIT_2G_OPT allows exactly 2GiB of lowmem, plus a little
under 2GiB of user addressing.

This would also be an improvement over using highmem for
most applications today, and it means you can keep using the
same setup once highmem support gets removed from the kernel.

For a new design, I would strongly advise against advertising
support for more than 2GiB on a 32-bit Linux kernel, as this
is likely to not be supportable in the future. Note that
in the best case today (40 byte struct page), the mem_map[]
array uses 10MiB of lowmem per GiB installed memory, so you
quickly run out of lowmem when you allow more RAM.

     Arnd

