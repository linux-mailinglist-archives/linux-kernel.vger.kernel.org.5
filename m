Return-Path: <linux-kernel+bounces-131672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9725898AA3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368891F22242
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5173F54905;
	Thu,  4 Apr 2024 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bwyYcZdu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jd6ifrXw"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7818F1C2A1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243238; cv=none; b=sVTtXymU0kP5RldcEyZDcyDZ1xmZZQFznRAUsezVDToQ296pZ/rWcXF/AjGGxXoBTkv416sYmReOjsHVJfl3WDEw+kJfqixpQuaUUA1ljXbLDWXxFKQ1ZWtg4hX/JTeMqElGR1iwxb/28rCXI88JgqUDEKH09WS46ZI8YLyxdGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243238; c=relaxed/simple;
	bh=8MQJPcx4xr1292Nxe+K1GL2bRjyWbkoPOhGmRjV3sfU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Rubr/xhlWBRyaChHo96JueLCebObLzUtLuyAwyOZM1et95PjOicsaKFVkijiI8+Cu4VppFRlwHTmF7hBZ2alyFAnSR6MPTtNREJUBdPMK0/bciz+HvD8f/RMT24XFS2HPmq1UE+8MRQKfjvRppyCBNUDGLyJCtfwG+eJgc/J8s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bwyYcZdu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jd6ifrXw; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0D12718001AB;
	Thu,  4 Apr 2024 11:07:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 11:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1712243234; x=1712329634; bh=Df3WYhd/e4
	mwV76oBS+r3imfhWKZ9Jv4zriSH1RBgp4=; b=bwyYcZdu31NsnPpgmA0ZRPL3lg
	cR/iOroTX0yQpVPsMse1VoZQHmWT8Umm7sJlImbvGmPabPQ67u1iiPHcEjEtaXPS
	C4nULGLoNQW+8Ag4scYSAiL7VSWfKuaiqxQT0WTNYc59m5ecDzAWrUnRDK9tYIIQ
	aE0SvEm8Kl9X0HsruWk9CUf9En1yhz/Jxnn74EIh8H0CNbXT6cCzMxIXscMYtGn9
	oGSBSd95amUUZoHQt6KhZSSnjM6fhdaj+DpDMMJ+0CYA7202BW07FxIH4bfMYIzG
	qdnH/cclOGSLvplpQM6xEzrLHfkBg9BNWeFMafq6LNp51+bjyA8uYk8LqVzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712243234; x=1712329634; bh=Df3WYhd/e4mwV76oBS+r3imfhWKZ
	9Jv4zriSH1RBgp4=; b=Jd6ifrXwGA7fap3xsh+sMJyeZRbQ3b4pjcxQnT7WCN3S
	iv5S6rKoygS+LDDzxLPhA0raNOjnuMUGtdwzdMSr7CHHExBTD97Sm/E2A+nahHqA
	IsKnU6kcxECiV43wQLHOAe2LKKSYPhuiGaab3sVDJ7RySNcZGxkZQhWciQyP+YSo
	esSh5HdlG6U3uOvQYJiwo63K+MXWtsb2T74ruP2KmSC4+j54j9ken2SFZJitKnI1
	AAMWalSBCpwV7fGIelusDqrcEuri0p/FxhZ/djhlYHZ0QcurEwJ8SgTtnUU9SHIM
	e7PAX4fBkiTfvQeym9Un+Pnz95LlHr+hNqGz5Qw+Mw==
X-ME-Sender: <xms:IcIOZuLzLNsU9owrhanKtw8LG_c2xKY-m_qzSLMvtT7HU6q2tl8p8Q>
    <xme:IcIOZmL_js1uYY9fUDujiFhiHBw7liZ2n29E5GN5Hpud1g5FMxEBUi4fjjJ4HNpgh
    4bEJSnkkkkIvpQtlKI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:IcIOZusgDWFGTpKQ7u3H6b-p1OxSX8i25oBEztBmfAoGLH2t7QyJ4A>
    <xmx:IcIOZjaSsYVJbWIWaZgF8lZClXjCVBx3WqMdoTXCag2q9Iu7dbqiiw>
    <xmx:IcIOZlaJA1D46C6rF6IyJ-9YAv4wWZambQAEeYFzsZ6CoPOsgSMK8A>
    <xmx:IcIOZvBZE-_CdrsSBsJndU982ZFYdmlymLsmNPrp7XU0DWSc7_6thQ>
    <xmx:IsIOZjMawgC1GXNpL6qKh7kKYhVjHnxJ7WG1kKcm-Z5AXWT_G_n7klGr>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9D188B6008D; Thu,  4 Apr 2024 11:07:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <110db7fd-9a20-46e3-9f6c-8ba30e146af5@app.fastmail.com>
In-Reply-To: <b84884eb-e23b-480d-827e-06f1188ece9e@paulmck-laptop>
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
 <20240401213950.3910531-3-paulmck@kernel.org>
 <836df0c7-51a7-4786-8a65-a70efe9b6eec@app.fastmail.com>
 <32936b57-f451-460b-a2df-e74293e44f5c@paulmck-laptop>
 <f9b3c536-887a-4a33-bd03-70e60c5aa517@app.fastmail.com>
 <b84884eb-e23b-480d-827e-06f1188ece9e@paulmck-laptop>
Date: Thu, 04 Apr 2024 17:06:53 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 "Vineet Gupta" <vgupta@kernel.org>,
 "Andi Shyti" <andi.shyti@linux.intel.com>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Palmer Dabbelt" <palmer@rivosinc.com>, linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH RFC cmpxchg 3/8] ARC: Emulate one-byte and two-byte cmpxchg
Content-Type: text/plain

On Thu, Apr 4, 2024, at 16:44, Paul E. McKenney wrote:
> On Thu, Apr 04, 2024 at 01:57:32PM +0200, Arnd Bergmann wrote:
>> On Tue, Apr 2, 2024, at 19:06, Paul E. McKenney wrote:
>> > Or is your question specific to the 16-bit primitives?  (Full disclosure:
>> > I have no objection to removing Alpha ev4/45/5, having several times
>> > suggested removing Alpha entirely.  And having the scars to prove it.)
>> 
>> For the native sub-word access, alpha ev5 cannot do either of
>> them, while armv3 could do byte access but not 16-bit words.
>> 
>> It sounds like the old alphas are already broken then, which
>> is a good reason to finally drop support. It would appear that
>> the arm riscpc is not affected by this though.
>
> Good point, given that single-byte load/store and emulated single-byte
> cmpxchg() has been in common code for some time.
>
> So armv3 is OK with one-byte emulated cmpxchg(), but not with two-byte,
> which is consistent with the current state of this series in the -rcu
> tree.  (My plan is to wait until Monday to re-send the series in order
> to allow the test robots to find yet more bugs.)
>
> Or is the plan to also drop support for armv3 in the near term?

Russell still has his RiscPC, which is probably the only one
using armv3 kernels (it's actually v4 but relies on -march=armv3
to work around hardware quirks). Since armv3 support was dropped
in gcc-9, it's a matter of time before we drop this as well, but
it's not now.

>> We'd still need all the combinations of cmpxchg() and xchg()
>> with the four sizes and ordering variants, but at least the
>> latter should easily collapse on most architectures. At the
>> moment, most architectures only provide the full-ordering
>> version.
>
> That does make a lot of sense to me.  Though C-language inline functions
> have some trouble with type-generic parameters.
>
> However, my patch is down at architecture-specific level, so should not
> affect the cmpxchg() macro, right?  Or am I missing some aspect of your
> proposed refactoring?

Today, arch_cmpxchg() and its variants are defined in each
architecture to handle some subset of integer sizes.

The way I'd like to do this in the future would be to remove that
macro in favor of arch_{cmp,}xchg{8,16,32,64}{,_relaxed,_release,
_acquire,_local} inline functions that each architecture needs
to provide either directly or through a generic helper, with
all the macros wrapping them moved to common code.

I've been wanting to change this for years now and it never
quite makes it to the top of my todo pile, so I guess it can wait
a little longer.

     Arnd

