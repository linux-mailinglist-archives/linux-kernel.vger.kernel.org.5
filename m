Return-Path: <linux-kernel+bounces-103920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B54FE87C691
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E811282AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EE26119;
	Thu, 14 Mar 2024 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eu0GrEpJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1304010940
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710459987; cv=none; b=epUzLPcNuOFhGmX1SXTltWRIfpopPVeVgze2HlFSMTEq1YQhYjNhq9ROHkNkQxBv/emIBfj0/Q1ObzvJb0vdigNNnX1I6jGoy+veeSWWCIsr8lQ+P1MVDBiXRgj/0SpA8EWPpQ+P9LLZNJRFFv7QxghvgN/IYPEkJs11VkT+Mz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710459987; c=relaxed/simple;
	bh=YbSwuJMzqyLFNYFakbEgp8eCa1rWqC8oakVam+Czpuw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FU1BTtvCXIBQ6W0hogEhUcH0TXEuaF1mT31iGldk8p7EIGUX7eCID0SMj92EXNTCowdt7H9KcOKkzuqFA0e04o5hrpnCvCETeCKYG6Kt0IZEIv0LNriqLagRmWv33PXAw/1qYMeoUnKoJNb6emEMBh0XY7O5fmHsebJyVuRstok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eu0GrEpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5C80C43390;
	Thu, 14 Mar 2024 23:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710459987;
	bh=YbSwuJMzqyLFNYFakbEgp8eCa1rWqC8oakVam+Czpuw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Eu0GrEpJY1P/hubvpFuUH3zBPJFlizprrPHzh2Wc4+R2usy7sXLQ6BDWvA4zEbGSw
	 GWbDlTIBJVqjPQcB6DT0eGb1jFQce4iUBO1Mt/tKn/I73dJPThLc9L8l2gCnJzzycy
	 DIFNcKeZuUheDyV8WLUPivOXGv5bgtTrwCbn4usvwh9kjDvdhy+nIYmqB/Eea0w9mh
	 j2HCL6KtCdoXhP/kGklMxjlR7ufWTORIJE8tw139nX/Xac8hSspu9yXjJNcT9kI0bd
	 vC63ZPEB9i/D8yCB1eJTjqkjBdc8vevDejxkIB6XETwg9IlF0DVUVEXA7PQ9D5jqJE
	 +XciYp6ICdJyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA31AC595C3;
	Thu, 14 Mar 2024 23:46:26 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/ring-buffer: Fixes that were for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240313151900.16491cc7@gandalf.local.home>
References: <20240313151900.16491cc7@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240313151900.16491cc7@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ring-buffer-v6.8-rc7-2
X-PR-Tracked-Commit-Id: 2aa043a55b9a764c9cbde5a8c654eeaaffe224cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63bd30f249dcf0a7ce16967935cecee8feec24bb
Message-Id: <171045998688.30036.14441301201734816868.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 23:46:26 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 15:19:00 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ring-buffer-v6.8-rc7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63bd30f249dcf0a7ce16967935cecee8feec24bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

