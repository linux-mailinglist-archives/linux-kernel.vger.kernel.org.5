Return-Path: <linux-kernel+bounces-92602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 572C48722BB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D6D2838DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D55128399;
	Tue,  5 Mar 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LD6puupe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fyE1OlkM"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50961272BD;
	Tue,  5 Mar 2024 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652403; cv=none; b=KXs0OsWHKQ8gKIHxFLZwV5f732SXlYjC2nHoDdJQaTUWlX/1qLB1aWc9PXVa0A1qqWSrd7U+pNL0sAd4mrdr/hcIva85POEi5+PPx+hnRzgdu4NeGr3tlpkXhw+PO59RSvQHzZ2mk0f2CzfdZRyticv32vXkdqsJ5Wp9mRGn16M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652403; c=relaxed/simple;
	bh=9maXCI32il46CAjYFMVaT0KmmG8v0yRwsxQO5+iiyJ8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=iJToBBCSW4tuoBBgCdRdaV+59yhOo2t7J5EEFqrZuv2D6HSE99iFNjyJoQIdf1N3u1IddENYLD7gO7K4IyvlpVAYQGJ6uCogoEgTswpVQM9wseMBr+viUZCc8i1utdMnEX8NkP912DuxIOu+UVjJbtf/jfpfznBBFlR63HvA9ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LD6puupe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fyE1OlkM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B628E11401A6;
	Tue,  5 Mar 2024 10:26:39 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Mar 2024 10:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709652399; x=1709738799; bh=mM85GnrQKa
	FCJuhHp4V9npg1BWZBV42eoS1VwxzuCH0=; b=LD6puupe+UYOkygnrRV11k93IG
	FEk6aU9K7Z55tgyn2reA3mFxo0W4CYRmjjOAhKOEFTEGAPi7Ypmw1ehHwIA5K3ZK
	eLV+VZQ8EsHofPtAV2c9qHouQRi/mNvfKrDK2tpeT4h1FsdaINq9uA3j25JAemq6
	puN3yKfmv12w8vE2Vv//nflnuBhoncMRNRNx+zhb/sTru+Q3+2ckpN2Bm0GkgXo+
	pKjrBIb0sKhkgiXB2aAjH+8NdoFIGpGKpdkKAg/nweksABcaB0aWs+KDWBkLE65Y
	lzC4jGKnwivC9mlK8CAikGWM1d7lxtO4MtWR1Hs6Mohj/2ksa3zwcfBiHITA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709652399; x=1709738799; bh=mM85GnrQKaFCJuhHp4V9npg1BWZB
	V42eoS1VwxzuCH0=; b=fyE1OlkMCmXfWWiJZ5I3zI/w9Bi31o+HrIJZpPGwKbSf
	JGx0KY48Zebpx83JVAqr6b+dXqCSZRKvnfDe/FB0zSMvNfWHwqhTPzd01xV7S9be
	fBODFpYbHWJ0zJ+UoAGusUoFxokByyYAwcpHMQIgYpUeNfOQtDWw8ZYDQdnzTTdo
	pyL6au0ELZqWY7stgLH7jwIjowUqqt4pPMB7TRRJEOjyYFIAM+AOO2VAc9l6exyj
	RbJ6ridJpV1dLIzHmyLqiPEVNyXmje0alQaCBbZB4kpwv/SQEbER/rO43aHy0dcX
	JTJ/bNZefEC8HP6qITO9XW+tXsjozIg1xv8RQ+klOw==
X-ME-Sender: <xms:rjnnZQT_uezG3J2Isg5QTmSwV_S5nQuCAt2GlQOU0uvfFQfgef1Hfg>
    <xme:rjnnZdxI9b3evSjdQYXvh-SLgMH1ZkRL9X5QTyTLLuYXP7jqP9xXBHPP8HMuPGVRS
    SPgxZpXF9KVgzQVaWc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:rjnnZd0FFiuD1NSQOSB6esRu9mO98ISH7SWQAC0hGSqoakLRtGCgCA>
    <xmx:rjnnZUB5RHRgQb0ZBqkM10fCRCSvcmCIsvWkkGcEh47zjKRXoiuiNg>
    <xmx:rjnnZZjkWokGwIT-6TJbYbcaFQeQX7z5PX73sAB8gMVKbcoh5_HSqQ>
    <xmx:rznnZaUfdtytSpaj9K9kcFrXqUTdqR8krMDGrq3XzfZE22DbsEJRmA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 73417B6009B; Tue,  5 Mar 2024 10:26:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5648dca0-4853-4dfb-91cf-282a656beb1e@app.fastmail.com>
In-Reply-To: <8d5780f5-1047-48d7-a9c9-09b95c7b5604@gaisler.com>
References: 
 <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
 <8d5780f5-1047-48d7-a9c9-09b95c7b5604@gaisler.com>
Date: Tue, 05 Mar 2024 16:26:18 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andreas Larsson" <andreas@gaisler.com>,
 "Sam Ravnborg" <sam@ravnborg.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 sparclinux@vger.kernel.org, "Randy Dunlap" <rdunlap@infradead.org>
Cc: "Miquel Raynal" <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S . Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] sparc32: Do not select ZONE_DMA
Content-Type: text/plain

On Tue, Mar 5, 2024, at 16:06, Andreas Larsson wrote:
> On 2024-02-24 18:42, Sam Ravnborg via B4 Relay wrote:

>> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>> index 734f23daecca..bdbde506c01e 100644
>> --- a/arch/sparc/Kconfig
>> +++ b/arch/sparc/Kconfig
>> @@ -62,7 +62,6 @@ config SPARC32
>>  	select HAVE_UID16
>>  	select LOCK_MM_AND_FIND_VMA
>>  	select OLD_SIGACTION
>> -	select ZONE_DMA
>
> This however makes a number of PCI drivers that depend on
> ZONE_DMA unselectable.

I think that is the correct thing to do then: the only
drivers that I see with this dependency are PCI sound cards
that apparently rely on DMA to the 16MB ISA range, which is
not provided by sparc.

      Arnd

