Return-Path: <linux-kernel+bounces-130135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6211089747F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115D5293056
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE6314BF97;
	Wed,  3 Apr 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dz2if+mR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IGRVSDj8"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F033B146A96;
	Wed,  3 Apr 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159448; cv=none; b=pFstUCat2rVlWskVtLDDnMnlXywcubx58LmvKOFfJIU7KUs1VLJijGI14DddojQrwp+urZWrRqPhvW6gaH09NzU2JSF327aqygYG8cSJiJ4/9PanhUMddXTgoz2hMSRHNmrBs8RAT3OosviIPoK/yPRaEyEZTcJHXVLhrIGgjSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159448; c=relaxed/simple;
	bh=uFr/skVLhS1k3c7q8qe9cHlRpUnBT4639sAJYyygcq4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Pz2ncl+n+iGsOacVJQlhkxovTp23PKTyUW0SnFkNEGCFYd7Y6+mq0seEtqM+PNi80huqj8tFXaqp6v2Vv6NWPICsno9ZhPHbnMXRy36VAKBrxUloVqmpuUV6B/QhyFmtLH4y3ZsJ7yuOdrScAfTGOQ7GfpEXVme4Rmw9fUqUMh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dz2if+mR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IGRVSDj8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id D84F11380124;
	Wed,  3 Apr 2024 11:50:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 11:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1712159444; x=1712245844; bh=TryBBe0l7o
	sJOQgOLFDSpuO7ArwSuBY7uBCGJfdpPe8=; b=dz2if+mR6qDpvZmiU5S+DNAa2E
	9p5epSWBU7zbZfknkQPs08hcESu4Gv9MqRd00qOtdVjirHz4s9xJ8Yr3zXCZQ+go
	LPMCEJd5doBc+/5ayEGCmmhHcy7R9dYrZmEx6fBDzlxRBbJDaJspQaF/jrjpt8Je
	yWDmUwonarp/cQjcZvAdQ/jVl0R5ibzyX/AD7+tz8OGziINnyJbMEWOU7P7dZmTa
	2rniPxCX1KS5FkzJMVOVPQW2SFoBpkldeqAiWWJpQOdgB8plSzDJO0TsZa+YdCND
	i8YRHB4NRcSFkfqF2xSvW8L4AkGPwTzn7AYsmgOlCwSdJjQOQfNlTcWVd8NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712159444; x=1712245844; bh=TryBBe0l7osJOQgOLFDSpuO7ArwS
	uBY7uBCGJfdpPe8=; b=IGRVSDj8ZsWakqdS+p6lpJDs4SrZKYVQq2C2dEVyLKYi
	GQBWWZQ3XgoPkl9hNCbR+yFHRbTHHaE3oWCL5ap1LmsOnBIcg3H/evxM7Q+bzzhw
	dy6DAIc8l4VAcwKkVtt1RcLkCQ3uittAA6yuozKxoMdF8wHs+egpDr6u7RA9TPfR
	AJ0axSfgr7g2uF3iuVJpuGJWAMMlLNu47WSQSZiATpCgbjMdc6ilshBONl5tbO3O
	Xp2cTjkx8NBRTcYBqGpoWspYVsP624pqeMh8yku7qjj2ayJFVSLtn63b2/ka645g
	hXwh1HGeRPSxOMs5HSYpUVJL3i7QfxwnhGM6YhVI/g==
X-ME-Sender: <xms:03oNZucDDYsbhlfq3f5AZwMd6HAECWSU-uZlLsZwr-KSXxlAonsdHQ>
    <xme:03oNZoNP9hjENGBYUVLgVvEyIepQ3_i_-PbYG-0ZIUdao65Rg412UjBaGsj6CuIap
    F9Gn_rP9ShOfECJIAk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:03oNZvjkc8pffHKULAjFk0l6-vE6BzsImrBCx5DmkH_Ld-SfwCzT3Q>
    <xmx:03oNZr-5krwo-MBzZBQXjjNtuurVpw8ooTXzQLr7Ty9wvWnDjrya8g>
    <xmx:03oNZqt0sjd-QsTE-N3kPK7QYE3OAIvDZuU6nysr0zhAe8ckiXlNVQ>
    <xmx:03oNZiHrV2TRQe1GQYZbfJHI4GFoRQjmIrnLhUEaVAtathLRF4nLGg>
    <xmx:1HoNZoD7RUebSGBCaH1THA-nrf9r1iPhS8VM8LzX1bxRhwz4jnZMxITt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4CB7AB6008D; Wed,  3 Apr 2024 11:50:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ac96323b-80f7-43c0-b99e-b7772eb26802@app.fastmail.com>
In-Reply-To: <dd7977b9-bdd2-f36f-36bd-a383a2588f6e@amd.com>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-25-arnd@kernel.org>
 <dd7977b9-bdd2-f36f-36bd-a383a2588f6e@amd.com>
Date: Wed, 03 Apr 2024 17:50:23 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Tom Lendacky" <thomas.lendacky@amd.com>,
 "Arnd Bergmann" <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 "John Allen" <john.allen@amd.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH 24/34] crypto: ccp - drop platform ifdef checks
Content-Type: text/plain

On Wed, Apr 3, 2024, at 17:17, Tom Lendacky wrote:
> On 4/3/24 03:06, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> When both ACPI and OF are disabled, the dev_vdata variable is unused:
>> 
>> drivers/crypto/ccp/sp-platform.c:33:34: error: unused variable 'dev_vdata' [-Werror,-Wunused-const-variable]
>> 
>> This is not a useful configuration, and there is not much point in saving
>> a few bytes when only one of the two is enabled, so just remove all
>> these ifdef checks and rely on of_match_node() and acpi_match_device()
>> returning NULL when these subsystems are disabled.
>> 
>> Fixes: 6c5063434098 ("crypto: ccp - Add ACPI support")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Would using __maybe_unused on dev_vdata be the safer, easier choice?

It's a simpler change, but leaves the extra complexity that
is not needed here.

      Arnd

