Return-Path: <linux-kernel+bounces-132173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38587899098
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95EC1F23B26
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A0D13C3C4;
	Thu,  4 Apr 2024 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="LMIK8Xyl"
Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931A813BAF5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712267323; cv=pass; b=tzhPFnnR/hZUOIAptK1n7alerTqC3AdFQSNBIMwUjHRZr17hEZY7GjmcQb1R7ZjFGCNF5yc2YGwWCVY6QEOkFA+PX/txTMmC+N/Y3YW8vFvDIWLWDYDWqr/JeFWw99d8jh1R0QSY5guaG90jhPHiFXc89/Sz0ZRAl4/awRCsEOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712267323; c=relaxed/simple;
	bh=M6DIshYVJQR0DO4VUKuLo4E19fWk1vmFQ2Kk6iCE5tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewBii+LCYmFuD5HjGA0nxwEDrwtCQWeJj6Wl2ov8nkxUveLSigAgabs8ZIaEj6+ZCL+Kud4lF7BEjtMSMgthmS1zAufkvGLUUqaZo9VNIdeGhAymkB2ZE8w3k9wBzeNTp0WXtNQJC7BkL8JfercEWTDEyfk0SOF1FRSF2QFPagk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=LMIK8Xyl; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DD6808257B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 21:41:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a264.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 84D8081F4E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 21:41:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1712266917; a=rsa-sha256;
	cv=none;
	b=0PXT1g2WDqexfisBw0CjqD6K5N+Ru+vs4In0SCl9VVkQ7LWYgNLInSI7v7JjD6IjG1DIEL
	9g/fPuo3pn2Y53wYATk06VD8vW8YyKkKTc5qKWYBigPa7+GXr0MveNk50u2IwwfirtrH4i
	48T1LVqIXpQHva7BGiH5mMo0lfDtMtyY4EosOJIZ1b4LhoNxGmiOMRwoUlOfJjfwWOHsfA
	jW99WTMnXNUWS4j/8KyCBF6MzJwe0VPERcKaD20nhYU6UyVjh8BmFzs71ANz2XroeEz19Y
	IyiUBAOqsODL6PpNucZ/ZlDdSAo8MEmpbU6++zjgfvDs6wKR0kMZYY8eed1BHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1712266917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=oiU215bQMRqMD25CrXr9YpvEHYCDhTpFJaAfQebstxE=;
	b=97ilUBTD0D9600sfwr0sIY5oxBsLVvxZyvvEFnHyyv3AS+jSQgM3O+tx+j2DqohcFZNSnD
	0D2e5XACe1zl1H+Ikx8pvlH8mlSdlx0Rv0LG2UiR+BiYJt5l8adgSUgSWoupIqXows4YQS
	BvXO1EH/Aa0Yb7lWpL0wf60sHPgltXaEqltFT4tF4nbDND03yE5frN/tjaVgXgMoBSwUk0
	Xn2eKF4pMpHOXvV5CiU5K8BkZ5GPp3RECnoC+cBQZBri5sZjFgtCzhwKBAQxNuDcjr0+QN
	W8orRTMr8JrjKAHUTXKKlk4gZVONGJ1thjN/poMXEiEaVQoPLf4nd2zru76XYg==
ARC-Authentication-Results: i=1;
	rspamd-86f86f958-64ssq;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Absorbed-Attack: 188f4a7f2a25fff5_1712266917779_651901442
X-MC-Loop-Signature: 1712266917779:4165931739
X-MC-Ingress-Time: 1712266917778
Received: from pdx1-sub0-mail-a264.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.113.83 (trex/6.9.2);
	Thu, 04 Apr 2024 21:41:57 +0000
Received: from kmjvbox.templeofstupid.com (c-73-222-159-162.hsd1.ca.comcast.net [73.222.159.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a264.dreamhost.com (Postfix) with ESMTPSA id 4V9Znx1TF9zVN
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1712266917;
	bh=oiU215bQMRqMD25CrXr9YpvEHYCDhTpFJaAfQebstxE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=LMIK8Xyl6bHblGCtjWTDQm/b66eFVU/mhAWcAHTczX+sQgZ1d/KhhBYxz6YF+Nkl4
	 M1dGy/oyIWRXRI7sABKox7pd2poOj0ID/nTA94ZDsFKHdc1NMncUVSndihX3qhEnRz
	 sBnj9sIc/4MY3YVzcKHf62ucff/Y9coWWktaClQ2viyYp+AkHBdZArpAkWE5enIHK1
	 pOG4qmGndYS0AmrVyjSrQfqcSPJN0KJoQpKGBzS6m2rskWbGPFKH6EFkH9XKsFoSge
	 2WfajbRLfnG+l4pvGsQQT84OSRQgExQoNe5DHzQ6qPeQUscrC9wGcpCYUHM+lsrFZ7
	 X9KWR0A5TFUHQ==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0103
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Thu, 04 Apr 2024 14:41:56 -0700
Date: Thu, 4 Apr 2024 14:41:56 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Ali Saidi <alisaidi@amazon.com>
Cc: catalin.marinas@arm.com, james.morse@arm.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	maz@kernel.org, me@davidreaver.com, oliver.upton@linux.dev,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com
Subject: Re: [PATCH] KVM: arm64: Limit stage2_apply_range() batch size to
 smallest block
Message-ID: <20240404214156.GF2178@templeofstupid.com>
References: <20240404044028.GA1976@templeofstupid.com>
 <20240404212742.11248-1-alisaidi@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404212742.11248-1-alisaidi@amazon.com>

On Thu, Apr 04, 2024 at 09:27:42PM +0000, Ali Saidi wrote:
> > Just a quick followup that I did test Will's patches and didn't find
> > that it changed the performance of the workload that I'd been testing.
> > IOW, I wasn't able to discern a network performance difference between
> > the baseline and those changes.
> 
> That is a bit unexpected that the performance wasn't worse with the patch Will
> sent because it should have disabled the range invalidates since they these 
> invalidates will be getting rid of blocks?  Which Graviton were you testing
> this on? 

Sorry I didn't mention it earlier.  This was on a Graviton 4 with
FEAT_TLBIRANGE.  Due to the placement of the test machine and the client
the max single flow rate was 5Gbps, and with both the baseline and
Will's patches I wasn't able to discern any slowdown there, at least in
terms of impact to the adjacent networking traffic.  I saw an approx 1%
slowdown with multiple flows at 10Gbps, but didn't have a baseline for
that test case so was hesitant to offer it as conclusive.  I should be
clear that I _wasn't_ measuring the the teardown times in this test
-- just how the teardown itself impacted the networking performance.

-K

