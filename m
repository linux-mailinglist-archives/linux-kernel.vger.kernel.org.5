Return-Path: <linux-kernel+bounces-29522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0F5830F93
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D351F25861
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456CC1E891;
	Wed, 17 Jan 2024 22:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P70zVZIy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1C1E887;
	Wed, 17 Jan 2024 22:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532291; cv=none; b=Md1f3dNLJTTuTKR35eJYY0XK0GK2qTwSI6fqewU9EIKPv/MctmhTDPVkJbCJuEdlwzHxvRtahmp+s4iQlE/qsZbuWD7vNWNxPc8+q4yHVvQOB5HAQa/JOc8MI1GlqX9uIVGhuym910Z5gqLPwij43nBcDr2u+9hogee92h4nyII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532291; c=relaxed/simple;
	bh=8zI0qNIA3uFLwOcqMXkXmkMk7kov40pP1EbsBXYTohY=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=FX1Lvzeg+2RkDvg95UxCw7GT+iDlecwhU3+1EvK+9CsPMcoJ/kI7uYjBz+rm3KObQ70es8zMP2+8vQFEUl93m8g/gtKl6HED6lURMsTRZwmaRF2JONmG8BZqkHH4iGjZHNGiHeN81tRxO0bWAQPKJJ4pl7aaelYUwsEj2c01OKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P70zVZIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5922AC433F1;
	Wed, 17 Jan 2024 22:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705532291;
	bh=8zI0qNIA3uFLwOcqMXkXmkMk7kov40pP1EbsBXYTohY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P70zVZIy1/lu022cQQKznKSa5jqxbCVmkOCG5DfwZCvn67x/Nlo7R7wsns5x2yn20
	 svcjD5CbmL9aoPBSrAAXXeT/721DisIGd6L+wOa+BVz40Frm2HADNqDqjyvaIVJ+PP
	 +qvFOOkqwYS0LKWabaI+UQoVZ1la7iVn7ZjTyfeItXSyWsVMYaCHJupMlYixne+JZq
	 ytyWPtw/GD7t+PBE8+giU5j+m/a7nCSog8k7wiGqSjhdy89wFNrb36upHJiZ2Xj4lB
	 MzCJi55Nvds3pCeI+U3cmf8F5pTcxNsiwhy6QgSY25sjEo58wv36jvr/EbcB2l/JMQ
	 GB3ejWaz8WiuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C18AD8C96C;
	Wed, 17 Jan 2024 22:58:11 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI updates for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iL9F8o5_QXv+Ki5cHmk74ofQ2PwKOtJjJQoOWEGpOGWA@mail.gmail.com>
References: <CAJZ5v0iL9F8o5_QXv+Ki5cHmk74ofQ2PwKOtJjJQoOWEGpOGWA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iL9F8o5_QXv+Ki5cHmk74ofQ2PwKOtJjJQoOWEGpOGWA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.8-rc1-2
X-PR-Tracked-Commit-Id: 5b5268cd49d233f03a5cfb1108dcd38bcb83f6d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f369a8f5ba973c1c1b680dcc99959773193350a
Message-Id: <170553229123.5987.5612596345077369079.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jan 2024 22:58:11 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jan 2024 13:09:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.8-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f369a8f5ba973c1c1b680dcc99959773193350a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

