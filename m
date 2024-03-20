Return-Path: <linux-kernel+bounces-109499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4760881A3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C83B21B63
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A1C8624A;
	Wed, 20 Mar 2024 23:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJbBuY2l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB00F8615A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710978398; cv=none; b=ZqWzbTRPPkZvqEyoDUU8o6KnAAl2puX4eC0ZVEGWIuY/+sMgvlYtIEIbe0a537wOVnXTplBkwu6gTgFDdw0GU90LxwimsC7havqZNkot9k44/wWkZOrkG7Tcrzy6eG7vMByv80phtnsWyvpPzVdBU8mWakt+pfyor/ra/xlnbNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710978398; c=relaxed/simple;
	bh=8xMq5Uw8vr29GtWDpI94T1uWHaqjkTCfM80n4fLiIlQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GgzKzOU8cD8tvHgPfPBcLQl6yF2Oms9oVWRBJF+kBN0h9J/2siHCuK5l5PkYYgs3eT8tWiRGCe9SDzXt3hRH3E44A/fuRYL2+V1ksCFydl+PUsEKOCYR9sXDG1Yleqs2k+YzD3lSEYIXq34/hiM8al/sQ914LUD7ziG1jeIKiZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJbBuY2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68EEEC433C7;
	Wed, 20 Mar 2024 23:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710978397;
	bh=8xMq5Uw8vr29GtWDpI94T1uWHaqjkTCfM80n4fLiIlQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mJbBuY2lItBuKeEQy8T6fCnac/VqQc9g+6LUFqzfYSA6MCAqkyj56UkaQVXbpKSAz
	 HnbY7xZ324LtwDjYzjDGsCzV8Wmct1QXV1/IbTxv9gOvhIpUi+dt1mdQ4o2kRFE5o8
	 pQtxU2UtBW1rUPHv3afTSb5u2vop9I4hDH1QVWrxM2tPKPEMaxE5VG+UcudqJrq57k
	 Fl8+ljDpLpTYajVWNm/K7mWcBmvexFfQpzZJK2auYevw7/hGNl8RcmHAfQjk6TnUrZ
	 pbkD8Ya1QSDa5HRUeMbvZPNQy2NssZVpjxAO8Tqty5kXs69+joPRUWj1mXgMjD2PmC
	 Mk7DY//epzFPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E0CAD84BB0;
	Wed, 20 Mar 2024 23:46:37 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/tools: Updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240320112214.01bc5339@gandalf.local.home>
References: <20240320112214.01bc5339@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240320112214.01bc5339@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.9
X-PR-Tracked-Commit-Id: a23c05fd76cf4ad27e0c74f7a93e7b089e94a55c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42c2a75694053cee46dd5d14b140c2094d2a0f2e
Message-Id: <171097839737.7347.2862817638928694445.pr-tracker-bot@kernel.org>
Date: Wed, 20 Mar 2024 23:46:37 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Daniel Bristot de Oliveira <bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 20 Mar 2024 11:22:14 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42c2a75694053cee46dd5d14b140c2094d2a0f2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

