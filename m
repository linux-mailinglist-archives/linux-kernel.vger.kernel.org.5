Return-Path: <linux-kernel+bounces-30619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A37B6832219
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B70B23FAF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B5C1EA77;
	Thu, 18 Jan 2024 23:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4NBOa6U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B910328AF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705618912; cv=none; b=ZNxiW+WndhgJMZ1eZ8Y7Oj1rXgtYI7t6TatlIB8fuzDaFtSwlmAt7VionPVOxgstkpchXEYhORMIIJc1ga4yP15GhczNoZRZDEMvcQ5ohVmrDzw3dx9rU1l5Yjduy9yHs/AFkam75crp/oIwaS2QynhpXTKrEG6bno6VcFoE5H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705618912; c=relaxed/simple;
	bh=CmvEi6e+WVu87susWtCjkmWS559vzK9JlokI9NeQN5M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QZC5zhxgpHs1REpFy6XAD6s6ptIYMpuyuICE3PiQ2Dud1GxUoy0YEiHqDy/rs5/TMHzIxe19CMMwDxD/CDbg4OI8QCmKEf1oLQmb7tgKtdgEQzxxw8rbInQjgbqLoEqwr0bbgfBXkB1kzZwDcg5MTTdq1I/uV5B8cmgGYwucD4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4NBOa6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15847C433F1;
	Thu, 18 Jan 2024 23:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705618912;
	bh=CmvEi6e+WVu87susWtCjkmWS559vzK9JlokI9NeQN5M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h4NBOa6UvX6luU5RcAnjv1L0AcH+h/Pn4rcujT9M/kqWQ7BcVrrxehZIaWT5bGJJl
	 BaqWZtJZmt+EEmRmwULFT7A0gz/ZoIh31IN9WRC2EdUc7g6WJ8lLBiYsE6B5VEaDCv
	 iZz3B+rjSZQ9dRkrE4us7cYULDnsabJ1F+lxWXvZS6IOmi1p/LHH+Gw/DvRM1tLt1F
	 UC4ODQ+ldIyToQdZTyy6s/VMvlrb4+Y6vPdG7ZWBbOm71PfudljhB5mJA7VbOeQeCZ
	 Xx1K5xzBaao0pLjSxwPoHrPjDFfI16++BWf3tqJ1S6LJoMnwgQUsk8Vp0cPQ2cuJbd
	 YJML6w/iI8x6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0472CD8C970;
	Thu, 18 Jan 2024 23:01:52 +0000 (UTC)
Subject: Re: [GIT PULL] eventfs: Fix for readdir and a seq_buf fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240118094645.58edbfb7@gandalf.local.home>
References: <20240118094645.58edbfb7@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240118094645.58edbfb7@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git eventfs-v6.8-2
X-PR-Tracked-Commit-Id: 7a8e9cdf9405819105ae7405cd91e482bf574b01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24f3a63e1fc36d5d240c1b3973c75618c20cf458
Message-Id: <170561891200.14039.13282776091981968002.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 23:01:52 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Erick Archer <erick.archer@gmx.com>, Nathan Lynch <nathanl@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jan 2024 09:46:45 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git eventfs-v6.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24f3a63e1fc36d5d240c1b3973c75618c20cf458

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

