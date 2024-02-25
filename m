Return-Path: <linux-kernel+bounces-79908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FFA862889
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 01:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B311C210EE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 00:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6B563D;
	Sun, 25 Feb 2024 00:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwdyMir3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBBD624;
	Sun, 25 Feb 2024 00:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708819685; cv=none; b=D0H9z7nUbh6Zj3VNsv8oapvPgYycSNtXReDF+MyG9UBUD+rwy61t0nDZiC0nNj4jLHrmTmXXRxMc8e4+poiCRFvalgxR/cwD0njzaHdJzP+YpRIJSywsrrXniD0eZZU5lpEwj7Mx/Hp/7k/33F0DklEmdwgRW19v7lSyEj7MJOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708819685; c=relaxed/simple;
	bh=yrY8Nr4zMfHxT+8/AsEaLdiLFsn/sLn2lQfmB0dp//w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k5rMg6YZBExuaT2b+gmIA71is6xJN8zpTyx4F6WBOf309clCuJ6lCWdWPxrbczRRgQ/jZL3yapTPbBIyu8WlTuhdZktGJL6aoYCGcx7FEBBKUnYyt8zLVxmp0XcecOEAUSiUEK49NFQf/WVTEipETuJdTkoEG7eysJlIX6FBWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwdyMir3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80634C433C7;
	Sun, 25 Feb 2024 00:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708819684;
	bh=yrY8Nr4zMfHxT+8/AsEaLdiLFsn/sLn2lQfmB0dp//w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kwdyMir3t+WTSW7ngPQY5wszmdFcrK4Af3b27EsAxZdNhxzLx2kb7eJIxijYopTV4
	 IVHGNzJ1OktmHtf1LZ7HcVUCIf9JPo12dIkiYBh7HkG9X0gSY7fzH08l6GAZDZEC6O
	 0Js6ePID+ha3KG0nTlJc1bWf5iZRdOw8wDjkGTD1KvjWdfBJA+YoLij9RzR8dVYbDY
	 cMoG+fxSVeC3Mmx7m48EhZzJ48HKEn8FTku4O1iMPlJgquj98h0TFzfxIEZajFvrn2
	 XoOxeoqIoWoT1rBOkEzbD2lkMiAmHLqPbQOfX6g0VHrwGAAaBM9FS9BNtTM3Ml8hOf
	 CpjKnhbXHDlaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D05DC39563;
	Sun, 25 Feb 2024 00:08:04 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZdpoYsivgpf_zdax@8bytes.org>
References: <ZdpoYsivgpf_zdax@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZdpoYsivgpf_zdax@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.8-rc5
X-PR-Tracked-Commit-Id: 65d4418c5002ec5b0e529455bf4152fd43459079
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91403d50e9b133eea5fb48e473c6f7c9968341a4
Message-Id: <170881968426.17738.2644658337200785466.pr-tracker-bot@kernel.org>
Date: Sun, 25 Feb 2024 00:08:04 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 24 Feb 2024 23:06:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91403d50e9b133eea5fb48e473c6f7c9968341a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

