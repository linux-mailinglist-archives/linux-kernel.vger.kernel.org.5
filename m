Return-Path: <linux-kernel+bounces-160712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AD68B417C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCE51C216A8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FFF37163;
	Fri, 26 Apr 2024 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVWWfcQw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FF82C68A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714167902; cv=none; b=QtyBwl3+Wqs61A1leSZNH8jp2Fm4uld5IpD42wZUoSdw1Ls4GYS8b7spc3m2RwUE5BO2/1H62jIUpY5HovFTU2pnokNNVmIIxCqNe++sUgHVxCHp0wi29Ci0xLP1qiJ3w89XJxHxam0nx7ljVqySob9BExb9HVZo6VJcOIOKfCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714167902; c=relaxed/simple;
	bh=/qcGTdfr4O698qMwd7hcjvNAVzoZhkDfEMJDy/zuCO0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Mt1VsMmeUIcezNGo/rhdZG9yEJsnmgbAF6bexWGtP0nJkH2QAHsN4p4UFLetEQUdwGP7JWzPtLOjzH9Rm5wiLLEo/cLs1/xjMH+lWm7HNhs6WF8ZlxZwCpXOTuWsDtmCWnpXp19DwWMUEsgDw3qFimKcNFBvev5/Xtx923HVSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVWWfcQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 101F9C113CD;
	Fri, 26 Apr 2024 21:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714167902;
	bh=/qcGTdfr4O698qMwd7hcjvNAVzoZhkDfEMJDy/zuCO0=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=hVWWfcQwKJ5IHJFfoujXgLB9ywzrwiVYWUXRDCBG20EJYC8nkTWOmGdWUP87oBc2m
	 CFKazm8V0EGw1Jdl1t+x1mEFB1F7OM8gnD52qgib8auBxfrHcNsp0uVaXanhfwOMNf
	 G8ph7NSL9Y1QJHEc19vOjEol7QQwkyFTlNks+WJA7FxCxVhprUZLcr9qJgccX4I9qb
	 OxeWndiNjuyj3Y4wguheT8/c/Z5owbENiFW4ctztrdhiJKNq3gubwR9GjKFxVchyal
	 T4IL+WRZRhOkMB/vfiykaa8aC9/Es3nlA3l86QDVtFViaNbvkX0spjQd0+ejORbpti
	 mfXvqUYJu7HbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04BEDDF3C9C;
	Fri, 26 Apr 2024 21:45:02 +0000 (UTC)
Subject: Re: [GIT PULL] ARM SoC fixes for 6.9, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <beaae28d-c6c9-4117-adbc-e8ee614c16aa@app.fastmail.com>
References: <beaae28d-c6c9-4117-adbc-e8ee614c16aa@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <beaae28d-c6c9-4117-adbc-e8ee614c16aa@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.9-2
X-PR-Tracked-Commit-Id: 9f26bc71b1fd895e22151e63934588e5ddb11b05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5eb4573ea63d0c83bf58fb7c243fc2c2b6966c02
Message-Id: <171416790200.29117.17418634709071104918.pr-tracker-bot@kernel.org>
Date: Fri, 26 Apr 2024 21:45:02 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Apr 2024 23:00:07 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5eb4573ea63d0c83bf58fb7c243fc2c2b6966c02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

