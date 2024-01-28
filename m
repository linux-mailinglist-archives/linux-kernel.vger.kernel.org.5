Return-Path: <linux-kernel+bounces-41888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B2A83F935
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3291C213C6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB4A36AE1;
	Sun, 28 Jan 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJD7QAXA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F48431A82
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706467641; cv=none; b=sZ3NniKhKwDhhN/Ivs4b2s/s7qFjMPPvg/PLYcJccmJ1VzG7I0OwDoxr+pU8NklkY1+JGMM777+SCwYBos7m05qozI1z37HS0MxIUuXVPQ6BWwKKY+DF++jVMnCmH76krfdTvJ7U4dSBl8HA8NxRTlZIAtLIQiUFnr4S99/UuQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706467641; c=relaxed/simple;
	bh=pDUXiW01e1HitfQcY7PJylNRYDNfWAO65X30Vh+HJCo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rzloZ0HF3J+OXIxAse27mnwUggCqJRfGl3hSWmFA6TfiAzKtQlpMkRxTxacjftPwVGiMY3PjyY4+rFMo83Mq88tEAVDrBQjaLdHtBg5oaVTPcyqh5Is6b1rfpJvUhufBXovLSQmds3Ue0FeCBhmSY8rTPPjWnLO9X3k2wfWUaQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJD7QAXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D0FFC43394;
	Sun, 28 Jan 2024 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706467641;
	bh=pDUXiW01e1HitfQcY7PJylNRYDNfWAO65X30Vh+HJCo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EJD7QAXA6sX5wzUdphCg6L2/SaQVhJEEGxUXUQftNa6NaIU4IjviaZ8pEVCdFFpxt
	 L6t30M8KYzqOjxL/5syZK0UjRDj1cT0JbLpP1NP+IZQNEsp2szTgqV/tuce+F/BaHZ
	 Df++Jw0e659/QcuVZKvah3CZP9uLdlXPoSfcNrEEGVCB66wDuYL4J9bz/M8nZslbJf
	 OJejNI8/NZCr29CDNdI7p4VT2HEIcmU7l6S1gen7QAoTOjYcte2y7qYOMn+MyIBQ/i
	 ZKwLQvLlNmrCS1GJn8X5nJ4sRfIaZqVremHGyzbjJYPEAVdkVtQo2yTWyrsYwkffCO
	 FoAc87FPG32IQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42FE3DFF762;
	Sun, 28 Jan 2024 18:47:21 +0000 (UTC)
Subject: Re: [GIT PULL] memblock: fix crash when reserved memory is not added to
 memory
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZbX3SHT2H_aqHnGW@kernel.org>
References: <ZbX3SHT2H_aqHnGW@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZbX3SHT2H_aqHnGW@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2024-01-28
X-PR-Tracked-Commit-Id: 6a9531c3a88096a26cf3ac582f7ec44f94a7dcb2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a08ebda97e2a32b8f1de2c8240337f726c2e1ba7
Message-Id: <170646764126.17624.8074455784205942166.pr-tracker-bot@kernel.org>
Date: Sun, 28 Jan 2024 18:47:21 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapopoprt <rppt@kernel.org>, Yajun Deng <yajun.deng@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Jan 2024 08:42:16 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2024-01-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a08ebda97e2a32b8f1de2c8240337f726c2e1ba7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

