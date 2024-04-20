Return-Path: <linux-kernel+bounces-152349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C31E08ABCBD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719461F21181
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92703D38D;
	Sat, 20 Apr 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXud0biZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186731CF83;
	Sat, 20 Apr 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713637963; cv=none; b=KWf1lJ0LXmdFZLgf/hvdljjCxhua9/zh99ye4oQ8esuhFW+Pq+v0WmXN1DoWYCfkEl4nXx4Qf/LiFC12BrKjr4CTGwQNiA9sjknTfv0MGduyYgSVNcotWjR3fFSaMspN1AMbmjj8Xokw6jQ2kMjHOyux++yU2jhGT4pVetogTWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713637963; c=relaxed/simple;
	bh=F2CKTvNRlGZV0FEwEWnNN4K+ZYLmDjE9KwRcvbzGrKY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fW8yqouyqyPx8YpBKRtjC63NFEb+ZNQDjXHV+sv+PHGEsTAjODYSST2nVFLW0PwjWPDk3XTesJmPNpBoCrzRDRnR6sOStoudEcxHWQDNtO+AhGXrbslYfUwqL1N7qPrsfNhiEY4h2tx+zDPRGUL0P2iqYPQ972PlheDLZ/XYfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXud0biZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5F52C113CE;
	Sat, 20 Apr 2024 18:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713637963;
	bh=F2CKTvNRlGZV0FEwEWnNN4K+ZYLmDjE9KwRcvbzGrKY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WXud0biZU1EX2pFbSkuns+viWaQjDAvJNIPP9rcaBTVE073/Lflt/2R/4BnJcVQ5J
	 fm6MgvnI9RuBLMsyITx2rZsD4ONNf6TzGyd8vhP713kjrrxyBbQFRY2JXwxFBsyAKq
	 cDV+qZgVIYntA55S1Kyo7iLj2UAB9SnIegXYrPSs0kQ0hwApc42xDYZih9mlof0vcp
	 yxuaRDnuDVa346a/VYOeIBUG2SMHrraxZul03JiYA85lhJdHQo9KObxXfnElXE1y46
	 vHxY/cbogI4As3rNlYUC2mY3pvLjLMbLCs4jtdB4nLzKsUPKqF8kAXg9J8cdZjLlxu
	 pEdMp3TG3to5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD1F2C433E9;
	Sat, 20 Apr 2024 18:32:42 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240420014853.87829-1-sboyd@kernel.org>
References: <20240420014853.87829-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240420014853.87829-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: d3e8a91a848a5941e3c31ecebd6b2612b37e01a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 560d4e773850533794c02d388921077fb1407920
Message-Id: <171363796289.22086.9542743780784571092.pr-tracker-bot@kernel.org>
Date: Sat, 20 Apr 2024 18:32:42 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Apr 2024 18:48:52 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/560d4e773850533794c02d388921077fb1407920

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

