Return-Path: <linux-kernel+bounces-59884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351E584FCE7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF20B28F730
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E7886141;
	Fri,  9 Feb 2024 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxU5n017"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC0674E3A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507121; cv=none; b=cJH0EeEr4VoO0ZO7QXjrKrc//fIVoomaecx2nXnC60b6hX7Ih9tTuVPlWkrOaRJA+PZycgFYfUXQ1elki8M+HSwsoMvE0HgSGpD7t73gJtCrXlU/94lrPuaNuN3ujXNNEtguAei9R7nL8MGLa6FK6k8c0Co0WEf4GOCw7PvfhsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507121; c=relaxed/simple;
	bh=SvRvbWUq67hWpGe06ImQpxOubWkq5TahLnFAgxsZSqA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nYzYv6F1X7iYrq6P6Z/RKcsRikjELLxOZUiE0UiANVkUZfFyLkarmIndmRDYk6bVpohSMpHXP0lbDgc1KO2evzB9uKrVnpsSsiQ90L7vfYlV8kPhQY5USlM8m4VsgIw1BgzolKyHsyhSxQfIr7vHuX0DAdwW4iiN1hroxumcMuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxU5n017; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A9A3C43394;
	Fri,  9 Feb 2024 19:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707507121;
	bh=SvRvbWUq67hWpGe06ImQpxOubWkq5TahLnFAgxsZSqA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rxU5n0171QGiEgo9t4DOwm7DQR/mP7csdB681esZoAz8by/yyd1PZHXvW55FDxOC9
	 pe8j54vTl5rBxK6TSfDEMO7OikYIHaVDp8DgmlcBUgUFJKnbhPlUoC9LJiSl6JS3hN
	 SG2AlvzrIeLu7Qj3qksq0VdBAx2YTZNhWnkbTL/oEJ1MDBR2aHV0tcrNj8BY8HUOad
	 IixmKbTvOXiLLNc2hqzY4ND5L0I685DPd/qtdfjWiXGgMWQDXNRrhJVfJs78ENMRrg
	 53cHL2H27jw+LvE4uDdhT6+G893yuN05h9Li0XDnX5J2LYVi9ET/aeAj7u9cE6q6hS
	 ONkZ2kpEGBT+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28464C41677;
	Fri,  9 Feb 2024 19:32:01 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for v6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240209084845.3744389f@rorschach.local.home>
References: <20240209084845.3744389f@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240209084845.3744389f@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.8-rc3
X-PR-Tracked-Commit-Id: 44dc5c41b5b1267d4dd037d26afc0c4d3a568acb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca8a66738a444e05fb256ca0081224d066318401
Message-Id: <170750712115.26526.3065654968842818136.pr-tracker-bot@kernel.org>
Date: Fri, 09 Feb 2024 19:32:01 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 9 Feb 2024 08:48:45 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca8a66738a444e05fb256ca0081224d066318401

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

