Return-Path: <linux-kernel+bounces-129371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34F7896996
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF3028AA65
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050CB71B3B;
	Wed,  3 Apr 2024 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LGR2quk6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cjwd4uNr"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C92F6E2BE;
	Wed,  3 Apr 2024 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712134291; cv=none; b=Kwy2IvJsTmI3A60a43je0J3Qbo6s8MAaIxnmgJcao16Z4bxLBZXzVPjdUOGe1FwpYrNjDvtICZiQI6C5MPQvblob/bQhlqTNs3szJh3NzUess7z8fQn2BAm4+ffX8zJJiMAWALtFUVJPRR1TEHGsuPhVxP3/lK055AxUUdZGr3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712134291; c=relaxed/simple;
	bh=P1cwV2YXIakKbwCYEURhjXiCMMQo/OuU51t31+urNz8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=EsaJoWVrAnFKJypGMKl/u/u6isb07il9U+//9Orw7AvsW3BBQMWzy/Nw+PAyruHu+G1bKOMNQxKeanvL18TjOGUFAEd/bVA7B0CieEDePuw3iW233EFJ2wH/BZY/11p4Jt5nIwVOKgXESoPp/i2DHGfrilnICEWCSeQ58F4kyHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LGR2quk6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cjwd4uNr; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 71FE91140094;
	Wed,  3 Apr 2024 04:51:28 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 04:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1712134288; x=1712220688; bh=IDm9a9kuZK
	Gr8VNhzI80ELq/9SON+I1L85BL3jH3M48=; b=LGR2quk6JYv7Fnxq/DHuNB2s1l
	6Ys8LLJKriPHlHTWOxFB9RsOvILxcS/KYYwjrIGkGBfhIuC6uJxiMQywv0+g1Aqi
	8FYEiccMNVK/JM+9/wvFtP5Fw1F8kgaiZ6gliWPO1A6/eOeKOJLqvcUF3ylLAAlv
	zwl1mP7HPfWIKsePCNEMejjKQxudWNwarD9rLsx0koyjvFwDf/honupj9EX9XCjy
	bNtk0jDvVnb/Sz0cSkLE5K7XZ2/agL3OccZ2Mc0uvhAkMZaWp7AXYNG4koim1/JO
	NWrCRHyNlg3Ew+NUDtI2loKoT+PAc519YKeQkoNdJP594Qu6z51d5uFo9lYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712134288; x=1712220688; bh=IDm9a9kuZKGr8VNhzI80ELq/9SON
	+I1L85BL3jH3M48=; b=Cjwd4uNr7CNtFCTbVUASdb/gpU8laqnra9RJirerO12G
	5SOUnLJXyFizzdU931oTSlEXaZ0BkAg60Baud6Aj/II0MKvLDLlSYr2oJBrvT07G
	+41EN83FkxhBNyCusJQyF0Hwit7nA3+A7ni28b/dAWW0S2T/fi7/3JLNiwWI6FoM
	YlAJWV4vEHbP5nGTTmFZ15WoWraZadPrWUGtI7m/NHC7urjFsHeHkIwB8EZOLTct
	1GrnBaR/+9Aw4G6lbtigODY6AK3nVq5QtixWUZ0iFYpkvPsWxvRW1PEUrhe7hs5X
	XZ7rx4ckokuvMkOPVe83besvIx+NGyfZTgpqQOR2Pg==
X-ME-Sender: <xms:hhgNZtXvNOjkAzXlKU2S-mCW9u3j5wLIVQfd5wC8qQmSq_qnAnwCQg>
    <xme:hhgNZtmXVYTJFf-Tmxh3x3SMEs7vMRyTW6prvF-Gfft6gVtGtUbGPSiOOrBngiLDr
    mmjTcWDG7DgKC58IiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:hhgNZpb1SmAvdwDtaADdU7RCPeYtj3G-cjcl8MCqc_LXkz2OARytAw>
    <xmx:hhgNZgXBuhcrfqmG4oNJ2oFuxNGGyBa9wI4cai7SSYjP1L2zioJT4A>
    <xmx:hhgNZnlxzmaOiuIsGolQHygyhiSevEVET7FbwOtq09HTP5LYdMRPNA>
    <xmx:hhgNZteiS0q-w0Bl5BoF7ggzLACbmrTGyhZP_YKTekkOW1XRrD78cw>
    <xmx:kBgNZszUXsOXBABkIH0w079vQIq-Q6q7U_daNQWZ5wEu3CUNv6LzgMn7>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2F269B6008F; Wed,  3 Apr 2024 04:51:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <78731619-58a3-406b-9112-5eb991bc6e7e@app.fastmail.com>
In-Reply-To: <a1ca8aa3-d122-4ec9-b239-8180a02106e1@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-31-arnd@kernel.org>
 <a1ca8aa3-d122-4ec9-b239-8180a02106e1@kernel.org>
Date: Wed, 03 Apr 2024 10:50:57 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Damien Le Moal" <dlemoal@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>,
 linux-kernel@vger.kernel.org, "Niklas Cassel" <cassel@kernel.org>,
 "Saeed Bishara" <saeed@ubuntu-saeed.il.marvell.com>
Cc: "Ma Ke" <make_ruc2021@163.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Sergey Shtylyov" <s.shtylyov@omp.ru>,
 "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
 "Jeff Garzik" <jeff@garzik.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH 30/34] sata: mv: drop unnecessary #ifdef checks
Content-Type: text/plain

On Wed, Apr 3, 2024, at 10:32, Damien Le Moal wrote:
> On 4/3/24 17:06, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Building with W=1 shows a warning for an unused variable when CONFIG_PCI
>> is diabled:
>> 
>> drivers/ata/sata_mv.c:790:35: error: unused variable 'mv_pci_tbl' [-Werror,-Wunused-const-variable]
>> static const struct pci_device_id mv_pci_tbl[] = {
>> 
>> Move the table into the same block that containsn the pci_driver
>> definition.
>> 
>> Fixes: 7bb3c5290ca0 ("sata_mv: Remove PCI dependency")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> The patch title is also not describing what the patch does.
> Are you OK with changing that to:
>
> ata: sata_mv: Fix PCI device ID table declaration warning
>
> ?

Yes, please do, thanks!

I had first tried to remove all the #ifdef checks and just
rely on dead-code-elimination doing the same when
pci_register_driver() is stubbed out and IS_ENABLED(CONFIG_OF)
checks turn off the rest. Unfortunately, the include/linux/pci.h
interfaces are not all stubbed out here and cause compile-time
failures without CONFIG_PCI, so that didn't work out.

     Arnd

