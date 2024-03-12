Return-Path: <linux-kernel+bounces-100648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23485879B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E931F241B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488CA13A871;
	Tue, 12 Mar 2024 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO3F0/yW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891681386D8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267609; cv=none; b=WYQoVUxIFWwsls1lbkCoksN2kDT747XtEke5QT+3Ao40XqP9vQyQLK8Ol9lCrjLn5AK7guPRIRlgYAdI5cGT8ip1F6IpP75Ye4uJcLTbI+78bJMoLqwP6gXtIwk3gjKoCLPK5ubZpWh8EDf+mOEu6KMqHhEUDcXMj/gArKSNn6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267609; c=relaxed/simple;
	bh=ohggZDhUEcDJ1X/LH8FUhe9mrI6I5/FdUciFa7g9Bt8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jzdYHsmhmldTqlpYCXn/IP9dlixK4y24FfArRFI9xCQerYj76iUezpTLI6Y/ldfwbsGcm3m7ajVrG5vvspvbuK/lFK1l9+gZxY0TYsmavlb7rHzkz6IZgPHnKlMtaqGg2ZPedGvsxd705clu+mU2I2xh3lsPZbcwMXtVdYjUUj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO3F0/yW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0788EC43390;
	Tue, 12 Mar 2024 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710267609;
	bh=ohggZDhUEcDJ1X/LH8FUhe9mrI6I5/FdUciFa7g9Bt8=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=NO3F0/yWCz44o/x0kTUOkSTHqi6KyWs4xnntu0ekJCLRQ0UUlRB0CS20ZSD7QV/ND
	 O8iLiu+nM/B1chiqjEoHsZ2UIVg3mfx0KuQGGFIy41A5ydIFLG6TA12CKTuyMPKkG5
	 2OznrN1O6eqn0thj+wmeV5CRt4aE2yvjWf7y0fosI1Nwif5zmkXODnSKBHG6SvoDfs
	 GGzn2ce3mCFV61DR/mk1rkxXYuxrThNpylfJQzxfqbu9PLhdEG1K1+Je28vd7eyWYL
	 L4fCkaZyzDbYY/LMq2kOcgu9raeGYiuYp8yZ0+XnffAUzXbDOWXu4O6UKNsq2hbDDi
	 gHLkWwqUKrftw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC656D95061;
	Tue, 12 Mar 2024 18:20:08 +0000 (UTC)
Subject: Re: [GIT PULL 1/4] ARM: SoC DT changes for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <5a628e85-33b5-4fac-b650-3ff9e1833df5@app.fastmail.com>
References: <89d0bb77-a608-4ae0-b9d9-e17fdf5f12da@app.fastmail.com> <5a628e85-33b5-4fac-b650-3ff9e1833df5@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5a628e85-33b5-4fac-b650-3ff9e1833df5@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.9
X-PR-Tracked-Commit-Id: 59f33701fd1c5970b875ca5ce4bf1db6e4740d6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 306bee64b73c92f43df46db7e92621f3309fd28b
Message-Id: <171026760889.25732.16769287987447910822.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 18:20:08 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Mar 2024 17:43:43 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/306bee64b73c92f43df46db7e92621f3309fd28b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

