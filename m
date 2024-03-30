Return-Path: <linux-kernel+bounces-125667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E8C892A58
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2A51F223AD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C94128385;
	Sat, 30 Mar 2024 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QprOH3yu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xNfaTlbN"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C045B67F;
	Sat, 30 Mar 2024 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711793786; cv=none; b=Ihm4pNbw2Wf960xNrLH8DQ0qtE3HXGkE7ZKXdWxwt8qiG4J6Zg19j5o87khW5aKmlXLUmp594TOJDtV76r1PkTwqZJcqBsQMkg0SLBFBoc/8AXisM5gOhBn1ep6mBSsuYM2BVcwHlD1luRed+4fFoeZ6SkSbfL13bN6Ix7VM8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711793786; c=relaxed/simple;
	bh=VmXkUZOyIKmfkUOUul0zspsIq3cKy0cxTdecNyGNAME=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=kpOkTQaMkYn9FVsS9A26tcqGSNjt4RH9q3BBm40n3/ZdLAyACVRsfAV7parh/ZkwsGqAXU6aJTCVuiIMOcUBDm36AdNZmTyqKcD5PoRCRpMXNa0WV/Q3PEtEc2R51p3Vp6HVLD5zU0gKJeLIrr/CfR1waMvaB3S2r+eRa5oIauQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QprOH3yu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xNfaTlbN; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E1B4F5C005E;
	Sat, 30 Mar 2024 06:16:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 30 Mar 2024 06:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711793782;
	 x=1711880182; bh=C1agP3KE9ryTsfFxMj9pcesfkkbP9jyl0WFWmkHubNM=; b=
	QprOH3yuKFDQDntorjsPIreNnbvEkxsW+LmXiF1qGNzpS47PfEepBqTd2OqLtajV
	mSLJ8oiE7kijeDm0yvM87RPEKnGOY/zji1kXpyoe013n7XYRReohpY14MvEMj+O+
	vuRfrhA7RLNXpi8XXDrOZwqzqcERci/Kir87igaJA4CvUF3BKbS6fHeBDoMVgupb
	SwMLawXjmp6yG+PLPf3U8NFdKS4KQdJuvDtQ1l+lDR6OsbYC4f4js3eyRUp544sk
	vv50GSikJDok1SeGQAplNgjSTXnVxY6qtDzc92XuLy9LKc6C+Ia1NucG/Jw4niTO
	Vb/WhNafw5T1oqjLlQqwIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711793782; x=
	1711880182; bh=C1agP3KE9ryTsfFxMj9pcesfkkbP9jyl0WFWmkHubNM=; b=x
	NfaTlbNWBW+sVsI7ghHjZUwYpDK9xbyQXR7QwSHcRLHl99PDlKuIwynvO6D4Oech
	6/F5MOMegGQw+0V8wqAXl1QbQ4pfWJMrftsX4/0iPQr/L2oWhoIkI8fnYhoHixAC
	3VkZLKZ2C/envoKqpFO++RQNEv4cTPqEd2x7CT2sP+SDxVU4sKchz+DMH0ngZ/ay
	/HL2YrWeClZG/M/zj4tui6LxM1T+QS6AtoghUHRbPdkaK+8LdTjMpfw1Y/9FzcWK
	LswCme7RstbRro94IfHraOINi8bETAcJ45lHx9lrQng5mUjn5i72DqbzKfiGBjzn
	KP/vL+gdbs3E8OanNk9bA==
X-ME-Sender: <xms:duYHZvb35RNnFDwhsbm151E4XReMVdjCFZzlRRbv_rmU3_8xB_sOIg>
    <xme:duYHZuazb0hiw-BvPtoOhCbNbSaKirAN7fIrPyjDTgpKkBsEBgJP2EwbeNC4OaBl4
    -5P2mzLF4hgMiFJz2M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvgedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:duYHZh-VmHa4EDKQcBmvf3F07F0fYMO5jWqcSq_pYRlAJOawCQ0DQw>
    <xmx:duYHZlrEaDQPOXdQnk6EFbFFLJvpy0aSQHp1r7RZcyXkqUghAhx4ig>
    <xmx:duYHZqo6QLwUpq2AIticZTMp6hZCYytI_LcGGePfd9gWebLxLWcACw>
    <xmx:duYHZrRSrN1C8PNZ5JCzWIVjAhTbB9ij5fdEsEcI8n8DaGzeOQ3ztA>
    <xmx:duYHZnAm3sTV72qgC1z2Iwd3iPINTZFQbtpFopJExiRJGm-JxvQ_Nw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6CC7DB6008D; Sat, 30 Mar 2024 06:16:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5e956d59-65f5-405c-8fc1-8faf68f1f02d@app.fastmail.com>
In-Reply-To: <20240330-sparc64-warnings-v1-10-37201023ee2f@ravnborg.org>
References: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
 <20240330-sparc64-warnings-v1-10-37201023ee2f@ravnborg.org>
Date: Sat, 30 Mar 2024 11:16:02 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sam Ravnborg" <sam@ravnborg.org>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: "Nick Bowler" <nbowler@draconx.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] sparc64: Fix prototype warnings for vdso
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024, at 10:57, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
>
> Fix the following warnings:
> arch/sparc/vdso/vclock_gettime.c:254:1: error: no previous prototype=20
> for =E2=80=98__vdso_clock_gettime=E2=80=99
> arch/sparc/vdso/vclock_gettime.c:282:1: error: no previous prototype=20
> for =E2=80=98__vdso_clock_gettime_stick=E2=80=99
> arch/sparc/vdso/vclock_gettime.c:307:1: error: no previous prototype=20
> for =E2=80=98__vdso_gettimeofday=E2=80=99
> arch/sparc/vdso/vclock_gettime.c:343:1: error: no previous prototype=20
> for =E2=80=98__vdso_gettimeofday_stick=E2=80=99
> arch/sparc/vdso/vdso32/../vclock_gettime.c:254:1: error: no previous=20
> prototype for =E2=80=98__vdso_clock_gettime=E2=80=99
> arch/sparc/vdso/vdso32/../vclock_gettime.c:282:1: error: no previous=20
> prototype for =E2=80=98__vdso_clock_gettime_stick=E2=80=99
> arch/sparc/vdso/vdso32/../vclock_gettime.c:307:1: error: no previous=20
> prototype for =E2=80=98__vdso_gettimeofday=E2=80=99
> arch/sparc/vdso/vdso32/../vclock_gettime.c:343:1: error: no previous=20
> prototype for =E2=80=98__vdso_gettimeofday_stick=E2=80=99
>
> The warnings were fixed by adding the proper prototypes to asm/vdso.h.
> The better fix would be to convert sparc to be y2038 compliant so the
> generic variant of vdso.h could be used.

I would prefer leaving the warning here until it is fixed
properly, or possibly removing the broken compat vdso
support. The other patches look fine though.

      Arnd

