Return-Path: <linux-kernel+bounces-125836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC00D892CEA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E131C2158E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1514AED7;
	Sat, 30 Mar 2024 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZg3lKrq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1C941C89;
	Sat, 30 Mar 2024 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830120; cv=none; b=iqUOMqgbyQSuJEdcW+CcCPmuls4uT1F3OPpSw6Iyn4LWLHJnGyP2S4oPebSHnwb35hdldJ6gnn3sqDRFYLAB8FG3Fp9QM6YmqHm1liUrY10xLrm9ecszt9DF0KAqTLsNXiW6OSXBPlPL+GZSiV0uCnz3DajCURLbK0x6jbLGF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830120; c=relaxed/simple;
	bh=3CjfT30DAA1fHzaH5vBPCe9TcCMwmUifTrJCP1M0LdQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JzCIAy2llT6KJrejK+QXVktapy0Hz2w8MrZecnRukvFG52E3VMT4mpkAWXX9e0ZoitOi6JX52pZvZk86ygHQWnXi1HDo3iFqk9+YAmir5whXrs/lWjbcFez9XDUR3ZTGC1iQeM8jB9QBmXxTBvbNJAiI5yQVqYzVwUc/6d5qi0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZg3lKrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29138C433C7;
	Sat, 30 Mar 2024 20:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711830120;
	bh=3CjfT30DAA1fHzaH5vBPCe9TcCMwmUifTrJCP1M0LdQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rZg3lKrqmf7knlKegl7PsapbaxPXiQxAgYTat5VNDp1cL5Ubmz8vM1Ff5NaGsjySG
	 XszLBOQ3JgYK0aShyg5xJTVPCIhPeo+oklJMHwu4C5QTDkwDBBsrkEN+F2Xe2rpoPx
	 Q2N09JYfpqd5bq5YdhfLZ9ycXoBK7zwTPCn9Qh4qXFW4ciTXmEi9TlGqEJdcDNiuCh
	 dihp6mv/3O0JyVkWEK4bZz9Slne/hoJGVRLBl8e0fINZbWL65rCAkLRvCr/8Nb5gwJ
	 FsGStwhFhCxMWiadFrkTV85zQ+eHCE+ubRDvMbo4VY+/o8O9MXheUS22LJFrRVjQow
	 Vn06IHOXHCHsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 202BFD2D0EC;
	Sat, 30 Mar 2024 20:22:00 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fixes for 6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZggEu9MdSTNi-9FU@kroah.com>
References: <ZggEu9MdSTNi-9FU@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZggEu9MdSTNi-9FU@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.9-rc2
X-PR-Tracked-Commit-Id: f37e76abd614b68987abc8e5c22d986013349771
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e6e422985514f7469a3597dd3f76629cddc3d00
Message-Id: <171183012011.3897.18173114013707806932.pr-tracker-bot@kernel.org>
Date: Sat, 30 Mar 2024 20:22:00 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 Mar 2024 13:25:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e6e422985514f7469a3597dd3f76629cddc3d00

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

