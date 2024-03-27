Return-Path: <linux-kernel+bounces-121541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8C988E96D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E5E1F31ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2D512F380;
	Wed, 27 Mar 2024 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JnmygjQ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L5St7XrR"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A424F5F8;
	Wed, 27 Mar 2024 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553695; cv=none; b=feE3EWea2sSctiX4ahyCgn5GoKXKjoREEPUJ6iJTCrZU/4SjarwHbUjLet9CMa6DDdixnB7HDTAp9nsOIEbQUMcsSvEgJdnOpTyOXymrk6CtMjZ8scMVSKk6wjBe3pDJLelCSKq5Z83rgVFB/2xHAI2tyvnZRI3EespGLRttrVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553695; c=relaxed/simple;
	bh=lUHWRBpXKfmP0a3SvWBrN/BSuWtzBTXtGgk7O5R0Pz8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=IKckvJZvS1Hxc4/6vB9kkUUFitoPtKgTv+dehR3/KOMcKiGjFeoTWQfMl8Cz8hxSdKz4cXdac8taqa2+p2hCE+f9OOI8VDjpqHJMN9Rqpr7WfVRb4APShi/COUw3bqfRAiUtCtDj+dGgkScBsHyaV83OxShOxC64iKKu2LAGQQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JnmygjQ3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L5St7XrR; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4EE5A1380090;
	Wed, 27 Mar 2024 11:34:52 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 27 Mar 2024 11:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711553692; x=1711640092; bh=gJ7Xh4n4V5
	9XATJeqHFzpnTJe2/5ypdcmW4oC7ig2Jw=; b=JnmygjQ3q8nH17VFO7y4ypXObv
	H5QudRFgGDXD3iPOWTOhnrfraaE2jEe2ZuERyQqkAvzguzWvrw9Xbrl0BgYPsuM1
	GQ91t4Eis0L2+PN6k9VKMgJbLNAEAnTipnubkg4/slYpNAUjCl+7dl3rILjuauvY
	aYFmTGt9RAfZ5TxlObNwaJ+oNo8mE5Z20aV/t6095L8EmaBbAODemR5brQFz0I/m
	fuM0RyeEluV2vMB/1pEl0KkawNa/6R5bW15G4adjuaejW5wrxm8e4nDLNXKnA27p
	mnrmYFcBXYCaLlIpAzZ6XvBjrkwnGXvILz+PNvwuHH/zrAULDefFEz5MxgAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711553692; x=1711640092; bh=gJ7Xh4n4V59XATJeqHFzpnTJe2/5
	ypdcmW4oC7ig2Jw=; b=L5St7XrR3/MAPQEbqvRF4QviegIL+Af8tRM+ibhX+Aae
	E8zvBhoh6gXO0RvQC22z/HNJk0FQWX9oin4ojBOoC43Iif/1ukDnl7LtyhzQe/O7
	WVmcp2VK6YD4xl8NARuAKzSaeCa01c5F4RffS1sQeaHJ9lGp/CPWI6d4lgHwzBmd
	i6tYyXQtIEvPGQzUOhKL5jfH44+kvvAA2DsBR2jzM1LiIrFRBvuUERZuU+fmuqta
	0T/1W/EkmLWLaeSkC0IG3JOGUbQIijCPQRq3t1CPyFBv+2H6eO79zC97SXw1SDbH
	2q9WhEDNMb0UjKsxgbNa+Wb/wiOnjmuOw+ITwsaFkg==
X-ME-Sender: <xms:mzwEZu78CN3xb6AsalWwSx4P7qfguZ-yv_lPNT-uYwb7STNBkAP1Uw>
    <xme:mzwEZtKOeM70KUmof9Q-MtZ1_K8bRjZu_8gkqVVkOaDajHM8x87vxc2pZrw7qr1j7
    KMh3oJk2VhR0tMLne0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:mzwEZvIa0ddXl7H1YeHdrSnPfbrS8lvG4dT2BrK5nfhSj4O6_NpDqQ>
    <xmx:mzwEZjXbnqlH0QatGBlS6dFGkxorexklKNvm0yv3OwPZ5AOc7vVdrw>
    <xmx:mzwEZpg8SyT9WSa8Ms_UCnN7MkzF4THhZf2o4VbSH6enMQBuAemUFQ>
    <xmx:mzwEZm_aX6I356Aj0Po9_lJmRoa91EnBg2JiPYlouwvd42KNhHzBQw>
    <xmx:nDwEZl4kWE5_OcwQPWec-d7QUMWV-jF7kzVebwQYJFkfSPeQ_ERQCg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7F4F4B60098; Wed, 27 Mar 2024 11:34:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-328-gc998c829b7-fm-20240325.002-gc998c829
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6242198a-8559-4465-918a-36442ea03e32@app.fastmail.com>
In-Reply-To: 
 <CO1PR18MB4666DF3B7684D340C3A3646DA1342@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <20240326223825.4084412-1-arnd@kernel.org>
 <20240326223825.4084412-4-arnd@kernel.org>
 <CO1PR18MB4666DF3B7684D340C3A3646DA1342@CO1PR18MB4666.namprd18.prod.outlook.com>
Date: Wed, 27 Mar 2024 16:34:31 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Subbaraya Sundeep Bhatta" <sbhatta@marvell.com>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
 "Ariel Elior" <aelior@marvell.com>, "Manish Chopra" <manishc@marvell.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Simon Horman" <horms@kernel.org>,
 "Konstantin Khorenko" <khorenko@virtuozzo.com>,
 "Sudarsana Reddy Kalluru" <sudarsana.kalluru@cavium.com>,
 Netdev <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH 3/9] qed: avoid truncating work queue length
Content-Type: text/plain

On Wed, Mar 27, 2024, at 15:04, Subbaraya Sundeep Bhatta wrote:

>>-		snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
>>-			 cdev->pdev->bus->number,
>>-			 PCI_SLOT(cdev->pdev->devfn), hwfn->abs_pf_id);
>>+		hwfn->slowpath_wq = alloc_workqueue("slowpath-
>>%02x:%02x.%02x",
>>+					 0, 0, cdev->pdev->bus->number,
>>+					 PCI_SLOT(cdev->pdev->devfn),
>>+					 hwfn->abs_pf_id);
>
> Confused. This should be alloc_workqueue("slowpath-%02x:%02x.%02x",  
> cdev->pdev->bus->number, PCI_SLOT(cdev->pdev->devfn), hwfn->abs_pf_id, 
> 0, 0);
> Right?

I still think my version is the right one here, see the
prototype:

__printf(1, 4) struct workqueue_struct *
alloc_workqueue(const char *fmt, unsigned int flags, int max_active, ...);

so the first argument in the format, while the printf arguments
start after the flags and max_active arguments that are still both
set to zero.

      Arnd

