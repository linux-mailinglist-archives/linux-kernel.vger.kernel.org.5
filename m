Return-Path: <linux-kernel+bounces-89124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFE086EABC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C38C1C22185
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA2356767;
	Fri,  1 Mar 2024 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIqeHcR4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BDD56457
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326336; cv=none; b=fm1XBe1YO2XaoHaQT3QJdlvuf41GNdiFDQ8PH1Vnr3BMnYz4Udz8ttz3uFIR193/7VETE5pHIjym41WzTWQkYtt8eITBj8qWDeW/6Ff5Ka2x1/pytYJpnS/PnPLAThcKgm+bMp8e5rDoRbogNR3bgA8wcfftx7VIyqTunFs37Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326336; c=relaxed/simple;
	bh=ssAqB+QWyIVQUkV1L1MYK1nhKVDkE0p+uOs9I+7kJNA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S+rZy2xHbC8gnHTfUZ0fuTyjHZFnWhvlsx785xOgbnTd14SJtZgv2nkgZx3DOCGNWpqVxCMxeRcQ4CJ7r6pjKDIu7cWY9dkYuFUIWRuXo7AhbiA0NZpI/fjdAVEWTUEN2QTAmp32IO81LOYs/xnD/R7Hxnrsz7CS/JBHzs7UfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIqeHcR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AA12C433C7;
	Fri,  1 Mar 2024 20:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709326336;
	bh=ssAqB+QWyIVQUkV1L1MYK1nhKVDkE0p+uOs9I+7kJNA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KIqeHcR4h0lUWYHgG3Dovb3IR5daCUGkpaQQNLw6KVzWeaUXDpt6zN5EE+FUbHRVX
	 po3Tz+AnKjA89cxnEGhieEudRf3WkCltnq98OlaiFeSgTVc+ZF3Rby39F3AlK+WZz8
	 buQ7lBngXnaYibD+PeKvknGPp3R1tBmRu1jw0U+MCzCa7RAO5CYZQGfoR6WS4m18qn
	 WBkWEGOwnz1jhwqgS0uCs5+lnIxrNGXoVa+2t+CqSOuUgF5xbhtTuHQJ6KyElP54QA
	 fGYsVHJd3KFUWcb9jgDRJ8cWZuliUTwg4bTeuvaYX4JhvOFWrciUB2uhZWUD4I0DR5
	 2MxapUOWeOKVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48990C595D1;
	Fri,  1 Mar 2024 20:52:16 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-17aa05c6-25a6-481d-ab1e-cd01d8b4da43@palmer-ri-x1c9>
References: <mhng-17aa05c6-25a6-481d-ab1e-cd01d8b4da43@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-17aa05c6-25a6-481d-ab1e-cd01d8b4da43@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.8-rc7
X-PR-Tracked-Commit-Id: a11dd49dcb9376776193e15641f84fcc1e5980c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d17468c6f1f49e6259698f6401b8d7a5b90eac68
Message-Id: <170932633628.15943.13364216292656642698.pr-tracker-bot@kernel.org>
Date: Fri, 01 Mar 2024 20:52:16 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 01 Mar 2024 07:13:07 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d17468c6f1f49e6259698f6401b8d7a5b90eac68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

