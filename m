Return-Path: <linux-kernel+bounces-81373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1DA8674FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE90528821C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9E460889;
	Mon, 26 Feb 2024 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="W4EI36qw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dpGuVNGy"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBCD2E626;
	Mon, 26 Feb 2024 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950618; cv=none; b=Q9Y2ZELsYafDVg1X6Hx4KsXKixf/wHGmPH6YZe7w0YkqWTCxyueTfdy4AS3px9jDzDBQe4cotdPi1OpvX96e9jFJqCDr39ZizoaHGG5AettgoTYBZ6t3IABXieExl6BQSGnvTpe1jHa47/gCOGj4DZTfLNEoBxx7jkha0qjcmA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950618; c=relaxed/simple;
	bh=jXFu1eR9b9KcNi39etPSmQnajolOhrEIf/LugG/HQY4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=K6TQHdZ/0BR2VXlJHGpaNG4nCsyImSb/WaFf8nXlfDmgah0Ecq9Dnx+krMVTauBgw2gE78b2jTK/em4q7jlz1Euq3HneZztVmpr4iFKZ/nBvfJ7Fk2ykApyGD+Sf2CGlO/kA7nwS5d2oRKm/LaCxzroSEgJjCapYh6juAGm9cNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=W4EI36qw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dpGuVNGy; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 332E11140073;
	Mon, 26 Feb 2024 07:30:15 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 26 Feb 2024 07:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708950615; x=1709037015; bh=kdqOYKJcLE
	6gzPeiqYptNFwgezzfiyBuGgmOlyPpbC0=; b=W4EI36qwfvfjuQXPOo7T2wyWgM
	p6It3fuaC+vlenQd31BWnMxCa900vWG/t5emmVmyM1IoyUARWdQhdCIgDtEv0LvR
	b5Lv0jZcYTXrLxGCJkBIudk1Zp1Lndephw1Y/wHrKf/5oeBr49f2Q+Iw6dHhKjWT
	H20kk1cYilaSfR7XPg0WDCZ81Vp6N8ozFpTAtuRB4PtPqxVhchBCmxOS869rgQJM
	/RXU2wo+x2vXgGTN1HfIZE4DBw1EguLnPfwVloYSUQQ61XVScDUE8+IJllLqD1M9
	IcwF192mr0nV0aZxnm8Q6El86dRYwsfC2eJFx+I+xPenUz0D6c4XKhiFJi/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708950615; x=1709037015; bh=kdqOYKJcLE6gzPeiqYptNFwgezzf
	iyBuGgmOlyPpbC0=; b=dpGuVNGy3GXs2Sv2da0+pTzLQ+bkZeYxKzNiiwkGTiGr
	4axYfz0kQzfkE6rgAsveKCLrD2eTAvs/mYbYIRBedMEpQY3Pt2mLd+dRSGw9eZhQ
	kYofoN7HywdTWMvvxSGN87eBok9hhfepVGfYflY4Cg2KMasGhQ3rwnM4YJeEdgZl
	hwWa+1RizRzK9fDDNbpAH9DCjk5OghbZfubv2PYl8zgZhW5t41854TvcqgI8gg+m
	AdT9ydG0uHH4qf/d5XbpiCR56QibxAuD/63+uy60Io4pTNMepHDm6YZIhbe6cWnD
	rpiwmNqhE8jj3mAPu+eIUXOSvl2koZXKyHpJ8zpbiQ==
X-ME-Sender: <xms:VoTcZUero4o1bZNMLtt4sOzb0nIBMw00J20PyStr30S9eHQdggkAWA>
    <xme:VoTcZWPT-9KRT-06J1SxldUgDWQqylet4qdm6tkksP-eHn_SENSPMqm6iV53OtExe
    FbcQzq0EsXk1HRichY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:V4TcZVhLyMWGwXmoPQhezK37UX9STS0dR_oEPxPyDy8M8YGaLqLUlw>
    <xmx:V4TcZZ-Q_DNTxyLQCS73jhLJZcA6Cfiq2xoAsTSAfcGn4s5Dobxnyg>
    <xmx:V4TcZQsyUH0gtbPr1S78erM2VcRDltkHGHfKJozYbRar-jpPHoLlHw>
    <xmx:V4TcZUhwfmKAp4Y1Z6vHjnPyjwi7oCJzDe9q2t5tgkd5lnH_Agz6xQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DB1A6B6008D; Mon, 26 Feb 2024 07:30:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <60e60313-3cc4-452f-a222-aadd7728183d@app.fastmail.com>
In-Reply-To: 
 <simbnmm644ouv3kc3agsxiub6fzg6advihkqsbjzgmb44nmuxv@ktgkhn3kr43z>
References: <20240226105427.7191-1-fancer.lancer@gmail.com>
 <20240226105427.7191-2-fancer.lancer@gmail.com>
 <34af21b5-a878-418e-a70b-299cab61b37e@app.fastmail.com>
 <y2lxeu5uvj7ezlv7kf6lox5e5xprmvrhqmf3gvzjsatlrrlub7@mvqzoyq5mnvd>
 <cc9e02b3-57df-4a7d-bd21-2d574bf4b878@app.fastmail.com>
 <simbnmm644ouv3kc3agsxiub6fzg6advihkqsbjzgmb44nmuxv@ktgkhn3kr43z>
Date: Mon, 26 Feb 2024 13:29:54 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Serge Semin" <fancer.lancer@gmail.com>
Cc: "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Alexey Malahov" <Alexey.Malahov@baikalelectronics.ru>,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mips: cm: Convert __mips_cm_l2sync_phys_base() to weak
 function
Content-Type: text/plain

On Mon, Feb 26, 2024, at 13:20, Serge Semin wrote:
> On Mon, Feb 26, 2024 at 01:04:33PM +0100, Arnd Bergmann wrote:
>> On Mon, Feb 26, 2024, at 12:27, Serge Semin wrote:

> I see your point now. Thanks for clarification. IMO it would be less
> readable due to the ifdef-ery and the new config, and less
> maintainable due to the conditional compilation, but would provide a
> more performant solution since the compiler will be able to inline the
> singly used static method. Basically you suggest to emulate the weak
> implementation by an additional kernel config.

I mean the kernel config that you already need here, since
the strong version of the function is already optional.

> Not sure whether it would be better than a well-known
> weak-attribute-based pattern. Anyway let's wait for the
> Thomas' opinion about your suggestion. If he thinks
> it would be better I'll update the patches.

Weak functions are not used all that much outside of a
couple of parts of the kernel. There is a lot of them
in drivers/pci/, a little bit in acpi and efi, and
then a bit in arch/*/, though most of that is in mips.

Ifdef checks in .c files are not great, but at least they
are much more common than __weak functions and self-documenting.

     Arnd

