Return-Path: <linux-kernel+bounces-17767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 204C582524C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314AA1C22FA8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C11250FF;
	Fri,  5 Jan 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Cwxb63r3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5nrcx3kc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9729250E7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 93CF95C012C;
	Fri,  5 Jan 2024 05:46:17 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 05 Jan 2024 05:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704451577; x=1704537977; bh=u0NWzru5Np
	WplG3MtwbrlDuQ2qJ6q4k8/PVrz6ggq5o=; b=Cwxb63r3mNFLSakIK7Ki7zERTE
	Rfwy3G1wOmRwhG3EPCCBJWvXH6ffzJdX56hr7Mc8cO58elCzMQf4F3sjP9VdyB+V
	Xv9+4ou2noNAjl9hm/HCC0odicrH3mz4C93d+h3gcQei7rrOEa5cS8zzibf6CluV
	ogbaaa/F/VKRdiaMk+7+rhVVAuxL8YPyqQcUxRN7C/5Uz33qkqXPPeoCZLoL07+2
	AIiIjaL8BuZWRkAUL8JK8rr88Cmdew/xgkt6rLJWTLgI/bYMZXkp1VR5/AzfEOg/
	YjgsEh5eTNfAmImCfFqv9A5ELhXN3V0nNB1+VfmCEkn9bqi8OfGalIJdPBog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704451577; x=1704537977; bh=u0NWzru5NpWplG3MtwbrlDuQ2qJ6
	q4k8/PVrz6ggq5o=; b=5nrcx3kcmY25shycuY70VQ0wyoF5MBa4qLEHPk0SX1i1
	851AddFTWSWC/oi4esje8q59Wxi2jTQASPLCHKPJ1WPrJgxLATg9eYM1jrbdXZGf
	0qspfrrpcw2JfzZ067E+OwSznC6SLL2bJBYwggyRrI6L3PDR4E3vQZAsY1PscOUX
	+XwEti3L75KYqBJIOP67nLMJ9S0SbmhtK0BCnhlEhxEGtpPaiN84RNJdPRW8VvqA
	Qtz6eK4YQvnlDBYt8vQph5YMbw7Vbm8DldmEzPGYp2X4kIW7HuCH1Svpq0ZxbjpW
	9tzy+6BNRTcECTgsV8PMbO7SpqY1oJF9w/DZ5IxzYw==
X-ME-Sender: <xms:-N2XZXwN5WLurlkz-BMOgsubhBFKLpBOGE1CxlDs4t15dhjN-71Y-g>
    <xme:-N2XZfRB6iP6c-eBvzKBouYdVnBK5RkPWk4HWLJOOfEpdlZP3JnGYwyGAUJDILPD0
    xQe56bL1vAwLRR2FmI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegledgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:-N2XZRWlTx6-s4i4GPrMnVXg6-xTLwuyvcmZoNLKKKN2b0rr7lUOrg>
    <xmx:-N2XZRiUeSD3XDWiLLY564guSNUe-0aDCkgKb9pNuZmQEC4aQybM6A>
    <xmx:-N2XZZBiNaHC3zYf1dmGhrZxaxWrs4zRBZWRl5mH2Y3SGiDkYSAfUw>
    <xmx:-d2XZTAx-EdDKo0vW_RTg5zpyNJuABSrGKR0P3_OEV6bi8WR6yzCYQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6FA06B6008F; Fri,  5 Jan 2024 05:46:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <582b9eb1-b50b-4c41-80b4-9cc1444a7801@app.fastmail.com>
In-Reply-To: <20240105041458.126602-3-leobras@redhat.com>
References: <20240105041458.126602-3-leobras@redhat.com>
Date: Fri, 05 Jan 2024 11:43:42 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Leonardo Bras" <leobras@redhat.com>, "Oleg Nesterov" <oleg@redhat.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Mark Brown" <broonie@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Guo Hui" <guohui@uniontech.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] arm64: remove unnecessary ifdefs around is_compat_task()
Content-Type: text/plain

On Fri, Jan 5, 2024, at 05:15, Leonardo Bras wrote:
> Currently some parts of the codebase will test for CONFIG_COMPAT before
> testing is_compat_task().
>
> is_compat_task() is a inlined function only present on CONFIG_COMPAT.
> On the other hand, for !CONFIG_COMPAT, we have in linux/compat.h:
>
> #define is_compat_task() (0)
>
> Since we have this define available in every usage of is_compat_task() for
> !CONFIG_COMPAT, it's unnecessary to keep the ifdefs, since the compiler is
> smart enough to optimize-out those snippets on CONFIG_COMPAT=n
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

