Return-Path: <linux-kernel+bounces-126340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C5F893558
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9F72B232D7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993F2145B2A;
	Sun, 31 Mar 2024 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKCLK7yC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E11E4A8
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711909250; cv=none; b=T7/1gbvc8dP4g/DEK1/Y7x0xBr1OO0lCpk31We1h3g6YvNk9H8vInbdFSL6ltueysrd1Dg06wbEp9EJCkCvYAPUgtGF6VZG8NBeOFG2U1mqD+As9ZtDQnpnVlcwZalwL5oUhto0yt/90TofPkQLyOvKIorEPabr/mgyoQP2No84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711909250; c=relaxed/simple;
	bh=l1+UvabmoMUSAjcD3JxL10oMISA/2et2qmkpRAGLsj0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GSToHdMTTR0s30x5FtvDcKBLjYm6uZVdP1HPSbgj6Z8eRj6r+Pb6QAIqLk2VoKAB6zLVeyMxwOKaVFypXEcw76nkY1JXk4HUJoocyPu9AP86QvXQZ76ohxKPiZVKcWhNPXC8jQDczgXe3nmL8blILa1WYuCp74Gpn9gsPmmjVRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKCLK7yC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7477C433F1;
	Sun, 31 Mar 2024 18:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711909250;
	bh=l1+UvabmoMUSAjcD3JxL10oMISA/2et2qmkpRAGLsj0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MKCLK7yCGLQQ0Tu9FSACmZpeS6gjE+LuxpdwzHB1Y49cQZCdXoXx8/q+tAzg6awY7
	 317J56m7XwGly5QAt1SiKQPZ7tygfv3MAdS/SpiTGY9GBLLccUr5uXqHNgtAhGGGMa
	 ZU2t4YUtvUhhBe9ytVV1IwVMUcHPKcaGu+Us/AoqzPE6KCQfgPkLTAtIUxql7CDI2D
	 ccdQIp3H7GK8Sf8dDw/WGLG5Mgm6tsSSkBQpmRLHvtlbHqTl1SnfVAgWiShH9S2+kp
	 SQ0UTbbUQSoa0ZPXZEobzz5QO7xjlhQ9KTmo5It1L8wPobvVvflU8W/FSvKN/W5in1
	 kNVVshp2CIWXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F3EFD2D0E1;
	Sun, 31 Mar 2024 18:20:50 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240331101625.GAZgk3-cPeMkj9y3JD@fat_crate.local>
References: <20240331101625.GAZgk3-cPeMkj9y3JD@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240331101625.GAZgk3-cPeMkj9y3JD@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.9_rc2
X-PR-Tracked-Commit-Id: 3f1a9bc5d878004ed4bc3904e5cb9b7fb317fbe2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1aac9cb7e66e0cde153c90e9b96ac5644285af8b
Message-Id: <171190925064.27603.9711758853126729901.pr-tracker-bot@kernel.org>
Date: Sun, 31 Mar 2024 18:20:50 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 31 Mar 2024 12:16:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.9_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1aac9cb7e66e0cde153c90e9b96ac5644285af8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

