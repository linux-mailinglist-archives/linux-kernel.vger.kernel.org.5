Return-Path: <linux-kernel+bounces-94272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED57873C58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B1B28888C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5715137925;
	Wed,  6 Mar 2024 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggp+Z8kT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9585DF3C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742811; cv=none; b=JJkEi5SJzCHk+0mpOosLP7/QkJN6ym32YHhfhc8D98bhraMLC9u/dmWNrzSGNkvIjtvVEKxhG0M9/K2GpN6+uYzjlpK0t4RGzbhFmlYr3znBJWJQGYL5/4h5v+poHCIG5N+IjhSVvpXweeJFxBlqZyhwE/EgCWDaCZi8fo9cLuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742811; c=relaxed/simple;
	bh=yRrw/OVP3a9xMUrNIdqSUoMp/rWyCFDwzWIj38MBYy8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k4Rc1Olp92j42GjVEhq/YZBmItL0IsX/WNu5/jgRJSVvEjuf/3gz2PWn7g6/k8gHKTw6isKNfRAR/v0I/giRN41UNvmGjJMA/jXRRVcDmwx5DQ0fEZ478Tzq6n0zyAZlKUzjtH50CWVPJGOktdp7GtFwvw+8VQALevmqsDunXjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggp+Z8kT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E913AC433C7;
	Wed,  6 Mar 2024 16:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709742811;
	bh=yRrw/OVP3a9xMUrNIdqSUoMp/rWyCFDwzWIj38MBYy8=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=ggp+Z8kTfs5CfZzB1FyAnrLQvhJIrxKSgii4N9ZtpAqNdDIU2mh8JMUJ+Euqe+zJ5
	 XH1p6cDIWtsRw8Yn6809/okcR73GxpT9HM4DTXurA5lv8gDMEwy3Er9gVcqTxwgwCt
	 oI0WyysDZgBXgWrW0kfX6dz28ipoXZvAxwssh8tBRFnRDs8MQo9xI4xMldUljvqLe/
	 0tl6gF387zkUwfPzbnUhzT7HekoyfGsTRlO4/fISHUAiwZXqdN68ahBRTyM+xMNjz9
	 Zptpu9mJIrTrhhADxWojIVABW2570mOGB264Mnrt3iKBiWMdkyKRTrskJOKl2imEwJ
	 ubDOHQyjoEY8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3AE4D9A4B6;
	Wed,  6 Mar 2024 16:33:30 +0000 (UTC)
Subject: Re: [GIT PULL] Arm SoC fixes for 6.8, part 3
From: pr-tracker-bot@kernel.org
In-Reply-To: <c3d1b525-7295-4da9-acc9-763f6b884163@app.fastmail.com>
References: <c3d1b525-7295-4da9-acc9-763f6b884163@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c3d1b525-7295-4da9-acc9-763f6b884163@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.8-3
X-PR-Tracked-Commit-Id: 1c7cfb6158f6678374ed42393b013b379b4c3964
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5274d261404c22b8b966d20c09b2ebea3cad7aaf
Message-Id: <170974281086.18944.16758702465169557656.pr-tracker-bot@kernel.org>
Date: Wed, 06 Mar 2024 16:33:30 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 06 Mar 2024 12:19:15 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.8-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5274d261404c22b8b966d20c09b2ebea3cad7aaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

