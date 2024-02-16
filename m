Return-Path: <linux-kernel+bounces-69212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE8F8585D0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5691C23963
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F32B1386B0;
	Fri, 16 Feb 2024 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJ8VdXmE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741D3135A74
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109524; cv=none; b=hfwI8MLAQudV03o8lTKsWR6HinbN4dXqg3THm61XznzhDN+2b+gelqmgYFeho2Nh89MrvB+7O45pxBW9J7Ko1vHLMCT1iEg1n+KjvTgIVDrq1pbKiglevJUL0w2SvQkoC4zsh31/cXc5cWzd1Ds0KdqWFFi7b9oyn5tdRQMdjCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109524; c=relaxed/simple;
	bh=5dglvLZJtgnGZ/rVIkTFvLbZanD7pcek0WQrqSmYOMY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PlN70f59PpNtr4Jh9gzhNOuOceeGJErfT42L2g1updzsDlN3yO9o4EBPRaYYOiRPYBkmV5JkTXYNnE4uXXhBnCIt1LWUZFbbivLZolqZIY+TnYEVn/hZhSUkGDYkdl0n1QAf3Osgvu2bnQpjC4rQ0/54+oHOin8mTIxwo2ypxrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJ8VdXmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A995C43390;
	Fri, 16 Feb 2024 18:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708109524;
	bh=5dglvLZJtgnGZ/rVIkTFvLbZanD7pcek0WQrqSmYOMY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TJ8VdXmEK+HS5RfpOnImnAp/AMvqLGIyd/Rjef2sxmhQf1UAbkH0asvMpzJsYrmqD
	 MoAOd/HSLXXi01TAAAumwJm+YNi9fuEoYib8TCWCHlIpNdmq/L6wZdDaSD/7UWXJ+2
	 4DZiqYVmvSAXpiNnrveKvTgOJJStu6Silj3WQ2cjKNB983x0tHV8xkJmdiqVczhqOW
	 sMhwqDpvXwFjvmD5ZWQ+E7sQBY2E04uqEnzDkJmg5MFB/ZIlDeVTzQK9irOr6WL4ja
	 81ruVB6IkkV5/412EcmDAe3jRblsQShCLCW0zS8Xi4mc3gKlXcABhYs10n3KnDED4F
	 Yh5BwMyb62+lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3528ADC99F1;
	Fri, 16 Feb 2024 18:52:04 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for v6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240216095357.6ee66d05@gandalf.local.home>
References: <20240216095357.6ee66d05@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240216095357.6ee66d05@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.8-rc4
X-PR-Tracked-Commit-Id: 6efe4d18796934b8ada66c1c446510e7f2d9b972
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b6f7c624e7094437df707d3fa0a39970a546624
Message-Id: <170810952421.23532.5635661456785988236.pr-tracker-bot@kernel.org>
Date: Fri, 16 Feb 2024 18:52:04 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Petr Pavlu <petr.pavlu@suse.com>, Sven Schnelle <svens@linux.ibm.com>, Thorsten Blum <thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Feb 2024 09:53:57 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b6f7c624e7094437df707d3fa0a39970a546624

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

