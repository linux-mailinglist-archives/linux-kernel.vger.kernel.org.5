Return-Path: <linux-kernel+bounces-103921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F112387C692
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A8F282B11
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3086613FE0;
	Thu, 14 Mar 2024 23:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCtg3jmv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B1411718;
	Thu, 14 Mar 2024 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710459987; cv=none; b=ppW3BWb/0+RXtf9NMWFxQz2lhTovK/yFCdbv9kqvI8uqxSWtg+5ZCMN/WDoomiQDaqNFU1F7BcVbYNVuiIH0EsJd02kHcbg0PXPfVfCiGAoiOS8RVCkjxSDVSVbuotLA7ABSQu99OKbK+qPffhwplaUcqh3/bdro9m0EVPxdh3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710459987; c=relaxed/simple;
	bh=8ebDQPfBnSVAIWaU8HP51kmtCjS4Y1cJKkNK/qupQTc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TTGd/aSH/aQVT8tMu98Kc8+azrzRh9WL6RBnPt0TTmNqaYNLYeG98VZWLihJ0gfj4tn3PHwznlW8Ix2dlR8bHc+vGh1i5hW2R1dcH7uphJm0pgyihoJ6KkhNAoCElZOFAUhpDEaOXURRXgA30MaYTo5wryuqxJ/X6jueUcqwJLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCtg3jmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 482FFC43394;
	Thu, 14 Mar 2024 23:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710459987;
	bh=8ebDQPfBnSVAIWaU8HP51kmtCjS4Y1cJKkNK/qupQTc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QCtg3jmvmyY4aUya4hkIpTL9jrVojzru40PkqchFAFraUMUSDcQiVcvTw7wAOidKr
	 Col28wWcyXvjOyqdvZk8kN+/Lfxr7t+oopUud2VzHZOt0CsMf9eCbDZ+df1L9cHkdP
	 U/KR9XMpxyTz8pv3zJ0PM8A06EWc1cAX0Y1YtLcqqHYmFCxJAXZ2v5d2A+9Tgu+zAP
	 h0gMGKCL4VzDVl7LS277o4+SCPHS5ukGI2YJ3PpwI4Zaqx/HKcGJISU3l9AoRpTqMN
	 6S9htO5n4FUge0+l83xOfQYx/NTKeAh5s6FWHTpUlmY3ynKEMlXmT1I6Ln2J8hPqlk
	 cj4PcidhKWUvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EC6BD95055;
	Thu, 14 Mar 2024 23:46:27 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240313205434.3066697-1-namhyung@kernel.org>
References: <20240313205434.3066697-1-namhyung@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240313205434.3066697-1-namhyung@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.9-2024-03-13
X-PR-Tracked-Commit-Id: 0f66dfe7b91d2743cc71dfff37af503215b204ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bbeaf83dd7b5e3628b98bec66ff8fe2646e14aa
Message-Id: <171045998724.30036.18085958749410087905.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 23:46:27 +0000
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 13:54:34 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.9-2024-03-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bbeaf83dd7b5e3628b98bec66ff8fe2646e14aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

