Return-Path: <linux-kernel+bounces-97553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D71876BDC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCD51F22773
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4BB5F578;
	Fri,  8 Mar 2024 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kQwPIMWk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p3/9HIZS"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3877C5E063;
	Fri,  8 Mar 2024 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929816; cv=none; b=UewiU1GFIps66172mb9aoOn+QsBhGEvc7Go69TFlH3JQ9+1o7+B5U8poox0H3/+Xn+sOTPp9FfmyHy7G7EtRzAmSlEm78rlQVp9B1lu1xZhsG+atYgC+w6i6eMVLsP8br03hyOLwvnbLUVRHiC4dHLEMCtC7krZh59X1/YGdGcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929816; c=relaxed/simple;
	bh=dQmf6b8r/JQlJSxgV6LHXxtLlFewVIk3A5hnBzx8nkY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=IuIdfUTSEJuzY4WFldOs0+tUyjMyXGis/WJ7dT4Al+BAK14R9/1/h5ljkfyVSbPyy9VW7pz6N9BlSYK1jjvQNvmRHFomxIPL3mDl/LWoCobGbRthxsl40CW4FNhXqNVjlOmxGRUKNg0PHGRZo2X1lmzyIt3Jk0yohTt7k88nh8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kQwPIMWk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p3/9HIZS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3BB3113800E8;
	Fri,  8 Mar 2024 15:30:13 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 08 Mar 2024 15:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709929813; x=1710016213; bh=i+BFqwvpsh
	hQkm0ab4yqWsNgexM9j1Rk2QJFjv0/UiE=; b=kQwPIMWkFCGEXxk6FMqTWVX3E9
	cC/nl21nFuAVUpsnBD7nrv2sMWWZnP1lM7ECMV8F5z3bjZzrZP+cAkHdDwoop+SU
	k3vM56qh/yUwJEAYxNxtIFmVeXKqj2Am0ShFu133j2vYD1o+0i5Ir8o37SvYuAq8
	xqDOsTo13ov/6XyatsxlGu8pczys2TxZHxmNZdHLSDqR98DiaKtXZ4+s1mHb7+N6
	yrMlf55MCRNwrSl0iBXpjFby42JJFzAFSBdB65sdlejeUuqg9zdzJRz54nObNNV1
	Te9SvtYaOLqE7sK9S/q2OzRqYOw206RsNXp01BtlgH2cUb8RCr6a24ZYKZlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709929813; x=1710016213; bh=i+BFqwvpshhQkm0ab4yqWsNgexM9
	j1Rk2QJFjv0/UiE=; b=p3/9HIZS3FcldnOxMlmQWuaSOTyT1e/GWzqYdCpXl9zs
	zEyxM1hWEVe9Qlu5eG92XFdfLm/pdJi3/YA0mTeFrFI6fs8uaUzWA2Q6XYDHUZ+r
	W7sXNsGvYVsq+J5UfOVNawXOotaaaFEzUhH6UHIO14qscXwAFdNOPqtd38iRI6FP
	3hOzcZ7/ToTfByLwZCaQ48oox4JpB4L9AD5LKK2eivVyNzLggUlbFN3FMBvFEfoz
	NPXdxfPz1UHqo0eKJPbNrb5nFrnfuQko4wWRngrj0Xlbii/belkJz+Y1wT8w1Fl/
	VwBEmJmr6s4oE/OUkQpm+5/txuX69CnVfUj/sb9VdA==
X-ME-Sender: <xms:VHXrZQ8DWgY-g_pp5WnCmN9fhdA96xLDU-GHrYf1EDh9Bwl7-jYQ-w>
    <xme:VHXrZYvj3K64dtnu8NBnsa-dDep0NFH2QaZj7etmznS3LaHDjrG9yv-59stL2ti_s
    2yevvQ4jFq2Zw2WOUk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieehgddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:VHXrZWAcAC4q5u5wua_WaJ3MKCMhcpbksZOT4G_DRpBysxH8L3OLbg>
    <xmx:VHXrZQfB7VyTRKWYbydm7GmV4eAqvbZLi_eOpcsgMPpPIrr8yRVpYw>
    <xmx:VHXrZVM-X227Gs3UqBn4wBiKjZQVZIiLY3R3rc0AqhGcN4SlHX1vdA>
    <xmx:VXXrZWscnuXoZeISlJzTiMqbKesLtfqVYjc1YYsALZ73luuRY8--HQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 216A8B6008D; Fri,  8 Mar 2024 15:30:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <acfc522a-5162-4b33-9d6c-1e25d0c44a71@app.fastmail.com>
In-Reply-To: <db7dfa2d-c7c6-4b10-981a-a7ecc87c8541@arm.com>
References: <20240305221824.3300322-1-jeremy.linton@arm.com>
 <20240305221824.3300322-2-jeremy.linton@arm.com>
 <202403051526.0BE26F99E@keescook>
 <34351804-ad1d-498f-932a-c1844b78589f@app.fastmail.com>
 <38f9541b-dd88-4d49-af3b-bc7880a4e2f4@arm.com>
 <f1dd15ce-69af-4315-8d7c-b7a480e541aa@app.fastmail.com>
 <db7dfa2d-c7c6-4b10-981a-a7ecc87c8541@arm.com>
Date: Fri, 08 Mar 2024 21:29:51 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jeremy Linton" <jeremy.linton@arm.com>,
 "Kees Cook" <keescook@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Mark Brown" <broonie@kernel.org>,
 "Guo Hui" <guohui@uniontech.com>, Manoj.Iyer@arm.com,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 "James Yang" <james.yang@arm.com>, "Shiyou Huang" <shiyou.huang@arm.com>
Subject: Re: [PATCH 1/1] arm64: syscall: Direct PRNG kstack randomization
Content-Type: text/plain

On Fri, Mar 8, 2024, at 17:49, Jeremy Linton wrote:
> On 3/7/24 05:10, Arnd Bergmann wrote:
>>
>> I'm not sure I understand the logic. Do you mean that accessing
>> CNTVCT itself is slow, or that reseeding based on CNTVCT is slow
>> because of the overhead of reseeding?
>
> Slow, as in, its running at a much lower frequency than a cycle counter.

Ok, I see. Would it be possible to use PMEVCNTR0 instead?

      Arnd

