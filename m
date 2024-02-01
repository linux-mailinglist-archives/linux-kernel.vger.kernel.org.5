Return-Path: <linux-kernel+bounces-48841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB8784623E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF391F26132
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6276A3FB01;
	Thu,  1 Feb 2024 21:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfPcXsJ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620D3D98A;
	Thu,  1 Feb 2024 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821348; cv=none; b=F7cfwzWe6elu7pk0QG/XMb25TPcu+uHwY+FYiygeUr0/fWpwHHnswRPjzJF1JPZDTqVQcPRFtSaJtnJdDAKSRZ0saLtIkkvRbOdAgeb+sTf9wjm6tlIStHEmB+hhP2Fh+94IgJKPJ7NbeiUHhI6PX2gXlXtLcqRgaHPAKtaMIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821348; c=relaxed/simple;
	bh=ZTKbt4f1eH3a3kzUZlj/w9KYr+abOEZN9KBvFmYuMSU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PFtSae3vlXMuKawcxhL5YPGSMCLTwYfR/cXLJszWfpuQ1iw5W86tAL7nL/I8TGrI8G6GBqhMxGlSC6AQ+176NcoDj9e3vjWj2JCSp9K7WZd100+0l1diQd6w/kx/xZ46VMWjZhD5K4vwzR/RkfS/otyIe1S8HQ1yY01pCXHj9a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfPcXsJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35F34C43399;
	Thu,  1 Feb 2024 21:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706821348;
	bh=ZTKbt4f1eH3a3kzUZlj/w9KYr+abOEZN9KBvFmYuMSU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DfPcXsJ9xflvSuyZ859JeksxoHaJ7+mfmnaVLIfRen5zzE5cf6hXT5799MxERReN7
	 wU1GsnDHBnyrDMOg9PUPRIMjfyyMxxwxbyzg/djQuS+KvMxDCRFmPFdcycmZrF3Ji8
	 fbfCviB8btABCBJUSlfa3Ek88gUVqN8OE3oBRwzMA8MVoZiag2sLlBfT1EDqgLffri
	 0P5rd/1LbZYVOCU2odRjb52/XGds0ewWt1a9uCY5sHn21QbCTxv+t3ao+c0qnm+NXR
	 gfAl8tkPxqoEvxHaa3cnaa15s1Gq3irH8nOYt1Nt8ngyJCQWZkPTJ4sBjuFvMxuQV+
	 FlmNbsmFUft+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2323AC0C40E;
	Thu,  1 Feb 2024 21:02:28 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZbvBzWJ5k5TnpRSW@p100>
References: <ZbvBzWJ5k5TnpRSW@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZbvBzWJ5k5TnpRSW@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.8-rc3
X-PR-Tracked-Commit-Id: 913b9d443a0180cf0de3548f1ab3149378998486
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91481c9092465d68bcb4540ac0dbfd65024a0170
Message-Id: <170682134813.25707.6966961786518888920.pr-tracker-bot@kernel.org>
Date: Thu, 01 Feb 2024 21:02:28 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, John David Anglin <dave.anglin@bell.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 1 Feb 2024 17:07:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91481c9092465d68bcb4540ac0dbfd65024a0170

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

