Return-Path: <linux-kernel+bounces-112875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A5E887F52
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BB61F21635
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB6A1D6A5;
	Sun, 24 Mar 2024 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ExwTFkCO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d3ta/uNL"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7CC1CD02
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711317978; cv=none; b=WUZ8kwPpCtbl3JkDi6umHdhfU7t2dYY91B+mMmlEz07i/1pgfJ1/dRHTlrcXFOdF6ouRbW+kknvNwO9zs+pyiw+4zIbWPB5uSwqwqT0ejHoi5OSrwZQ7exow+PfwWLQRpx3HlMvkDmWlkWdaLA4KHlK2GCsVrjnj1/G22nqS7w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711317978; c=relaxed/simple;
	bh=WgvpP+iZAziEU6XyEImoxV4uJq9sct88omD3j9dILXc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=u8wxvQLe/AkLDdJLQyOJEt1dFvM4uJt0XOTb4VjOTBs+kttL0SDflZfRwkj+HLdJlAHrEIHV2iWyNrPSy4K/HYVCdBjiQlzlhIiDuiPPHvNYF3yEf3/X1QEPKOrogg7YIfszStIMXGBktTYmzAAvwgM1/9KF4dN5qSZtdJ1NjF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ExwTFkCO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d3ta/uNL; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6B2221800089;
	Sun, 24 Mar 2024 18:06:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sun, 24 Mar 2024 18:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711317973;
	 x=1711404373; bh=GRJdMDLcsCv605YDty6b0aLIc6c6sh50+KXqZZugJ/I=; b=
	ExwTFkCOFpIo38KY7iJTosSFyXZAOHlKjwtxVcy1uBg+lHq5z7viRERmRyORuZHc
	J7rfXpEJb7+tkkUhPScyQ5jBPF1C1yHaDIFmucrqsPkL6O3sW2sR+rQ/h7sKrVbl
	XcAa9z3ReV1LMAspEwmUFwGy8taTCtcwICz1s7MnUB1NZPJNsK/iWoG43iImsjh2
	Iz3D25ulblIYetZhPHIE2Q5Mnkb/iS1sg56twYE8i5a9148aB+LCtAIVUq10O8nr
	o1pyALAQlaToMrmVK/b3IgarpWhY8/F/Zoj9GLXWg/nuC8G8ZinXPEDNbhGy+BXb
	fVZDDqPmckEmwoqx3JrwMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711317973; x=
	1711404373; bh=GRJdMDLcsCv605YDty6b0aLIc6c6sh50+KXqZZugJ/I=; b=d
	3ta/uNLxM2d/dUh5PPLdRhACAzMKKtdvv8yUG0NX1RIPTovWNJSBu9myOqusORUG
	NaiyR50yKBMBMQKRi05keIU1vbbFDTVZ3Z+12esJyOQnIyQzvIQfvX7eEvLOEIYa
	PH3XMUICS43foQFAaVyfCo7O9gDBP9YsDneIqtTWDHrcuHiEfACea7pSWYg637/P
	Ia/hpR6WKRIMv3+U+ewhAE9VI7VZCGZ5+F4JZMAE+zSW85DjOQlh/kiw1eRFHE3x
	y+eR3dTJQyCcwSSTKxbDu2GBHGYGRdnXgrY1GI+4Q6estGI0aDUQUxdq2TULoNgI
	mSH/3AZAtoSzrvMv8eUGw==
X-ME-Sender: <xms:1KMAZtvCDd1cmAZ6YkyDkrtsg9fQrgNW-oIu-V0AfSdf-Eb_ffQrmQ>
    <xme:1KMAZmfVxk-ZxU0_YjW6Ar5Xq4HhO1eFlVmBe_0wmb-VZkgX1ZsX3XBxWMoBrxi0H
    Z3KZqdF66_0Uq1Smio>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtjedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepfffhvdejieelteeljeekgeegieevheelueehieehkeehgeekhfdtleek
    teevtefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:1KMAZgy_t59OkKPA6aDjPt0kZ-izfepHB2wJ0xjHi8H6yh_yvI1nAw>
    <xmx:1KMAZkOM1OIxnJa-LU_65bl7I4Eia0SerNrvx8mOeOIN8jTFPBfpIw>
    <xmx:1KMAZt-uiy68wNs75EB4nqbKLnmPoAJx43sgy7eUh1yGUNST5aFhdQ>
    <xmx:1KMAZkVrEGm1QXVnjDhaAqIkawvmm7MkMv0XUp1sQFN-dHYjcUubjA>
    <xmx:1aMAZigScsf2mFxkRIGxd95EHsuB_g64nRP0WLfBJUuCkU1Y2DNIbOi4IiU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 97D01B6008D; Sun, 24 Mar 2024 18:06:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b0a07878-a9f1-40aa-b177-423b05137d2e@app.fastmail.com>
In-Reply-To: <b5624bba-9917-421b-8ef0-4515d442f80b@ghiti.fr>
References: <20240313180010.295747-1-samuel.holland@sifive.com>
 <CAHVXubjLWZkjSapnsWJzimWg_2swEy7tQ-DQ6ri8yMk8-Qsc-A@mail.gmail.com>
 <88de4a1a-047e-4be9-b5b0-3e53434dc022@sifive.com>
 <b5624bba-9917-421b-8ef0-4515d442f80b@ghiti.fr>
Date: Sun, 24 Mar 2024 23:05:52 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexandre Ghiti" <alex@ghiti.fr>,
 "Samuel Holland" <samuel.holland@sifive.com>,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 "Albert Ou" <aou@eecs.berkeley.edu>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Charlie Jenkins" <charlie@rivosinc.com>, guoren <guoren@kernel.org>,
 "Jisheng Zhang" <jszhang@kernel.org>,
 "Kemeng Shi" <shikemeng@huaweicloud.com>,
 "Matthew Wilcox" <willy@infradead.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Xiao W Wang" <xiao.w.wang@intel.com>, "Yangyu Chen" <cyy@cyyself.name>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024, at 17:51, Alexandre Ghiti wrote:
> On 18/03/2024 22:29, Samuel Holland wrote:
>> On 2024-03-18 3:50 PM, Alexandre Ghiti wrote:
>>> On Wed, Mar 13, 2024 at 7:00=E2=80=AFPM Samuel Holland
>> It looks like the call to fixup_exception() [added
>> in 416721ff05fd ("riscv, mm: Perform BPF exhandler fixup on page faul=
t")] is
>> only intended to catch null pointer dereferences. So making the chang=
e wouldn't
>> have any functional impact, but it would still be a valid optimizatio=
n.
>>
>>> Or I was wondering if it would not be better to do like x86 and use =
an
>>> alternative, it would be more correct (even though I believe your
>>> solution works)
>>> https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/=
page_64.h#L82.
>> What would be the benefit of using an alternative? Any access to an a=
ddress
>> between TASK_SIZE and TASK_SIZE_MAX is guaranteed to generate a page =
fault, so
>> the only benefit I see is returning -EFAULT slightly faster at the co=
st of
>> applying a few hundred alternatives at boot. But it's possible I'm mi=
ssing
>> something.
>
>
> The use of alternatives allows to return right away if the buffer is=20
> beyond the usable user address space, and it's not just "slightly=20
> faster" for some cases (a very large buffer with only a few bytes bein=
g=20
> beyond the limit or someone could fault-in all the user pages and fail=20
> very late...etc). access_ok() is here to guarantee that such situation=
s=20
> don't happen, so actually it makes more sense to use an alternative to=20
> avoid that.

The access_ok() function really wants a compile-time constant
value for TASK_SIZE_MAX so it can do constant folding for
repeated calls inside of one function, so for configurations
with a boot-time selected TASK_SIZE_64 it's already not ideal,
with or without alternatives.

If I read the current code correctly, riscv doesn't even
have a way to build with a compile-time selected
VA_BITS/PGDIR_SIZE, which is probably a better place to
start optimizing, since this rarely needs to be selected
dynamically.

      Arnd

