Return-Path: <linux-kernel+bounces-59827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAADB84FC33
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18131F22313
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DFA80C16;
	Fri,  9 Feb 2024 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt29pSWj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724F27BAF6;
	Fri,  9 Feb 2024 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504379; cv=none; b=mMGb7xcCCLmxagjhIQnK3l+eb20tLlmzqSeYqvepn3GcjeNPLbb4oiv7Yjxcy0GWIp1upPk6A1LhZsndytNft42Wtd9aG9do+iMi0bY19miFYjbtcdp296Tkk9UwvvHm9JIDLbZnnBfZxGnO6GCunIrsgHhe1B7XQWikKUnIfDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504379; c=relaxed/simple;
	bh=WuaCYgxBC9ZkB5J3ifqdQL7m8JUOTABVZmrqBw8J3pA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VxwFwLnkH2RvO1SzFmh51XkXNRX7FJWpDKE08C/KUO9JuAyr1o6AAGXBeZGgwhXjez4YXjHpWURApsnS0XRqq3B5GhPEyxprGEJ7qkSaRPt2ITWJpmit5zchaqRzAA+5avEAIfheOiXR24oVHkN7kp7FzoRM4d4Dtu8qJ2yXm1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt29pSWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49EDBC433C7;
	Fri,  9 Feb 2024 18:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707504379;
	bh=WuaCYgxBC9ZkB5J3ifqdQL7m8JUOTABVZmrqBw8J3pA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Bt29pSWjft9riFRG/32DywEabY2TgWRuGNf4VVC8nzl9pZEmHVf7LtBNcLE6URUDB
	 qvjkJe4zvMNCZdtK2G+ZAL5EcxS0fXFkNaMOUmyFv6QryTr1DyijxajYiC5s1nCblz
	 jPXpC3fCSp9XSgRXMvNcwH34/dip0RoXm9yINAHJO2+P0uiBhoD3NUk3FmSQnXUi+P
	 h9aTKC2pMdf3l3VcTeCCZ5nytnxqkZfMgF+0Hc5T78lfYooU2sgWLqOiJ5LIACg3Cs
	 bR1yNJJHffIUdMr18cKhVECtERjBA/SxQEA75G5KpbgToIGmbsdSBeK2jKTak3DF2C
	 tfJfeJHIQGvTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3598AE2F2FC;
	Fri,  9 Feb 2024 18:46:19 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain fixes for v6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240209123818.768037-1-ulf.hansson@linaro.org>
References: <20240209123818.768037-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20240209123818.768037-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.8-rc1
X-PR-Tracked-Commit-Id: c41336f4d69057cbf88fed47951379b384540df5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3760081ff414c4fec37396499f5b298464583b03
Message-Id: <170750437919.872.9474856253417247586.pr-tracker-bot@kernel.org>
Date: Fri, 09 Feb 2024 18:46:19 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  9 Feb 2024 13:38:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3760081ff414c4fec37396499f5b298464583b03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

