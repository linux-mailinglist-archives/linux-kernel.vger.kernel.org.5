Return-Path: <linux-kernel+bounces-99800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 046DC878D83
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999361F221BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F152558106;
	Tue, 12 Mar 2024 03:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdAUWzm2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C825DBA56
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214356; cv=none; b=VXF8a2JPyBexDY8noXAilTWm9KaJb3fU2w2WzX5gL586SIBzI616c9ox4e8NS4kWisw0C/OuZDwoyfryhvgrRqVk8ja6HBJqpVnZDaLRHf+8bf7oyj6RCLs44mowxT7/qsHJxnGm/WllChU+x0r6aRXOqVasAajOHN7iEpMZSpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214356; c=relaxed/simple;
	bh=MJjoFDgmN4yW5oBAFxWdmW45jFhgTUQNN1hc+fRFxZU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c7P7uQALsrAU6nOXMLJoy2YfYQv1sCePdxOYbNmKRGWqY1Qx+QWcgaWRkyhu3WqpYp2tg35jRAeIUWL3Rezraucid5vkSRdsoMeZtfTX3mgu1WjNuBf+Cl/LwFyVBcCy0YMqBNXjjqSLJdQ11t6qQp3aztMldJVH5PQ40G9t2Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdAUWzm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97AE4C433B1;
	Tue, 12 Mar 2024 03:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710214356;
	bh=MJjoFDgmN4yW5oBAFxWdmW45jFhgTUQNN1hc+fRFxZU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cdAUWzm2OoUHjz7Ss30ezvMoJGj8yDQrLWAcNBycW2RnyWR8ZCL5WRvn4yskasxv1
	 6w82mbn/LZF2hDIw59Y7oSniy0s81ZnEm5ASP0XCqqw1VjdmWGEmY6zUunvhv7HkE2
	 vo/yNn3NeuHG82v2ghPPNp2Bx/lZWD++hZ6Z2781mPRiJOw7O2rJf7/7oLQIzdobLo
	 19HO6vMT7EpVTcxq2G+BF1Qkabpb4ajZJfn5Ulm3q3hRDlDruDM+8Q1D/jXXKE3/gx
	 MV8GGMkGP3hJjt74IQirfivhM7OGhbV1WgWQUmmfdODaQ9QBtAcCkE/yOljGjjiddS
	 kvwAs8/qMbcBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 842F5D95058;
	Tue, 12 Mar 2024 03:32:36 +0000 (UTC)
Subject: Re: [GIT PULL] x86/core changes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <Ze8LpCezZ4yHRBnk@gmail.com>
References: <Ze8LpCezZ4yHRBnk@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ze8LpCezZ4yHRBnk@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2024-03-11
X-PR-Tracked-Commit-Id: 35ce64922c8263448e58a2b9e8d15a64e11e9b2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 685d98211273f60e38a6d361b62d7016c545297e
Message-Id: <171021435653.8573.3656852578696235237.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 03:32:36 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 14:48:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2024-03-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/685d98211273f60e38a6d361b62d7016c545297e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

