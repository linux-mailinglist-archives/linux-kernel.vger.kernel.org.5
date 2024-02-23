Return-Path: <linux-kernel+bounces-79000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D612861BFD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCFCFB23FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B761468EC;
	Fri, 23 Feb 2024 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/UzYrDF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F096314532F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713848; cv=none; b=kc3Qxng+r1fnjekHov8R5JXX7OzMa+KzzrpluCuKsDaw8OtmkLDXCqxPujy01J/Xdvqsn+kdGJwFezE9Ro1Pyl0aqOege8hpjdpF6ro4bXbP0bI5IrU5jx7Zo8eWGkHZjeae6sZSEvLg//Hfv/2oKnhu4at/0mZON0dheEU+5/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713848; c=relaxed/simple;
	bh=+fgEMlJLyqCjjjp6HnkjlJyX+vpTlI6pSCw1DxdOpp8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oUuRYPYrTqYupfdn215CVn2oeHIbdNoIKYVaZSm+ddxsMm92Nm19vM8uxSeuIpeF1FemKhKeypTlZGJgbDWIl4ZBPjEEJjVvR8nT/+LoilznnC8uFJ8TE9eI5YJ9Vz4u2IWPpTGfRsH9VCfKgEjkIJ+RXwMUA3apeBJwGt0pzrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/UzYrDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88989C433F1;
	Fri, 23 Feb 2024 18:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708713847;
	bh=+fgEMlJLyqCjjjp6HnkjlJyX+vpTlI6pSCw1DxdOpp8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I/UzYrDFiRxJxMXNCZdNCAK7/56Q0UatiS/Of+bw8eG7LVl6y8Ve2BWD+kxPkRTQQ
	 oRx4KGGmqx9D3YaOZAH+l6pC15GKwp+wFcbCPj+eyEn0ucarc5kkPbTgL6YBTCxXxU
	 dXJem4A+sRZgcG4C0t+7L902qtSPJg27lS6RgG8H1UjrrQgwpgHsA8BZ8h1C5kGWWX
	 sJMSxaEOtnpg6yGimFOhXrvBRmlz/4xCWHjzwYFM5moHyh2U5NgJOZOViMeBJkNSj4
	 EhRPAwx2sXRfKyZZYVv0vsySIYGuyUOtPOoZ4G42YaJcX9ZzZRdMLgyOj5hc5UOX5w
	 APmhqsqmh+9PA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 751B9C39563;
	Fri, 23 Feb 2024 18:44:07 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240223102531.GB10274@willie-the-truck>
References: <20240223102531.GB10274@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240223102531.GB10274@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: d7b77a0d565b048cb0808fa8a4fb031352b22a01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86f01602a41fb711f992ad6ab6483a4487829b4c
Message-Id: <170871384747.26987.14345883877585633830.pr-tracker-bot@kernel.org>
Date: Fri, 23 Feb 2024 18:44:07 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Feb 2024 10:25:32 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86f01602a41fb711f992ad6ab6483a4487829b4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

