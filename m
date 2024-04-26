Return-Path: <linux-kernel+bounces-160679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2E68B40F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2ED2B23176
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589AA2CCA3;
	Fri, 26 Apr 2024 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmvKcM9L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ABD2C1AC;
	Fri, 26 Apr 2024 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714164771; cv=none; b=C8SNyfAmmoEkURQmq8X0W1VdCh721DGP4PR1sTUYKwGPs0Jvb/YCXjel+tiugLyBmgcP1s4Qvi2GleiD+fQy3EAvoQYFd5UWj6+2UmLXvr6ZABmGP5fSWY5H4x1dSKxAZrWpgkSOx0UEwYBYI7zvaLhO8QxYWwC9HbJ/6KqyW4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714164771; c=relaxed/simple;
	bh=nNme6+G28RKhaZ5Az8i2eftMHNNZcfGylVkzHPSMbuI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ISuzlc/P4ziyMu+gNZQ6bQxdpdTxYvIMQdZfhsqt6fhgGqRgGW0KUkKV6HaX9Y2PAlCFTb6PJb3wy5xh9Hjt+LrqKPWJk5okBky8eu54/++jub3kH9LpfC+9vDHWVJsevg01aEFhJH1FoanW/Uok3N0m4CV+F6uEPGJ5PjevyuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmvKcM9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F104C2BD10;
	Fri, 26 Apr 2024 20:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714164771;
	bh=nNme6+G28RKhaZ5Az8i2eftMHNNZcfGylVkzHPSMbuI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WmvKcM9LpmQUwsvgaisLUCd/UW6+dNnUZStI17e8HwgI5WU6rdZeggoQO4DEihfM4
	 BYDg6F3JN3P2iFo6Er2OY0fBbfVoFdIEflCNoYbEynisb5n3VySiTB2+du+oFWq+Kt
	 B7opoO5vKHITrodPFedPT3B6Dr7hB5ttlKL7BM1hBpgWEO0W2gtX03/9+/hQVXuKN+
	 AFLsNRONiKaNvySBhAfygc/by7fKLRi2bKuqpQ7o3pLlk7SvGdIhAhOs14WDWkRuJk
	 0bJ/IhbObGFOqZFR2LrqFhRPLaGmPqUvAm81LcZj/gZht+chQsiPNHyAiFd/3JVebh
	 gvJfA1IRuwxbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64B90DF3C9C;
	Fri, 26 Apr 2024 20:52:51 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240426133713.02b077b1ddbf56bb81989f34@linux-foundation.org>
References: <20240426133713.02b077b1ddbf56bb81989f34@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20240426133713.02b077b1ddbf56bb81989f34@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-04-26-13-30
X-PR-Tracked-Commit-Id: 52ccdde16b6540abe43b6f8d8e1e1ec90b0983af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6ebf01172185d74237193ca7bb6bdfc39f3eaeb
Message-Id: <171416477140.3172.16607791024188967577.pr-tracker-bot@kernel.org>
Date: Fri, 26 Apr 2024 20:52:51 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Apr 2024 13:37:13 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-04-26-13-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6ebf01172185d74237193ca7bb6bdfc39f3eaeb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

