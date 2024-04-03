Return-Path: <linux-kernel+bounces-130450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BF6897859
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C35BB2E1ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8C2153818;
	Wed,  3 Apr 2024 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCQVo/GT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC14ADDBE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169321; cv=none; b=cv+YE4EQSyApQHWfMpyNXZHAQEIJxxqnjtPA3T7Qk23QENBNTKPXwYQ8ZAxP5XpYIZZKjM36PUW1MWnlk1g2++jowZ2o2Sg4h+tIMaKoXRWSIRHqWhPlSCCSk2i0VHpRucYIpQMusC/tdrI+G/zzD/f6VlmD8yjTP08Htv1a7Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169321; c=relaxed/simple;
	bh=mCrNASzWtaHR7F1oNBb9fLP4WPDgWqP4aJQpAtG6Td8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Ge0M2R+pyeGy4RKKIP7NSZ8hExIQjwViiBAEE0nUqinvtuNVKVcnqxDYscPxlzyoh8LOuCMt0FypHNEo8SVKJxaE9TI7V6yZEgMxh4U1oqIIYDgQhpe/9PKxnZlGVDQ2CoqKcTZTKDOqXQJK7TZs2zPhaVN6mKaRI4RT3bbuRFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCQVo/GT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F834C43394
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712169320;
	bh=mCrNASzWtaHR7F1oNBb9fLP4WPDgWqP4aJQpAtG6Td8=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=VCQVo/GTRfbf3668bALS+0IO+fhQqEP1FLS3F8EW1JVCLf7B8IHHgF4vCXFD2acdb
	 pN3X1kJ4vkhyT4/Ek6nKlHp0NZ8wBBF8NxvOOPDDNUrKSbw5IhY/e9Mu/rzkJ4iXJa
	 0ttg1Gu2+kLN0ZJtmFekKuWFErYIMLob8ua5zRkoFxcL+0WSPxtMyCxfvSZcrXU7Lc
	 EwyvWFjFxf9BPhsLMJzEl6Hepfd+gjjd4GHvKZiJFixqRZREonq4kSrXdORgY/JpXO
	 ysUezT/ahhAHsHcaCTMTsNpd/GIoczIRsqhwuWhz7kMhZIqQuAd7mECJAx/CDStmB/
	 YdIKhmvCHIxMg==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 6018B1200032;
	Wed,  3 Apr 2024 14:35:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 14:35:19 -0400
X-ME-Sender: <xms:ZqENZjrzPiiP98A3nX6hgIGzm-M8vgsLaqxkJmvdYQoxrPWEKaSYzw>
    <xme:ZqENZtrHwX6_waNIfmGAyai_prtHhR2y4rNZMXBJp_IO51V_iH_my1rUJdN8HrnUH
    -57DO3Z3EoIJ70zXFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:ZqENZgNMaFIrS2AZ8HCkxTHqnrkeACMue6mwS9i6lRAkVxzbnMBmrw>
    <xmx:ZqENZm57Wrw_QR0mHokBqj3u4d79Y3yASwLYWuZqd8DY1-Ah4IuvKw>
    <xmx:ZqENZi4mF-dp5wPI_nuQvZvRYmFG_QXOaeYdzO9x_OQwqzFZhclVcw>
    <xmx:ZqENZugxd8gimbzaNskMDNd95mEeo19s1Q6NwWVRmARFLJHBILW0xQ>
    <xmx:Z6ENZonsjBMduWT1UsWtPrqh0_eBfz_NUoo1UjT6GarXqcNApf2bjdmN>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D0837B6008D; Wed,  3 Apr 2024 14:35:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bf276f98-2712-4fcf-a119-f984a1aedbf2@app.fastmail.com>
In-Reply-To: <dd55afa6-8cb6-4e25-b720-d2df62dbb5e6@gmail.com>
References: <20240403122851.38808-1-schnelle@linux.ibm.com>
 <dd55afa6-8cb6-4e25-b720-d2df62dbb5e6@gmail.com>
Date: Wed, 03 Apr 2024 20:34:57 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Michael Schmitz" <schmitzmic@gmail.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] m68k: Handle HAS_IOPORT dependencies
Content-Type: text/plain

On Wed, Apr 3, 2024, at 20:11, Michael Schmitz wrote:
> Niklas,
>
> how do you propose we handle legacy drivers that do depend on 
> inb()/outb() functions (_not_ actual ISA I/O) on architectures that map 
> inb()/outb() to MMIO functions?
>
> (In my case, that's at least ne.c - Geert ought to have a better 
> overview what else does use inb()/outb() on m68k)

If a machine provides an inb()/outb() set of operations that
is actually used, it should set HAS_IOPORT.

For the Q40, it may be better in the long run to change the
drivers to just use MMIO directly though.

    Arnd

