Return-Path: <linux-kernel+bounces-99481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8D687890E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F691C20C41
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950EC56B72;
	Mon, 11 Mar 2024 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtZiaEtc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAE656B6A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186189; cv=none; b=exU24Pw4cg/nmb6mH44ALQtXAa9APqb2qSj5wvuqTHgGJDDPFtll7PIPQhVAsGiVeM+zDK/6mDO8kWrLTuBuAHbhzUmZeJc1oG8sOdKsOZkHoOjwtK5TAKUoIuWdoou2e2KB8gVednBWT4z9XV3z5ILyDViI98XyJke8sX7v6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186189; c=relaxed/simple;
	bh=7WZOXQ3krnSBdIVMthxBkpKs10QqwLgC9vA9uVJCy38=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SrWiq0I5CZ6i+0DSMpjxz9Oc8KHqouW96iHmhm3GNVrklRdRAz02Fa5CfQnM+GgXmMI8LHJx1k3CMip5c+kQ2/bv44mXdJyDkiQgtWykcXq/SbTv2yTm75h34Esx5d8Xzcsn177Fa/hJ4VSnaUsVNsHcnXjxyf6VtP20hSJLQ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtZiaEtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1E46C43390;
	Mon, 11 Mar 2024 19:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710186189;
	bh=7WZOXQ3krnSBdIVMthxBkpKs10QqwLgC9vA9uVJCy38=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VtZiaEtcom81QlmdgeXGkcUy3m3S07hGlfWn72WWXsg0X/2E5HI/QGbGr6BHBK9gp
	 w0Pu2bWR/zLeb59XYPM9+muZuJfllpSsyjj8t8faX08KWwZDtzOziQI8se+FgoKr1N
	 SD+3Bn74HLcOKC7mFNr0zGaAXzNl+GXLa022WHrfijCffi7fBs7tBahkn5j5JVqQUg
	 kxUTffWvTNU1hVM8NBme/MescR/NvdrnVFCkZrn4R5Tg+fhQZ4Lc3vMFS9huWT0xas
	 VmRt7lJyjcUlQiRM09iubNS4lPkq+IqX22dqxWe8DqHPjizK1r+i90mfh90q8nqrFa
	 WyErbrbS2eR7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9481D95055;
	Mon, 11 Mar 2024 19:43:09 +0000 (UTC)
Subject: Re: [GIT PULL] Compiler Attributes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240309124423.326574-1-ojeda@kernel.org>
References: <20240309124423.326574-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240309124423.326574-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/compiler-attributes-6.9
X-PR-Tracked-Commit-Id: 2993eb7a8d34aee6165e1f6676e81cdf1d22aa62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a2a15cd7f91c4c065a8acaa36afc9fcdcdd4dcd
Message-Id: <171018618968.28701.9520824855488462660.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 19:43:09 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  9 Mar 2024 13:44:23 +0100:

> https://github.com/ojeda/linux.git tags/compiler-attributes-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a2a15cd7f91c4c065a8acaa36afc9fcdcdd4dcd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

