Return-Path: <linux-kernel+bounces-117294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 882CD88A9BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0270A342AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C871784A36;
	Mon, 25 Mar 2024 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CacBWkUl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wNoaA6WV"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8DD4CB41
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378402; cv=none; b=IOUVH40q0PRcJuYQs5an203UWISU6FgVomQ4igaPlMoEjBSiKl0v01sHtGblEL7Fl0Wmqret4N9tOTYVYjOURY4ruVfsqByM+Eafhvb7yygW76vi5EAModhpg4ZQvQGb5oHVWi+iRznT5YZcCR60TAqMvLxtEiuyTipxQdMhpYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378402; c=relaxed/simple;
	bh=lXujXot4S9tLJUVp/yiCTHk9HVhI0zfAl8FyIAtNsmE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=CSIUe9SwPq3oTUEH0sy34LcrmEOJVli2z4YfYZco+T6l413N992nlMFzDhBGV/9ZjcmYWuWoB6VbD8lYkUQhi4iBWUAN5CnyB5ZKSx5ox5clgyNRAss5yYBc4pJHuWr7BvLTi67n3+yQ3dpIhZdP6TvxjNdhGppq5AX5RvVc76A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CacBWkUl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wNoaA6WV; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6B6C511400CD;
	Mon, 25 Mar 2024 10:53:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 25 Mar 2024 10:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711378399; x=1711464799; bh=0sIw6prcuu
	pV5nvKsQK5rQFPdaKM0FEnw0vJntKN5V4=; b=CacBWkUlD2v+QLRNylDIpgycNJ
	Q0XjpxI9mXj5+a/fgffp36+OUpAelgIgvRdTB+k0ht4xHbENk6aGOdG1d8vta9RK
	dB3BjlYnMoisuphDQnx1cf/6jgRV/eEXw9eUwrqzTkG/V4eAF/LWsNWH8V8QVQDG
	wCHYlMbT60UpiejIhO0aoxOlw49SqZ4Q+ti2sRxKPX9HNFNMEqFcNPxlxfZcUO/T
	QX9nRdUuwGakBJbNwOp5V37lxLRQYgyW3uhP/sp+9b+nT2gC7z2hIjbM6m5ImFyT
	9ZhIlvBPLv5KVUtY1BpNH31cauyFzQpw7rQBgLAY+JRhrXUPTvcojR/2ZbuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711378399; x=1711464799; bh=0sIw6prcuupV5nvKsQK5rQFPdaKM
	0FEnw0vJntKN5V4=; b=wNoaA6WVq2M2ez/tZC5pJRN8zV7OSZ4DJA7eYxQJMXSl
	Igeok9NYFDLHrlIqa7956qB/Q33sMUCvovWjDg55RhzAcMloGkACtzPwZEpAfGdw
	tftlH3w+ncmafiACZRpdtue/x+MVyCzy4RzwehE13QWaG9wEqvSaSgdUJn4Youeg
	+QjBvwZgRH7jNSitJyTtHbm0cLKwpLkPMNlxQguQr68RqSO5u3AYUUbH3IZ0QhW2
	iqA7s1H7PaiSu4pPO+ym1Q0cxdBr62Abk6uUpR6t3b+he66w/EVaYI8Vd1oZRc4Q
	JrI/WOGwi4+sLA/P8l1OcUKEudB64/Zmhr/OiI8XpA==
X-ME-Sender: <xms:3o8BZqAW1yvMTGri4GZV8Rhe60Pz3WUuuLQsffLoN48Vbjv2L-U_bQ>
    <xme:3o8BZkh-XswnF7m3FWJR4a44IsGwVeAzXPvvcUsqguDKtPyn-htiRJwxe44E-rCIW
    K7nlMmw8tRIkoFYVaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepueduteetveehgffhteehleeiudeigeetfeeliefhudekfeffveehgeegteet
    hfdunecuffhomhgrihhnpeguihhsthhrohifrghttghhrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdgu
    vg
X-ME-Proxy: <xmx:3o8BZtnMcLtYUb5H0jH-3pERGnoMf0ibUHcm7uJ8kSfV7yM0k35CtQ>
    <xmx:3o8BZoyaAXLEZvD5sPp_Ml8gGbiF16WVbO3iHcIOyWe1Z7Z_tGIASA>
    <xmx:3o8BZvRZ3BgCSOMtjTqBXQHqhK0eO4Umz8_ns2eKDnC5sqe03CbiZQ>
    <xmx:3o8BZjYhepTIDOY825gGZW2_5IY_WFMlHr_zyuumLO_K3Ueroxs6LA>
    <xmx:348BZrqGJHYnhoOV2yQBV_sbdobcxspgOWZIuigRg1E3-zPwPSMc-w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B8306B60093; Mon, 25 Mar 2024 10:53:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ef640185-21e2-46a8-839c-d81030fb13f8@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wg0cMa6B6OeTtXjx4R-kqxWVHSJ=6y=stRuzk8WduJTsQ@mail.gmail.com>
References: <20240322165233.71698-1-brgerst@gmail.com>
 <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
 <CAMzpN2gOZEddWUgncaLutVDihcEK-oEUdSVxsgaaX9xiMWfqPw@mail.gmail.com>
 <CAHk-=wi0arqxMFFdM+jGv1YXXhY+ehxsmcfv+iAndD_dmpYjMA@mail.gmail.com>
 <CAHk-=wg0cMa6B6OeTtXjx4R-kqxWVHSJ=6y=stRuzk8WduJTsQ@mail.gmail.com>
Date: Mon, 25 Mar 2024 15:51:30 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Brian Gerst" <brgerst@gmail.com>
Cc: "Uros Bizjak" <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, "Ingo Molnar" <mingo@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Borislav Petkov" <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, mwilck@suse.com, tiwai@suse.de,
 vbabka@suse.cz, denis.kirjanov@suse.com, nmorey@suse.com
Subject: Re: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
Content-Type: text/plain

On Sat, Mar 23, 2024, at 18:06, Linus Torvalds wrote:
> On Sat, 23 Mar 2024 at 09:16, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> The SLES situation seems somewhat similar, with SLES12 being 4.8.x and
> SLES15 being 7.3. But again with a "Development Tools Module" setup.
> So that *might* argue for 7.3.

According to https://distrowatch.com/table.php?distribution=sle, they
also provide gcc-12.2.1 with the sp5 update, so we're probably fine.

On the other hand, I can see that OpenSUSE Leap 15.6 contains
a fairly modern kernel (6.4.x) built with the gcc-7.3 system
compiler, and I think this is the same one as in SLES.

Not sure if they plan to update the kernel release beyond that,
or how inconvenient it would be for them to require
using the other compiler for future updates, so I've added
the developers that last touched the OpenSUSE kernel RPM
package to Cc here.

     Arnd

