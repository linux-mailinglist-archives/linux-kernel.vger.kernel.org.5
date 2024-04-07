Return-Path: <linux-kernel+bounces-134576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0294D89B329
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B961F22F82
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE9E3BB48;
	Sun,  7 Apr 2024 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeNjTmWt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CBD39FF3
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712508257; cv=none; b=lE1F+zsdEsSqvH0rbXo2mYvLuQP+rzsBI/pBwb2kG8O7BXDR4quX++4NvRbkXLMNs6zmyVpUGGUShhAFRkjUWG2X7lPvc2Hs8gkCD3KvtkDVH1oadExIU7EcXvaWkQ3BqgJukLKltLJam+nJBThl0MyMmJVGm4c/6Jdbsc3LiQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712508257; c=relaxed/simple;
	bh=AnrmTyGG0CNFzwDyZhsPIcW2xsSMEq7R5vRpkTYZaD8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ljatb8U8hYaxLXnoke4lbw6OWFH8whx3aeA/4Tk83XEerDjdn8cNNKOm8sWN4ym7oycqm5ruMQs1q9C8HFkWB8fAigZ8Dg+rZELQPNc8jxy9OV66CFGm2kXfenUtEQqX9mN6YrQummIdfsZLJem5bs1T3wOQ1rEe963dbgpk7bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeNjTmWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 604D4C433F1;
	Sun,  7 Apr 2024 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712508257;
	bh=AnrmTyGG0CNFzwDyZhsPIcW2xsSMEq7R5vRpkTYZaD8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PeNjTmWt4Y/v6lleye0gKPZxnR6MiNc4gFWiQ+5UvqRPkNn+aaVmY22YdaBtM2SBu
	 QsXGDppMW72dCXnZoWeLWaUH6ROfx2BSoH6uLDVbC0xfHMPMrin2rrRAPUiMY3gug6
	 I04nLDCHPiLbgIS1OJ7BwocxyQgnTRYjafR6LcwrrBJBVmpjZDzbFPcWIQk29IZt1N
	 PiZoQ5WpJdZvWP1YFp96Hl58ildJAz0kPcu3ymL3+qbEXpi6j1tA1k6MNPPM2hCwlO
	 gC/MpmrE5OISnU2v4wDHPJ5ljoeN8UO+Lpfc2qhrFtBY2hZB2x77EX2hQdgSccVT8b
	 3cZYuvWnv31jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5240AD2D0E0;
	Sun,  7 Apr 2024 16:44:17 +0000 (UTC)
Subject: Re: [GIT PULL] timer fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZhJTPt6s4Kwibcas@gmail.com>
References: <ZhJTPt6s4Kwibcas@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZhJTPt6s4Kwibcas@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-04-07
X-PR-Tracked-Commit-Id: 7a96a84bfbee96871bb16c70ee3e93d564e190f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3520c35e5f0b00cfd6a774d04c1b3bb18edc428a
Message-Id: <171250825733.19258.15359122887595980930.pr-tracker-bot@kernel.org>
Date: Sun, 07 Apr 2024 16:44:17 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 7 Apr 2024 10:03:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-04-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3520c35e5f0b00cfd6a774d04c1b3bb18edc428a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

