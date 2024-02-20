Return-Path: <linux-kernel+bounces-72587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B18A85B599
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A448B24573
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854415D904;
	Tue, 20 Feb 2024 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Uf/b7tkA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pHbtdwNw"
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA175D473;
	Tue, 20 Feb 2024 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418475; cv=none; b=Kc5d22EhESEqJJLTaW0M6M+fV4zKSUWK1bfy/3qT28tif6ESsZtn9FSCur248X1zfwejxIEq/RgLtWt/i/G8gQ2q2mi6cZEyJt6NfY5OqAsQNSenICCADloo2isEhxqKxMckZaxoF+tcNh2pjgwFLPf2DNAvoFXJNGvGO5uVIUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418475; c=relaxed/simple;
	bh=aDDymV6LEztxPD2Auh3QLl09iq6XKr3D3yY7CqwO8Es=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=uC4DyP9SsO92Vl2YYJ7IL679En4/Cg1O25i0RN3RSmniR9FNxGmeqBkXsRP1qZ9SDNtuVPobzGLnatPNZnqHKruKyegHjyodDsXfOcrmh4r792FOFVdtGP7fffJd38WlkDFF9TF0o03nXkZOrd80iqsyLmNtWI6dsB77oNUTbXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Uf/b7tkA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pHbtdwNw; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id A92C21C00082;
	Tue, 20 Feb 2024 03:41:12 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 20 Feb 2024 03:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708418472; x=1708504872; bh=wXfeXdPi78
	lk9EdJVz4SqcfJXJZWVAOw2kytIQNAzT0=; b=Uf/b7tkAq4epPR56tQyD7SAITT
	+8jMynBiZtK4UOtgEcaqG9FdicdnBhzXibJwQT4hqNgESke+cNdsI9QQ/w+6b/4m
	sC6fYJgmZB37BD7Q/ssrwU3IRAtuSrxuHcSjCl9oLpd8PT6FrQ/MSScexSq6IAOy
	ufvMrVgylRS8jqL/0iliX+xsuN8z6KtFDcV01p0J9wNsbI3T954+lFM5Opfy7MQ+
	XD1WUwKHOjy+sMOwQekkIhtHlemQiueyjnEo7ibUeO8wHKSIA36kT/TzYqzdXHtU
	W56cuoKYMJZyGNfCZKkzZjDr7CvsaAtSOHEqVnwCMxgqwl1hS8MVB7zyds+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708418472; x=1708504872; bh=wXfeXdPi78lk9EdJVz4SqcfJXJZW
	VAOw2kytIQNAzT0=; b=pHbtdwNwuzwai5yuQznBWyV9DcSP2CseIcRODRHo8Tz+
	THU3OpCtMOD7BrCcmwKdnKGfjFMgC4ZSgd7iftmLAFbtjRDe8LGXYdpctohyd4UN
	Q3IPFCD7GSUzMwXxtFiJTAl4Vz4CveH4C/cXfUs3BtqzCLdkym2OIfd2sK68ABTd
	ZPNKeMzGqV4P3z2nVzvorjQFTevJVPM/XDxoTJYf/GViczcOqDqw7UkYBI/rzGYz
	N3XuXrj8BMiyJLUyPgN5jo++xr1nTAn35DXcNoKj/gXoR04upT7GqEr+TWQmrH8L
	i2drCXQQ8RkqUY3KDkeUpB6T07OtD3Y7w8zWyCyclQ==
X-ME-Sender: <xms:p2XUZed7OsyNQvGsgvOrzezQpIx1UkR_ruzNz8iblCneiWneEXl1Xg>
    <xme:p2XUZYNnIlO2pxfyG6h_dRIEzJSYjywB32c-J_p0na_2JqKgoPBe9Pea9Zj6mdXqX
    RTeQk83vP4rFggt2JI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:p2XUZfgcykzOnvqhGuVg-Aj-dUlFdg1kQJpfe_WJKuziARciV4UfZw>
    <xmx:p2XUZb-RmFGEzh2fB0Wam7vUtOKssYUYKrGS8QTUF7byT537UH7tyw>
    <xmx:p2XUZatsPwugfbhlLOe8A3WPm9B_1VFoGTrjoH7vPET8ok6MTALayA>
    <xmx:qGXUZYAzmmv0H_K1n_DH26bbAjtrC5t0d_Bg-Yu86zsgEVCvSNs8NilA_QY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C1C18B6008D; Tue, 20 Feb 2024 03:41:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <476ca8e4-b0c8-4be2-ad65-8430c7f4acc9@app.fastmail.com>
In-Reply-To: <20240220003433.3316148-1-javierm@redhat.com>
References: <20240220003433.3316148-1-javierm@redhat.com>
Date: Tue, 20 Feb 2024 09:40:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Javier Martinez Canillas" <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: "kernel test robot" <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 "Andreas Larsson" <andreas@gaisler.com>,
 "David S . Miller" <davem@davemloft.net>, "Helge Deller" <deller@gmx.de>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, sparclinux@vger.kernel.org
Subject: Re: [PATCH] sparc: Fix undefined reference to fb_is_primary_device
Content-Type: text/plain

On Tue, Feb 20, 2024, at 01:34, Javier Martinez Canillas wrote:
> Commit 55bffc8170bb ("fbdev: Split frame buffer support in FB and FB_CORE
> symbols") added a new FB_CORE Kconfig symbol, that can be enabled to only
> have fbcon/VT and DRM fbdev emulation, but without support for any legacy
> fbdev driver.
>
> Unfortunately, it missed to change a CONFIG_FB in arch/sparc/Makefile and
> that leads to the following linking error in some sparc64 configurations:
>
>    sparc64-linux-ld: drivers/video/fbdev/core/fbcon.o: in function 
> `fbcon_fb_registered':
>>> fbcon.c:(.text+0x4f60): undefined reference to `fb_is_primary_device'
>
> Fixes: 55bffc8170bb ("fbdev: Split frame buffer support in FB and 
> FB_CORE symbols")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202401290306.IV8rhJ02-lkp@intel.com/
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Acked-by; Arnd Bergmann <arnd@arndb.de>

