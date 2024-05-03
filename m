Return-Path: <linux-kernel+bounces-168161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAE98BB47E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1901C23398
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C65158D6F;
	Fri,  3 May 2024 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="a0r3l47B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S1JkIxgy"
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1D72E646;
	Fri,  3 May 2024 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714766877; cv=none; b=fa3/rqiSl685v9SBfIQ9G+k3KbDiHrqgSmQ32L45PvzMgkVVWwUMEFO3/3RH9Kth1z0aboSP6Zw67zx/GjjGlji9AWB37HZSzvtEQzYSmzbmeiQTnfHNhR/3lGRs2etreBrnN8buqlWxvJ5W+wu7CEogjG+7HLNxgxKKUk/SfZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714766877; c=relaxed/simple;
	bh=assvwasAzVr51WOmP4somhcgdbTrkk9+A/EE66lEZN8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=K9RYcbUrEdL+zViLI1nDYgbzhNdUfMbZx+3OxHuL4RAWOTMfw3672Mf5azNtC1iyHLFhdNFVMpd53XPWVu4rntHre9N8fxSeYZUAjayDkO5XPxE9As2uCtxP3MBzfYutdFCnxWGCT/JqgY568APlfovvLrJ2Oh8WC1fcjTjvrs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=a0r3l47B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S1JkIxgy; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 5B5D21C0014A;
	Fri,  3 May 2024 16:07:54 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 03 May 2024 16:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714766873; x=1714853273; bh=cnR0f4AXm2
	s46FHt57bseaKoTPb0SuUXLKfxHBTK4GI=; b=a0r3l47BD8FQ6ni5rkBzN7A1zT
	kG+XuJBKkm7qhyJASOHANU+nOQHQucn1x3KUtGfXnTFSUw42J+dSV9f0xF1uo+bF
	lI08/K6Odnam/kpTUzHV2FY3dohATzF/4sFtjgOLI1TlZnmWR5wC2nFBoub0M13Y
	zigvvsRuzrSQEbcn3ZgQMBLVFQqR2al9gzhd392aZK2F4ohkXg5/5iwrSaWstWRy
	zTyI3HhZ089CXC+bTEHg5wgVf+/jaGp7AmFw5dMnzqP5rVGzUu+QKgaex4Dtb0dx
	5WPxxT38G7axvxM6MCbgJcIEI2ss8O5sf1ryZtPh/6TL8yvynaAkfwJyqU1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714766873; x=1714853273; bh=cnR0f4AXm2s46FHt57bseaKoTPb0
	SuUXLKfxHBTK4GI=; b=S1JkIxgyb/fvbtB0m4/sVeZcMrMuBoafu9Lxo16AcjSg
	QWgecYMZIbC6Bk27Ou3wcPmCHtLwyugXztq7y9L3da902m15qaLvnI3val+gFBbs
	1BCfrfk7sMZxNnVIhHou/UaoqcyusTAYmOL70+LwxtK+YdKPnsuPtm9OcCJjh2Gs
	dKz2D+zKHHI3Ou/yrZCb/8YxMJj5nVUoQWWtEr/vbZv4wzcn5mUjmvLR16c92tQr
	bnZJmRe2QlXFrxuyYXVIurUHHYaqxmz2XQ67ZEK7hTyYln8xpjBigOaUcSH5XrK/
	aUQIXeH8+lshTT4n1IWGeSxsGAtS+wO7uWQcYrSQ7A==
X-ME-Sender: <xms:GUQ1Zr6REG-t4yjqi3zc8vL2hqYNyRKT61x-lwUf5Y-J_7sSAfQwLw>
    <xme:GUQ1Zg7eHJSVz41cjHS86c8dWRAnap3oUeotPp7Hw0EwPRM4Xe-Q9W6LrVsweTSHM
    PadBOkfWuHTGiL_-iM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:GUQ1Zid4E9DAXCDPXYQillsCjxTS3NadaFlc412kFeWk_SSkEDEgbA>
    <xmx:GUQ1ZsKeFPGK_ZzuoEC7akwIWQYkII-bihtoRiB1N22Zwtr29sESHQ>
    <xmx:GUQ1ZvKohf9jpa6BhM2wMzdZt9lQmgr54EZN7t70BZO4BSZvF7rz-Q>
    <xmx:GUQ1Zlz3sP0F7jAwNT3LwiqO8RB-957fdpzFQn4sR5eSZkmLWQ7znQ>
    <xmx:GUQ1ZgX0diznhvyLBZPNbFTZLKEtvjg_dvNtgRbfVh8Vn7DD7Q8pk4ef>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 218C8B6008D; Fri,  3 May 2024 16:07:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-417-gddc99d37d-fm-hotfix-20240424.001-g2c179674
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7bbdbed0-aa16-4b2d-adfc-236fa119a07b@app.fastmail.com>
In-Reply-To: <20240503170028.GW2118490@ZenIV>
References: <20240503081125.67990-1-arnd@kernel.org>
 <20240503081125.67990-11-arnd@kernel.org> <20240503170028.GW2118490@ZenIV>
Date: Fri, 03 May 2024 22:07:31 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-alpha@vger.kernel.org,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>, "Marc Zyngier" <maz@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/14] alpha: remove DECpc AXP150 (Jensen) support
Content-Type: text/plain

On Fri, May 3, 2024, at 19:00, Al Viro wrote:
>
> That should be moved into commit that removes the caller...

Fixed now, thanks!

    Arnd

