Return-Path: <linux-kernel+bounces-40714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293CA83E496
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28461F21B08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E1053E19;
	Fri, 26 Jan 2024 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpyUviXQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD8E51C20;
	Fri, 26 Jan 2024 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306730; cv=none; b=Q4volL60O0azD7IwEWQ9pKrJHT3tVJpX/7RGrXGQt+zW7nIAeCrc9cI1rD8AsDdWfUDBjAaatJ2Fnd6ergwikVsWSUf0UmK+H5rl+ABW71EKIRa3nkgdbOn+3rSmosW0frXpy4y/daXWhIznO3KErrYMtfArhAfTNrZ63wJBLiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306730; c=relaxed/simple;
	bh=Y2JuC5v1p08QFS1tJxVNDG8xj4h+nqssv7Nc+OZZCeU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FoMuEmvPoX2AhUnNPkQNKDeIja69X9H9Tr3Q9Zk9JqRuuan2iB+hlTdfE6nwUqAzqeCq2yUajWtGYOPJmMpr4frQUbhvKz8Zf6rLWzBS74YM4dyWr55oD7gsdbW4ngTQDFASAWffq76gT7DSzQVmjVSaaVZNNuCcgbiqXWeubk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpyUviXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 430B7C43399;
	Fri, 26 Jan 2024 22:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706306730;
	bh=Y2JuC5v1p08QFS1tJxVNDG8xj4h+nqssv7Nc+OZZCeU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jpyUviXQhh+sylIwZj1rcUeQzcOh7eULdXaNFpZnCJMgwmf4lfFsA2wYI4vQ3ZMNr
	 RvkW9XUWVL3anTrlkYQ/N42MQo9llwjHT2NsAAAQHCA8wczzWdR+oANlgXdPhOwSSD
	 x/4PS9OhtqHlmP2IeZNnH2tygxdxqkAlc3DGmBlQpJo2jqooE2LRJRBrZC17KhQn3V
	 aeMwDRAKy9QmhNFp+5BVgvBPT7l6yZf2Zwn91+tR2xr7YOwhTRBab/sNjp68yyKeLa
	 8xVEY8lKsK/QK6YX5dwP0G56nnVcuq8NA6aywMJTYe63eRWMotZLFxce0TIKftrs1H
	 iT1+JgWJSiEFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2601DDFF765;
	Fri, 26 Jan 2024 22:05:30 +0000 (UTC)
Subject: Re: [GIT PULL for v6.8-rc2] media fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240126110338.2d1063f4@coco.lan>
References: <20240126110338.2d1063f4@coco.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240126110338.2d1063f4@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.8-3
X-PR-Tracked-Commit-Id: b32431b753217d8d45b018443b1a7aac215921fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4aeb083707d6a2535bfea5d16140b72a81efb62b
Message-Id: <170630673015.20742.8308794657971173367.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jan 2024 22:05:30 +0000
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jan 2024 11:03:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.8-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4aeb083707d6a2535bfea5d16140b72a81efb62b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

