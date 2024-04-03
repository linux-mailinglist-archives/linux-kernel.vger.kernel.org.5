Return-Path: <linux-kernel+bounces-130757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7E4897CC7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8971A28A611
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F98156C50;
	Wed,  3 Apr 2024 23:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ly6fWjob"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3CF156997;
	Wed,  3 Apr 2024 23:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712188664; cv=none; b=tNYkrnHWHgT6zFVL/lxqtmzWBjZzQHpjaErAXvIcLpFlTvgpCGzsKhauw2furuwFnyDCJHaEz2AjyanQHpsqGd1syabXzJw/vYn7fuAG9RwFVdLtBaQId0d7oTN4J5XzQbCpr3awN1ocGG0VpJQb84NnCpfJs4vMop8RAt5KM+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712188664; c=relaxed/simple;
	bh=sFxDO+zcW9BeIxLKqoVAM4vcKS408qpmhYpiIyex3fM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l2xBTNjl2LXP9IsKBNvtqOhP0h5VNrsJRhjtjfdOhaWmlJuheGZkSS8aevor5D41RvSX8uHwa+Qsw8JBonS6ojnWKZD5xnu5l8UqVHhofprOx0hwUd4LmOPLLU/cMXnMt8YJfonX/UuDltvnjuSlf4wmf223+dVLRH6c0v7Eh+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ly6fWjob; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3336D18000E6;
	Wed,  3 Apr 2024 19:57:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 03 Apr 2024 19:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712188659; x=1712275059; bh=OELAIjno4nfQgKNkfoFeM6509nD9
	yu+wU/USbZIq3mQ=; b=Ly6fWjobE6ZPUlqXWFEtFH/gQIHpoid9rDB98jlyaTJh
	kk0v1oqGGpUj+C/hZS0ulZ4QUvTqgqCDpFBgENNtyGoua/PvmNqc1nnqdZ9KNmS5
	hPjpM12T7AolRLgwAARWy4jdMc516acWWWOPveTAIqDnqhXPi1CKQtMOjEvyo+jH
	6/umDSd4MU77Diw6lBfYdVdQjr+XK6mD5w52xsNsVXildfxRfnhdDbfeJyC9L201
	JlBcfAj/JxeiEWyZ7LgduHl7/NaA8JGPex6jK17kfIXNnOr1ntkwEXtfJln3nEQL
	WUgUxhNP9UT1myLjFjZDCNEeMMM2F3/qFRT3jcqbrA==
X-ME-Sender: <xms:8ewNZkTXh0nV2ISUSLnuW7Oj8hQdO11sxYdWG0mRQ8-FBm_xIkf6GQ>
    <xme:8ewNZhzc4wwfGHlOkW75fPnJs1LIPB2Wue-SlE1gtpqWXC5LafnTfeT9JaF0T9yHY
    iz0DV7ci4SojJduBOg>
X-ME-Received: <xmr:8ewNZh049l3BJr1P2mIyKD-vFwLBO8ufPIjoOWylYTIGkqSBmDfYX99TtWiRG7ZPP5tTcsaIF6OUcVSdTlvnP3H0CoMr0reU4Mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiudegheevveduffduudehtdevhefhjefffeeuudejueehffekieeguddu
    hfefveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghi
    nheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:8ewNZoBe310LAF2hGNBzgtRoR-M25vJsOSzH0y-laVkFeRDt3lNfeA>
    <xmx:8ewNZtgARgFk-67Wou6YN8MmamJ2gYZ-5b_MekAWFpvczgjV0a5Evw>
    <xmx:8ewNZkoIlwcvaHAAuaJjCGd3BGugl3zWonp5KX6y5pcGJOX8rExKBQ>
    <xmx:8ewNZgiVli_ELxeApB-oKXO5WTac5Xt-SWt80PQeh3OWSIEtntNTNA>
    <xmx:8-wNZgSmDgLSavzmSj0cOTWXTC7LPZbgA32wZfSC3-xp9OwvbKmLW_LT>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 19:57:35 -0400 (EDT)
Date: Thu, 4 Apr 2024 10:59:21 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Christophe Leroy <christophe.leroy@csgroup.eu>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
    linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] serial/pmac_zilog: Remove flawed mitigation for rx irq
 flood
In-Reply-To: <Zg3YZN-QupyVaTPm@surfacebook.localdomain>
Message-ID: <8f234f26-d5e3-66ed-ab0c-86d3c9852b4a@linux-m68k.org>
References: <dda2187e128bfaaf092351812e4538e2e41c17f6.1711599093.git.fthain@linux-m68k.org> <Zg3YZN-QupyVaTPm@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 4 Apr 2024, Andy Shevchenko wrote:

> ...
> 
> First of all, please read this
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages
> and amend the commit message accordingly.
> 

Right -- the call chain is described in the commit log message so the 
backtrace does not add value. And the timestamps, stack dump etc. are 
irrelevant.

> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> > Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> > Cc: linux-m68k@lists.linux-m68k.org
> 
> Second, please move these Cc to be after the '---' line
> 

I thought they were placed above the line for audit (and signing) 
purposes. There are thousands of Cc lines in the mainline commit messages 
since v6.8.

> > Link: https://github.com/vivier/qemu-m68k/issues/44
> > Link: https://lore.kernel.org/all/1078874617.9746.36.camel@gaston/
> 
> Missed Fixes tag?
> 

Would this be ok: Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
I have to ask because some reviewers do not like to see a Fixes tag cite 
that commit.

> > Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> > ---
> (here is a good location for Cc:)
> 

Documentation/process/submitting-patches.rst indicats that it should be 
above the "---" separator together with Acked-by etc. Has this convention 
changed recently?

Thanks for your review.

