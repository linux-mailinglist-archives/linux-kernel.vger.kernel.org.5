Return-Path: <linux-kernel+bounces-69211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81D68585CF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C1A1F22E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1314D1386A8;
	Fri, 16 Feb 2024 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rovVMdF/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B59135A73
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109524; cv=none; b=AwyvN+zfAkPjIHJiSlThOM8/JawZfF2v8Lgxtb9QmsiYzAqsTEuxcPTFGCgiw+Z4kw9WMug/AnWdM40sTrSa10so8OAKzy3eHqTTZ9LcHq9pJQguFhusPdgIKwtFWpVIVRKraIHpOwrWEHtJoOLqe/dDzqDpxskInRnv7jxaCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109524; c=relaxed/simple;
	bh=EOW4rDET4aXDWr3T3YBtcUDyirIWwK7Mgu+E0m+Y3tc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PCR84VomngPphAuV3TVE97F1pSOWeR69YdJFqf/chm65aIFx9axj2VltK9LuY4H50kPTp48A3wc//OboyB0itMo9Y/jT0zQtwITO2d0LmBKan13lBZiw+YRqyNQzCRI6OyhBPHQWIVSbGrJSDSoi5/UQvYoZSaatiT2RTWdKtbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rovVMdF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 238C2C433C7;
	Fri, 16 Feb 2024 18:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708109524;
	bh=EOW4rDET4aXDWr3T3YBtcUDyirIWwK7Mgu+E0m+Y3tc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rovVMdF/NnD1866quW3UyEwyiAcbSaGpaH/YGuufOPAXSpMNN3gOeevQSPhyz6N2a
	 ZrMGLSCEofjvwAB+rYp9xp/cGwFSHiLTTELbCc1eN1eoFc/AcFnKPi3oTgxSSTFHE7
	 O63nC6X96AcvrYLtBqE61JbCqWIpdRIScdbmpecmzFm1/izZ+c+BBtYTkHUuvx6QOb
	 k35P0c7H2bK5Tf/942TMVt7o0BUJSdHIzJERKfEa5t110w/NuIqrvwjGRcLDWRx/4F
	 nZVIu4XxBXuoYM4hDCMcvSPtbAvqHzOyz0hqK7pXQiWApsZlMyjppESwC+OykU+MCB
	 xt1e7T5FBV61A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1057AD8C968;
	Fri, 16 Feb 2024 18:52:04 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240216115819.GA1804@willie-the-truck>
References: <20240216115819.GA1804@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240216115819.GA1804@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 2813926261e436d33bc74486b51cce60b76edf78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f3f64cb60eef5bf3a787573cd05803171eb99ec
Message-Id: <170810952406.23532.1437982823384303516.pr-tracker-bot@kernel.org>
Date: Fri, 16 Feb 2024 18:52:04 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Feb 2024 11:58:20 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f3f64cb60eef5bf3a787573cd05803171eb99ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

