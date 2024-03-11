Return-Path: <linux-kernel+bounces-99623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7914878AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97741C215EF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF6358AB0;
	Mon, 11 Mar 2024 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qI7I57+u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1083B58129
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197078; cv=none; b=uNbMvTdNL/bNd3KtohVy6+eIiGXtgUTmnOhR/P9HiGTK5zOUHk3iNyjItXW9tE+k5uaOggrMlJKgxNyxhA8wDlm+wf1kuSBn/3++dQPCvQsSGjV4i3NRSl+AmB8062Q1GLTOrZEqfF5NBDk1BNrCKdEEJ5MiYFXRqoEJ2y/RR1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197078; c=relaxed/simple;
	bh=FO3kAzOb/vnDLKoEKUzpsteVimHIhIerlLdOoPtzrQc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZwOcTz7PMJ2yOUC27CbaMFRSa4KJ/n+BMK9jKjhx6FG/M+9y6u0kFFdL1HGT2TwGwT6OhMvuHIdiXyfFCC0GQ1LiV3WdqIEXxsw8tJhdTzmrmZZWY07fMKw33vk8bMAUjh2Mwr/DGyRPMCwcU6vMvEWpD8U0HLbyFtpwTA9Zbag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qI7I57+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C7F8C43394;
	Mon, 11 Mar 2024 22:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710197077;
	bh=FO3kAzOb/vnDLKoEKUzpsteVimHIhIerlLdOoPtzrQc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qI7I57+ucBAGKn6akBRRRUjQ2CT79WZnaYqPq0imV4v+FQo1JXLqakGcyMlzlqQWk
	 hz8Fvf6RB+BpTCIiIhJsnAtcRI/DjW8NNMG6YrJbZ6ywnhTDsKUdUlOYxPCmoXXEB9
	 VC73tjUSLTeUVs43bk4vzwHwTcll+sXAEHCw52sgcaP2FpCkBLmBaOUpfzK0U7Y6q2
	 KXZwiNmflyzeA7Q7K45ogP0RAMrdN8xVnHFr/ESwZi7g3gTnE5EmlxpO9CsS4brnRR
	 g1HeSWqajISI3BEQSj9BJySsFeItsKa6jiX3VE79OtOjphNJxcM9fAuzjjD8y3JR+c
	 iPhzLfrs8HhZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7755AC395F1;
	Mon, 11 Mar 2024 22:44:37 +0000 (UTC)
Subject: Re: [GIT pull] timers/ptp for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <171011361885.2468526.7938950392542631632.tglx@xen13>
References: <171011361246.2468526.10740060923051583953.tglx@xen13> <171011361885.2468526.7938950392542631632.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <171011361885.2468526.7938950392542631632.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-ptp-2024-03-10
X-PR-Tracked-Commit-Id: 27f6a9c87a97f5ea7459be08d5be231af6b32c20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80a76c60e5f6361c497d464bb6da6ea07e908a0e
Message-Id: <171019707748.5315.15631978930950190665.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 22:44:37 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 00:38:57 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-ptp-2024-03-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80a76c60e5f6361c497d464bb6da6ea07e908a0e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

