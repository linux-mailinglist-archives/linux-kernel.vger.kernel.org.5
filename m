Return-Path: <linux-kernel+bounces-126345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4979489355D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7626B285472
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93D2147C8F;
	Sun, 31 Mar 2024 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbBfGreb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55825145FEA
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711909251; cv=none; b=WwgdVfw+hSZGr4Js7ONl/XZ3Vk4gHmH99pHztDPLgPYqy2GUcEUQ8nm6+rq10PIe7fVoU0udGjvxCWM1koQZ1DpKAztWmSQQSojQq9eG0xnWiMGKG2p0xNR0d6N4bQpKSFDu8f3Q2IW56Lz1dNyMIF4tGaDhP32RTpekYBQpjPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711909251; c=relaxed/simple;
	bh=xGKEIcn1+0yzebaqAs6mbsf0cSkUPm4AlOYeFn9xNGA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tC1JDQXKZ3+kWIXj5GE6k0q3iJTnSCmbIch4uC5aa7DUmCnfIkvr83R6FcXzPOsaFNclJwoqubCqSBeRENrkpbGQ/WdWtNzEJ66j6BlEm4xTVQ2e/jRufEvDV3CeM+XpCMj8+8ij6Locd0ITPJN4FVISJmVRQ2SgSv09L4pypcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbBfGreb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 387F9C43141;
	Sun, 31 Mar 2024 18:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711909251;
	bh=xGKEIcn1+0yzebaqAs6mbsf0cSkUPm4AlOYeFn9xNGA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jbBfGreb/j6W418j0PWF9clAS1jh1ux68oX4CeQXpN0TxuHAWwHTfeox0IrD3jmap
	 zxcRWtZ7SD9wo6T5nSTCwbri4T17krUsUtSq8UlbryM5MGf/UcAwyT2CC8qW18wt8u
	 mRh5ALM8H9DZXduv/UqG/NCwmdGfUvBx/VB9aR4GJ4RL2hPp8BU5ap6bcSyOsQsf+7
	 iQSctVXmz0pytgZ4FHhvb83B/9VF2XBtr/OshpC3sNPyM2U4aiOzB1ATgx0ONhwofv
	 oN/Kh970FmoyKIst8YSp6/sE0xie1ugExB/l9EtvUbsQ7pC7AsAxuAoxQZuVMnT3Uc
	 fhu/nnHY8dmiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2ED7ED8BCE4;
	Sun, 31 Mar 2024 18:20:51 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC urgent fixes for v6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240331113654.GAZglK1jFAzgAFWjZS@fat_crate.local>
References: <20240331113654.GAZglK1jFAzgAFWjZS@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240331113654.GAZglK1jFAzgAFWjZS@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.9_rc2
X-PR-Tracked-Commit-Id: a6b227d70d2ad9eb08adc3fe532ebb7ec88ac897
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18737353cca01db58bb62256338cbb820c310bd7
Message-Id: <171190925118.27603.10428732595055521164.pr-tracker-bot@kernel.org>
Date: Sun, 31 Mar 2024 18:20:51 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 31 Mar 2024 13:36:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.9_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18737353cca01db58bb62256338cbb820c310bd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

