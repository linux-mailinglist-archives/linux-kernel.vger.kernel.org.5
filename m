Return-Path: <linux-kernel+bounces-161555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A358B4DA4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D43D1F21560
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8202274BE8;
	Sun, 28 Apr 2024 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPpOLeol"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCC574439
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714332496; cv=none; b=amTS82esCMGrGlmGeh7K4iCPEnUEKKnitS/Eb9GRAmaxOWwfvGNhb/9SMiHLABXZNY4/RFqKW1DZcypZsm7cJAFAkHa3FY6NZ0V1jZhLbMEF4LCJqZ2TAdLzVqxRZEV7DvAEiz7yAZGPUhFo7wUL4sMVrSo+ezfV1MxHCJ5xkjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714332496; c=relaxed/simple;
	bh=PHrsxmY69ZRrfqWcwjc61jcffGtyignyWY+HIufpAVg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DBSHCIWMSF6cSNMRSMh4jy7EiKfLtv5gtkDBOJ3FLBevFK3rxblksLIboQiYxck7D6q2ix8bwKZRzwLzaq+/9iMpXx56++ifIpRp3F5d5YCa4fTjs49dRpqm6P/ajP0aOncdYuVeuCzF9m5scahwbohMtteH+5vCSj13bCzmGrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPpOLeol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 571D6C4AF17;
	Sun, 28 Apr 2024 19:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714332496;
	bh=PHrsxmY69ZRrfqWcwjc61jcffGtyignyWY+HIufpAVg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vPpOLeolzxUrIUYaiM3AvTgK5cJOlpKEK6AX6+amQjNW9bqzoH35RjoTDdGgd1ahv
	 lKB4JyfGESR6jcGKblyDYMGXaforfWipZHrE/CyrA6bcr+lqs+7qO+hGpVW+lp62da
	 ehdcqS34OWj8TAaB8i9WcuJ2IUO2kgJfQEok4fQ2up6akJLMeu4ay/KSsCJCLi1Hw8
	 1PHgwZebaowshW2r3gag8WUrG+iAYLaCwXg1r3YKii5SYOmOO1lih2UtZxQEQcOw1z
	 z2BwMmFutJVlrvHqAuySG0K8I7oeFbKsJd5kRvcrxqNE82kxEMoYGrHGdCMJVx0T+o
	 MiuXTeYxCZ/yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47F4CC433F2;
	Sun, 28 Apr 2024 19:28:16 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zi4HyMFJBwm+JIKZ@gmail.com>
References: <Zi4HyMFJBwm+JIKZ@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zi4HyMFJBwm+JIKZ@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2024-04-28
X-PR-Tracked-Commit-Id: 257bf89d84121280904800acd25cc2c444c717ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 245c8e81741b51fe1281964e4a6525311be6858f
Message-Id: <171433249629.9908.8820172546151118618.pr-tracker-bot@kernel.org>
Date: Sun, 28 Apr 2024 19:28:16 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Apr 2024 10:24:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2024-04-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/245c8e81741b51fe1281964e4a6525311be6858f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

