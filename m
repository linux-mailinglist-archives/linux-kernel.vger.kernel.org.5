Return-Path: <linux-kernel+bounces-105521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBC587DFAA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8B32815A5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E1B1EB46;
	Sun, 17 Mar 2024 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUsez/8y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0026208A3;
	Sun, 17 Mar 2024 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710704051; cv=none; b=uLC9Ej/9VEsFNg399LHg0TkxQV5A9PZp5E9EsRhOoI5/hISRnsDn6DsKbGdH/5XE3m08wNu8OrWbQYDtZWfUsMo9zWSuMD5mI5VXGEPmhLlRBw1qSr59tFnNQzGe2iE2laApBBMQRdky81Z6ZsQ8tgMs8IBH+AUF6pSeNNQXMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710704051; c=relaxed/simple;
	bh=aGvxnoIqnAah0kd1tzWbRs1e4jFiNh+XXW2t2vBuKuY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aCKSczIbCAJe2NwSo0ScapiUm5UvYtyAG7QH63CicPEQplKcokngNgM5o3STjdnHBd5/t5PlOdnSgZOO1xVMzThnOHCtDHzhL0SNJFmnihss98tAEB9e+jyVpnibXvDoFOJ5Kj211ikO9ACMtSbc6Em8XMC6VaPg+YYJKGrigV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUsez/8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E8CAC433C7;
	Sun, 17 Mar 2024 19:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710704049;
	bh=aGvxnoIqnAah0kd1tzWbRs1e4jFiNh+XXW2t2vBuKuY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cUsez/8y33+yMOHTuGwSfGkFbUmrlbAK+geSMhwHQOqLW9NlQaIa/8kQ9SKYv92DQ
	 Cpbc+SzQFNpbKKsLpDd7XxPR0vQac0sS/2iaVN/J1gw9Iox+2CZvDDk+7/5cxWBYDI
	 hNJCi/wIdJSZbnSEzIMQ9ZEUMtlLwtrzvSUOqTDP3BaHJDEnx6o1AzgvJSetx387qP
	 WegW9zVwpIWrbEfE/vxKpgLAgdvHQTallf69y8c9KhUqGxh4VTMI0bie9tR3nV74VD
	 FUbMNU1yGONdsA8rCRc6fhYeVrPy8ROK0UXAg50/+DeCdKHl6PYGdXghKlbc5A2Dpt
	 cCh2al2APohcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5529ED95060;
	Sun, 17 Mar 2024 19:34:09 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zfawgi3HBOSuWMy3@gmail.com>
References: <Zfawgi3HBOSuWMy3@gmail.com>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zfawgi3HBOSuWMy3@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-03-17
X-PR-Tracked-Commit-Id: ad8c91282c95f801c37812d59d2d9eba6899b384
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b463a3c347df6f4d2d24f47c65716ae3166006e6
Message-Id: <171070404934.21222.14516922468390780041.pr-tracker-bot@kernel.org>
Date: Sun, 17 Mar 2024 19:34:09 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Mar 2024 09:57:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-03-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b463a3c347df6f4d2d24f47c65716ae3166006e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

