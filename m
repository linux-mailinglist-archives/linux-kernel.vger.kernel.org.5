Return-Path: <linux-kernel+bounces-50550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5521B847AA1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78E41F25A10
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AC87A71F;
	Fri,  2 Feb 2024 20:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttn9TQOv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA491754B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906614; cv=none; b=UrpoWWROTj94w73Ze9D+h1Wv/+5L3ADpB7v6hEQIKs8PdnEAoY0ViMp7OJLQO2FGpTfQcOFo/ojNkEeagRRO3cv20FNdB885df8lQZngI1bLerDKlWSgjw3QL2cho9rNOzYFgoUQvKZRuI2qtFzGujmhJkCQZWZ+HHpTJ1kWiD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906614; c=relaxed/simple;
	bh=YihQaMJBNuzPTedpN0dIR+B5VXMcfnxR3Of0vGVkIyU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Z5wr8XZv+sFxnSzeCwsSyaXkK2/l9dXdf+pyXZaITfKmPbInM3JPw4cnqQGOZf94t9ZWbvK2IShJrcboIqpso6RajPgn4w5w4e84VD6x/oNXGtlOD/lZGyNXW0Chgbhl+ZDpqXP6BPF6y8oz7E4DfXmr1P4azrK6l2VN2QFtANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttn9TQOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92024C433F1;
	Fri,  2 Feb 2024 20:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706906614;
	bh=YihQaMJBNuzPTedpN0dIR+B5VXMcfnxR3Of0vGVkIyU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ttn9TQOvUPIClIoksJ3h2ukmb6NbN1/RhwkhsGSB3CDmblO/kKIXCoYzet9/oUDrd
	 04B9pbHHiEk2hGJhiCxa0LCBEPhCheXc2l9cHLRacbYuN7l2R4PbT1nwBxDgJXo8V1
	 RWyKRMIpGlZaW8I+3HLxQclDFPizyg9eICl6RU+igPBb958+qwscOiV8ynLtzF5v3d
	 tCAb0hfg0BmyWJX5hG9Md0LfzgmH6XXlJOiOxr37ox4WGGaNSvE7G91+WMPPDADyC5
	 pUMzJzCoS76m19EFa96X319ur9Avwlna6twtfrFTD/q8xnYUpqI87JJu81dLdUdz6q
	 ngCkgeQ1fjE6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CDADC04E32;
	Fri,  2 Feb 2024 20:43:34 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240202111107.GA16598@willie-the-truck>
References: <20240202111107.GA16598@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240202111107.GA16598@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: c7767f5c43df2c453af4651d1f58f489e3eb4ac1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec86369c88f6794a6cfa0383f715f276305399ed
Message-Id: <170690661450.32059.3284110650609579874.pr-tracker-bot@kernel.org>
Date: Fri, 02 Feb 2024 20:43:34 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 Feb 2024 11:11:08 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec86369c88f6794a6cfa0383f715f276305399ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

