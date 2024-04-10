Return-Path: <linux-kernel+bounces-137947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B224889EA1B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD651F23E33
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC552030A;
	Wed, 10 Apr 2024 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="jczkZAbk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iVTyHwPI"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE39B17745;
	Wed, 10 Apr 2024 05:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712728270; cv=none; b=dtqrVXSI0s/5oYhOrflZUaRC5rAJO0ZvctQg7qzhCKFA8kBhR3u2VfeVsdu8Z0UnOOWD5Gy4pSltejei0Ma2CpZsFSts7DRNkI757qIoMuVrtCQfPVB2woY+eOdG1/7ikLFP4EuIZqzyMakfhWdyQcicsMFLXs5KrkxCaL62uk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712728270; c=relaxed/simple;
	bh=5BdpXbBttgdr9xHrq7HGP6qq62gxDtv0CQ9h2KVbysM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbP6G6tR7ODcKrxmgOsLCdkkRGoRd4VPlR16C9I7IKnVgXvG4kcvbHh8vUrKyZrCj4TALo2UnhD21KyQ0n1ke/uiwX7kRvV2NG5oPx3gMUyHqb19GGGVMudTvzRN1LLVT6CeaUsUXg6RL+IvFt3b9W4JB+rlZmXU3zO59glGzlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=jczkZAbk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iVTyHwPI; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id BCC1F180012B;
	Wed, 10 Apr 2024 01:51:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 10 Apr 2024 01:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712728263; x=1712814663; bh=jkV1acoxnY
	ywWAbyLpFFbxibsnS9FadsdDiyYpzzDxk=; b=jczkZAbk92xGf0Xqh24S6UOXDx
	6mWpFKM7iEtc3EmA/g2HgtYZdgqvcjp41BGt2/QuZtbfVz0H4yzz8Q4VqHCPyYXN
	lJ0MM27ZHuSHiNT70Jpr1ZbzkS0mwv8jea2u0RbafaF2YBv+DNfupLIAdh4p6h6F
	tw0HsfiLiXQdIRWxxu7KVwmsnCUr8G2p8bWBtkTQJv9K8QpzzkrqukznCIejj7cy
	z1qXERSh4Z5udof+EkOkdRZWpL6exkZnw7Sf3N0uVb6IIENL2jjxvP8DIFlZ5aKN
	Qk74h9JWe2goAP6r9lyge7R+MkrLz4YG2tJ8fPj0U+VSGCifjrYRuXLw0NUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712728263; x=1712814663; bh=jkV1acoxnYywWAbyLpFFbxibsnS9
	FadsdDiyYpzzDxk=; b=iVTyHwPIwh0ly2XTO1+EF/KzMiRyC1a0dwayOi4VUWLz
	GzV1Crd4p6w3URzwVce3c61l14IsHiJF/8pJ0t/Ay4xsbKsbnUwZm5f3nuvQkZ82
	uj23sK7rV3C7Sr3qorfLp4c6Z08XR8PfoeM6Pu4NziZELbb2dpTaTtbtAmb+K0D9
	m3ntlfnQSJUy8mp/IXbAyWkGV5ss9rkW++oO3ZtpaVutlmTGluhbuTvYKb+kqDnE
	EqwBZjd3uS+SjFIXkXzs0Fan4rUYHyjYB/E3g7aEV10f3xZYAEIMcdYDTyaPSVUS
	O0dwZ2cISrQHnJE8L/L0jMsJpx3PAoi5oSuVMxX/eg==
X-ME-Sender: <xms:xigWZkQP8fQpUI9xVmDhPfhOQI8zA5xhQMDj6kjxR-7O1aaTEN8wQg>
    <xme:xigWZhy0ADFA6_RYST46q3_04xGJ3fQm9g9CUpDTyBmGBZaGYRKTKjg0Ho7tPoM5Z
    UR_ykvU5kvIaA>
X-ME-Received: <xmr:xigWZh0wTsiGX9a37v3ALWH-cKZJ9OHLzUBP7j1Ti3JuQl5eOZENfVB0cB9G1EH2WwKKdKqHk0XlX9WMO57TWvfBbJln8xSoRRdueA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehhedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:xigWZoD2I06NQv1BWObpTgk4vuMlFuZBAM9aYD6-A1DVKKadHLv_Xw>
    <xmx:xigWZti4Cg9dVHHbFZfGHR7505wJraCFinfLaJ10-654I3XWEH25EQ>
    <xmx:xigWZkpgqUEmoKeeTQ6DlkUrJj7vX0hzvGXpOaJaaCDTecdEUKg4AQ>
    <xmx:xigWZggNdoQ7P-Y8i-IFkRli4LHSIDBwBGzv38xqAYqspUjS8Tvg8A>
    <xmx:xygWZt4AfMhr7p7nNAaEa37w0qGSjEDWPRI68s4R3WeI7YIeVi0O3xw->
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 01:51:01 -0400 (EDT)
Date: Wed, 10 Apr 2024 07:50:59 +0200
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the usb.current tree
Message-ID: <2024041043-sprain-stank-10af@gregkh>
References: <20240410090500.4018b9a0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410090500.4018b9a0@canb.auug.org.au>

On Wed, Apr 10, 2024 at 09:05:00AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the net tree as a different commit
> (but the same patch):
> 
>   fbdd90334a62 ("MAINTAINERS: Drop Li Yang as their email address stopped working")
> 
> This is commit
> 
>   eaac25d026a1 ("MAINTAINERS: Drop Li Yang as their email address stopped working")
> 
> in the net tree.

That's fine, this should merge without an issue.

thanks for letting us know.

greg k-h

