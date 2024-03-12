Return-Path: <linux-kernel+bounces-99796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DD0878D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECA81C216B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4E0BE4A;
	Tue, 12 Mar 2024 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/RWQW4a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA20B642
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214356; cv=none; b=VMZh+0vGlKrx67JQnqwHzxQpu8Ytrcu6MUoHNrvSPGviMwgO7mdUS8PpaX5YCy8eGgzz1Ep9g6U1zgwpHRF3gNB9J8caoBQfpWFtkaMEmeO6MO+MgDTTfYI4mpUyByXE8tiEGL68Iw9VL7tZwuuNzopzNQwKBcB7sD7G8kd3FhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214356; c=relaxed/simple;
	bh=o9Pt4TwG6PqciTljFFq+y02cDWOk2Emf4WrgqVhDVDM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t9hGQd6FYbvci5CMFOPGGvOqD4b6xU3KjMUbl0I6yfXpNDNbxUokGaVLAkOnp6sI5UVo1x0IwfVL16pSY4NsPBTVYSA7qszmJglyAE+9PdRe/eyIIkjex7c6BoA194Zz8ppvlV3ytNQuTBxGeTRPzT0/jUHbHHOZCXOxug6BxKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/RWQW4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 091ABC433A6;
	Tue, 12 Mar 2024 03:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710214356;
	bh=o9Pt4TwG6PqciTljFFq+y02cDWOk2Emf4WrgqVhDVDM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A/RWQW4aw8/H4NCDinQNrYw4C+mkVkYeFEJn4FC7y3BVCGDD7LfCrwNePb0gl2gkl
	 XGplIe4MVDw6nf7Sv6ItfToh6htRbmrc5g74BAEQ6Wb0xTrwRqOuTiuTqNCGiHlw8X
	 iXAQETiE/5S6DL7pkRINbIZrMNz4/ND6LpIg4e4+wSL0dwphdth0UYQFUoEDyYMCGv
	 zy4JVhnX2LYwXqzO4FTybbh1Etg6ngPJtfi/3PDx5VvRzlPjGZAzjzCuICjBJOem95
	 DIG3er0tjhoLOIucX1HuEasJ6jbjNnWT4EmXJxM/7/XOsrl/ng5dc3hexgNchs5yOq
	 mnf/DbSdmKGzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5999D95058;
	Tue, 12 Mar 2024 03:32:35 +0000 (UTC)
Subject: Re: [GIT PULL] x86/asm changes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <Ze74VMV1hYeaRuaG@gmail.com>
References: <Ze74VMV1hYeaRuaG@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ze74VMV1hYeaRuaG@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2024-03-11
X-PR-Tracked-Commit-Id: 07a5d4bcbf8e70a430431991f185eb29e74ae533
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73f0d1d7b4abb4a46bae1a0d8caf66e23d1138d0
Message-Id: <171021435593.8573.4611801305020328569.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 03:32:35 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 13:25:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2024-03-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73f0d1d7b4abb4a46bae1a0d8caf66e23d1138d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

