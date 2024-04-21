Return-Path: <linux-kernel+bounces-152544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98648AC04C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D751F20F47
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 17:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3524C3F8ED;
	Sun, 21 Apr 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBMcYqDw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5123D548
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713721018; cv=none; b=YLsdsRdzFvmZcE5Lbx+eqlQNJT3AH93v2QSrrnhSYQR+BP3llr4ZA7CTPqRf+PQQaeDuoJ5X+6Dv2f58uSzR/btaQmXEnmc0WKk7HXz5Q2AChzIuzBNYbyQ1uB6CTTWxxfMIANnJMoxyaRcMt+jdPaXiwn2NkhjmBU6Eh7v9Gu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713721018; c=relaxed/simple;
	bh=VLQ2RiHKj6ba844TGo2H7jXImhiJKfyB0QgI7oG0P54=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JrWUc/GPbzPzFHySM8vP3OudHosDJLLNEM2VjCtbYVnEbsmcuIZvqFYa/5nA4lk2EBbYxDS90lkiSERBWoN4Dd71DNUVI6Mfm4nlzLaY1CZKwvl9798usLNraZkjaBM4Kbce2Zk9G/UoCPVh1V/eNEwNvo52IAOELgGAiiCTeYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBMcYqDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EB5AC32781;
	Sun, 21 Apr 2024 17:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713721018;
	bh=VLQ2RiHKj6ba844TGo2H7jXImhiJKfyB0QgI7oG0P54=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FBMcYqDwuUL1XonD391jjBe0F/TdO45Eq819OUfvUuCYowC2k+YQp6A8DDidKiAIr
	 cZk7lTd/xn6JoEt2EB/VY8osfoLT/nZEr7jWNlIA9vFVKEQ3XUxbiM3YYlq1fSBHoo
	 iR2EYY5/26j6GxeKIgClSKfEWJSrz6eFBsFDFDF8pF/aM3/EfR+NGux8TO4srz9PDM
	 cmm+y7HUmVv4f/jM2HE9h2UALNatCJTPI6vTS2WGoJtbEdjn9pgZfO9Dmov+C3Y9tv
	 VPepECMTfw/CJETOiDIoseb7/XBaxcSK3K4N4RMb+ZekphnDtAjOVBYyePi8MKr2zL
	 mR1Lr2ohTnGHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53971C4361B;
	Sun, 21 Apr 2024 17:36:58 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZiT6ed-F2vh8sCwP@kroah.com>
References: <ZiT6ed-F2vh8sCwP@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZiT6ed-F2vh8sCwP@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.9-rc5
X-PR-Tracked-Commit-Id: ebaed6d4def877d2035786ff318379eb750044c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48cf398f15fc3b2af11c78fed548355d3b66ca11
Message-Id: <171372101833.14492.8115727433156445376.pr-tracker-bot@kernel.org>
Date: Sun, 21 Apr 2024 17:36:58 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 21 Apr 2024 13:37:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48cf398f15fc3b2af11c78fed548355d3b66ca11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

