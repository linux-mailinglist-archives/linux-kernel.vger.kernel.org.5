Return-Path: <linux-kernel+bounces-134574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 008D289B327
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7C81F22F99
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6FA3BB36;
	Sun,  7 Apr 2024 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB3JYine"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F782EAF9
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712508257; cv=none; b=ZxF+aecufW5Nb0dZg+Dd4wyMEybEULrNlXHKa1hdDAROucYVKQBCCz18xid9+H1M4zO9QxJlPzwc+h9UhRgDE+d5+/NFevv4tM2GhZzwSZ+PEBFI+ddPdwYSkYKKV3mgicBl8yrsjekUjtNIRc3pNVCbrdAlRbqtAIow/JnQ0S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712508257; c=relaxed/simple;
	bh=wJ4i2/VEm1OwJIoO9Wa+olnbwPQYkJClEhVZUaPFcGM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uRWw0+ge8jLO8c1/VhsGskHbWN0PL8mb0uetNwwMJ+K4a1fS5s+chS+uV2AIDwq3+RlLckkqpAkofcUUTDZZ9fPBqUdbFOkcjXl6xlKGWj7SEjPXQXKL5LLlVLad6dwQUyd1eDEWKKgQ2b6lyaEQyHbLAmRch4iRa6VcOCGtRus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB3JYine; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41D9BC433C7;
	Sun,  7 Apr 2024 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712508257;
	bh=wJ4i2/VEm1OwJIoO9Wa+olnbwPQYkJClEhVZUaPFcGM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XB3JYine/DIlxr+s/ZFcn+CcJi/2LZ9lYWbCYheUTJOW0kqjiUiGzYSQux5q4/d31
	 CFbiedvdo4mMWwN3kTu930Cs2H2cNNmT9xMk9x5imyS0m594GujYmS1oXTLLPtSRup
	 7GujkbvLKIipjBoIfuxWVaflek8VLYTu9x7RLZvuEe5EbRrNsGWM1IFRbCcnHjHQoz
	 7tctRk9x2Yi3rCM5Mn+FolU4LM9RGY4tvWjMqHQWukKBLKqX/A4L3V1ZAnfkhgAxys
	 zZpUPp5SGN4B2XjYPzUosE2yCfllFtcRILB8OjDVvTAhWww10BJdzZS1tL8pJg15MI
	 Cyb7DMxgRtoDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37489D7E2AD;
	Sun,  7 Apr 2024 16:44:17 +0000 (UTC)
Subject: Re: [GIT PULL] perf fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZhJRb8TBJOLEEES5@gmail.com>
References: <ZhJRb8TBJOLEEES5@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZhJRb8TBJOLEEES5@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-04-07
X-PR-Tracked-Commit-Id: 312be9fc2234c8acfb8148a9f4c358b70d358dee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2948effa9063ae8bd0e7dd65ca4a0fa068c71a6
Message-Id: <171250825721.19258.13689059662633641101.pr-tracker-bot@kernel.org>
Date: Sun, 07 Apr 2024 16:44:17 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 7 Apr 2024 09:55:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-04-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2948effa9063ae8bd0e7dd65ca4a0fa068c71a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

