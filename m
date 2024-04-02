Return-Path: <linux-kernel+bounces-127504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6311894CA3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6176C282F05
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705E83AC08;
	Tue,  2 Apr 2024 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YP+bATBr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VqXZOvZV"
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C0B39AD5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042962; cv=none; b=NvnSTJAOpuxPBwV8aJE17X/6hWEMyFrym+Jb50qbAh8NAJua1m3qQUGhNPX6Xt4PWQOI9lOjpE0NxMAk4l5elrC7zFa+PdOtjlEy32K1Uh9TiUU+xFAC1BcNxDktfKO2nl+X7e2e+X2VrucXrR+Cqd1ZFOgTPg4KSUdqoge9yU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042962; c=relaxed/simple;
	bh=dy5mf8wUaHiqNi7xt+mivTQz6gs6CRe4j2Tyv8PSl80=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=jvIRlWZex9MkdgaR1umoPI2yKJfxyvdIvIxLHXsxkiOAJA6rcLKiAsebn0Ilg0PW+Obzsh/g8wxMGZPZ9c7KfW1fIjQNc7cWfalm1wS3+CMOKc//crOML7xZXIjtSwWr0zeF7G/eTMe9NvMVWglK+IjaDAr1myfEm8IQmXzucxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YP+bATBr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VqXZOvZV; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 65C7E1800098;
	Tue,  2 Apr 2024 03:29:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 02 Apr 2024 03:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1712042958; x=1712129358; bh=Z3cnle4iwC
	d+R40QeP2L9ykcUKNwkO+w8K/xqqDQtp0=; b=YP+bATBrsyQeAIkFtRnRwAGGMq
	1WaPOm97FXC15NQUBgq77zouHMaAcB+C2Y65YfUBEPNJcvL5aBiHycuMJcryp8Df
	QuyztGfet9MJGyYmwHxl9ClEwEk0kHv6Gxl/SH/ZP0ggRwbL9Jj3Q4g3us3N6IOs
	y5MMtkfyD37s4+CFPUINCVlY9ZyaCxLHT3KSIub+0yHS/DP8d5R3OAk5yFoaeySd
	IVmNRaOS29Cb+VjQA/i0HZhtWMjieienCk5UKMuaR6tE43c7F5MtZEYWZfHf1+dG
	XICHxGB6zzzpxfgMfoCmBxgb8q0SXUmCGs+tkUbs7dkXLuCAZIYozE2p360A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712042958; x=1712129358; bh=Z3cnle4iwCd+R40QeP2L9ykcUKNw
	kO+w8K/xqqDQtp0=; b=VqXZOvZVNplobqxv/mqHa/NWJIW/+0hDMy0fVIM17FVa
	jmajIIs2mOTnz8RdJmUVyNtMf5vFtnAou7w/wIyUbSElbgFPjEoSHC9G/7LDoQqR
	RsfmYu7fwtETMiiFka0UsCi75jwNkCr//dw/bFIGBM8dyTacPUjar5/qvQcZaWsM
	rYKzroPfWhzDjNBwo9TqNIXiFh0KLp1ecA4iE59Dd7W3ObCDGz2nCrIJQ/0CivfJ
	FSLdMLJxVIb0rm+YmKuOi4dPM8jNHgq+zJ6W9cYqQ4J83i5u1K6Q8hXzPMtVGEgX
	09UsHpsjW1RoH2E9udTGSpTEaCLvmUj9UMfMPww3Xg==
X-ME-Sender: <xms:zrMLZjK1x-PY93E7ZwPsKtIvDeEAJ-7H3bs3feM2zLyjYgLui2XQrQ>
    <xme:zrMLZnIu4Rak1HvqSP7mV4s28TNmWwZm_47jGbw7bbdZfUNiWfu2dPjiKweR2coJF
    i918blQdFbdhKy97RM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:zrMLZruKE7IKkfuKbnC8p90aGYQ7GdnW9pOrW3bRYqfer8AQ0dhPsw>
    <xmx:zrMLZsZ_PbSjSlZkeS6xjcsdXWuuP2IVcHJdB8mhogcefHVAU1H4Qw>
    <xmx:zrMLZqYPx7mtR_Qkqv7WOHW-4v32bOrGqX841IGIKc7AEKu2wzjsNQ>
    <xmx:zrMLZgBqv9ODlL4imXIRTZB8eR8FEBfCmOlZPn246sU5VSfHufszpg>
    <xmx:zrMLZgOYdpIxsZO065T8X06894C2SeYcjPpdMmNvJmfLZqKPaQ6AE4LH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2678FB6008D; Tue,  2 Apr 2024 03:29:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d85654ba-54b5-419a-89e5-526660284769@app.fastmail.com>
In-Reply-To: <20240402042835.11815-3-viro@zeniv.linux.org.uk>
References: <20240402041138.GF538574@ZenIV>
 <20240402042835.11815-1-viro@zeniv.linux.org.uk>
 <20240402042835.11815-3-viro@zeniv.linux.org.uk>
Date: Tue, 02 Apr 2024 09:28:57 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Palmer Dabbelt" <palmer@rivosinc.com>, "Marco Elver" <elver@google.com>
Subject: Re: [PATCH 3/8] sparc32: unify __cmpxchg_u{32,64}
Content-Type: text/plain

On Tue, Apr 2, 2024, at 06:28, Al Viro wrote:
> Add a macro that expands to one of those when given u32 or u64
> as an argument - atomic32.c has a lot of similar stuff already.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

I think we should merge Sam's series to remove non-CAS sparc32
first:

https://lore.kernel.org/all/20240309-sunset-v2-0-f09912574d2c@ravnborg.org/

I don't see a patch yet to actually change cmpxchg() to use CAS,
but it can probably just share the sparc64 implementation at
that point.

    Arnd

