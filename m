Return-Path: <linux-kernel+bounces-106769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D61687F347
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9954282E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15385B5D8;
	Mon, 18 Mar 2024 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRgrSC5a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA0E5A7BC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802043; cv=none; b=NyIPrUc48nn4H3olXDNK7aHSaFlZMEiFrjfw8Z29XoBhOgBqF3zfX2sHzwEM9oKAjfLjk6rRzVwyrANafpJ2b40Cy+4lmrNtqVv3biXBQZrYW3EDc+pbKcpEjA2YcoTxPybP5fSnfLPyx0SpZyosyztnj1PVPONNbUPO/5m4OlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802043; c=relaxed/simple;
	bh=mcKBpPMq96teu9wEwpJ+BsM5G2WXgIMBVPNPAs26aGs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hdPVwhlhyzV49jYr2QE90J6VWhrpO5r33wPvEZYBYgFEeiJJJKPxcS57CSvHxuxf30lz10BZFu7IKxMI2gdeYZUHL9rkBbGRC78GeRC3XnrJFjZpp4gCBinW4WY3R/NN+0GSIkWR4lp7zckE9iKASsxXbnlClV+naO4nzIQj2xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRgrSC5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 724B8C43390;
	Mon, 18 Mar 2024 22:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710802042;
	bh=mcKBpPMq96teu9wEwpJ+BsM5G2WXgIMBVPNPAs26aGs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gRgrSC5a+l/Hvz71xJn4vvTR5Su4HecJDPAa2eSM+KKO3z8KPRwDXWJFO7vn37Xar
	 hDtOGNGHXFBBRi6cxJfGadbjyhxdaNiD1PmVkxNXzaz3HZAOj099Z6drIOQg5x7aoG
	 LAHCbPOib0csBMQNEasLT+7gjbAUbcudwpKxHX2kPn96mxiyts6ADXnDRoofrlW0BB
	 2FJbfOC7v7FgfwVB7VydpiIGPbcN6VH3yHUJ7Vi+nzumynKxuz2XeRrVJQ4aLnXKuD
	 F7lhRnmtl4z0ENI3DUw3DMbNEIKQdsgGytCcREVCYgIiWEmEI8TzDonWwvIJHVSxLx
	 qvpS0KTe9tjFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F7431372BE0;
	Mon, 18 Mar 2024 22:47:22 +0000 (UTC)
Subject: Re: [GIT PULL v2] tracing: Updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240318113053.7f87ce7f@gandalf.local.home>
References: <20240318113053.7f87ce7f@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240318113053.7f87ce7f@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.9-2
X-PR-Tracked-Commit-Id: 7604256cecef34a82333d9f78262d3180f4eb525
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad584d73a22b2f6e6b4c928956fdece5c44cdb3e
Message-Id: <171080204238.23091.3202395666670607279.pr-tracker-bot@kernel.org>
Date: Mon, 18 Mar 2024 22:47:22 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Alison Schofield <alison.schofield@intel.com>, Beau Belgrave <beaub@linux.microsoft.com>, Huang Yiwei <quic_hyiwei@quicinc.com>, John Garry <john.g.garry@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, Thorsten Blum <thorsten.blum@toblux.com>, Vincent Donnefort <vdonnefort@google.com>, linke li <lilinke99@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Mar 2024 11:30:53 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad584d73a22b2f6e6b4c928956fdece5c44cdb3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

