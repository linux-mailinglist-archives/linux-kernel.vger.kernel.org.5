Return-Path: <linux-kernel+bounces-112495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA19887A8C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109EF1F218A0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA235B053;
	Sat, 23 Mar 2024 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jl+kQi1J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE6222625
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711230963; cv=none; b=Brd9MciIn4iieM0Lb+OS/U4AZ17UtTiJ1D0U2AlcgF228do3qfKRKQm8RREE2BuLMR9J1QBATd2V8Psa5XvvUPwLM+03zMBepPIf650nmuOOcypyDQYQZBk9sTRWXopLlg5fnS8I8alqcPgOBErWfFENSGTPLkLTsqIDgqUzV3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711230963; c=relaxed/simple;
	bh=DCr0yd7NEaFQTfQiyE6bWQbizEnZXPBIBpT2hO5K0sg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WSOXkNEllET3UrYqoxtsiQIpkQC8gzbBuhT6IzEqLmNtXry+yYih77etqHYnx+jLtfcU+bX6ZdyXir8yL51bLMaOi1rcJYXewVvLt+GnrBZi/BepOLlwG1nV9+BG1BzL5hFB2tdBMm9Izdadbo6ziVLwBy85ZsqZ5wR4gYBGMr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jl+kQi1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DF6AC433C7;
	Sat, 23 Mar 2024 21:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711230963;
	bh=DCr0yd7NEaFQTfQiyE6bWQbizEnZXPBIBpT2hO5K0sg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jl+kQi1JF5h72IRhDTRzXP1WpK8A5hwCAiAzRqzoTJ9axFXtnbiFVxR/w9YHMdGwd
	 RFscc25XKR/kEAzgvmQ2kIzNLa66gE0Qglg+cc+2ViJ8agIVDvCoJjzCvddb41R5fR
	 Owzzufe3w21vyhwiIoRjiEmghTr1z29fQIENbyfGro9KCj99rG2WUpb4tIRT1EW0Lw
	 m0AmYyz5iXEWYGhG13hDgcMd5LQNaqRcJ3DOVPM7M/TPOu0p5Vu1OZPPWLjT4JzutX
	 jRO0RYz07PxCJnPGpJb2JDyDdwFvuWaHGjJwVFHM0NvwAwZb62+HOThduhNIghHj+S
	 bEtbmocaa+iSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BB3AD8BCE4;
	Sat, 23 Mar 2024 21:56:03 +0000 (UTC)
Subject: Re: [GIT pull] core/entry for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <171122346785.2772088.10596056144848184713.tglx@xen13>
References: <171122346785.2772088.10596056144848184713.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <171122346785.2772088.10596056144848184713.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2024-03-23
X-PR-Tracked-Commit-Id: fb13b11d53875e28e7fbf0c26b288e4ea676aa9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 976b029d06607f98f4156d8690d447ea8ed61c84
Message-Id: <171123096336.10193.1782038362659043075.pr-tracker-bot@kernel.org>
Date: Sat, 23 Mar 2024 21:56:03 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 Mar 2024 20:51:59 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2024-03-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/976b029d06607f98f4156d8690d447ea8ed61c84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

