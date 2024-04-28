Return-Path: <linux-kernel+bounces-161554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EDD8B4DA3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE452811A8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493EF745F4;
	Sun, 28 Apr 2024 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd9aoq9H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880ED71B25
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714332496; cv=none; b=fwQlx3r63J1AKKGw7QYb8s1k9lA/oUGVTHFqSQ4UlpdXOaSLnI66q2TZPKa0/9AYgEvJLtPo8Q29LQRH4w5QPD6KBMmUxERxov2KXKevup5CaGdvF+4ftM2JPDnbn7CegbBuV32RGYX/drfcjENJ4UUOCleygbvowHpIotdBoM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714332496; c=relaxed/simple;
	bh=lRaDg/n/APZSH2BUPD4QX10o7rURcwqiKAezpoMIpfE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NL+PtaoMJNlpZXM1nfNcYhbjM1hrVejvn79OgrKfy2JEJ9KgDAEQkSoWa30yD33fs+LTDY2m4OnIqXie61YMp6bZJuVyT34WKs8xFh7bM+ibbhx0pEIiM8nqMbBFZ0N3PBIhnrlNADOpQPaCDbrhoWps1r1cCUxNGHhCV1I3Wj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd9aoq9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 647E9C116B1;
	Sun, 28 Apr 2024 19:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714332496;
	bh=lRaDg/n/APZSH2BUPD4QX10o7rURcwqiKAezpoMIpfE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Qd9aoq9HXXCKtQ/uxuul22mCKFr2wE15ujIYucTXvg2FUSx9M9pVihbtIljIL3ID2
	 +2HzKPGhzv18/Acpvqe2mG4+WnycKXJnSkDQufzJ0FH7TibvO30LGDztMfG4d6i0g2
	 h3/f27GFU4VkQCwT3kEYCqphTmSb+c+RdlCEBHpE3PAiMFYH0//MVJBjKJF7ocVPcZ
	 eH/69aJ7eFKSbZYhBua10sH0O9aZd8iDhJ7IEiJNQMApGlSy4aRcIswfl0lgIiTdcL
	 OhMqovr1XxlrQJ/MJxlJXHe/52BTTRcpDPwL80VuTgvfeGKMTO5jCqY9LoKqZS+LYk
	 /Nzhg3Rv2wmHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56F4EC54BB5;
	Sun, 28 Apr 2024 19:28:16 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zi4KAESpbiYDwXdA@gmail.com>
References: <Zi4KAESpbiYDwXdA@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zi4KAESpbiYDwXdA@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-04-28
X-PR-Tracked-Commit-Id: ce0abef6a1d540acef85068e0e82bdf1fbeeb0e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aec147c18856fa7115e14b9ad6a91c3ed2cf2e19
Message-Id: <171433249635.9908.8024704101138439685.pr-tracker-bot@kernel.org>
Date: Sun, 28 Apr 2024 19:28:16 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Apr 2024 10:34:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-04-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aec147c18856fa7115e14b9ad6a91c3ed2cf2e19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

