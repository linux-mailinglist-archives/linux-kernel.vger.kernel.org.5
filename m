Return-Path: <linux-kernel+bounces-30618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE586832217
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4471F2168D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CB6321B5;
	Thu, 18 Jan 2024 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFOpYziO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9212D609
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705618911; cv=none; b=KqmJvlLdgi03QoOz1lmJLoSgOMm5FSTKcA2rEpljXEz91G6huZoHGeSVXLZ6Mzz0wisola0SzN7urOt726Hm0dxVpvq0++Er5dPgNwkxL8obThPtDkfgTxTeP0N1N3gfWih2LRfORB8HgM5E1VBo9gCXQ1LWy0Hw6ApcN9qlvgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705618911; c=relaxed/simple;
	bh=jd29B2OPmKiby4DIxHIZtQDgO7IZCc9GSJvDMZPKbZg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jCtYtYQCHTEYBmxFOvvX4PA3B3Cl8ewHDq6woV8kXjw2ed9O+aD9AuKibdxjsd5zWCyYyjZi5ap4TNeAMdhbFUnin/tJ9y7dbFSelEkxCGxhBuECf7uvbup0v5yVHQHn+V0sIY/nYu4xbh99jvMThQhhPq28LHXRwxzPKelL9l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFOpYziO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6977AC433A6;
	Thu, 18 Jan 2024 23:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705618911;
	bh=jd29B2OPmKiby4DIxHIZtQDgO7IZCc9GSJvDMZPKbZg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PFOpYziO8TCGi28gx9OfBiY+TZja0dPOV5/PF2+PYyCCGEK59pYc90vLEaI5vARTZ
	 LOpQmDcnWBvIWvaroXOtIio3wgZekED78vr9nnBUJ9+pK6doVJKEwn4PuYut1U1aaT
	 dUkYcHAHG3r4hxJGsid4SuGh+EQ9TZON4okWGsWaosU+DHCA4kv52wed8roKrI1WHF
	 aLj+Es6R2wzgWkhSrF3r3CqvF+uU8FqmFGjJmVeM5Ed9bDE7E/lfViOdDxbNgZyyRn
	 8C9FMMtVd1kGDuY/B4CNuHI6ei8s62Z/eqauejrOxxR8aYUQm51I3GkvdmhUMkNJwH
	 XlKiqHgQdHWfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52551D8C97B;
	Thu, 18 Jan 2024 23:01:51 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240110184115.78c13944@gandalf.local.home>
References: <20240110184115.78c13944@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240110184115.78c13944@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.8
X-PR-Tracked-Commit-Id: 25742aeb135c4a44e92fb347e037adaa145b9484
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2ded784cd7fd83e567829637068cd86aeffbeaf
Message-Id: <170561891133.14039.7308582297867586243.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 23:01:51 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jan 2024 18:41:15 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2ded784cd7fd83e567829637068cd86aeffbeaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

