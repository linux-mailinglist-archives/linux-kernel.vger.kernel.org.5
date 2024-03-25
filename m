Return-Path: <linux-kernel+bounces-117681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 826A188AE5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2475F1FA1897
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7293A12836A;
	Mon, 25 Mar 2024 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IAObQhaW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qwJPF71r"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A33DAC10
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390126; cv=none; b=Gg5yczizOqRdEyUYNRikS6bK07knxjoGdwXIdzF3HIkr9cuYOo+bl36wwKzOlzye4oirb4PQmTgRjDzCvThdO7E6U+se+zWbEMlyTZWZpHHrXRa4Agk7wE158uBHexmGXTgLw9UUKIAARh0K+mJp1YgnMdVi4OUr+QXdkFMKkQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390126; c=relaxed/simple;
	bh=57GXuQ0PujGn5bzQtaXuWZ8GwbdBQalO3xJx6GQyhEk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Fkq+gB1nprEEH/jOaXdE+C9qSCOCShlst1hExgEso74D7ncmzIF0iBAJHB/HcqtHsCByEj7GiqTNSzjBzZpHAI32FL2gfqAez6gZQOCUYX5vZsIRduZGnPXqAzsFCOTepwpbjbWvo8EYDBMO9PDwAJMtx9wyghlecYGcUsfBlh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IAObQhaW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qwJPF71r; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7FD4218000FA;
	Mon, 25 Mar 2024 14:08:42 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 25 Mar 2024 14:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711390122; x=1711476522; bh=ZcheLSYH9z
	/7lCSriLEuc6eCZTAVDwadfvicka689HM=; b=IAObQhaW2lJ4HIE3BXPw23a2fm
	vhgeoNTq6WMOCH1CJ87zAm5qAR1AuV+lBQYh7QLdZExGQ4bVL9LClRniXF5+YA1E
	oDO+Rz7Xv5URLMo4afMYJx7mhVWlHLxYXrcUFCrsuCE7/z0/Sh8qF5/KybZS4SNF
	XXqCl6Jl24Z7Ti3myopeyVrX7/sSheTODOOniDSWNo9BszKjIOSvttvVYsdypuKT
	ktkGXo7JUBdVV5qsv6ZCuScOonOq18KB2WewlxfZOqwM0pPiGNoB0cwsEMd/kKgP
	ypM1N1KbgrETepN621znAnPSB5fz5+YZ/KPOD0WS6XA15Y3A/RTcnP2zGa2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711390122; x=1711476522; bh=ZcheLSYH9z/7lCSriLEuc6eCZTAV
	Dwadfvicka689HM=; b=qwJPF71rsD02gm/LdYKF2MGSIITHRvJAyjtguRKd/VTt
	PfFHLXTJmF9mAr+7r6Gw3OsPtSkc3ydPx287OgW4LinYMvcU0adBAADkPAmY0+IE
	UvWxEsk5yEjuz74UrA+xgZX8ONsE87tpn+W9/JDBJWiJ16pij6VIcku+3ztbTfbx
	E6esWdpBib3N7dyFApyZyasKl7t8ke8+w1QYYvFUxpgLKgH9uHpwINu7Pgn2VfV8
	UANNstPIVb9SUdcdflZHRoGsToKMnC1rC+9opG2JGca014Z60zb2QzYUDznT1cio
	WIoTUc1CgfoiyJqEyf8+Mu2pW16S8xdthOCEjZahpw==
X-ME-Sender: <xms:qb0BZvasH3CLQ8T7vGdisyvVWq32qoRFCu2TWXf_M8Azj_LEB-aa1A>
    <xme:qb0BZubEn0HOMvALgENiDKnPg4Kp1lQNfrnVJumMtuKU7n-NzrRaojtjjy2p-lLEL
    5Uxug0Lp_LrKID0CbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffetfefhjefhveegveeuueejueeiuedvfffgvedvheffjeffveetueejheev
    ueegnecuffhomhgrihhnpehsuhhsvgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:qb0BZh_SVWthjSuAu1VxxWEmgnHOPmEyFLAGSoD5O7SmMVDBDZkWXg>
    <xmx:qb0BZlq9yamXJZmbd7YtqRmWZgV6ItQP-BivgJtQEPbGSyn-mOydCQ>
    <xmx:qb0BZqo_QGLREEgMCXJ5GTulkxvI56i0MlC1Hhg3sTRorKH3rLbnCg>
    <xmx:qb0BZrRzLCxPXlsXUKCzZP5G9T8MpnfIKuU0wy_xNBXLERm9bOGZ0w>
    <xmx:qr0BZlBDDt8vHxnGpn2OXLR7Cs3eln5Zi7s0UwR_tWtNpOSmt1h3AVqVzEk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 63A3DB6008D; Mon, 25 Mar 2024 14:08:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3e9d1217-edeb-4dee-ad88-971795856776@app.fastmail.com>
In-Reply-To: <871q7yxrgv.wl-tiwai@suse.de>
References: <20240322165233.71698-1-brgerst@gmail.com>
 <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
 <CAMzpN2gOZEddWUgncaLutVDihcEK-oEUdSVxsgaaX9xiMWfqPw@mail.gmail.com>
 <CAHk-=wi0arqxMFFdM+jGv1YXXhY+ehxsmcfv+iAndD_dmpYjMA@mail.gmail.com>
 <CAHk-=wg0cMa6B6OeTtXjx4R-kqxWVHSJ=6y=stRuzk8WduJTsQ@mail.gmail.com>
 <ef640185-21e2-46a8-839c-d81030fb13f8@app.fastmail.com>
 <871q7yxrgv.wl-tiwai@suse.de>
Date: Mon, 25 Mar 2024 19:08:20 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Takashi Iwai" <tiwai@suse.de>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Brian Gerst" <brgerst@gmail.com>, "Uros Bizjak" <ubizjak@gmail.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 "Ingo Molnar" <mingo@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Borislav Petkov" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 mwilck@suse.com, "Vlastimil Babka" <vbabka@suse.cz>, denis.kirjanov@suse.com,
 nmorey@suse.com
Subject: Re: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
Content-Type: text/plain

On Mon, Mar 25, 2024, at 16:26, Takashi Iwai wrote:
> On Mon, 25 Mar 2024 15:51:30 +0100, Arnd Bergmann wrote:
>
>> Not sure if they plan to update the kernel release beyond that,
>> or how inconvenient it would be for them to require
>> using the other compiler for future updates, so I've added
>> the developers that last touched the OpenSUSE kernel RPM
>> package to Cc here.
>
> SLE15-SP6 kernel (based on 6.4.x) is still built with gcc7, currently
> gcc 7.5, indeed.  openSUSE Leap shares the very same kernel, so it's
> with gcc 7.5, too.  Even though gcc-13 is provided as additional
> compiler package, it's not used for the kernel package build.

Ok, so for SP6 there won't be a problem because it won't
update the kernel.

> AFAIK, it's not decided yet about SP7 kernel.  But since we take a
> conservative approach for SLE, I guess SLE15-SP7 will be likely
> sticking with the old gcc, unless forced to change by some reason.

From https://www.suse.com/support/kb/doc/?id=000019587, it
looks like kernel versions are historically only updated for
even numbered updates (SP2, SP4, SP6), so I guess there is a
good chance that SP7 won't upgrade either, even if that decision
is still to be made.

I would assume that if SP7 does get a new kernel, it would
not be any later than the next LTS kernel (6.12 according
to phb-crystal-ball), and we could just decide to move to
gcc-8 only after that is out.

> SLE12 is built with the old gcc 4.8, and SLE12-SP5 (based on 4.12) is
> still actively maintained, but only for a few months until October
> 2024.

Right, and it also never updated beyond linux-4.12, which still
supported gcc-4.8. gcc-4.9 only became a requirement in linux-5.9.

> The next generation of SLE is built with the latest gcc (gcc-13 for
> now).  So SLE16 will be a totally different story.
>
> openSUSE Tumbleweed always uses a bleeding edge compiler (gcc-13),
> too.

Thanks for the detailed reply!
 
      Arnd

