Return-Path: <linux-kernel+bounces-166689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002A28B9E31
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BA39B251DA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C66115E1FB;
	Thu,  2 May 2024 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6Jbt+4T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880B15AAC5;
	Thu,  2 May 2024 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666081; cv=none; b=rTig2DP8fC1+qhSWRmKGWueUkcOD8sBuS/x34iS0oRARJ5aSXHbBsOTVJHYjgCxtQdihpWF9a30O97rXt1ZJC+07LHRj2bH5/enqIljcgC497nXeonbQRG1FeZ/pjp3hA5LqgLAlUwqqJvu+6RidqENmjo7IiuevmIJXAaxU31o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666081; c=relaxed/simple;
	bh=ZTrEJzmJG0Qibm5qnkZNxiOBAVOeOGiADzyzLnfBoBw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gR0JkzA1xxlnPKIajLkYCTmbE8AMEoQTsthCnEvfATGJ6pKRH4FmBqncvpVyiTljr0FEgnDwi+GIy/5vSnusjPPesPpvkNiJ8kABlgcgA7iigICf8aSumXMQz2/IoMDLJpsJgW1bFgy07fODJ+MPz/4IcDwk7KLC7/GnAoyRFdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6Jbt+4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52E6CC4AF14;
	Thu,  2 May 2024 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714666081;
	bh=ZTrEJzmJG0Qibm5qnkZNxiOBAVOeOGiADzyzLnfBoBw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=X6Jbt+4TpcVk+EBvGTn6Ujow322PTlPvgDs5wwMmVkf+rRQ0khgCt+rGm4Cvj7vGu
	 amqC4WnWPolpxUfbw8c9gxTNPJsxdryb/wx8DyfhqfF89tLHxVC/J2NVs0qJhfbBBP
	 cpd+S71UBkR4vg5xePWtjCZ9Tys/wknY/8V5OhpkaYvVvptUQzjC18hu6lEBH6H+Sw
	 nD2ZtN8olh1E1Jl4jmBvgF8SRL6tCd1UhzULrzQaV/dYbuY6Qbawtzszk9dzrgu3sL
	 kW8KlnkTeUf3u/2gdmXUKN5AeM0fKNv/OCG0rlAK/ue+rpcfLs638+NHzEacco+sKK
	 byGt9p5IiOZdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43259C43443;
	Thu,  2 May 2024 16:08:01 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.9-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240502112326.34463-1-pabeni@redhat.com>
References: <20240502112326.34463-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240502112326.34463-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.9-rc7
X-PR-Tracked-Commit-Id: 78cfe547607a83de60cd25304fa2422777634712
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 545c494465d24b10a4370545ba213c0916f70b95
Message-Id: <171466608127.26603.8291380975724582922.pr-tracker-bot@kernel.org>
Date: Thu, 02 May 2024 16:08:01 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  2 May 2024 13:23:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.9-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/545c494465d24b10a4370545ba213c0916f70b95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

