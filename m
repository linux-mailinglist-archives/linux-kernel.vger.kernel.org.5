Return-Path: <linux-kernel+bounces-105309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD04087DC05
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 00:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD39B20C84
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 23:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6471EB2D;
	Sat, 16 Mar 2024 23:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uU1YxNsu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8573FC2;
	Sat, 16 Mar 2024 23:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710632714; cv=none; b=OMle7VxWezVF/w9nOiaSrcauEM8/mI7Vzpyxo4W3Dik3/mFyCGlvSBSUeJQ1+sNegqwShh/n8dtsF/45aQwaen5otie5k/79PW/LcWbprgAr1c+hDmQieVq9Njp5z6/EpBikvjJ9dT71C8vDeBUq1DYir+Z4KNegCVEh3J3khJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710632714; c=relaxed/simple;
	bh=0VXEUegwQfPApZuaJWiwyJfCSVI+beIfXO/D1HmenKc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Rfvbgk1nfVU3HaSQezDup3V7K2eKkX6oB+vuZ8LBKyaFFxwBdqTDGyQN1OZPhdZv14hR+dIrpcmeGapGx3tw+aVz3CZoiveFOT08aX0f0EXOERv/wTcgXiQttPkiFcFQonYzNakHOToYWpbzvhUQLk3RZNcl3ieHbuubY5goRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uU1YxNsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 347A3C433C7;
	Sat, 16 Mar 2024 23:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710632714;
	bh=0VXEUegwQfPApZuaJWiwyJfCSVI+beIfXO/D1HmenKc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uU1YxNsuRhjUgGSbbFVeOfelPVLZIra4GrgB6iUE47fbMvpo5QKvyD5oZe0McLCZb
	 FRQ+gxwikr0bHtDDmx18oMqy0ADVH7qVbqsWCVM1RhmlCKd144wBcT64ASzUhJ/NEF
	 BGuDQMXdiT3yydDW9H0wvGn9Xb2GyFxuqsp2Jiu0ipQFRCXYa3vEQZdtj6BFULZU4J
	 97cG3YhXZtF2ECilzl8g5olo1urw6GxXsRvHcCh60vAuOJM/c2SPRpV3kEVMK++nye
	 1DzH5xhOb4xymidJtwCGpvj04Qi0b+WjA3U7rfKaNGmrvYpH5c7rSxAZG15E4V5F67
	 oWrbqd8SuIFSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D9C8D95053;
	Sat, 16 Mar 2024 23:45:14 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfYUBOSVxkFmcM8M@p100>
References: <ZfYUBOSVxkFmcM8M@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfYUBOSVxkFmcM8M@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.9-rc1
X-PR-Tracked-Commit-Id: 26dd48780bd2232a8f50f878929a9e448b7fd531
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 342d965376c5dafa124eb1c642d2fce043407cea
Message-Id: <171063271418.4585.12159820222745713627.pr-tracker-bot@kernel.org>
Date: Sat, 16 Mar 2024 23:45:14 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, John David Anglin <dave.anglin@bell.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 16 Mar 2024 22:49:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/342d965376c5dafa124eb1c642d2fce043407cea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

