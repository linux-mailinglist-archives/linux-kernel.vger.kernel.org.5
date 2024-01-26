Return-Path: <linux-kernel+bounces-40840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE4983E6DE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D7D1C22BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D37D5FEFE;
	Fri, 26 Jan 2024 23:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dK1ra5ih"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC815FDB4;
	Fri, 26 Jan 2024 23:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311328; cv=none; b=ClzBkJzFXBRQjns49NWr4EKjOcUWfHkGWEji0+NPvpSTHPaALrHMdegov0qGhBqausGT6+LwVCuOAkwhKgcQVKawOJ4IaeJGhsMn1WvQoF/cFJHPcrf/3+R53TGZDWM6YfKLaQV6vf0iZ0k6WDypYPgmf5MDin12G867nsww3I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311328; c=relaxed/simple;
	bh=fzEwPeQ+uXU980SE/kgv/K/Sbg2qcTyrv6njKtqJrUU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qvX4PRJZw50rodE4hjf05ZXi3RLqXULKK9uMdSerinac7m1hqqUL5bMRBEtzPDpxjIv0xnZv+0uu2cEhOmu3UoDQOKMOZJRkXv9t20rZdMwcUwUbtRymytMW0W/W8ldCZ3ljMBk6HC2Vg5v+bhmCouTCeNNncq7zn/GXyMn0IoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dK1ra5ih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 663DDC43609;
	Fri, 26 Jan 2024 23:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706311328;
	bh=fzEwPeQ+uXU980SE/kgv/K/Sbg2qcTyrv6njKtqJrUU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dK1ra5ihp49visJEt+In4SyFaIWhCr03zDh2GZNNMthb1OWMLuFl2OoMt2YLaeD0w
	 RQOLHc8wv4h06Zp/Cc2cZ/mySkgl3r0nOPgPxyKkCaQt4wy3D2dbkA3QDjF+2G1Rpn
	 PUQ5TGbSWPSFpf5VYmRdxkmN3iN6nsTaRhBCD6pFtsDlBvZ5ckshOnBrURHiMmgjKZ
	 tuoZ85jLi4JNZOhq7d/7NNqPUSNAGhzMBID3KPZLwawS+DzKYJhvuD35mJhdltKDLa
	 XeFQmKlTS/lKguu3YsGEdw/UR84pyafVJ9Fr1RskhAv1rDmd+YYeVZCsBNQ6nqNqZ/
	 SwgHg/yqXu1eA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54C4EDFF760;
	Fri, 26 Jan 2024 23:22:08 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <87il3g6py4.fsf@meer.lwn.net>
References: <87il3g6py4.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87il3g6py4.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.8-fixes
X-PR-Tracked-Commit-Id: d546978e0c07b6333fdbcbd81b2f2e058d4560b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70da22eb63f73a1ce41c7d106a5a417c352089f8
Message-Id: <170631132833.4030.17191682570282070293.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jan 2024 23:22:08 +0000
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jan 2024 09:04:51 -0700:

> git://git.lwn.net/linux.git tags/docs-6.8-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70da22eb63f73a1ce41c7d106a5a417c352089f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

