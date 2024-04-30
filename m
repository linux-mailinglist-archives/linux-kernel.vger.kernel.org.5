Return-Path: <linux-kernel+bounces-163252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 932158B67B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351A81F22F94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B128BE0;
	Tue, 30 Apr 2024 01:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R+FcX0ZK"
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089579DC;
	Tue, 30 Apr 2024 01:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714442049; cv=none; b=Gg03QtywyCsxU2q+0MLxeGw3z3nrgO7LN22yKX4cy1jHVBPe1Nzk0PF9pJS9zPOy8SYpy9yqdDvpJvvLLVOrXGA5FxpMniQUiQZAlWiLVuG6Yal5Vn/it6o9w/NLupXq0ZkEocLt1q6MERh2uPtJ4pew8QnQWSvX4PwL7rM2cCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714442049; c=relaxed/simple;
	bh=/pKumPOlfhaWlo9dOCFEE/29YIst6MSj0NpY1zurQuI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W1+5Al46JqYdUq6DVKcZ/JPDkU4tpklu2DFCniDa5hsjo32KjGWAAG55BGyVymteaqiSMmIioifZcDylwW31HAZZnsUJ8BbEau4gljGzN/Gx0w97c6Vri9daQUwL0hjjsu8hg+s2/CAKUgyJofxoSr4yGKWGQJoV3SAdHA1O5f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R+FcX0ZK; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 4D9D51C00171;
	Mon, 29 Apr 2024 21:54:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 29 Apr 2024 21:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714442044; x=1714528444; bh=TvQfAezCIQpgNjRX/9FITqcxG7cy
	pBbpvMsEhvlw3CI=; b=R+FcX0ZKSCBWt1V2G4IvUL2lxCHIzkfDskXzqeUbMs1e
	ybgch9ILFtGGF0T+KN64ac/LAC/KCaR++MwBCTpWpf2kUJi0Drc8DLLTqGVlVxyp
	IISN/vYnjUEilbbMICs/0kcKnSUi1xp5L1ZTimSDzNIRlh22D5A/wnJ7yBn22gX0
	B01V4CMPmJ5OaScZE3XFyEZI8kK8XssgaYBzu/PsTToJRbEOBKRN+/TuzxknyZtN
	fh30/Wo/JglVY3BTrzGRAW4A5uzZXyMkLrDFm1b6kGtwv7uQFHqgpw03R7Gybgje
	QuF2+amjMi0AY53qA/WE62m2RJr3zzm8BFBqvlYenA==
X-ME-Sender: <xms:PE8wZkhsO6P6t4d9NxUY3Ismc5FW4uHt9cORQXv2sXcMBDuok9m9Fg>
    <xme:PE8wZtDm622xwiiHW_VYSOPCuQPcjL4gqFunEyyj1dG3xZi3-WXsFC_BECCwYB8OB
    xEJsrpWAay-N3VGuHY>
X-ME-Received: <xmr:PE8wZsF-8N1YAlsksLftXmPMxwhLuvfavM8M1yEDKbibOlLrOfqmBtv0D_x1CAk3XlojpbFx_0RdcZhiInWPLdUaGvm3orYD1fA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:PE8wZlTKFg7wBMZZKH3xggMyM5np0dnjB9ffa_UpUxRV5gylO7-QUw>
    <xmx:PE8wZhxiLxPPmMCOwL-ISbcMhJrTj0rQNkuVQCiIw0R77CYFu_7mcQ>
    <xmx:PE8wZj6KCPjjBM7D9ygSuDamrmVkJC_fJyEO3zrG1JK8Fb99b_mVcg>
    <xmx:PE8wZuwhnO-AGfQ9wb43QqRsDHa54ui2wMpuT4Z0M6aRxaHGG0x-3Q>
    <xmx:PE8wZhcogwxLQTgjCHDHFBy31huu0HdPWkGff1fW7f2Kwzf9zK3NBOG2>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 21:54:01 -0400 (EDT)
Date: Tue, 30 Apr 2024 11:54:27 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Kees Cook <keescook@chromium.org>
cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
    Erick Archer <erick.archer@outlook.com>, 
    "James E.J. Bottomley" <jejb@linux.ibm.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Justin Stitt <justinstitt@google.com>, 
    "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-scsi@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] scsi: csiostor: Use kcalloc() instead of kzalloc()
In-Reply-To: <202404291259.3A8EE11@keescook>
Message-ID: <070eccee-25c1-05ae-0ae8-7c6fe2eff82f@linux-m68k.org>
References: <AS8PR02MB7237BA2BBAA646DFDB21C63B8B392@AS8PR02MB7237.eurprd02.prod.outlook.com> <202404291019.5AC903A@keescook> <yq17cgg58sp.fsf@ca-mkp.ca.oracle.com> <202404291259.3A8EE11@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Mon, 29 Apr 2024, Kees Cook wrote:

> this isn't a case where we can show identical binary output, since this 
> actively adds overflow checking via kcalloc() internals.
> 
> ...
> 
> it is a trivially correct change that uses a more robust API and more 
> idiomatic allocation sizeof()s

If a change is "trivially correct" then the proof is trivial too.

Based only on what you wrote above, omitting the overflow check would give 
binary equivalence. That validates the driver change (for hardware you 
lack).

But, since a build without the overflow check must contain a second 
change, you must validate that change too by showing that kcalloc() 
internals still work for every other caller. (You do this using hardware 
you have.)

