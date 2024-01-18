Return-Path: <linux-kernel+bounces-29566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD1983104B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCEC41F23027
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A4181A;
	Thu, 18 Jan 2024 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VECpag6N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1CB623
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536309; cv=none; b=JKq95YvDli9KeZORNQ9cJd7bGKmXMy14NYvoT6cQjaqCgjwu9eKS0zMlGBJHPLWHLnw8r8ORJKhXn09cdIP1EXUTZEs2i6X5xG1jxLWL1Zol/FTqF4Y7r7qk7TdeE/SK+yc/On9XbGwhrmzjFvK1Fjuc1p9W9RdBBQYFnf4rGKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536309; c=relaxed/simple;
	bh=p1TOLb+HI8ctOfXvgwoJuQY2B1a2iV2T/c3yJ/CGPyg=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=XYphtvyQPmfsxtKWoOK1ZqZwAACKHF0Xzy1Qz7H+IqdwhVCRfts/VbvY9WOcjiSdByl3JjzXa4ZayWh3+ZHEHeYT1Ay9/K5SoyIsOts6knZxbLgUvJEWiFmaFr/hRw8Ov4Ta7WSRJzGp1Pmw6TBQMTKotoxrYfkXYgcbI6kMAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VECpag6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4CD8C433F1;
	Thu, 18 Jan 2024 00:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705536308;
	bh=p1TOLb+HI8ctOfXvgwoJuQY2B1a2iV2T/c3yJ/CGPyg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VECpag6Nnbm3nVJSVG2Fd+DFksnByUCzDoh25M+cBQ151v3CEr553aA2WF1msUJ5/
	 +quk9FauQqp0NFRn+Es9G5EgR8MPs+xdnstMrCpcaROxUqfeq3AU1goAioyOg4S3D/
	 r+lb4xbCouwwHMPDGPjL2gwT/JNOfItXb+6YjLXOd3cn9z5VpvUAu6oFY4YsnHJw8X
	 8cfhIiRnk1Pn/8qKVySfuMmTmIvuRs/Bi3xgGKjj9cXD7UsLIdI/iPbnefSZsrsjHF
	 tKKqAhPUa3zkHmrD7+AJPaFLxwuULtx3hlqkOeKb/P+v4z7Lf/CtNR7c1URXcRdTLw
	 oG7m8uaZzdI6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A11F0D8C978;
	Thu, 18 Jan 2024 00:05:08 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY0AC-_0xfYf3veAkY5X_+=daYZEc4_wnKZ+fUpX82BCZg@mail.gmail.com>
References: <CABb+yY0AC-_0xfYf3veAkY5X_+=daYZEc4_wnKZ+fUpX82BCZg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY0AC-_0xfYf3veAkY5X_+=daYZEc4_wnKZ+fUpX82BCZg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-v6.8
X-PR-Tracked-Commit-Id: cd795fb0c352c1f70e5fa437b01572c8693e1b77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75afd029e607623df50495ec6acefe82138d6935
Message-Id: <170553630864.10877.12457360073889596183.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 00:05:08 +0000
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 13 Jan 2024 23:25:56 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75afd029e607623df50495ec6acefe82138d6935

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

