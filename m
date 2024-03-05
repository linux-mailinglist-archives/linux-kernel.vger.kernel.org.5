Return-Path: <linux-kernel+bounces-93035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554928729F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A831F2B1EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0695212D1F7;
	Tue,  5 Mar 2024 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCFjrK/V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4604312D1E4;
	Tue,  5 Mar 2024 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709676437; cv=none; b=L7RRD/lD/RnoCphSIhjbZbvGmga6cGtMYu3VTDmnQ94PEZPQ/08Ny3HJ2BDQ4vJVXao5WzMVZr6Jt5ZuJHFvg0p0o+5TzyhdoEnqRo35DNQy8ZfaBfzxDVm5kLO9XoavjKMTspDsd4dgZVB+kwLUcHEVe5SpUFwHk3kCFkzqdsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709676437; c=relaxed/simple;
	bh=J6a7XvGPnI3s0peLjH93kZweZoJXaxFP+F2307T3aNs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D6Y+miOlG1HDisouUQZVUf/wXRS8+xd78yjFIdHPvl92wXBQuIJJB9gx4GxA2yOOJo9zVX4InI7LPi2B7dJlu3cW3z6pnOkmN+rZPhOH0FqAbOTQSfepPQSeFNDi92ehD7dn/PeGGCK0F4lStDZ8LHUJyNRZVB8ln4pnYN4kfV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCFjrK/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF5CFC433F1;
	Tue,  5 Mar 2024 22:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709676436;
	bh=J6a7XvGPnI3s0peLjH93kZweZoJXaxFP+F2307T3aNs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KCFjrK/VKY9oqXrAY3l+l0WjBLRK2S0relwN6NWCaOCXhagxxPvUrs4+7qfxhkZ+j
	 NzdjR2Z8Q3LHo2igQoLEtbyl25/nR+5XZXcQB6pmQOe52BTJCU7E4067KUcVIsCBK9
	 rDcb+i06mNS8DehTc0oBllAd4iW2BuLCvu7Qymzy9MAcJ2toBgHui7nPkJKaDxuXkV
	 3HqsMQnh84PUdQCGConB9/3zbBXmm+2hmTA3szXPfXyPsKQ2JBaB5sAnYpta/Fykmi
	 qSpeGcDA1BWGfJRv2Mda62Ahx4fl3bO486cz6ogk0f7e5E24UmYf7gK99Wbb3XqDwa
	 /yJJ0H7A9kq6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0964C04D3F;
	Tue,  5 Mar 2024 22:07:16 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZeeUxivndz9IXJJD@slm.duckdns.org>
References: <ZeeUxivndz9IXJJD@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZeeUxivndz9IXJJD@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.8-rc7-fixes
X-PR-Tracked-Commit-Id: 25125a4762835d62ba1e540c1351d447fc1f6c7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5847c9777c303a792202c609bd761dceb60f4eed
Message-Id: <170967643671.27520.3613210946575720936.pr-tracker-bot@kernel.org>
Date: Tue, 05 Mar 2024 22:07:16 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Waiman Long <longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 5 Mar 2024 11:55:18 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.8-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5847c9777c303a792202c609bd761dceb60f4eed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

