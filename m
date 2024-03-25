Return-Path: <linux-kernel+bounces-117682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900E888AE5D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26C51C6078B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D991524D8;
	Mon, 25 Mar 2024 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fS660U1h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H+VPet54"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2019C136;
	Mon, 25 Mar 2024 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390309; cv=none; b=dZTvKOorZqio3pgKC7yKrCuZW0u+keft9OpwituVcIQoAjvHs5K4mLDEbe6jnNqxeQD4dN8ODdYqAzx5Q8QAlKsApWQnNWg5ZbP6DQ4avnZx15+O5YI4OgvOsPjSCVGs11St6b53fqX7xsx3lRP8dZwIAFEEOtMWlgIrFOVUTSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390309; c=relaxed/simple;
	bh=VWjCK0A0o0a/wQcdaC/U8lJXJ+TjP1sEl8eLKFH7/Bw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Gt7hvCbD3xeDtds0nRlIrX9MyAlx4RctQokne1IKA4NMk6nbdNqbYQV9jbyxb64fOMidTRycW1aEYT/zKwFGZ2thWD3prC4o6kXK1OBwWxtvo/U3lpl2leew8jKs5bT3K9BpmfuSGmMyI54thpexLnN4EprLxqOcQkfcRn/jjC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fS660U1h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H+VPet54; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8ED3C18000A9;
	Mon, 25 Mar 2024 14:11:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 25 Mar 2024 14:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711390304; x=1711476704; bh=ZOF0LllNEk
	KwlFc4eVFPUYe1z5e6mKp1Z3VJw8CX4q0=; b=fS660U1hG06tBjiG8AmosLeM/q
	hTeorddBxLag/Zrf1xyO/FfWBp+7Twp3Cklk/LKdRm/+lq1rQZz9dGiJIplirevn
	g01k8hHNfbZs67tq8XfM8O8Ir7YUNrjrjvXriGv/0GYfVW2d/UJSEmPaCNtb62IR
	Tya66B9hoJs/aNBwVkJ/6cmfuAYa0MVAzz8Yz5WWKsSvmk5lMo47gCl+b4WZGufs
	FtWbrj3AKA12vOFmE7pO9V/dgQYsntI4tYwE+ZrWjeGTpXO39SUXavwlWoX/eXod
	UE2RObvC29IPd5j7tndSR3+56Jy8ZSQ329r45g4ikN7lIRVEDFKyuWfRVd0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711390304; x=1711476704; bh=ZOF0LllNEkKwlFc4eVFPUYe1z5e6
	mKp1Z3VJw8CX4q0=; b=H+VPet54C3Y7QbMN4Y2/THGlKNi1RQ8lSrCen5xjBCLL
	GvOr72eh4g45YjvUQ/5YtYLW1AOGcmWZ+AuVmPe8BCv415DHKnogCrH0veC1RzUP
	4soLf281avDmAu6o2vVquy7wX/pPOYa/cjz2mU96CdaPk3AO5uGkRgnmO8yHdpv1
	yfhOd+WO9EAZPencMet7UNg86WPUFuzUNsee+X8N2L8zdMT4OB8tVDolLinZT+JR
	ElfnIjfZikTWSHvSEEPs4tpr0q8xAHqBHBJ/6jRuBNHG+IjH5X2s93lMvm/gPm6D
	rc/3lA0lJOYRCfA/QqhioypyWr5YC9LYioXWoow66w==
X-ME-Sender: <xms:X74BZu2tN7xekPZqMjmstbFirCYBYuIE4NS_Aipa0ZYoDcbMTLh0eA>
    <xme:X74BZhEYak51UNjk1N611INqAXz1a3OPovAHBTVgVffZSwrII8BUVewjxfUHbB4mn
    HjlTjcMd9bfrm2r-zE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:X74BZm7d15nmTR2ONKJhlv31T8duatevTAgzzxKBYSZ4iRsnImAcOA>
    <xmx:X74BZv2HJTxGR8ksu7SGOKNh-dIO4cSyazLOK8N_zmAYHdnG-lv8Fw>
    <xmx:X74BZhH5p1M2Y_T48GPkgY5vhVfFNwm6T-0M4q0kNJmgZs3uO-mtCA>
    <xmx:X74BZo_u3GJhLGwX2s2jnYhlEIV3pCrVDa0qvj1RFw1lkP0FFAJnqw>
    <xmx:YL4BZkY5RtfvxTBGVyjsSPklDjJbZKwMA_1vxkvxXLhg3P-H24-8kBVlprk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 237E3B6008D; Mon, 25 Mar 2024 14:11:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <64804d62-1946-4cde-aea1-e8bab0860bfc@app.fastmail.com>
In-Reply-To: <20240325064023.2997-1-adrian.hunter@intel.com>
References: <20240325064023.2997-1-adrian.hunter@intel.com>
Date: Mon, 25 Mar 2024 19:11:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Adrian Hunter" <adrian.hunter@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>
Cc: "Peter Zijlstra" <peterz@infradead.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "John Stultz" <jstultz@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>, linux-s390@vger.kernel.org,
 x86@kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Nicholas Piggin" <npiggin@gmail.com>, "Borislav Petkov" <bp@alien8.de>,
 "Andy Lutomirski" <luto@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Stephen Boyd" <sboyd@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, "Sven Schnelle" <svens@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 00/19] timekeeping: Handle potential multiplication overflow
Content-Type: text/plain

On Mon, Mar 25, 2024, at 07:40, Adrian Hunter wrote:
>
> Extend the facility also to VDSO, dependent on new config option
> GENERIC_VDSO_OVERFLOW_PROTECT which is selected by x86 only, so other
> architectures are not affected. The result is a calculation that has
> similar performance as before. Most machines showed performance benefit,
> except Skylake-based hardware such as Intel Kaby Lake which was seen <1%
> worse.

I've read through the series, and this pretty much all makes sense,
nice work!

There are a few patches that just rearrange the local variable
declarations to save a few lines, and I don't see those as an
improvement, but they also don't hurt aside from distracting
slightly from the real changes.

     Arnd

