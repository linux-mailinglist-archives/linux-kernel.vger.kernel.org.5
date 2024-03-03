Return-Path: <linux-kernel+bounces-89852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E0286F686
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 18:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384EB1F2162F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF7B768F0;
	Sun,  3 Mar 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Baxxyjdo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1D7641C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709488771; cv=none; b=XXPuQkrm2WBvDqhjQ11rXAn6+uyEA4AQBq64OLeaMl8dU+VVcBIqEG7joDZdOQ3G4YsiBUntYNxh9MxNqrcIDLmlCUfQTpxH5661o/0Me15+k5PVDM/T8dK++JfSztR2tSOX2YMNx5sTmFo3m/rGV0pQCFOnw3UFZhI9BYA5HAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709488771; c=relaxed/simple;
	bh=Mx6zMpWsskUhKKt2fBNSCfpyLsnuT2GVgtg/5nuD7Sc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ttTdzgaXk789Ylukzdx8OM7MRZzGwmiqTqnPlsceEVFtzUFQdL0AkuPXg5m88bq5kElDHxJ77fYf0ws+W/MpwzyEdZyhfzyVl0qbHT3u4DI+nHtTvuJZllsrp5uEbO9Wy9HhwAJYNQWQFuYhh4dmoq4GmSVBsBzBjPJRwjwCIX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Baxxyjdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DD86C43390;
	Sun,  3 Mar 2024 17:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709488770;
	bh=Mx6zMpWsskUhKKt2fBNSCfpyLsnuT2GVgtg/5nuD7Sc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BaxxyjdopV9pLlcZFyvCrX72z3nKcdES2QASFMprVstpMvw+yA+CQt2UC4DWD9iL8
	 BkCe0uh9wCAWDHZ+ZZPqgkvr04a/cKwnnPjLkMt7aGEbaMqUj0Fv7tmdbJZtDV9yvv
	 aQ+KcT79OasF/7sTto0LycoEBrukiJusD/G0/jAnkffETlz6b0mWpeViGkwMNhDOwG
	 1myUkATJCuanRexTEXoWNpcQgd9s1zI2z5Q3hRssx2pb0IZKtUd7YPU2GQfwMxsX+H
	 2UA3PGQx+35ifE/gL8cQ6ywMUlSI+qiFAirujlBYeGm8GepKfuDDkz38lsCoXQCASM
	 tPxOcwD9UNGCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5775ED8C9A0;
	Sun,  3 Mar 2024 17:59:30 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy fixes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZeSsuy_-5k7ibvgI@matsya>
References: <ZeSsuy_-5k7ibvgI@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZeSsuy_-5k7ibvgI@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes2-6.8
X-PR-Tracked-Commit-Id: d4c08d8b23b22807c712208cd05cb047e92e7672
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58c806d867bf265c6fd16fc3bc62e2d3c156b5c9
Message-Id: <170948877035.21543.5446401310363803653.pr-tracker-bot@kernel.org>
Date: Sun, 03 Mar 2024 17:59:30 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 3 Mar 2024 22:30:43 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes2-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58c806d867bf265c6fd16fc3bc62e2d3c156b5c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

