Return-Path: <linux-kernel+bounces-99729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60032878C49
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D0D1F2234E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2603FBA34;
	Tue, 12 Mar 2024 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaePCUol"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60563945A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207013; cv=none; b=Exunb3wJf3ZrVj1XPeBHggRxiQZrUIrOxedZYRsTSi97u0t1OOySrqs+bMsyIOqyaMP5V2tfZDgg+z5QHF5U7GEdw6Jz88wlLic31ZHsqqFJvqyHihNhydIJCN+PgH2E7koNJCc8CxS9A/miMsFr+tsyi1LPaiqyk399AftXWTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207013; c=relaxed/simple;
	bh=4UdH1BNQB6hI3wQ/yzohYKeMGl8iQRahcvqLC9YuxYc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LDdkBPvRbPUTLBljZYvr50M0lFMAHLkj6ajtK27xHOac5mETUq0gqsj/M1yIrl0vMkdcu10h44wJWnq1zhJfrTQ6RrJHR1HM3OE1AU4zqgDBVACWzyLU6IGw3ItHe1yRr+/fdnqh7rdnCYMfeUZT1GfN0FcuIJI3NkbWqDlp264=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaePCUol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB503C43394;
	Tue, 12 Mar 2024 01:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710207013;
	bh=4UdH1BNQB6hI3wQ/yzohYKeMGl8iQRahcvqLC9YuxYc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RaePCUolsL7pBFP4yy76k9bAcB2s9qI7nSWsE9R3Ws5IVRctbXGmgQyxD8YPt9uC+
	 S/DfmPFsfPV7NiES3+pTB1raYc+CN/IkDwhQRMUnW/otHPULtqaBf5g5sKfJd540U5
	 5pGT43aW9JUO+SC0WafJ1c9+3JiqErv0Ql5SSAb1cF7k9LHnT4FTdsXvj79og0imAs
	 bZIH2JvSi83S7bySSRGdmpO5BLMVeFbFxCiLo4E299w0jKQkIpY1/lXS72xcWAEsjl
	 XEpECzmIu3DzUsuOpVlO4XKQuuZgp7XyY0AJQu0NcM5ZILnQpXuHAtsS98VKYQUY6p
	 D5zgSNL+0bcxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D759EC395F1;
	Tue, 12 Mar 2024 01:30:12 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cache for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311144621.GAZe8ZPWxhiTzw2wDP@fat_crate.local>
References: <20240311144621.GAZe8ZPWxhiTzw2wDP@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311144621.GAZe8ZPWxhiTzw2wDP@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v6.9_rc1
X-PR-Tracked-Commit-Id: c0d848fcb09d80a5f48b99f85e448185125ef59f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2edfd1046f555db6456514bc8ffe0847537e54f4
Message-Id: <171020701287.888.17572693974224970767.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 01:30:12 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 15:46:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v6.9_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2edfd1046f555db6456514bc8ffe0847537e54f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

