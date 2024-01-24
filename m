Return-Path: <linux-kernel+bounces-36251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC469839DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B4C2B2929E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178464C86;
	Wed, 24 Jan 2024 01:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="um70s1PR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7511872
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058091; cv=none; b=CggS1ismkO3df7flFtsmp0dpl0zwegrJ3P2jFUbgypjojvIlt8fpWt6kJwRWVj5kqxwy2SSCr9KjV2AD+ulhnjOFw3m/fNkIM6mYy7Hj2AaTK+M5Psxs63hb/F8aB6nQIvbFP7IKWJoRr/7gO0JpV9E7t3eKWHQeUMFuTBVD7oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058091; c=relaxed/simple;
	bh=gvG9acOcxhUntXdqbVJWw/tLY0fsnEvM3QdznPPEeto=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=THSwkRVG9O9hbrAvBHjyeA37Ss1daFYwKflQWUN/PvjfqWMJ6p9YIJf09LNhyOtBvNB0ySnQChjgyTtvf/jsmZuWz7v51s2gNL6SRco34nL5WUinXwHad/ubTOyzGkj2qXY623vq+RJn/mGuQP2EgAchbpinFyZtVctvZbK2RXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=um70s1PR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2733DC433F1;
	Wed, 24 Jan 2024 01:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706058091;
	bh=gvG9acOcxhUntXdqbVJWw/tLY0fsnEvM3QdznPPEeto=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=um70s1PRGhi/Gfpc84PLDpdVsnG6nnqCFwOIumj0SIrNK3NXCkBMMB1LDAref+66/
	 blTr92shFJQxNE2Ay6UbJD6lTuD7E+nBfqKxJogGGYL9l1gxgEgDhsmOd8X7u+yby8
	 hjTn7EU1RYVbLk0zPMs0y7RmHlDBsP5UCsXer7jtpKqS26tvkiig5n4AZqStBdLqxL
	 /jO1GbVte4fzbraD67fJLt6+7T93i9gZ8XGZMGoBbK/gKaBZc1RaHFmekqPcaiEGsI
	 WTDuThwVsz3ZP7yht3QWg4d/t48oVpvNJVIcYmYbQZ7T7GE5o1ULc/twviMtNB99by
	 aeweOlNyxXUkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12759DFF761;
	Wed, 24 Jan 2024 01:01:31 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for eventfs and histograms
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240123092600.39d78909@gandalf.local.home>
References: <20240123092600.39d78909@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240123092600.39d78909@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.8-rc1
X-PR-Tracked-Commit-Id: 834bf76add3e6168038150f162cbccf1fd492a67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 615d300648869c774bd1fe54b4627bb0c20faed4
Message-Id: <170605809106.31831.11382551143630160745.pr-tracker-bot@kernel.org>
Date: Wed, 24 Jan 2024 01:01:31 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Petr Pavlu <petr.pavlu@suse.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 23 Jan 2024 09:26:00 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/615d300648869c774bd1fe54b4627bb0c20faed4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

