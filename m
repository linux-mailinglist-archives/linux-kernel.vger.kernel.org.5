Return-Path: <linux-kernel+bounces-99798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB40878D81
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD031C2162F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1870ABE6F;
	Tue, 12 Mar 2024 03:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHhkqBWJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCCDB658
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214356; cv=none; b=MliwpI9GwURYuzAasPWovBtunzLqULkQiezDqDPkUQyQwGt2OOZU6rCdzj6QIqKvg7HoR6PSUn8QzgqTt9tD203dOjFEen2jS8rABT0dabfNLzZiUNJsVEA7tYskHiSXhhbOnhtpZ/vWSWRkfTHG2wa4muZqo+cALVk2qGhx4t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214356; c=relaxed/simple;
	bh=CfgJRAzCFSziHu9AYxm/Cg8WNKqbdoXXsjIrxEIA2KE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DK5RDtDrK98oiTEf1hpYNbySrLUeztSr9ai7n05jtWulF+CS6ewLCF75l6mmEUMan0TK0Pm7opU69QHqV8AaM4BvH+Tt+LUL8sDEijGjtpVsEk3oPX2n2hJMpG9sARQn3RLwUQIaxUR5JaLeEYrT8i6v2A1X0mX928l+M6KnosQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHhkqBWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38E4DC433B2;
	Tue, 12 Mar 2024 03:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710214356;
	bh=CfgJRAzCFSziHu9AYxm/Cg8WNKqbdoXXsjIrxEIA2KE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OHhkqBWJakjNhMowx519fNwlJ6Df6mrMkPjbXq9kRyFS1oPkf1e/dS10CN7QyN6t5
	 ISha6sHltPPhe9SOif+4qghxWMWzexMCHqx2rNZti3R8nhX9wHkt4QLJsB2vyPzR6K
	 3griEwUw6x0s5hqn3olORSu4DRkhrlq03JETEZGEHXlo9WbMZ6GncjohD55gq8gNxp
	 ntOqCVWKyMgsNBDEooQmNt0Bf80wgI/cjMiohC4WceRGCgg7rKlprPAo9UiHZ2Q2CS
	 FNXvLvFsa3iWVO1vLyE0BsMi2zP7spOOTOuvg7Dz8L5M70iWkXEUIp+0PW6WEJzZk7
	 TFEDreXDBh8BQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1ED0CD95055;
	Tue, 12 Mar 2024 03:32:36 +0000 (UTC)
Subject: Re: [GIT PULL] x86/build changes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <Ze756cuF2NTFxH3/@gmail.com>
References: <Ze756cuF2NTFxH3/@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ze756cuF2NTFxH3/@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2024-03-11
X-PR-Tracked-Commit-Id: 103bf75fc928d16185feb216bda525b5aaca0b18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d69ad12c786f0a4593c48c0658043aa4a5116b09
Message-Id: <171021435611.8573.14644599656655827314.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 03:32:36 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 13:32:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2024-03-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d69ad12c786f0a4593c48c0658043aa4a5116b09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

