Return-Path: <linux-kernel+bounces-18399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F807825C89
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E1A1F23800
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183EB360AF;
	Fri,  5 Jan 2024 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DzmzuMCY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RmIJ7/zh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B331E3609D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id B0D3A32004AE;
	Fri,  5 Jan 2024 17:28:10 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 05 Jan 2024 17:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704493689; x=1704580089; bh=1KOe40KZTR
	zKDV3JMkZuj+p5G4YTHfXPIyBx+3PJiOU=; b=DzmzuMCY0Zw270ZcqG9N874IJ5
	TWz8jsa6T/DCXE4UR61G5DdKVb4PCuVhSGLEHnbVmQrTsn1cLWf2RTIarIEEhzTI
	LQ/7q7Xc6ZozaWKMGH47MzkBn4UsDl+pFAvO1cSCfC1AM8U9MmJUs3ZOO5iG4g0E
	WIxKfBGcIaIeRWf1zsx00nGmsb3j4SALfwwSk7SpJeXCXEkPL8kvy1ATP3IUfcmK
	OGEQZmlT3OR34AyVEQJGnInq64rTCdJDB8kFRf+cykV+QZOAIDRn/qJrhyXmR/lX
	hGdgasm0WYHNn2xpsxxa4N4oGTUEUhPasah+v+ctFD885BOQLuq4DxQyI9Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704493689; x=1704580089; bh=1KOe40KZTRzKDV3JMkZuj+p5G4YT
	HfXPIyBx+3PJiOU=; b=RmIJ7/zhGcoueyka/Kx5qLPxGXwrbyYPflnUfMNkMDfx
	lG8IUqsdA9xlnUI1s8L3Ce1SNC2fo8OGtzMLAr7Pyx06OF19m0xPQzFb/JbZxMlH
	gYYmLXKc3M0oaH5vki4SnncSxwvWWtNI3/vTcyBlyyU4rC9osgo3SCWvJLR4uJso
	FJu+FNKMmt3YJzStsONKKoLDResl5fxkdi8MCmRPJYtoDmft6IfSMI91wDVM3Ssd
	m9LWD9XhZAaacpQHQmZ6Ue/av66lzUNBi659pyCJDG1mrbyh0+r6UKpN3WSBJG8o
	LSDnpLfqQ2L0i3XUbYaxVJ8l3fOjZbuhL+5t5dvDkQ==
X-ME-Sender: <xms:eYKYZSEc7THCFjJfR2IzFb67nGOxZBR9COHTxD0q2-Wz4-im2aX_zA>
    <xme:eYKYZTW8nB1iFsn4qUQCKNgVbi7ynVu8LnsUfDBRA2L-Golund7NySN5pZIUHTTQj
    MIau8RN0sC0RAwoWww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegledgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:eYKYZcIYENvZjFiDZFMnngJCr2n7tdYgrfUlJM6N_8o2IbCDeAIuuQ>
    <xmx:eYKYZcFC1A_MT_KSTOrkZdb26jvId-jlxjLLFra9c8s0K3IxDfRa0A>
    <xmx:eYKYZYWWiZXDy-rzyPeSWGt6mLOfgu87FVpkhdfw2FqA8xwvmDwQAw>
    <xmx:eYKYZTeFDoDHXzxmNMrjtGxjZeMVh2Slyp74p1cqvcvV4XKqVlj21Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 97578B6008D; Fri,  5 Jan 2024 17:28:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1826ab26-5314-4cef-bbb0-716402c7e91b@app.fastmail.com>
In-Reply-To: <20240103110409.167132-1-martin@kaiser.cx>
References: <20240103110409.167132-1-martin@kaiser.cx>
Date: Fri, 05 Jan 2024 23:27:48 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Martin Kaiser" <martin@kaiser.cx>,
 "Lukas Bulwahn" <lukas.bulwahn@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: debug: fix DEBUG_UNCOMPRESS help for !MULTIPLATFORM
Content-Type: text/plain

On Wed, Jan 3, 2024, at 12:04, Martin Kaiser wrote:
> Commit 84fc86360623 ("ARM: make ARCH_MULTIPLATFORM user-visible") modified
> DEBUG_UNCOMPRESS to prevent using it with multiplatform kernels.
>
> Update the help text, remove references to multiplatform.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  arch/arm/Kconfig.debug | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

Applied, thanks!

