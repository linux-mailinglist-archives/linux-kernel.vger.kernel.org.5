Return-Path: <linux-kernel+bounces-131350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FEE898698
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7DF9B2604C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29E38527D;
	Thu,  4 Apr 2024 11:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="S0ZH2vNC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SRiZMHrZ"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DF184D35
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231876; cv=none; b=YVUZH3nGxNrjc/aVfNoHyfWPpOBTOegCXaS82XSLO+KreRH3IUMtuXRJa8IRlt8pcyWphZ6rVzslq9W2HnPfbMfnBzbn/dqyeVJ6mbJPUCSerJ2fbI6OkZR+ZKxbPmxLo41eZsfYhUbMcBFCXiyc7rv7wBNJYPfHDxWtgRHYuwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231876; c=relaxed/simple;
	bh=xpPSToXnScFnQLa4LDpK7c2Q/G7khDfZVgUOFA8eCzo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ZYh2/sxbRD5TbQAKB0KXMaabwRRGV7pDTo9lYWGjtic7Got1W8tbo440SmwhPpbSNE0uAbaN14D4+6U433q6E5guMXSkL0qr945g7RjG4OxSAqGzZABXDqSsIOcAC8xnKulnVB3trTf/bVcW58G6fu0PVjpD2aden/LxE4Ypi+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=S0ZH2vNC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SRiZMHrZ; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 9C0141C00119;
	Thu,  4 Apr 2024 07:57:53 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 07:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1712231873; x=1712318273; bh=D/MSOh/i9T
	oqciNjLOcNeFhiNaDy1EPMCBIzveAwq2k=; b=S0ZH2vNCr1xg4e/Y/5OQHYNMFC
	59Yt9ulNm6yPvo2q84EPK4o5+SrO9xCsFm4AuhGI7kWbpHGMSJqPRIzu0Y7FlSVe
	L1BJJ7mKWSlS+jzwSFPJs4z4yJsvSFvBACnRj/SOfxbFJ9XbkWfgyxFyoGukMZ3w
	7dpY+D8xndOa9MagHCYlPkesZz5muSijrLpYGp1/gVT1RYXhVkr22t1Hv9miL8i7
	E7gP/gY7clC42ec+X+ibe9japFkaprhucMWm1BX7CeI0jG+/deVKlcFY7Pl9huLF
	/lZ0xGvawcQYSB9ydwfh/qNb+5jO98oG5Smay0JBzEzsrJ7RhLPsQiMrxGsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712231873; x=1712318273; bh=D/MSOh/i9ToqciNjLOcNeFhiNaDy
	1EPMCBIzveAwq2k=; b=SRiZMHrZbF0auOWjL6wYfR+Rp4XOArVoMkQEG3WYlP4i
	YAXbOb+uVKoVXMyWEuH3erB0uQL1a229lXCRDb/wuBjIsxmUXNAt1wSA8N9bkutF
	9wjZhah0U8B37qdUNyuL1QFnLGbn1UQKLQa5RF+wbyhJ/ghS5sPWJwiFmAQ9oJCh
	/Y4zHzoJ1cHxXZSRMwh6GgW1JWjNDA5gdK78JeVmHLbCdEw+wHvlqCEToPeh6qT6
	7Fzpm/3RanLyWx+q+NMw5+CbqCHDdLwBlSQNWRiNexeXNGWJku9WQ7ADBjl0MJGP
	ZfKvUv5H+oh6pgxK+m5YjpGb6LXeu21ivT62U4oRzA==
X-ME-Sender: <xms:wJUOZkIve_XcrIkLQtfTmHNxuv2FetMW4iOQ6W0MlJ91DvVFjHsKcw>
    <xme:wJUOZkKHtkYgEyCEr859BMASYBMfmR357AOfQ1FDBIUPtZPX88740Z35MNqQvwNe-
    hg2nWgXrpSD6p5iEhU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:wJUOZks7df2n0FH9tzQmCigrD5gxXJrMRSs426F_1G_V0Pgvkya7Xw>
    <xmx:wJUOZhYNNzYZdoMXt4hm4bXdnLj6sMXrhz1-accxVc7SB2BnkFw8Rg>
    <xmx:wJUOZrYavuuNJOBBPfiKdeLZAzf5076YKG9GWzJCEqY-c1JV8514KA>
    <xmx:wJUOZtB_nyBXZw9GKzcc2yBswtCYCnkq5ZdCpZXhk5CbDLiB5XXzRw>
    <xmx:wZUOZpOM5XqEO6YhYdQKrjt1BAkE-SvRmjp8UtzgjeFrjQGTWe4_0ea2>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D7512B6008D; Thu,  4 Apr 2024 07:57:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f9b3c536-887a-4a33-bd03-70e60c5aa517@app.fastmail.com>
In-Reply-To: <32936b57-f451-460b-a2df-e74293e44f5c@paulmck-laptop>
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
 <20240401213950.3910531-3-paulmck@kernel.org>
 <836df0c7-51a7-4786-8a65-a70efe9b6eec@app.fastmail.com>
 <32936b57-f451-460b-a2df-e74293e44f5c@paulmck-laptop>
Date: Thu, 04 Apr 2024 13:57:32 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 "Vineet Gupta" <vgupta@kernel.org>,
 "Andi Shyti" <andi.shyti@linux.intel.com>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Palmer Dabbelt" <palmer@rivosinc.com>, linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH RFC cmpxchg 3/8] ARC: Emulate one-byte and two-byte cmpxchg
Content-Type: text/plain

On Tue, Apr 2, 2024, at 19:06, Paul E. McKenney wrote:
> On Tue, Apr 02, 2024 at 10:14:08AM +0200, Arnd Bergmann wrote:
>> On Mon, Apr 1, 2024, at 23:39, Paul E. McKenney wrote:
>> > Use the new cmpxchg_emu_u8() and cmpxchg_emu_u16() to emulate one-byte
>> > and two-byte cmpxchg() on arc.
>> >
>> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>> 
>> I'm missing the context here, is it now mandatory to have 16-bit
>> cmpxchg() everywhere? I think we've historically tried hard to
>> keep this out of common code since it's expensive on architectures
>> that don't have native 16-bit load/store instructions (alpha, armv3)
>> and or sub-word atomics (armv5, riscv, mips).
>
> I need 8-bit, and just added 16-bit because it was easy to do so.
> I would be OK dropping the 16-bit portions of this series, assuming
> that no-one needs it.  And assuming that it is easier to drop it than
> to explain why it is not available.  ;-)

It certainly makes sense to handle both the same, whichever
way we do this.

>> Does the code that uses this rely on working concurrently with
>> non-atomic stores to part of the 32-bit word? If we want to
>> allow that, we need to merge my alpha ev4/45/5 removal series
>> first.
>
> For 8-but cmpxchg(), yes.  There are potentially concurrent
> smp_load_acquire() and smp_store_release() operations to this same byte.
>
> Or is your question specific to the 16-bit primitives?  (Full disclosure:
> I have no objection to removing Alpha ev4/45/5, having several times
> suggested removing Alpha entirely.  And having the scars to prove it.)

For the native sub-word access, alpha ev5 cannot do either of
them, while armv3 could do byte access but not 16-bit words.

It sounds like the old alphas are already broken then, which
is a good reason to finally drop support. It would appear that
the arm riscpc is not affected by this though.

>> For the cmpxchg() interface, I would prefer to handle the
>> 8-bit and 16-bit versions the same way as cmpxchg64() and
>> provide separate cmpxchg8()/cmpxchg16()/cmpxchg32() functions
>> by architectures that operate on fixed-size integer values
>> but not compounds or pointers, and a generic cmpxchg() wrapper
>> in common code that can handle the abtraction for pointers,
>> long and (if absolutely necessary) compounds by multiplexing
>> between cmpxchg32() and cmpxchg64() where needed.
>
> So as to support _acquire(), _relaxed(), and _release()?
>
> If so, I don't have any use cases for other than full ordering.

My main goal here would be to simplify the definition of
the very commonly used cmpxchg() macro so it doesn't have
to deal with so many corner cases, and make it work the
same way across all architectures. Without the type
agnostic wrapper, there would also be the benefit of
additional type checking that we get by replacing the
macros with inline functions.

We'd still need all the combinations of cmpxchg() and xchg()
with the four sizes and ordering variants, but at least the
latter should easily collapse on most architectures. At the
moment, most architectures only provide the full-ordering
version.

      Arnd

