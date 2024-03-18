Return-Path: <linux-kernel+bounces-106218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9771C87EAE3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5371F28167A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D034C626;
	Mon, 18 Mar 2024 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ncdeKa7P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wQ7xDgGJ"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA01364DA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771947; cv=none; b=ne8mitUDnQNpWRAM2ONpP5pzJ5v6MDwBhoyjTx4lvD9qabgrg9/461ZTBGZ7Mr3DMb8jITHKDt93lbby/bMZuh22uUBzEPdudsSWCkLMfUIw0V+y6FshPA6ABm6I+R9E8zz+wyWIiGnl9TLQHjs+ubCjYaJPvwIX1cXAvg9GLV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771947; c=relaxed/simple;
	bh=7q14TjAZiKWDJSVA5Px7Ujy/GZGWu4oPnBPl6E/1B5c=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=h4RlUTOUmciykyAQYbfM9RIh9WfR4/Oq0yNduuP5u1MxWUCj7FEzgHN/sc1A0J1SGwB1HZm15ygUb00IAiqOPSN8daptxjUx1vSS6aRmr/kyl+x9Hui2NtrOa4wN20AgFMocuurH/X7Mh4H8Q1U2IsjdZNbxkcBVXUVNbwyeWcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ncdeKa7P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wQ7xDgGJ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 97E99138010B;
	Mon, 18 Mar 2024 10:25:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 18 Mar 2024 10:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710771944; x=1710858344; bh=/DSFG+RCXY
	GGTrl2W6TfjuAsH4EycxuKPNllqSzMLpA=; b=ncdeKa7P75nQJXKzpgM6HFK/sb
	oZzUEg5zsJEn4R2B+BcNfmHk6GrfGTX+8EsmJeCKTY/KKJ7M6rhCbfzmWZ1lDZXc
	kKHSq6oV9jDgx1Xc2T2JcACj7ZDvEPB/IWwcqBqEzg10Ipn9tyZcwgAY75tQMN4c
	MPyOs8ic4dIOZlc/gHT6KqXSxNPyX5ZGQTBj/0SxnCbCKvqZgr3tNkgg6IFJZm19
	zLrz2mMEjlWjIa3z8LYI2qdzYZNz0cKucQjdVjwqtFdR0AO8XdgRGeuoQWj1dIvp
	13UdI+y10yBtxUGUW6LnWLKzz9xLGf/osefKsZLseTsyVBmfFiNJgnGiCRYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710771944; x=1710858344; bh=/DSFG+RCXYGGTrl2W6TfjuAsH4Ey
	cxuKPNllqSzMLpA=; b=wQ7xDgGJ5+eApBDwPZI+YN0zryul21C3361WAEV4D94Q
	iOrIueT29fRLaAjao8mMB/fza1kUHr4voogbNxbfAO4Dz0fluVQxVwpRUIXB2nxd
	uNrk9ViGstUCnQ+NbQyMdwlTqksgoZDfY1XGOAQlkWdgEWuS+AKPkPVWU05TvvjX
	dQffrfh12UVW+qPRZ8WOl0C+BwNVCbYJUnKBXeDWUkbeYL89cppGOcd8B3Qz/hY0
	Q9zQe+julMPaB28xvGAVjALOEB+mlSEZYAx4vdrluSernI+ua3+2RkuPww/WiZNt
	dJf9rfRRL5y2dU3jKIT60HydnwxTjPNCVBXuv5nkdQ==
X-ME-Sender: <xms:6E74Zesw6rjF3Y0sOlVZ3Ld5aMVHJvPSGClS0Q5z7xG04YfsKnho_A>
    <xme:6E74ZTcSRE4STBIxsK_T5nfsaAe5woJfb9zcQk1c0ni2-ML01y-_9heZS5_3bBY3x
    NpCzp9sA1Uogu7tdfI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:6E74ZZyDbe_cKzVJg3TjmpiHcncHSGEE2bSn2YifIH3a74QppLmdRw>
    <xmx:6E74ZZOdkjaTgdhG1nGW41uyaEWhoyQAyQW4mUgVhGRLQdxJ6KYyNg>
    <xmx:6E74Ze_txu_SXZYP9Thq5HdI_wTAjdOKEgR7AWC0O7faD_Y6VgMp0Q>
    <xmx:6E74ZRWlsuyljPi-pJs3ge-QqtXglbUX8xM6a6DglX7g7HQCzn1r1A>
    <xmx:6E74ZSZgB5Ers8Kx3iPWPzsrM0yBrsX_u0Zx4Jg5YfLIT_uUlMcxnw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1A54AB6008D; Mon, 18 Mar 2024 10:25:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c9eecda1-a8e2-4ded-89fb-a2cc98d4c19a@app.fastmail.com>
In-Reply-To: <202403182122.G6VFSE9v-lkp@intel.com>
References: <202403182122.G6VFSE9v-lkp@intel.com>
Date: Mon, 18 Mar 2024 15:25:22 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "kernel test robot" <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Borislav Petkov" <bp@alien8.de>
Subject: Re: WARNING: modpost: "cmpxchg8b_emu" [lib/test_lockup.ko] has no CRC!
Content-Type: text/plain

On Mon, Mar 18, 2024, at 14:27, kernel test robot wrote:
> tree:   
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
> master
> head:   f6cef5f8c37f58a3bc95b3754c3ae98e086631ca
> commit: 88a2b4edda3d0709727be53f4423b0b832d91de3 x86/Kconfig: Rework 
> CONFIG_X86_PAE dependency
> date:   3 months ago
> config: um-randconfig-r035-20230726 

> WARNING: modpost: EXPORT symbol "cmpxchg8b_emu" [vmlinux] version 
> generation failed, symbol will not be versioned.
> Is "cmpxchg8b_emu" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "csum_partial" [vmlinux] version 
> generation failed, symbol will not be versioned.
> Is "csum_partial" prototyped in <asm/asm-prototypes.h>?
> WARNING: modpost: EXPORT symbol "csum_partial_copy_generic" [vmlinux] 
> version generation failed, symbol will not be versioned.
> Is "csum_partial_copy_generic" prototyped in <asm/asm-prototypes.h>?
>>> WARNING: modpost: "cmpxchg8b_emu" [lib/test_lockup.ko] has no CRC!
>>> WARNING: modpost: "cmpxchg8b_emu" [lib/atomic64_test.ko] has no CRC!

I have not tested arch/um randconfig builds, but my guess is that
this was not actually introduced by my patch but rather lkp bisected
this into my commit because that changed the config in a way that
hides the preexisting bug on older kernels.

      Arnd

