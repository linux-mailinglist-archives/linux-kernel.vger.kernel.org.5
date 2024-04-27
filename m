Return-Path: <linux-kernel+bounces-161130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2EB8B4772
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351B1283898
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 18:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FAE145B23;
	Sat, 27 Apr 2024 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dM8vjfpo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5171442FD
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714242491; cv=none; b=nroqGJPaBraAG8LlRtcCWgnAP2rH/lbtAGHRe+rQFLJa/PVUcxr/SaKtGFnCDWMDjLPZ3vawqIOcu9sAxDLzjzGKfBGeLz2w8I1oiqi8+8aXpPH5KyRQJlEcEHa8ZVBpqgLJHuCI8K3sFNFv9CXbCuoTuumSrp6iJNptsHyiQqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714242491; c=relaxed/simple;
	bh=0eVoFWOnByEzTR0cjHUtcXCUOolPNbXOEFRT33WgRgg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=feJ4KVhNYUM1LVjFEhpDMdBDN8U2cFmuyULIuaNBa5vHa37YNMq9ZcvkEs9fsA0NvlUw1mExBRafTXzI73T2xkobjUBMD1fKCVW/gGWKLKgkKGRMgV2699SZP97+6WEYjhZE/6YJjPz0Yz4Uqd4YKbOdYdFNk+Xl+JsFwdlGXvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dM8vjfpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97C39C116B1;
	Sat, 27 Apr 2024 18:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714242490;
	bh=0eVoFWOnByEzTR0cjHUtcXCUOolPNbXOEFRT33WgRgg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dM8vjfpoT/JoUGGtm3mpAJC2USILDH9xGds13Syo5cWO86lORkdB/ya6NE/e2SEiI
	 nJyPMmYUe21SMdiPGIuFadtqQKQzPysSGsI4Bq0cjQty/7NmL+0/BT69KT6cHGx9Bl
	 3Y4EtcjJoPopZHpkcr1UfoVoJttoWbB7OZ6GDPf0phGX8nbLY0JoyOB4QHQVL5Q/cp
	 8/vXv9kbum4xG/wDz2gJtWrjRZhGs0+YOmStEoPLFtXvVnGH6PXSS7kkZmCyr6tw76
	 Scj9DlWhMvOXME4Co88FnCCCzCT+tz59bm8gKvdicrImXmv8+WezR4yAy5Pi1rJG78
	 uNqzpk3p6qfHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86273DF3C9F;
	Sat, 27 Apr 2024 18:28:10 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZiyNohV82k_NTxKZ@matsya>
References: <ZiyNohV82k_NTxKZ@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZiyNohV82k_NTxKZ@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.9
X-PR-Tracked-Commit-Id: f221033f5c24659dc6ad7e5cf18fb1b075f4a8be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fba14a7b57ae06cae05d939d97319d719e64ae2
Message-Id: <171424249054.21148.12624789388279386968.pr-tracker-bot@kernel.org>
Date: Sat, 27 Apr 2024 18:28:10 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Apr 2024 11:01:14 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fba14a7b57ae06cae05d939d97319d719e64ae2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

