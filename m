Return-Path: <linux-kernel+bounces-100581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8CD879A63
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8116C1C20F32
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1346D1384B4;
	Tue, 12 Mar 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkB15YDi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D0A1272A4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263504; cv=none; b=O9XmuX57QSZS6pi10Uz7/3d0QrO53p0CXIwb3poJHY90xhATnBEdO3TDQNvPx0HvBB5x9lbU2thRlUCQuckE1jNw2gZc5sBztobQw6q8SPBoYcMjitakHFK7sPPfYH4EU/iXh0AOtcwA79xSobdFi4FR8ckJIPMOkDOciFszOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263504; c=relaxed/simple;
	bh=e0frPq3R17XkR8Xe2eJSDNMKhbd4Y2kZu0C66gp1gRg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S+pnHETK8PHA5lpxrMGYcfrC0h9zqrpz7dETZyBTxqtjm2Lh86O93iAl3M+To0t9rVjJn65vPMXt0z/snYOG4Zntx47716dpQIjX3pVOK8IZBB1dh7JBDJvVEwUyp+ySgH6++XBpTtRUsNLT2lE27/5padIwIxm+HnC+I0Sgw7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkB15YDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38C70C43390;
	Tue, 12 Mar 2024 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710263504;
	bh=e0frPq3R17XkR8Xe2eJSDNMKhbd4Y2kZu0C66gp1gRg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZkB15YDixcvu8IfXHUgc4/rEMwyUJWFXwS1yqY+yxhbJrG8C+7+k55TRPdsmCKdLJ
	 PkgPUnGkG42IP1st0JfLYYY55OrF6fuysOa+HFykNPsz8Yj2ZDahT7mAQ2j/OgvpO9
	 h0EnbGqHGXCB+4GDAUCuZvDqRhuxap9gx7rKUV7lemR7xiB7cWkuGatLYggIyIYuyY
	 i1Zz1MhyVbSWtjKpbHbxjuKuZQiui0zXtzv6vDQkhPgfKt8b7rBSkOPKrQ7NB/EOEf
	 9CUr71wlCqCdS651P8POQf0hQHl+6b5JJFDULSyl5LJo/ZxzcVY05HbtStbqPJJJZj
	 WPtwqF+D8JQ8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1DB53D95057;
	Tue, 12 Mar 2024 17:11:44 +0000 (UTC)
Subject: Re: [GIT PULL] x86/boot changes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfAjjSP7raRzEA5/@gmail.com>
References: <ZfAjjSP7raRzEA5/@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfAjjSP7raRzEA5/@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2024-03-12
X-PR-Tracked-Commit-Id: 2e2bc42c8381d2c0e9604b59e49264821da29368
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b29f377119f68b942369a9366bdcb1fec82b2cda
Message-Id: <171026350410.10470.1412029869376203652.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 17:11:44 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Mar 2024 10:42:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2024-03-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b29f377119f68b942369a9366bdcb1fec82b2cda

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

