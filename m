Return-Path: <linux-kernel+bounces-144330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B952F8A44B6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D4D1C20FE4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF5E136E2A;
	Sun, 14 Apr 2024 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgSDV+p3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA913664B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120483; cv=none; b=ONLCVy/j6oTTYlEpDT94BVOagl2vDTVnk9gav7tJ7s7mlA+2+OBkkrRuF7A3PDioV5OmwbH/NyKQFb1svR0qnSYwEfbqgPlmga4tfm8GmmgWMS3eDfdx7B5gHcG9+PHmuDB0XEk4yjQm6TydDyxsDO8aTLBx3qHbnDvRDWM+SXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120483; c=relaxed/simple;
	bh=gQe0gEDxBqgyBBXa0cl6/tOs9Pg87uYOL7UBCHOHO4g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ck3OdsLiDllOX345PdU6hfknydcOa5a07NcqRQy2Hi1IoVUcwMHmU8eW0h53ndyBKWJ5e7U4ubzvgP+epn/6BUCb1CAmFzXyZm5CffZHu6J6LFzgOIXcCcMsYc7Y+MFT9DwtdkzgJtsn0iFzTpAsE+H10Kyqm6BXhED4+xnENKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgSDV+p3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CECAC32783;
	Sun, 14 Apr 2024 18:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120483;
	bh=gQe0gEDxBqgyBBXa0cl6/tOs9Pg87uYOL7UBCHOHO4g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PgSDV+p3mBY4SZxA0owY33BZbjLP8/kEdTxDyUC37VBr1Qz04M6dMwqPMm0ZsZ+sx
	 OkesyZOxpSm9/8kUgWzTBkEThNYYJxknfVjs/SaqKTDK5HKSBOuAi5UOq0v5NRxelA
	 xVKI8h9Zc2cEfc23Z7QXk32xgAoqJj+AM3nPpFTYNY0hjwvWuNQ7fLyolCe2zRiTkl
	 DP3xvgQvR2RJ7XEOPTo7uIZb5Zq00c+2n9Rp1p7r+aRaeFfO9BHyBN0r2d68p+fgT3
	 VhwQY9JhKgWPB+oX1tfqEA8Aamr5xlaN0NmnbR1oaWGUYLeTs7fTULRCWuzYwITnkJ
	 yF/0ZgX+TNgIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CD75C32750;
	Sun, 14 Apr 2024 18:48:03 +0000 (UTC)
Subject: Re: [GIT PULL] locking fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZhuNSJxHZzWhVAik@gmail.com>
References: <ZhuNSJxHZzWhVAik@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZhuNSJxHZzWhVAik@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2024-04-14
X-PR-Tracked-Commit-Id: fa1f51162338b3e2f520d4bfedc42b3b2e00da6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa37b3be189606d8af1888b490342f7aa4cc8023
Message-Id: <171312048344.2589.7802738334583086384.pr-tracker-bot@kernel.org>
Date: Sun, 14 Apr 2024 18:48:03 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Apr 2024 10:01:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2024-04-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa37b3be189606d8af1888b490342f7aa4cc8023

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

