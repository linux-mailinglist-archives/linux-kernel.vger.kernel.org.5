Return-Path: <linux-kernel+bounces-127533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6526A894D3F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AECC1F22876
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6DE3D552;
	Tue,  2 Apr 2024 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FYN7H8Rq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FqXs5hFi"
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C42F3DB9A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712045674; cv=none; b=pDqFl0Y9recM88PjZXxNuVnrtsAp3RqSyFO0tf5wx+sqTpYxbaA6f5YV8B17TqD4xSwFFzDAW831FzQ531SuEnM3Mqn4WN8rvGOpk3eGMM0VnWF36kuJVnadDdLRKw/GSoM8M42gdhALMBtdNFThtIdnddaIKjkz+OlY0rCd+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712045674; c=relaxed/simple;
	bh=iNFlvirMU8lZXV9Y7jCTtUF73bW5Ai5eAKEP0ci2i40=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=uYPyLXGoisKfa1UzBV6zYT3BlDEWBMMI38meLmy82TmMRumLs7psEhkdxg/114gHxpMxBZE3tVqzN2tsvxMMU/sIYCCWg0kYuKwkwv4k3JQTHdDw2TzYRk1NNf36jx2eIXwMnEtbcKjgKZjiilZOkEoEqQ5w/5NNUJ2hihHELUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FYN7H8Rq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FqXs5hFi; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 66E5618000CA;
	Tue,  2 Apr 2024 04:14:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 02 Apr 2024 04:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1712045668; x=1712132068; bh=dfMDUBNmuX
	dryFesVw8VFSNVl1Bx95SySGFLMIecno4=; b=FYN7H8RqU+1OxDtIHEKLvOfM+d
	h8iFEhmWn89q1KJZ+ohm2x4JzcySXpkw0cLrsA+pod65RKp5ZIL9Lm6dOpcqbNtB
	1qOFtQxuPVV5V8Q5GyLIpYsxuyrCOJF2BEgQ9iNk+mUkiL2BTVckWK0ZmYb75aV6
	2NRtyG359tgWbo4tmlU2MrWfqzhIeLQM9yzcI2RfCeTLEBpI0YlaW8qMlDiUrPLG
	6xYxnN+njBhEZpX0yGBSzB4v11uhx/ZIGp11jQ00CUcHuWHyQ22gYRRwDuCe8mOJ
	B65hTueLgk+yc5LtCcSp+sPjmokYwD5t/wIr7apjrjhPkYbBPLIUyZpH9BeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712045668; x=1712132068; bh=dfMDUBNmuXdryFesVw8VFSNVl1Bx
	95SySGFLMIecno4=; b=FqXs5hFiiQQHONab7WpHgmKafJXZuBvTfwhXHbL0M5HC
	bg/FX2xzOc7asGHmuDoHgW8quL5Brhg3Bw6YZYgis2pAqJuOZMyob7WozRXGcS68
	CoNz1j38y4J3jkZK0NFUiRRm1PYuhwfcOo+WMq7jitmOJ58GBfwt1ldNDCjJ4vSg
	lgJveavo/JrUtsi/GuVR4uhxrE3LWUVFmiiKYO4rcT+MonJKnI79PusWlS+m2ti4
	m/d4nWh4nB2Gjw7a6ZB0RCKIgHXaJdx1x7wehAER0DkG06TnftLsnt/ngk/n0NgO
	NhjTMmERxu5Dbo5CKNSzPiZqs8Z64KXEHAJI//ZYhg==
X-ME-Sender: <xms:ZL4LZoplvT6HRSUK59ydly-0HKwcYkF5ZlUT0yzqL1uXaYQanCe2ig>
    <xme:ZL4LZupTDG_AcmefCJlRfFGwH8wf12nWrX5WcdId7Rr7PezYl2Upvq9tN6DN6qt3Q
    n4Qrf28TZ62RVjx11A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ZL4LZtNOvJq9TkK22V64WcH8rtqSYOoKEXIsYMjc0hbwvIsnwr8M3g>
    <xmx:ZL4LZv6NZvo0Y08PHKntg65pofg3YD6JRP8yJgrVDnCT9dDdY6kPSQ>
    <xmx:ZL4LZn5tqCeccRS-m-B5Eesb_PyH-0sQLgXcXFuNVyhBTDouWacwTg>
    <xmx:ZL4LZvhuJOpGfuUNqIQrplLaoqSBXl-thb-M0Y1PgltY8pI7Sm3P-g>
    <xmx:ZL4LZhuSuNGutMMexmk9Znd7XDyJ5hea0B8k6xEf2er2cYqC8Bpv0mCO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 552A4B6008D; Tue,  2 Apr 2024 04:14:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <836df0c7-51a7-4786-8a65-a70efe9b6eec@app.fastmail.com>
In-Reply-To: <20240401213950.3910531-3-paulmck@kernel.org>
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
 <20240401213950.3910531-3-paulmck@kernel.org>
Date: Tue, 02 Apr 2024 10:14:08 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com, "Vineet Gupta" <vgupta@kernel.org>,
 "Andi Shyti" <andi.shyti@linux.intel.com>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Palmer Dabbelt" <palmer@rivosinc.com>, linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH RFC cmpxchg 3/8] ARC: Emulate one-byte and two-byte cmpxchg
Content-Type: text/plain

On Mon, Apr 1, 2024, at 23:39, Paul E. McKenney wrote:
> Use the new cmpxchg_emu_u8() and cmpxchg_emu_u16() to emulate one-byte
> and two-byte cmpxchg() on arc.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

I'm missing the context here, is it now mandatory to have 16-bit
cmpxchg() everywhere? I think we've historically tried hard to
keep this out of common code since it's expensive on architectures
that don't have native 16-bit load/store instructions (alpha, armv3)
and or sub-word atomics (armv5, riscv, mips).

Does the code that uses this rely on working concurrently with
non-atomic stores to part of the 32-bit word? If we want to
allow that, we need to merge my alpha ev4/45/5 removal series
first.

For the cmpxchg() interface, I would prefer to handle the
8-bit and 16-bit versions the same way as cmpxchg64() and
provide separate cmpxchg8()/cmpxchg16()/cmpxchg32() functions
by architectures that operate on fixed-size integer values
but not compounds or pointers, and a generic cmpxchg() wrapper
in common code that can handle the abtraction for pointers,
long and (if absolutely necessary) compounds by multiplexing
between cmpxchg32() and cmpxchg64() where needed.

I did a prototype a few years ago and found that there is
probably under a dozen users of the sub-word atomics in
the tree, so this mostly requires changes to architecture
code and less to drivers and core code.

      Arnd

