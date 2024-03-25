Return-Path: <linux-kernel+bounces-117672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE0288AE4B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9271C60680
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FE33DAC01;
	Mon, 25 Mar 2024 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VEbwH/ZO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DuwM5x/R"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B6660ED0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389760; cv=none; b=R4A1362hhS6c1WnqDoT7zkbdwZhcBoDczbOc5UAz2bsrFnwkPZZtM3u/Hp04ZE7tx7+YhM2ZJXVV8hZkOtGTlCCZoWHTG6z/mXKfq6KKk9z4oC48D7dluj7GzcQS/mYm17H1X2b1b7xmEyNW2gJpj+/399K9Dh3px4X6k6Jwzd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389760; c=relaxed/simple;
	bh=9Kc4RxYAxHuTl3CFSV/d0BgxGhfm6+wZgv60jU0R42Q=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=qrh70x3nMvJBQCwjxSD4kV2mDQrUEcTX2jzW/3AF6f0NNClqv+DJsHgbgPY/udNVuOkgV0+5sPoFMKi8s0mfHtglBCawCx55sLeOKC37euyGx8MHVj+s4idBSAbNYl0905JZrae8B4epbpezCNIHpLttRfBU4pZ3WGu091Iwcdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VEbwH/ZO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DuwM5x/R; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 67A5D18000B3;
	Mon, 25 Mar 2024 14:02:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 25 Mar 2024 14:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711389755; x=1711476155; bh=MZ8i+Gw+8U
	GRptvTYhnegZ3s5XeZTdAEd0vXFYyBJzU=; b=VEbwH/ZOjXX+6S7+y28Yyc+vWh
	Ca3MEk4YxNwb4JxA0pyWCeXBL3vAle5gi06OoeGki82Ie7LQdXk9n5GK2GW55mql
	nLmqXwC4hshhdsEGA/K1nk+h6K4AODag0IvFFzhl4aQ9BJOME6U/e1fZj1tp4EBG
	sD00QoVswMY6HvkZjafP+T8piL2yAFjVEoQBudVHuoWEMb+Lmbp0wyrN8SzDjh+P
	BE7Bk0sAbbqrQcm8RSeVzxFzabGwYZhWMHazr3NyMddCg67R04fJNfFrnShZaI6F
	WNoPquXpDSHD8xSYetuhQ/rc9A7Jf3nkfy9eEqnp6ZP0Cja2z9qsQxaK2VtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711389755; x=1711476155; bh=MZ8i+Gw+8UGRptvTYhnegZ3s5XeZ
	TdAEd0vXFYyBJzU=; b=DuwM5x/Rn+rxyTOAQOoNhmPfZJ4KGAm63mFOUDozt+Ob
	g9Ro3gpszcmkCZ+ZW7UQtWxZLo9gxE8dL3WyM7zDNFynjxGeURELyiI3V7oocqJ0
	BEG59jkhks0VzPAbX2Ca9Ygb1rUsX2GGI46jVOeSV94gMw2gSyUsZA98P/NmQSvj
	p7aWN7aO4IzJG0Lx9b35xnOL+WFgPj10LtBAmgOG6/VDxe4qZHB7mHNFpLLBFM8+
	TWWd+Bp/V3VtiOF/6JcAtlFXboYIrhP4xGpD7Tnr4pFwWiRQVFc4xzxmrOr9PDcw
	F7In0ielSZEvfnoysg5q9vZRv+StTODJVsCRepSAlg==
X-ME-Sender: <xms:O7wBZmZS2Yc5u3MAUARmODwOLObuSmzHtufAokbGzOz97nuNV5Iqow>
    <xme:O7wBZpbVjcn29EifG7tL_9vS4qWCzuKBu_aHcIt3IM9V4OhyL7MQb3gjDKg5uxVkY
    TT1C1f67qsLXAICkZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:O7wBZg8N8TBButbyzPSQbH_wtxgHkTx9XSA03qUtwlPI5rqhag8SGw>
    <xmx:O7wBZop1FbmeL24HRxYUCdkvt6OxCVDhJ_8oTbvazQzLsIzXOZkwig>
    <xmx:O7wBZhrMOFnF_PIpTrY9AO29f-0VAVk5ohB7n79_EVvs2ku8DKyowg>
    <xmx:O7wBZmTfbDmy6niO6Rb-rrD3nXnSECylwgOd3MqtOFG46ZLgyycPfQ>
    <xmx:O7wBZgclbJGPimIKrGmA7WJgBmutgU6M8zfAG5sj4OYzmbNn_ZPqMd9Xshw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 03979B6008D; Mon, 25 Mar 2024 14:02:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eeccbc9f-7544-42c9-964f-2b4c924c2b2f@app.fastmail.com>
In-Reply-To: <ZgGosOiW6mTeSnTL@FVFF77S0Q05N>
References: <20240313180010.295747-1-samuel.holland@sifive.com>
 <CAHVXubjLWZkjSapnsWJzimWg_2swEy7tQ-DQ6ri8yMk8-Qsc-A@mail.gmail.com>
 <88de4a1a-047e-4be9-b5b0-3e53434dc022@sifive.com>
 <b5624bba-9917-421b-8ef0-4515d442f80b@ghiti.fr>
 <f786e02245424e02b38f55ae6b29d14a@AcuMS.aculab.com>
 <d323eb10-c79b-49cb-94db-9b135e6fd280@ghiti.fr>
 <ZgGosOiW6mTeSnTL@FVFF77S0Q05N>
Date: Mon, 25 Mar 2024 19:02:13 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Rutland" <mark.rutland@arm.com>, "Alexandre Ghiti" <alex@ghiti.fr>
Cc: "David Laight" <David.Laight@aculab.com>,
 "Samuel Holland" <samuel.holland@sifive.com>,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "Albert Ou" <aou@eecs.berkeley.edu>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Charlie Jenkins" <charlie@rivosinc.com>, guoren <guoren@kernel.org>,
 "Jisheng Zhang" <jszhang@kernel.org>,
 "Kemeng Shi" <shikemeng@huaweicloud.com>,
 "Matthew Wilcox" <willy@infradead.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Xiao W Wang" <xiao.w.wang@intel.com>, "Yangyu Chen" <cyy@cyyself.name>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Content-Type: text/plain

On Mon, Mar 25, 2024, at 17:39, Mark Rutland wrote:

> Using a compile-time constant TASK_SIZE_MAX allows the compiler to generate
> much better code for access_ok(), and on arm64 we use a compile-time constant
> even when our page table depth can change at runtime (and when native/compat
> task sizes differ). The only abosolute boundary that needs to be maintained is
> that access_ok() fails for kernel addresses.

As I understand, this works on arm64 and x86 because the kernel
mapping starts on negative 64-bit addresses, so the highest user
address (TASK_SIZE = 0x000fffffffffffff) is still smaller than the
lowest kernel address (PAGE_OFFSET = 0xfff0000000000000).

If an architecture ignores all the top bits of a virtual address,
the largest TASK_SIZE would be higher than the smallest (positive,
unsigned) PAGE_OFFSET, so you need TASK_SIZE_MAX to be dynamic.
It doesn't look like this is the case on riscv, but I'm not sure
about this part.

      Arnd

