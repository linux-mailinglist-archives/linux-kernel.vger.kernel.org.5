Return-Path: <linux-kernel+bounces-117951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787FC88B1B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FE81F615CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAF353365;
	Mon, 25 Mar 2024 20:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="S4+3f3pI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u32nqvW/"
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8958AA9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399127; cv=none; b=X8OzUvdYriP70/3XLG/Drmp4KuZimMNdeJ5Mron/uObp9UqY2xeLfMCy6nLb4H2jymnjLEn3AtLZG/h+AwtRK8eY8/wIbEUACvVFsRmYKIfjiL8VoJb1BPzXXsa9+b7YW4W90/RylO//iBT2pCSeBlplryMbk/PB7Tm1E6adzR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399127; c=relaxed/simple;
	bh=iT9eyly6DP9h37ybQ3m67Bk2Y0xru04w5y6qfNtN6IE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=g5iS6d2qXwkQ76iTHmuCrG/YxskPgyTyMsCeqyaBHbiyuyzt2t/xS77stYYb7fDKWBVNBrJmlhlwrcpK2qpDSMLd7OXvRS6PA8vP1TEIDg76AYAYiBnZFdszZwLZB7EaZnj0HfgojWj78r1ukofH16qzIsQLY9hEPcZB2d24Gl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=S4+3f3pI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u32nqvW/; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id A423818000EC;
	Mon, 25 Mar 2024 16:38:42 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 25 Mar 2024 16:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711399122; x=1711485522; bh=mhY6UWFYLp
	GLu9vdotPDgrt7ybIuTPjbMRoJG2CzZUQ=; b=S4+3f3pI+YNgZTkRsaTjGJfLRs
	Xweu5smHhWwlqgrDI5QfCAjfgKFimPLMcOtAiJFv9/+2Ra9A/7aH1LkVcqmybvFh
	a62M9OJKTCjVXetf4lH2HozBSdq2g99we27It3uiAagqrnSbyyPNCXKPlXsGHA01
	dWj9L/w1en8+0bV3DC03xKTtylfxZkqSzuIMVIdMp+ZuToAhsV1HFhgs5AR7g4z3
	+ILghfHMnso8IbL5sCA9knFCp8TTNknARg0qrSGU8ZGb3G2vXpnQeZDL58lJ05E5
	HWT7F2C3rD3t9OCUpExjwaogVlQlQ5p6pnVciE8fRZJXpxqO7LOco2rywpkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711399122; x=1711485522; bh=mhY6UWFYLpGLu9vdotPDgrt7ybIu
	TPjbMRoJG2CzZUQ=; b=u32nqvW/CcrUFWOplIZK0gE8RfI4wQqWSTaOJbichPqW
	F8wAjfnUQjVn6L1ZoVu8P/ujI6RfbOfxe1DOGbHvnfKaY255IPvHJdSF0SUgSDPg
	z5C6fLvVhJ8v4quxdLI+ifwlTBrEjbS2I7omtvfmSPMTqrVPLu7ZzVUa0aDuziXJ
	/JjEORS7k19yFUnGMEI8iN2Bch5bpCr8lykf2U5hKsVn8YoVB0A2Jnh9v36AxQTb
	1oXCVPR94ANzzSZDHaERbmizhb6r8RQX4Y5gFT3g1Uxkoc08yfETn4fv1ntVXIzU
	DlORhxg/MTZyG+LlHQMP7/vBiOVxsF2fY0yIa+2+6Q==
X-ME-Sender: <xms:0eABZnQaHnU1AP3GZttcz8PEo95D_DgHn0RIM3Zr6orqkpg1Y-gQ_Q>
    <xme:0eABZoyXeyz9W9kOmyBgWJIAMyK8wq5OREbZdCbMhwa4tscrpyB6CIN8LcJ2cRlc4
    uu2X9lubeS5q1kW3Vk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:0eABZs2mNw-athT52_5o41vbqDqoBn0iAFxef5VZEH_N7_OYPpERYw>
    <xmx:0eABZnCfbUpFEOj2UQFGkuCq4Uy7hCFqMumAnGFrZehsDYSs6n0cuA>
    <xmx:0eABZghHb4UsX07Ini3aMVOIYhg1UsE-GrxEaEFWITzKlh574HCvKQ>
    <xmx:0eABZroKebaSLlxRwaGH7GZsFY6lgt6VAo6ldGtt6_06VptPo_MSJw>
    <xmx:0uABZp1WzsT0Qb9npqR74HyOmserEQy6QdZ1NthLJsBZvTXjVDoDfFU9nFU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 484A7B6008D; Mon, 25 Mar 2024 16:38:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <95eb125d-dd54-42f1-b080-938faca6a8a1@app.fastmail.com>
In-Reply-To: <ZgHCpgHh1ypSyrtv@FVFF77S0Q05N>
References: <20240313180010.295747-1-samuel.holland@sifive.com>
 <CAHVXubjLWZkjSapnsWJzimWg_2swEy7tQ-DQ6ri8yMk8-Qsc-A@mail.gmail.com>
 <88de4a1a-047e-4be9-b5b0-3e53434dc022@sifive.com>
 <b5624bba-9917-421b-8ef0-4515d442f80b@ghiti.fr>
 <f786e02245424e02b38f55ae6b29d14a@AcuMS.aculab.com>
 <d323eb10-c79b-49cb-94db-9b135e6fd280@ghiti.fr>
 <ZgGosOiW6mTeSnTL@FVFF77S0Q05N>
 <eeccbc9f-7544-42c9-964f-2b4c924c2b2f@app.fastmail.com>
 <ZgHCpgHh1ypSyrtv@FVFF77S0Q05N>
Date: Mon, 25 Mar 2024 21:38:20 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Rutland" <mark.rutland@arm.com>
Cc: "Alexandre Ghiti" <alex@ghiti.fr>,
 "David Laight" <David.Laight@aculab.com>,
 "Samuel Holland" <samuel.holland@sifive.com>,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "Albert Ou" <aou@eecs.berkeley.edu>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Charlie Jenkins" <charlie@rivosinc.com>, guoren <guoren@kernel.org>,
 "Jisheng Zhang" <jszhang@kernel.org>,
 "Kemeng Shi" <shikemeng@huaweicloud.com>,
 "Matthew Wilcox" <willy@infradead.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Xiao W Wang" <xiao.w.wang@intel.com>, "Yangyu Chen" <cyy@cyyself.name>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Content-Type: text/plain

On Mon, Mar 25, 2024, at 19:30, Mark Rutland wrote:
> On Mon, Mar 25, 2024 at 07:02:13PM +0100, Arnd Bergmann wrote:
>> On Mon, Mar 25, 2024, at 17:39, Mark Rutland wrote:
>
>> If an architecture ignores all the top bits of a virtual address,
>> the largest TASK_SIZE would be higher than the smallest (positive,
>> unsigned) PAGE_OFFSET, so you need TASK_SIZE_MAX to be dynamic.
>
> Agreed, but do we even support such architectures within Linux?

Apparently not.

On 32-bit architectures, you often have TASK_SIZE==PAGE_OFFSET,
but not on 64-bit -- either the top few bits in PAGE_OFFSET are
always ones, or the user and kernel page tables are completely
separate.

>> It doesn't look like this is the case on riscv, but I'm not sure
>> about this part.
>
> It looks like riscv is in the same bucket as arm64 and x86 per:
>
>   https://www.kernel.org/doc/html/next/riscv/vm-layout.html
>
> ... which says:
>
> | The RISC-V privileged architecture document states that the 64bit addresses
> | "must have bits 63-48 all equal to bit 47, or else a page-fault exception
> | will occur.": that splits the virtual address space into 2 halves separated
> | by a very big hole, the lower half is where the userspace resides, the upper
> | half is where the RISC-V Linux Kernel resides.

Rihgt. I had even looked in that directory but somehow missed
the vm-layout.rst file.

     Arnd

