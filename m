Return-Path: <linux-kernel+bounces-166690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C7B8B9E2F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47071C2376F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E3115E200;
	Thu,  2 May 2024 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv6JmAHu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2DF15CD7B
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666081; cv=none; b=QsIDPLl5XVQLEWJN6taPirHM27CYoj9P25qPoU0vOeN2Cfcfz4ZH2nrgxMzI9zkV3uKpqcpXUEe0E7PmJ6UA+a0siHukOvO43NWS5z6wyEY9N8rNnBO4NEQs2r4PRekv5XV6BfhFvjnJHqOR+laTRsbzF1h4rmwPOdMQymYUE8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666081; c=relaxed/simple;
	bh=iRsnJLmrCIZnwjyX/JQ7u1L8B7cbmDRFF7+V84hfFW8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aes0t0QQLfDQHUOgfSrqUHHJ/GHm5EpN4vSk7EgwB9lempAv0UcCydNQZxezxYHOwBcSYtmdayUnsIDcSOZPaKrBHf6H8NTqq50014Afe7rVMhCu7rA02Q7aT90uLfK5NNMk1lDdxON3+PUJQ8A9lRT52LyPerfMeNt6Zis3CUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv6JmAHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FBDEC4AF18;
	Thu,  2 May 2024 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714666081;
	bh=iRsnJLmrCIZnwjyX/JQ7u1L8B7cbmDRFF7+V84hfFW8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kv6JmAHupnqDKMBSTzAn2oiQ0aZNovyZJ2UX2Mg6LIoHw0PCZ9dWRBJx+8+QKStxO
	 OU23jRVz54Sdz5dHUGCB1atptEy9sVfWPF7OmiwbQ8Qvv49N9Z2eyGVwMyYmsu4dTl
	 0fY4CDa0MNYzY4Vy8KHsxZA2B6ARl0HrVchCj4uX8vUJ8XWXYsCsLXxp2cjjeFKZk6
	 9vCh2DXnTsQ/Nw4fB5/8nl2frD4ZswXajky15YLQHOrytO7XfGex2QAcChlNBV/+iQ
	 9dZ62RA5QGffura8QBUb+4ECTaMAN5j0hUKwBwWFvmQfiteBtTdsEWrnoJwLpU2Qwf
	 aVF2W3k3ox2Eg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62C75C4333C;
	Thu,  2 May 2024 16:08:01 +0000 (UTC)
Subject: Re: [GIT PULL] firewire: fixes for v6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240502120657.GA121265@workstation.local>
References: <20240502120657.GA121265@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240502120657.GA121265@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.9-rc6
X-PR-Tracked-Commit-Id: 09773bf55aeabe3fd61745d900798dc1272c778a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49a73b1652c58ef2a81776a12ad9ac0795f38de0
Message-Id: <171466608140.26603.1114407251111793135.pr-tracker-bot@kernel.org>
Date: Thu, 02 May 2024 16:08:01 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 2 May 2024 21:06:57 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49a73b1652c58ef2a81776a12ad9ac0795f38de0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

