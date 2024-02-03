Return-Path: <linux-kernel+bounces-51100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11401848672
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82322B219DD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406255D755;
	Sat,  3 Feb 2024 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ojq/QYEr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F195D47E;
	Sat,  3 Feb 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706966130; cv=none; b=MdAhwj46gmyJJJI7Xits1zox7oyX0oq5xuJoYvQlKUuLbXdimvEipAMJ/Tg4BqIu2rcuLY7xz2SlrxwHK4+smZFHqFbnsQkdmQgmPCX4Q2rdXDbl3noojzRjopwQs8jsJLClar4OQn98s5xAR9ur2Rsyj+G/JrAN6stwKUCPQyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706966130; c=relaxed/simple;
	bh=flQ6GnLUKLFnvuxnXDKqbRXwudb/hut3th1YVysTEfI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W4BEbDhN3Q5k7EM/JfTlh85q5nTtcvyRp/CTP+3lBQvSEMHYWXNtOCZQ3qvCF+TYlW+h7eOHx+z9ea98Sc8c815utKJ3ReayJAP34PdMgNOKzz8xfdf17lCI3roMfgsX25DI4zMw8cQaU4a0Bi8lRmDvQpgfsvOt0FZ1r/qXKT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ojq/QYEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6227FC433F1;
	Sat,  3 Feb 2024 13:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706966129;
	bh=flQ6GnLUKLFnvuxnXDKqbRXwudb/hut3th1YVysTEfI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ojq/QYErN4buWyS0hjJoAjvD1qew51dG3yRYS/ug94Tdr3wlQiQXAgDQxAQPizarT
	 ZaCmI+uGklCmY3CktbdW1NORm2tuDLEO8ZTKujSGMx+RkmF+9FdY9BRKVX5YKEel/t
	 3caU6iup9fqSuYdDkbAKS/T3rqxB1AAzJ3XuArAw/WYtONoD2qkKTjG3Juj2Uw5qeo
	 ew+bGh5M4YnZAQNRMYIM54MRxFjmLFi4gzJu5vESDjCKYUIRspeVPAbcKLClz+i4Aw
	 +ry+7KIFiGkvyDbdKfyj4SfIB/+9ZgRB0sPyy1XOqO6q7waTHuwb1MFHV6B94iU8Et
	 NrBjS6cRmU8kA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B088C04E32;
	Sat,  3 Feb 2024 13:15:29 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240201202254.15588-1-acme@kernel.org>
References: <20240201202254.15588-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240201202254.15588-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git perf-tools-fixes-for-v6.8-1-2024-02-01
X-PR-Tracked-Commit-Id: fdd0ae72b34e56eb5e896d067c49a78ecb451032
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b555d191561a7f89b8d2108dff687d9bc4284e48
Message-Id: <170696612929.602.15683354228494654874.pr-tracker-bot@kernel.org>
Date: Sat, 03 Feb 2024 13:15:29 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, Thomas Richter <tmricht@linux.ibm.com>, Yanteng Si <siyanteng@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  1 Feb 2024 17:22:54 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git perf-tools-fixes-for-v6.8-1-2024-02-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b555d191561a7f89b8d2108dff687d9bc4284e48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

