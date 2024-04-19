Return-Path: <linux-kernel+bounces-151945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025188AB620
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7551F2115F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459BE1386C0;
	Fri, 19 Apr 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igkuZfW3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876992BAF7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713559594; cv=none; b=ll5JoqoWNLS7CpHqKGdmMEAli70MDSoBkGdKEcCZY/7QU1YxBvLa5l3Ylngio65XsvXMTNomRc2Rmpzb2nW4wfGaeBc/SuwLSabgbVXfp+F7Lp/e0nzrtHJe8nRo3cbvJwR2J7EqHyFuBcZcugDg9fAeH9p19D6VEqlxhVSaxFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713559594; c=relaxed/simple;
	bh=WKCQgu9y14UeG2X/lyxxoerMV5dWpCoyo7UadUi4auY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VFTlHUclwXTPvK4reexfwyc4vgB/dMeDsrjLvqY/5mmI878mnZzVE5CySLundQbfA8UbDnZzCb99P+j9q99XyFaBqIuXu+LDFAz96xUJf5AlzWiZyGMXy4n+y7hbhtVWZ3pAIp6jNwKwm8S7shydAQD6mMs8biNKhcMg+EwsIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igkuZfW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FA66C2BD11;
	Fri, 19 Apr 2024 20:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713559594;
	bh=WKCQgu9y14UeG2X/lyxxoerMV5dWpCoyo7UadUi4auY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=igkuZfW3iIXsxhS7z3hX775yuoJGQlX/e2mc8TbVz69/+HMGWw2HziAniHIy5g5Ep
	 IzQbgwwq8FBRfVIX023PzzLwdHZEKVXmoNJ+bkNSFzcxTtkBHPpmiEMlEVxsiHKoB0
	 uAdGWxk8YxHyffm1eAmua9gI8Idx8SPtWxL8Vijb1TUV8GeAqvgCgv8IQEJj5KXn1U
	 uN0alTp5tIWIBMCB8/wAMXXKB/9jk9e07tag7i9BRP2dUNewJRm0WpnYqnGMHeebAD
	 DjZDsa8lI3zDONqz7JjWgL8x7NiRkUAMWh0sekH+1ZWvMPZkXn4XUqCq4pC4BMbr0I
	 AzjaLb45TSfTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25310C433E9;
	Fri, 19 Apr 2024 20:46:34 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZiKvB7Pp62tFAoBP@arm.com>
References: <ZiKvB7Pp62tFAoBP@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZiKvB7Pp62tFAoBP@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 50449ca66cc5a8cbc64749cf4b9f3d3fc5f4b457
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25ec51ec86a75fbe27e08bf0887a2ecaeb04b2ef
Message-Id: <171355959414.22865.10840059573086676727.pr-tracker-bot@kernel.org>
Date: Fri, 19 Apr 2024 20:46:34 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Apr 2024 18:51:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25ec51ec86a75fbe27e08bf0887a2ecaeb04b2ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

