Return-Path: <linux-kernel+bounces-44440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79116842221
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A92DB2D4A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CDD664A6;
	Tue, 30 Jan 2024 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YKHZJLE7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U2ctUQWI"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1099657DD;
	Tue, 30 Jan 2024 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612370; cv=none; b=t7busj1WgdWeZW/dmUW4DOYUjUGpfXXZpmHbyf8JxNjoO6XfgGSaT0LYRsPzrsuigCgU382oxV0fhiVQW92N+Iy8meTPwtOWSnSPxqi+aBleInjmUeU6XRdXqA2cKYtEnX/PRcW3ysOOr1Wt3pca3vY3kAE3sMfVDJj/2t5SIUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612370; c=relaxed/simple;
	bh=hriKEi3Sv4gStp1lVTHTabtn0IF1x30Yrbw88AS+yh8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=NsxHfxgevDFtK1qYNuWa20WgK9B/I8PSR695ZoPCjJ1yl6DpdYRzDPyWDnCoczIpq5VLFW+20+Vxizi76LEaVfNwJ/9RpI8CPepCh/DmvcBa48lQBbCRS0lPVrgA17Sy7/5cwNErxR2BMCqgQdSN0nVnow/EEvrwvJQWbFWH++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YKHZJLE7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U2ctUQWI; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id EE7093200A24;
	Tue, 30 Jan 2024 05:59:25 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 30 Jan 2024 05:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706612365; x=1706698765; bh=vLH/ZiLStC
	joOoUQcobS4Maaw1gFmNEZ5FBewuBPXDY=; b=YKHZJLE7i7nCO3EFdLtd80Zbev
	NydOk1DEef4ovG2Ly7T4TDvLYBhd1qM35bkT2KrDVMwAZ12eM6I+hIXC7l92CgWl
	2CWS3lslkUERO6nkLeYh2ZW8IIf0Z7iMCndzfx4p/cb8v0SGDmyb9y5fWkH0dA3o
	GqZZQ6iXu6+EZ5mvanCkFVG7mSXI2qjxXWGpkW55q9SSp/kVX6Lrf+mHacoFWA1B
	DsmW7OP3N49ckMMzCJmlqsmZuqHIG6AC1KXvag3GOt/ZuNg80zR7ftjb/GXtvIMj
	kSgNAo+dl1nuBS3ty+U34jK//U0JxAuXM/T/703Dwzeoy4I3+csSZMHOKToQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706612365; x=1706698765; bh=vLH/ZiLStCjoOoUQcobS4Maaw1gF
	mNEZ5FBewuBPXDY=; b=U2ctUQWI6ZUgHoJMJCBghSLKPyOFmCGVbsgvBtI5Q3+/
	957ENDoE5+tTGqRuS350ajieBaPh3XlGWrXocoowk1iErAnZE70vz54QtipZQyKz
	tAL2qpN8LKdYk3Sdo+8Os9R93vgtkfqYFSKRkadGlFfkV6HthlAdntVvdY9zI9s/
	6A08YaSxv8stQ0EqUFu5zLACGLZnRKOOpG9CULZZOxwCQzbvZclvSqDrBCVoKNxi
	2Tvvt7OnCZYJD+wz7Rohs2mdCXtRUpRkZZ3dKf68ou74leByONqG465nSBxm3hv/
	A5GemgFE+mJhzvy147L5AtWdgK8sleei7QoAu64S+A==
X-ME-Sender: <xms:jNa4ZfkvUAtD9JiWq5HpTZCDzz_qMSBF0ERmNs3-T2Rk6lLelE4KKA>
    <xme:jNa4ZS0_wEtXTIIBZcWVpHtYVB4vk177YbnlMd1769_f_YpCgLvhzh6WwpS5a-T3E
    ZO-oKBwYZ1YDqBtlAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtiedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:jNa4ZVqseTSV4jiA_GL9AYgBHoivoB7y9a7L2ICz0w5RWoafrKoKdg>
    <xmx:jNa4ZXmqgtzCNtKKEmOtJE3aHk264EzTz8cdZJ4NPiYIhLqlFaw_wQ>
    <xmx:jNa4Zd0Pm5r0wRlQujCh8Q9KPW_M7oz4FdnerbKAyUxu8z-LtdBtcA>
    <xmx:jda4ZV9ilBtQlH-f5dl3EqyleztOaSdrUmCVsDZgCGgHgQafMkYUTw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4F22DB6008D; Tue, 30 Jan 2024 05:59:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dafa2fb5-276d-4c87-b003-4b7f30d44f0a@app.fastmail.com>
In-Reply-To: <61e8b6ae-fd30-4443-8473-6429f6de8768@nvidia.com>
References: <20240129143030.16647483@canb.auug.org.au>
 <d0e1a7c1-06a2-4fa4-b4f8-df149af8eccb@infradead.org>
 <61e8b6ae-fd30-4443-8473-6429f6de8768@nvidia.com>
Date: Tue, 30 Jan 2024 11:59:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jon Hunter" <jonathanh@nvidia.com>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Stephen Rothwell" <sfr@canb.auug.org.au>,
 linux-next <linux-next@vger.kernel.org>, Kartik <kkartik@nvidia.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "Thierry Reding" <treding@nvidia.com>
Subject: Re: linux-next: Tree for Jan 29 (soc/tegra/fuse/fuse-tegra30.c)
Content-Type: text/plain

On Tue, Jan 30, 2024, at 11:46, Jon Hunter wrote:
> On 30/01/2024 04:06, Randy Dunlap wrote:

> Looks like we are missing the following ...
>
> diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c 
> b/drivers/soc/tegra/fuse/fuse-tegra30.c
> index 2070d36c510d..eb14e5ff5a0a 100644
> --- a/drivers/soc/tegra/fuse/fuse-tegra30.c
> +++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
> @@ -38,7 +38,8 @@
>       defined(CONFIG_ARCH_TEGRA_210_SOC) || \
>       defined(CONFIG_ARCH_TEGRA_186_SOC) || \
>       defined(CONFIG_ARCH_TEGRA_194_SOC) || \
> -    defined(CONFIG_ARCH_TEGRA_234_SOC)
> +    defined(CONFIG_ARCH_TEGRA_234_SOC) || \
> +    defined(CONFIG_ARCH_TEGRA_241_SOC)
>   static u32 tegra30_fuse_read_early(struct tegra_fuse *fuse, unsigned 
> int offset)
>
>
> Kartik, can you send a fix for this?

If I get an Ack for my original patch, I can pick that
up into the soc tree directly:

https://lore.kernel.org/all/20240103102654.3779458-1-arnd@kernel.org/

    Arnd

