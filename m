Return-Path: <linux-kernel+bounces-134007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 869B189AC0C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412851F2187E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEAB3BBD9;
	Sat,  6 Apr 2024 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJTKi/5G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CB4107B3;
	Sat,  6 Apr 2024 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712421303; cv=none; b=s4qC4Xj+p7XU2bDqW72NUFZbQm/6/r0+/wf/0JvXOBMBn69z+7poWxnZpAAVwZji7PqJuTkHjyr6guajfdPO0XP7V+BPIkCcgYrcrEV1ETtMv3mzKF71vwoJ4m+CrwFO+mkS1H+seRu0xnSNqnU2Vk6d2YchHaG17MbrulZY7Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712421303; c=relaxed/simple;
	bh=7KA9K48IrbMRV/1dY+e7BQAyqn3kmkUCdzyC0mQDjFc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bCs+ImXGxToaHk9ZbtZPBKE8eDKgns/R8n/bo37NKuyLv3rU+xeapZX9NsEZtTe0+hlnG8zshfmSdGstgekwLQ7DhvvALAHU0D/ySIYD5H49vxV2uFY9ZGUT1p4On8RRKgrWF8x7A9V4b7c+RNa1rRSG2DN9iab/K2Xe/kvUiDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJTKi/5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DD22C433F1;
	Sat,  6 Apr 2024 16:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712421303;
	bh=7KA9K48IrbMRV/1dY+e7BQAyqn3kmkUCdzyC0mQDjFc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AJTKi/5GgER+ghxrIXv6V60qJU6PjZwF1f7ZNgs/J2lpIZ6iSS8Wwj+apcJrzh1O8
	 TvpnmMyP1YkGd/6meC8chG6Cc19kgwsb5RCJ4yr17z4fwpRPTxy2bH7iy96xUd6er+
	 BDI1LgulpkdjAPiXHHVOrKaxHrTJA4j+rvImebc9kuIV53FaqaoAPhFbfeLlPOH67/
	 eniM+ATBbU3wHNlSSuN+DXibvj2JTxYZqGjSy7O0e04eK+fn6TSW8oKvED9zJk1toA
	 /A2urvbI93L/2z2aJk85O9WpSKRI+wbZ0fsVCFOUENEENvyvBu3hKVVAiVawlMQi1Y
	 KdRoBh821NwnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22BF3D8A107;
	Sat,  6 Apr 2024 16:35:03 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZhEb2zk8J-YCCgaZ@shikoro>
References: <ZhEb2zk8J-YCCgaZ@shikoro>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZhEb2zk8J-YCCgaZ@shikoro>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.9-rc3
X-PR-Tracked-Commit-Id: 5ceeabb0eb2e1982d25c384048735b9da66911f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf17b9503f1781af60f414c183c1dda8cdba696f
Message-Id: <171242130312.8716.7935450468280333391.pr-tracker-bot@kernel.org>
Date: Sat, 06 Apr 2024 16:35:03 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 6 Apr 2024 11:54:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf17b9503f1781af60f414c183c1dda8cdba696f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

