Return-Path: <linux-kernel+bounces-60233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4737E8501B4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E39F2863E5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51281E87F;
	Sat, 10 Feb 2024 01:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5ISpW4P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E387D1A29F;
	Sat, 10 Feb 2024 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528251; cv=none; b=dDhStxGHNbQEhybInzvCxnfRPRsOp4lfZ1SUHCev44Yg9aKtHkvK7izerGmMpecioYfjpLQXHGbUl1zx9KhGmqBAw7/g2L+xsH3P2dHxodGXeZG0aPhazNeOKVx50po9In/PfzLQRxvwLGMzwaX0JAFEsK4oVU1/x4a6tnzt6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528251; c=relaxed/simple;
	bh=M5J+RtqDSp/9POPXx7SzxUz3FTRMzFLR/2oLrayLf3g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LlhR6qgPPjJF9XuU9eVMPZd5Gq+Gi2AYbDkxm97Hc7K1ZNrFGhAc3LebjZCxooRYr46vLQyR8v8R810KNrX9nTFxe88eyRq6UeuqXqLSIrCGcfaBmrPu6mFK5l9HJ2JvWvag2nLaKVO4MZxObmIYXG/GeQyVAI+3uTBwHHlsu80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5ISpW4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52FEEC433F1;
	Sat, 10 Feb 2024 01:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707528250;
	bh=M5J+RtqDSp/9POPXx7SzxUz3FTRMzFLR/2oLrayLf3g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=T5ISpW4PDKIlit3W6bb3aHU3l27PKfWDvmHG/DC/QfQoj2ZkwzCYiuzLakbgrBnFi
	 iBbicJRvp8caU9X6CVTyV4R2DQSWSY/YrFwvkjB3GgEarlylmbU9kTIMmD/TTMoXNi
	 Mn384pHZaDNJJYuf5233LrazcOQjuNw57AvEPwub4QFABgpQ7j67GjFyY+Kqj/C4c0
	 C4myKKgu6EM2kO8rjj7vFdi07GIGm7W+BVBt9kfAjydc6zJOloUR4mbIEMdQ1hU/eI
	 /rrSgmF7QrSPH9zHMr6M+pA0a35RQg//MF/PheyT+p/c0MnmmC5tOU6+QD2fOsR9YL
	 cQawNuGMjeckA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FD51E2F312;
	Sat, 10 Feb 2024 01:24:10 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <df8e539e6f1e708d1a1b0025632ae3b42bb7ff84.camel@HansenPartnership.com>
References: <df8e539e6f1e708d1a1b0025632ae3b42bb7ff84.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <df8e539e6f1e708d1a1b0025632ae3b42bb7ff84.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 17e94b2585417e04dabc2f13bc03b4665ae687f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a7bbe7519b6a5d189feeba1d417c8ce9f7e852b
Message-Id: <170752825025.10429.10943299676286092255.pr-tracker-bot@kernel.org>
Date: Sat, 10 Feb 2024 01:24:10 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 09 Feb 2024 17:30:46 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a7bbe7519b6a5d189feeba1d417c8ce9f7e852b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

