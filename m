Return-Path: <linux-kernel+bounces-77117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78AD860165
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C201C23F87
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743F315B0E0;
	Thu, 22 Feb 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+5NADQ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86E01586E6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625914; cv=none; b=HLeLeIxd/Rn4JLNugmZzBa3KJvAlSOTFS8cgbffBAGGKDQ+otM9TccFAB/7582xgvyZQztz7ff47QBwU454la0kxhgzZ2PbLKJQCR5xCkBuw5iIgDEtwoqJl70a3tSawY+rI5KurvfEwHLIRh0FNRQ+J6atkQjfyrHHk+Ep1V38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625914; c=relaxed/simple;
	bh=9wzU7sOqgwh1R656Pk5CBUbXybgWWAxFqWldJHZrA8Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Rt1HmFrnIbdmrS7puIDfODBo6BmuFubzH0lLVqqJFCVAipM3aQ3jGLG2Z7V3dHIBvX1GXgma8EMwCiiarWtBvQnDxfSgOShffMjvAO5sJoGfRrZGR7JWC69ktb8cJRe8EjHR1wIVm/VCr3q95mg34Kuu/jWS0UmuVCJ56f2q930=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+5NADQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92ACAC433F1;
	Thu, 22 Feb 2024 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708625914;
	bh=9wzU7sOqgwh1R656Pk5CBUbXybgWWAxFqWldJHZrA8Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=H+5NADQ7MztZISORoW4IWWzWoTgj7gkJWi+lDxAP+9mVy+N/gFy+co1f8vVYcc8Fk
	 CgMtwkekXoOjXGbPg8W+Nwe5VsagI/3qxPSpqpLasM4nd4puGIxxFZbZHrLz/chcvW
	 Z64mpD/RdNG9yYug3fk4oXbrOVPvigYaSHdOzOp2GVt7a9rxvTv0+zXrHqO98kk3TO
	 6bcAHnUn0lRsf5YH+sjVwtf9lZmzCxAerH9J2PAfb3SaCnyYilKLdRtZQxoRMIvvQX
	 0/xQG9tS6S757K73Tmee4oJV9Bbd4DbBu6CvyCW4cpk6s3Dnv99JSakYO8HUbh4f6U
	 y7kZ+7epSrnzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80EB5C04E32;
	Thu, 22 Feb 2024 18:18:34 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Add ring buffer sub-buffer size check
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240221201816.0d1e7829@gandalf.local.home>
References: <20240221201816.0d1e7829@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240221201816.0d1e7829@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.8-rc5
X-PR-Tracked-Commit-Id: e78fb4eac817308027da88d02e5d0213462a7562
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efa80dcbb7a3ecc4a1b2f54624c49b5a612f92b3
Message-Id: <170862591451.18883.17965030433150608623.pr-tracker-bot@kernel.org>
Date: Thu, 22 Feb 2024 18:18:34 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 21 Feb 2024 20:18:16 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efa80dcbb7a3ecc4a1b2f54624c49b5a612f92b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

