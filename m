Return-Path: <linux-kernel+bounces-41335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5741283EF00
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B6F1C2141E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E622E633;
	Sat, 27 Jan 2024 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSS4gSaq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADFF2D03D;
	Sat, 27 Jan 2024 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706376071; cv=none; b=IsUmh5Jae/sahkIkeM59wYXwH4J6Wg9PZEZ9/tl7LjPjUJ7rMTHI6E5tEXdAEBX4aYbkXIn5efMhYuOL2X064VeBRzdwE6L8DSRGyyx/dO980E5eC5Vo9D6R6HqCnHwhn6PrSNQ8TgV1MPXcI6QAn66Ac9mV0SWtN2I03QKte24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706376071; c=relaxed/simple;
	bh=5K3/h7eH/s5mr/TTQmFURWfuLJ9VAnLfDLA8E8qWbII=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SbvlRIaXrP6PEOW02XZF1FHf3HRMZSiIfLTUyn+7NoXLd0NhXsaewcVke+WYgTIMBkaNyisKiATrlxqaw2oDR9jiQpaMm86UG+/nMvFogRRqDLY0uZu8UHwf4e1b51A/Rk7Ie1dpAuGtKiIbtXTy2BzGiSDg0400jPQFcmRkMNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSS4gSaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A43AC43390;
	Sat, 27 Jan 2024 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706376071;
	bh=5K3/h7eH/s5mr/TTQmFURWfuLJ9VAnLfDLA8E8qWbII=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lSS4gSaqqaTr8zqZXXEsQ9nbyzB+YBMlNfds+4XtVULc4uPSixXmh28+IlJ7jTSKs
	 Hra/ZcVrFmd/yUk78Cb1MFbPwL+LfWi+Got4p5TLCDGAzNnz+HXlP6hMq/sWUTNPJC
	 Sn71IvYlNbshx63JUoBcqudWf/Vos6NxUp3qUKXORLEOY8UbyxOaOFgc1fKEpIi2Bj
	 yt9De5AkKn9DThoGT11sPwphIL6HcsDAFMWZN4H3XQIodYyUAuFFJJgwRN0dzLqeJH
	 k+J0aLmv5gLRWC08YlmwHqyVvC7uWwGhVjmd/68YxiQOdrsWRsRmaCgtVizR8gN0BN
	 xmPuFmN0GxXYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05B8CD8C97E;
	Sat, 27 Jan 2024 17:21:11 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mt0S22dHKCYSK2pMOX8mc+K9Dp+zV-Ocdy_15ZCHvdMWg@mail.gmail.com>
References: <CAH2r5mt0S22dHKCYSK2pMOX8mc+K9Dp+zV-Ocdy_15ZCHvdMWg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mt0S22dHKCYSK2pMOX8mc+K9Dp+zV-Ocdy_15ZCHvdMWg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.8-rc2-smb3-server-fixes
X-PR-Tracked-Commit-Id: ebeae8adf89d9a82359f6659b1663d09beec2faa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c6f6a76465a4c001770992867b0a4985d20f927
Message-Id: <170637607101.5716.8328877926273533716.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jan 2024 17:21:11 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Jan 2024 01:20:21 -0600:

> git://git.samba.org/ksmbd.git tags/6.8-rc2-smb3-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c6f6a76465a4c001770992867b0a4985d20f927

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

