Return-Path: <linux-kernel+bounces-58863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C74984EDA3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C90281B55
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AA2537E7;
	Thu,  8 Feb 2024 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDbvy8cm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9AE57876;
	Thu,  8 Feb 2024 23:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434175; cv=none; b=NUvthgWPFsPrxrzAVHPEHlhvFxoz45T1Pq1sJwB7rvaAzknn9S2YIDXTcNyLSkVLuYsf09Fu+RKbgTk8IUfIR7DQiNzwKxvVwpIL4aRlJXYFnaH/GQ64vhBNCWCQ4uUIX1PBsQY3fcaJCODW6VbreAoXnkzcaLNEcu0d0hR7zRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434175; c=relaxed/simple;
	bh=Pe+Axqe8q2yNzcz39DBsWhSxqTMl3VShEkAxmjwAUTA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hosljo41CccxJeG+U5Oqh200RLNu2PLFry6Wmt7q++X5VRgsdmKpn3NdH5XilusBZBcHJPwPWJXKvf+g3xoOgM0MzM8iFFaJG0QqykXTnXomnVtlx/OkIow5RYWZtye1YU2b8XEmH09bMcz5vm3nmMSM9VcNTy8CKCE4+6lWQZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDbvy8cm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2DF6C433F1;
	Thu,  8 Feb 2024 23:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707434174;
	bh=Pe+Axqe8q2yNzcz39DBsWhSxqTMl3VShEkAxmjwAUTA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KDbvy8cmrlqyIwua9TEQ+Dy80pdG2UWm5pLmEwHyjAp4WvXWIuecGu8hovr8OsoEx
	 yAeMblqNwdLjzy/9H7oSVgtqSjefnvyQsUj8dppSEQFUCMtbqAKdEKSddaH0S3fnoR
	 YmtqNexs9B8+5oQ3igVJyoCMNR3/vsEo3bZLnwAAfNIZNO77n76r9tgXKh7HRagZAi
	 aPre23M1BJD7vkCtuApxLhzu2IwX7Ah3zGKXig0A4bczdRnLJH7BCqueGQtv4f2oiA
	 qZIxY7TtjhakCmzquIp1eNQvPGqgbFEpiSfHOlsFIBGOOSVqISiqo12jIv9ejsJc8l
	 /NUup0nU6M2Nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF128E2F2F0;
	Thu,  8 Feb 2024 23:16:14 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fix for the v6.8 series
From: pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYy1Y-y8ON2Q1cz56NJzMFx7C-=5PFXeQ_xwem_bWma7Q@mail.gmail.com>
References: <CACRpkdYy1Y-y8ON2Q1cz56NJzMFx7C-=5PFXeQ_xwem_bWma7Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYy1Y-y8ON2Q1cz56NJzMFx7C-=5PFXeQ_xwem_bWma7Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.8-2
X-PR-Tracked-Commit-Id: 4451e8e8415e4ef48cdc763d66855f8c25fda94c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0d5d0f73761124f0ece33f5fec421e76a22a9fd
Message-Id: <170743417471.5821.11330778527038410807.pr-tracker-bot@kernel.org>
Date: Thu, 08 Feb 2024 23:16:14 +0000
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Thorsten Leemhuis <regressions@leemhuis.info>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 8 Feb 2024 14:43:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0d5d0f73761124f0ece33f5fec421e76a22a9fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

