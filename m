Return-Path: <linux-kernel+bounces-66184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E8385583B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217BB1C222F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6307D6117;
	Thu, 15 Feb 2024 00:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjFa2hLo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A901E4A3E;
	Thu, 15 Feb 2024 00:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955963; cv=none; b=OMMWshh9BqrytDV9B7wTT0YUuVISV6QkjH/4K4E0jRTxQ7977wx/11Ib/72mY8QXWh6lyqUnJ0grgHDXvg01oMFFIPIycEqkRAljds/VPYBDwDuc8QEu4wT1Ua3tAp2uizObE0jYa7rDpRXCwEZBjsxZsfM0kXfT8Ka/NNkQ6Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955963; c=relaxed/simple;
	bh=IOtjgm0TsTQpYOXhKX+dQcoWRMWi0Nj7uZ2rY60BBqk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WGVET0Akovv8ZKGz4BRHvppMUngcQZhO7bE+1ddKVt93vGV+gKYmVwIsGqhaINUnR/PYf2soXnrggBwPoXeN+oTRvbQ/TEtHzHoYmAROD/B5H12c6AfPUqqEhW1Cq9XNyPFd+KClCRwvTuqdv7C0iE8+eL1hlKEcw6QMVpJq9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjFa2hLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 803B3C433F1;
	Thu, 15 Feb 2024 00:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707955963;
	bh=IOtjgm0TsTQpYOXhKX+dQcoWRMWi0Nj7uZ2rY60BBqk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fjFa2hLo+W1HDSQ63XYZecUAx7w62x0TWqpC10gNIxWVQ+1UnvxaHsyGeo2r8eycn
	 NAPu7dKnpMW5HyzGSGOUVUOmt6U3tEazGMDDzu2JB42e2Y0G3nDe6DckqcowkCBfHw
	 b7fSEKffaD1KFb8QlSioFMpOIbadLXAukKl2TSM6LF3njSD1olTtsSxiVR16itPgL4
	 HZPsr3OPzpS5JLkrYciyRIM4cWUG3e9NXtV3sgHYTtdA7m7dVSFAMP6G/uGPPFw5TC
	 op5kiRV5LVAlbDGtGzv+6ZwOlv7OiOvSbgPFMs+D7+jsrqST8dTHcMKkIlqp+RMHjt
	 +u10qINyMUxXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CE57D84BC1;
	Thu, 15 Feb 2024 00:12:43 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock fixes for v6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240214142026.2401046-1-mic@digikod.net>
References: <20240214142026.2401046-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240214142026.2401046-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.8-rc5
X-PR-Tracked-Commit-Id: bb6f4dbe2639d5b8a9fde4bfb6fefecfd3f18df3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6004b044f77121d09cacf47073c19dc106da0e9d
Message-Id: <170795596344.14173.10426787456011400092.pr-tracker-bot@kernel.org>
Date: Thu, 15 Feb 2024 00:12:43 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Hu Yadi <hu.yadi@h3c.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 14 Feb 2024 15:20:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6004b044f77121d09cacf47073c19dc106da0e9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

