Return-Path: <linux-kernel+bounces-41889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F3583F936
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB26282FDD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C683C082;
	Sun, 28 Jan 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAZ9cgMO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEB431A98
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706467641; cv=none; b=Vk4hpr5PvzbtZhl16WaI0JK5GDn/rwTVFlZPx8rdBb4+NsgU+898nOhJFIsM6KtHO0TSw98x4Y+FgySPb12UtMGX5ugsi65ZrrLp1rP6J6ddmqvuX7GB/kpwewrZQp9SKPd40jMcdjR9CNHueXy5latvg5Ri3R/eZADrzgmYoZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706467641; c=relaxed/simple;
	bh=i2aLDCyRY+/WirCpyfX5cBNIeswSkWK0SGdplv/rhls=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VRhi8+xfHXP0XH4EOuoIRr9nZYU1wIv9M6AzVMBQfNr6JcViiLOvq67T0e9WPFlDP92ufMJfXsO+QK9KO0Yxb+MY4WaAX349uDeOHXsVeayfIP7qk/8gaLL5R7VQksHJEdHfq0WI7K7xA805O1QqfuRP8dD2Xzju2Vqm/Bp0SWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAZ9cgMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A759BC433F1;
	Sun, 28 Jan 2024 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706467641;
	bh=i2aLDCyRY+/WirCpyfX5cBNIeswSkWK0SGdplv/rhls=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QAZ9cgMOg/qSVOIuLdOZwae4euyRIUBbyrkqfJfD7rkfE8txlfa5vgZH9dFS6k2n0
	 FH/vGNum0B7M5EasqqfQhBZyN8hjX+PC5IpZJhyr/s0thIiAr/YS8vOWnUdzG4WsU0
	 s/cGTYpQ/q1gTdpHcvwTR1Qz+cBtGh6G7Ssfs1iopf8wat1C8k7+/enHGmSJ8V4Pt2
	 OFIX+jtRhBmOk9t8DboYMKdjd7fVBKULslar3pzwiqOcdVR52XmUHMDxnn/KWC5Egc
	 hgfnxNO45FQe127bG2YW3ojYPbhVD+QSb5c2e6bSVeyjAALWgkWB1F0nWCaBpvgueN
	 6b/tXS904Jk9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93790DFF762;
	Sun, 28 Jan 2024 18:47:21 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240128102227.GAZbYq41uhKVmVFc_F@fat_crate.local>
References: <20240128102227.GAZbYq41uhKVmVFc_F@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240128102227.GAZbYq41uhKVmVFc_F@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.8_rc2
X-PR-Tracked-Commit-Id: b184c8c2889ceef0a137c7d0567ef9fe3d92276e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e4363ac1a21268c0c02ff65e16b3d33dde3bee8
Message-Id: <170646764159.17624.7954806117871350502.pr-tracker-bot@kernel.org>
Date: Sun, 28 Jan 2024 18:47:21 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Jan 2024 11:22:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.8_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e4363ac1a21268c0c02ff65e16b3d33dde3bee8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

