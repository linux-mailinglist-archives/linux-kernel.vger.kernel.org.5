Return-Path: <linux-kernel+bounces-69966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E79AC8590E8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AD91F21CB0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0137D407;
	Sat, 17 Feb 2024 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3jxP+39"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24CA7CF26
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708187222; cv=none; b=XqwpjTUqGP+3y5+1ZX1YHYUv0OGqBbTJkw8Z6N68+kLz53GwlIMYNaCd5kBtwEHPgqZP6DtfvlVSFxikMZ65It4UHyqYicMGGC62z96COTVaB2T1vuEbDYGYRPTK+2aJwxhzIpo7WrOoNe5QEJloWfpzfxgfhm4s2vVj+vsoO4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708187222; c=relaxed/simple;
	bh=UfP3JcMFoZJsGFLd2xcvHKLbkRGoy4oeSWglPMokk3A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Q8pcTTcwc5GyAUh/TFk049av4KXybNKyPgDtodsncYfa7mR2dxaKA8c4zZgLwJEVq+nIG48Cs5SfSyYK9AQl2XClHmFWCGOu4tJtEkwL5Ds4/L4SiN7sEPOkqDTGPc7VrGgXnM2SDAgMKFL5Rlfb+QP92QwXY5fJymkAlIBYLyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3jxP+39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F8E7C43394;
	Sat, 17 Feb 2024 16:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708187222;
	bh=UfP3JcMFoZJsGFLd2xcvHKLbkRGoy4oeSWglPMokk3A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y3jxP+39yEXDeiPX2hAlITorQ1Fka3Gg+9hrOSXg7tupO6OTSUFmd+ibnaF2yRsZ1
	 AIJsX/C3fB4Arzf7/SYOGZaglDegwo8bZj5VeYwMK/rJU4/fvyR5r1j/DpDdyeBCZE
	 SW+C/PRbmXWxNg7OWqQajTox7tiy4CKW6NQvYuwAdgQlHAbVaWg+CwtEwsDZDWUnLM
	 n+Mfu9Yq5zFl0iegpUSU9F0sZiM1ch0+/rcOPvsTsGi1YEf7VjW46qIqeBZEL0ETP6
	 ETjzfiSOp3uSllBSSaBwhT/Gyizv1ELeg2ZKd2Pk7DnulDvKAughNJcCgV1+SgD5H5
	 utPee6ziMJwlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D8A8D84BCE;
	Sat, 17 Feb 2024 16:27:02 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240217220911.b6be7031dcb84aeb99a131b0@kernel.org>
References: <20240217220911.b6be7031dcb84aeb99a131b0@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240217220911.b6be7031dcb84aeb99a131b0@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.8-rc4
X-PR-Tracked-Commit-Id: 9704669c386f9bbfef2e002e7e690c56b7dcf5de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad645dea35c1381890bb190f208f8e62c61e3cbd
Message-Id: <170818722231.7289.11602015252587066542.pr-tracker-bot@kernel.org>
Date: Sat, 17 Feb 2024 16:27:02 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 17 Feb 2024 22:09:11 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad645dea35c1381890bb190f208f8e62c61e3cbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

