Return-Path: <linux-kernel+bounces-21795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A32CE829468
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA2FDB2479D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAF73A1B5;
	Wed, 10 Jan 2024 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="EizVZI9+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S8TMmgL1"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C7938DC0;
	Wed, 10 Jan 2024 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 368A13200B21;
	Wed, 10 Jan 2024 02:37:57 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 10 Jan 2024 02:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704872276; x=1704958676; bh=9wkDRQh6pF
	FKUXGsU4Ant2stj6MA5eYv8VwCd+J8M4g=; b=EizVZI9+THloNiP6QFH9F3BR6i
	Pt+D3ruiLPekF/vwc+I0992Dh+A4ps7yM/edsEqX6wFEhm9CV06d2dnqsbfwG8kt
	2+MVR0cbw/eTE5hcy5SxNSSHR/jJhU/0+jTE6Jtzlc7TjcT5yKsE1HRn2fWUH4Uw
	t3g0ohsiosQdLzYG4gvac2RPHblBvV0rNHm73ADYVQf7FZU+L9rvjejTGtuFM5nh
	epIStmMNRqn8gNDoKQ3VoSGPMtrXnJWEg9sG4FeQQT1RGMAc6p+E94la9XPgJLIQ
	3kzHItOdm6qXxEbpbjm7O59UIgzhJnQgm+LHEiS9iu8sQfDBnKiAIwaEq0ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704872276; x=1704958676; bh=9wkDRQh6pFFKUXGsU4Ant2stj6MA
	5eYv8VwCd+J8M4g=; b=S8TMmgL1glDm7J7wIXXbSpAM12cRTah6GJkpxVEeYMao
	It+lVaxyw+JNOxqw9qWrGAldwoNF0uYBKPQ08Yrjerpc9JWDdwl28BqHgleMcSUh
	uv1ZDV3mC5Aym1ostbuVj8wB8blbsgTdtlyV8tvAwmpNg2gwbsWrTsg1+ktnpzdB
	sgA7FzVtT7/KFyF+dk0k+XphOBnCN1LVhWfdD86wyFxJmxA0X8/3o/SZ60YQnFGb
	ThK3NfH136+Vbp8Khh8F9MCAHfrRK5pxBkUpFcnJPzweAaQants85VY/C54zsZFw
	un6HP4sNBsZse6b/UTLtGjv4JSElUdEnMe0CVRewDw==
X-ME-Sender: <xms:VEmeZcsfuhgUOJ_LNXYcuFqnZZdU7bEUCGk2jF5NPsniRCt9nhl5oA>
    <xme:VEmeZZcH6mCccEm5HG3gXlehNsHqlWCXJ45NVppqp9pL_2VclTiwGE_TaxMPwTSXd
    ZFjWS7-j_yrpxfNXds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeitddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:VEmeZXw9C29aEeyIT_GfJQNaVGuKfPJFiJwEEl2OppZxHsIlFUnU4Q>
    <xmx:VEmeZfMBOtx7GMdYH0WjQuOw490MXBKsRBq6zeFp3d4mFWYnqSjRBQ>
    <xmx:VEmeZc_quqQcjGDCYybWNQLDD4pTsTsO7GtPv5dboJQrH4FhW302Qg>
    <xmx:VEmeZREO3FrIkUpm_MwN4gsKDHf5qJWT6UDAk1KpJzQDO_UX6EYSow>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 404E8B6008F; Wed, 10 Jan 2024 02:37:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a74946d3-3fa1-47ce-8dee-13123c0fdfca@app.fastmail.com>
In-Reply-To: <20240110083442.6728646c@canb.auug.org.au>
References: <20240110083442.6728646c@canb.auug.org.au>
Date: Wed, 10 Jan 2024 08:37:35 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the asm-generic tree
Content-Type: text/plain

On Tue, Jan 9, 2024, at 22:34, Stephen Rothwell wrote:
> Hi all,
>
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
>
>   e8cf41b96bc9 ("asm-generic: make sparse happy with odd-sized 
> put_unaligned_*()")
>
> This is commit
>
>   1ab33c03145d ("asm-generic: make sparse happy with odd-sized 
> put_unaligned_*()")
>
> in Linus' tree.

I ropped mine now, thanks for the report. It was still on top
of the branch, so I'll just send the pull request without this
one.

    Arnd

