Return-Path: <linux-kernel+bounces-107838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D35E88025D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6CCB1F249BD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CC220DC8;
	Tue, 19 Mar 2024 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVywMTv1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E220335
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865945; cv=none; b=F8gFr1gaXRHlFi7CpMRB/T357/r/2/R2N4ueGIHjp0WZAvRAbWvKkBHvfpPNyfD/RdjMAkthxtUEpcDDt6RJ5fFRa5+oZpHaARB3NeDpkYq8Hd9by9uODXbGZyJ/VOJm74RunuOlupc34moh3556/f2HVKrOW5J23N2H9MzE3JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865945; c=relaxed/simple;
	bh=thznYSl/RULrLuI/zS56kmqKZGuZNeDoORWBvdGwIrQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MTTLZppxGqm1RGg+waMiGLNYXa5ebJnAxgTX+kZPxjID02Usd1zpSIq5PJN1Wwkm8YSTgv7OT6mnI1QFNWM21ejhiG6R0bWh+DES4j8mHv5eQb60nA0XG+MC/AQVbLvxUO7BG7qVxs8nABo4fKyA20qSnBeRTLOceM1cHmm/vgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVywMTv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1588C433C7;
	Tue, 19 Mar 2024 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710865945;
	bh=thznYSl/RULrLuI/zS56kmqKZGuZNeDoORWBvdGwIrQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EVywMTv1T8LmU8pLrqbhN3KB0Tjxm1ynvn8vr9rEGry566r3cnlITHyEQT37ukb+M
	 7NCa+nkF7qP2B+ZoESetk9riut7VP51dlE3Joh/F9AZeQFaTJ703Pqd1V0wO+cc4p1
	 gu+TsE/l/294+dfDW1RcaollOUut83o9espjDZv+xeBCmaZW1762lOI4oPqWXUzTgM
	 M/JCLancaMXuMKPa/S/+GgzZkG+HMSHT9TCdL8QNyrZbEjWQdpaponpgGLmtsTDBDr
	 mQ2gitEHVHY24bakpDPG4A/SKd4CU43ga5aN8N1n4VZJnT+y4sEnbu3QpKE93Ca4UO
	 MxfXp4vR6x/Fw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA2E8D84BA6;
	Tue, 19 Mar 2024 16:32:25 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240319071022.7513-1-jgross@suse.com>
References: <20240319071022.7513-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240319071022.7513-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.9-rc1-tag
X-PR-Tracked-Commit-Id: d277f9d82802223f242cd9b60c988cfdda1d6be0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0815d5cc7dfb4a2c6d02a6eb86974ab3992b803d
Message-Id: <171086594569.7768.14518623666259076339.pr-tracker-bot@kernel.org>
Date: Tue, 19 Mar 2024 16:32:25 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Mar 2024 08:10:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.9-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0815d5cc7dfb4a2c6d02a6eb86974ab3992b803d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

