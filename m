Return-Path: <linux-kernel+bounces-152022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9828AB78B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87D3281A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96C313D898;
	Fri, 19 Apr 2024 23:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7nbVH3g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E610810A28;
	Fri, 19 Apr 2024 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570274; cv=none; b=dgYomwXKtCcOgoq9JowMg/bFTzB4rcnjTckGhV4jn4Ii5FLphq+jazE4HKbwpHa34uMksh8KasqTaevKmTICPljHM99U4QfWrAePKniqKUCAWHXayl7dUp/w41iKKW8HzzqqBnFYS/2hG3wUJsBldAQjlO5QfGiemGq9kTq2fN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570274; c=relaxed/simple;
	bh=kDow+YoIV0JFmZ6TFlftnMo7ta+LVgBFS1WDoclcF9U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HT2K8jW9GgbsLI1O6U5tcoCxKqIOaxAjKfeSMJd+dZgZyopazqq1EUZ3UOT+YE5wz22A4yQGIDNr65I5by96vHZ4YHUDzwUdXewgxryBkb+WXzLR/6RS8tRQz9y8vJv2lG8l2eHgm+VZc0xgwnmUlUp+CJ/jouvNHKfusrH6aUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7nbVH3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA745C072AA;
	Fri, 19 Apr 2024 23:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713570273;
	bh=kDow+YoIV0JFmZ6TFlftnMo7ta+LVgBFS1WDoclcF9U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=d7nbVH3g938x0wRJA0bDw65VwDDF40uytM18FnN1eGnUYi564bu8286QK10y/1PZV
	 3DkMgyNaUe6ALDdQlvNYOHlUz0/P6Qe0eD9uACRQM0Mdzl3f1j7ldhLgWWSfNvg8KY
	 N39U9ZVB+dD1Iz6oSv7E8StEb88bErfo5HTnWmQpXrhVpIeOKk9Z0spIx1RHtMgRqO
	 Ok5DdDREZzbMVK+0TLtf3rrmJ4EzzBU85hpi2hlyLa14Vzyrr18tTe9UOxLa2Uvcfy
	 QOA+qN3toRWrs2yEzHOaq4skCAZcYf/FFo2pJNqAVqgw1dr2z8Bbk8V1s5Jq2cUJRP
	 RQ+U5qqPOfAIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFDFFC43616;
	Fri, 19 Apr 2024 23:44:33 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240419211227.821832-1-namhyung@kernel.org>
References: <20240419211227.821832-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240419211227.821832-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.9-2024-04-19
X-PR-Tracked-Commit-Id: 1cebd7f74976455ccd89c1dfbcf00bca52d0a512
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13a2e429f644691fca70049ea1c75f135957c788
Message-Id: <171357027370.12915.13244194076074050483.pr-tracker-bot@kernel.org>
Date: Fri, 19 Apr 2024 23:44:33 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Apr 2024 14:12:27 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.9-2024-04-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13a2e429f644691fca70049ea1c75f135957c788

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

