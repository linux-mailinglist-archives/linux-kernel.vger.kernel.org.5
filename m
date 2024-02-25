Return-Path: <linux-kernel+bounces-80246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D936862C7F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 19:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41831C209A5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1D918AF9;
	Sun, 25 Feb 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcWmtp7E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ABE8F5B
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708886765; cv=none; b=jy6pgWNtZ0ec/aVIxklhdUCD4jx4x8DHesFPmZ2+7gzhSJbEuqVCm5CBSNllPFLNrCPbmoM87XLFUlpGEsSv7PknJ2EMQ+/Z5gO+gbIdfrGibqxB0d9+MpXz1KJDQx6rfI+FCWX784CwmMsmIEVg8oVplhAJybBqd8mV8PtyBE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708886765; c=relaxed/simple;
	bh=kIpHNVmztmSzwD8eg+/RY32vFrCEVqTfm0is7w7grB4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L7UqjeC/nXR2s2TDH8HW0+cwn8tbW2ytxn8ol6rLLxX+6rIi98JiOOjtcMm+t2V4/pIbJ1/fLmOKabIMco+egquf6iUcBye0tkYv0BZJ8hYaTNW9uhRh/PoxqWNrYYLjESGyfsR5p4dWI8aBgioQnwaHakmdFrLxf+fwuUo0veQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcWmtp7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A36DDC433F1;
	Sun, 25 Feb 2024 18:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708886765;
	bh=kIpHNVmztmSzwD8eg+/RY32vFrCEVqTfm0is7w7grB4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CcWmtp7EIAsgtZ+Z8840s6r4g3QGNUYOlQhel/oP/u34NqighYI/0e/MymxxxYiJK
	 7MtlB46VO5nYJGWYIonCZ92tIGE0nXS61mdBjoE8SVyXi4dO9lJvXVlg4SoUnCbKJB
	 slvWiFULH445TJs6DJmq3NzUop9x0+7CgQl1qa8gp9oVouot9ybhWBfea27QysZgcX
	 veqzGukQoYHjcjzuxgFjiPaSHRyOMMAe5sn/6YHaHXWsSYzEwRfF//HDb69Jmh5IXJ
	 kpZxIN20IeMKrmPBVcnSbg+zwmfS6NlmucrzvnOhFVxlfwwE1n94qzIh28yNJV06/K
	 xOq2yjIvB+Erw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9314CC04D3F;
	Sun, 25 Feb 2024 18:46:05 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240225104638.GAZdsajv3v8YcNNqJt@fat_crate.local>
References: <20240225104638.GAZdsajv3v8YcNNqJt@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240225104638.GAZdsajv3v8YcNNqJt@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.8_rc6
X-PR-Tracked-Commit-Id: ec4308ecfc887128a468f03fb66b767559c57c23
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c46ed3740e27aeba30866ea3da4bc41b08f98a4
Message-Id: <170888676559.24357.12238031164416784398.pr-tracker-bot@kernel.org>
Date: Sun, 25 Feb 2024 18:46:05 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 25 Feb 2024 11:46:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.8_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c46ed3740e27aeba30866ea3da4bc41b08f98a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

