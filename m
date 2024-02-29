Return-Path: <linux-kernel+bounces-87330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C2286D2EE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81EC284A20
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90476651A1;
	Thu, 29 Feb 2024 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="maUn7J8h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dfm5r3+7"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5172F13442D;
	Thu, 29 Feb 2024 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234129; cv=none; b=BF7ThBCpMBYHV6QTsA4dotPrqMOV+Wlg7GQeK4yNHuCnZYQ1yEbMv28J31siWGFEFcfz7uBiWVWNiFLaNk9vGFsQsk9vXo2FNtn/+o+UbzRPNB7C5BG5zK1MhvAVxupmdqAgjNdMbQoY74jwEw85jUctsvySeeBQUzC6Lk6fzXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234129; c=relaxed/simple;
	bh=zXomuryHc3URaDVyA8RmSDnNUVl9W1EXal3bVsoWlF4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=O0qgLn/KUKzN7KsWOUWApd09yEkSBj6cKgSEudO3CCtXxGjmdU2mwm6GZMCkYG6AMsnR1wr9P9nNOGd0IHrkgzQ1f2CvfrvpzBdH+MavE5Id8fTvVcwZGiA6T1OBLc4/PQTd81EAuZyEhS6f8H+651zrx6bfPBkCIqRESPO4Erg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=maUn7J8h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dfm5r3+7; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4D77E13800D4;
	Thu, 29 Feb 2024 14:15:26 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Thu, 29 Feb 2024 14:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1709234126; x=1709320526; bh=19TErd8Ckr
	DetDe9IDAuQlxdopRaTQfnJEAjo+XBylI=; b=maUn7J8hUeDgrsNtrY7v6xeu8Z
	1CfPig1dL+HbO3HSdU/UAwTtNqnPUWfXVwgbqkwUWpf6zJJ2W/7yWG46HIK6XIrT
	/+eHug7NZTlHZfa4ca4bv125OtWp8Tz1UAQQh5rzhzx/ifhgv1SRXbPnMzUVknMX
	JSn/Dxnj5r3Ccb3HzHQMLHEHc7bx5jDrARAtHk7Y5nATFrVPygIXwn2qUuLhZSE1
	e+gIuZU4uqnos2jW6+M4P7hVf+ZNDbPAD5ZGQ+AC7UKZDaY+dt23biOWx84GS57S
	K68/SuarQwKQlrFZqBp15LbkElR0vWUfQgcHTvZteB6G211hjU3he+UEzKeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709234126; x=1709320526; bh=19TErd8CkrDetDe9IDAuQlxdopRa
	TQfnJEAjo+XBylI=; b=Dfm5r3+7Y+jzCThCJP3T8ojofWKN9fSAolUOhCCiMCj5
	gVxg/8CQ0qMS2lLtSUjDMxofoT5Q2zcoH9zWYy6RM8raruGEy68m4WVnHFnxgZnv
	GBIcaAPM1a1Hhfe8CyjLYivLSxA4ZYFdq9EICdVjN4qsRydxxZcOzYn0wGZxstnC
	bmxCPZs63hzXQoRti0jeiR9yQVtdLoB9LofKtHDI/89vicNNvsh6bOIU+cifw2t7
	cf2HAvzNHEev6jXplXaxCAqk2JtF7Z+ifq2vHI3gTtbgqPXA8aLy7RrI3K223/fS
	kNKzjzVXx21Yf77+QKgJK/mPR+5lecNnlb/GMTrqxA==
X-ME-Sender: <xms:zdfgZdX4eTqSZwYYs-eXSeCWcqKUpdHkTv9AoE_1Tro48_m7DiiZQQ>
    <xme:zdfgZdls0N283m1DJr_jbWqYpowcrqAbDEShrXrpVanlHORy2WvKuvygkefC6bp7L
    qgJLWCOp9XHnCeAhVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeelgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhesshhquhgvsggsrdgtrgeqnecugg
    ftrfgrthhtvghrnhepueevffdtfeejveevjeehhefhveefleffheefgfehffejtedvvdfh
    udffgeehfeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepmhhpvggrrhhsohhnsehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:zdfgZZam9TBcUMr2v0fQvKhL46M9sWEMao3YuTYHBI3WXHa8gE55rA>
    <xmx:zdfgZQUebncXE8BM0h7M1VWj5hs47AIb3_7hjWCrroxc_tLq8egaQA>
    <xmx:zdfgZXkKuwfYmgGcP9y6SNt6kerTo8wDiYZ8GqPIGbtFm1DhS_YFqQ>
    <xmx:ztfgZStAJ_dphyceWcCQ6kysO_dcv2epMFrIJJ7SgrMe3cTBv8gq8Q>
Feedback-ID: ic2b14614:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B6E0DC60099; Thu, 29 Feb 2024 14:15:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-204-gba07d63ee1-fm-20240229.003-gba07d63e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a91ff3fa-5c0f-4302-9f98-6cbb254e747c@app.fastmail.com>
In-Reply-To: <06bf41c9-34b8-4361-a6d9-72afeddae1b4@roeck-us.net>
References: <20230721122931.505957-1-dober6023@gmail.com>
 <a361ce91-beba-43d8-b969-285063658da5@app.fastmail.com>
 <6b0373a2-7750-4d57-8839-95c6fa30c6b8@roeck-us.net>
 <4209014c-1730-4c31-87d8-4192d68bcbc6@app.fastmail.com>
 <6615ab2a-3267-477c-ad1b-a72d5a4244e0@roeck-us.net>
 <412acdd3-6b1f-4c45-966f-c493b6fc3ddf@app.fastmail.com>
 <42a7e7e9-01b0-4d41-8af1-328de90934ef@roeck-us.net>
 <74a39cd0-cee3-49a2-a47b-92a9cf9ca008@app.fastmail.com>
 <45490a63-e46a-4eb3-a55d-2e2642588ccd@app.fastmail.com>
 <6066862c-cad6-4845-8e90-32d4572c7a23@roeck-us.net>
 <6c97c63b-af35-4919-b5a2-a867776be8e9@app.fastmail.com>
 <06bf41c9-34b8-4361-a6d9-72afeddae1b4@roeck-us.net>
Date: Thu, 29 Feb 2024 14:15:38 -0500
From: "Mark Pearson" <mpearson@squebb.ca>
To: "Guenter Roeck" <linux@roeck-us.net>, "David Ober" <dober6023@gmail.com>,
 wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 "David Ober" <dober@lenovo.com>
Subject: Re: [PATCH v3] Watchdog: New module for ITE 5632 watchdog
Content-Type: text/plain


On Thu, Feb 29, 2024, at 1:47 PM, Guenter Roeck wrote:
> On 2/29/24 10:12, Mark Pearson wrote:
> [ ... ]
>
>>> Is it necessary to treat this differently than, say,
>>> drivers/hwmon/it87.c and drivers/watchdog/it87_wdt.c ?
>>> Those work together nicely because most of the address space is
>>> separate; access through Super-IO registers
>>> is limited enough that it can be shared by using request_muxed_region()
>>> in both drivers.
>>>
>>> I'll have to look deeper into NCT6692D (and NCT6686, for that matter),
>>> to see if those require mfd drivers.
>>> I'll also need to get the datasheets for those chips and confirm that
>>> they really need different watchdog
>>> drivers to start with.
>>>
>> Ack - I'll look at those and see. Quick look at the watchdog driver and it looks possible but I need to check the details more carefully.
>> Afraid I can't share the datasheet as I don't have permission to release it. How much of a blocker is that for you?
>> 
>
> I do have the datasheet for the NCT6683 EC space. I'll need to check if
> it matches the code submitted for the NCT6686 watchdog.
>
> For NCT6692D, I asked Nuvoton if they can share the datasheet.
> Given that it is some kind of security controller chip, it may well be
> that Lenovo has an NDA with Nuvoton which prevents them from sharing
> the datasheet. We'll see.
>
> Undocumented ITE chips are simply not supportable. No matter what, someone
> will have to step up as maintainer for those chips.
>
Ack, but given the ITE chip is for our platform, are we as the submitter not on the hook for maintaining it - especially if we're making so it's only usable on the Lenovo platform? 
I'd expect myself or David to need to respond to any issues.

Looking at the it87 driver - it looks like the main thing is the request/release of the region when doing a superio_enter/exit, which we are missing and would be needed. Can definitely do that in our version, instead of the MFD, if that is preferred.

I haven't gone and looked back at the NCT devices again. Need to do that.

Thanks
Mark

