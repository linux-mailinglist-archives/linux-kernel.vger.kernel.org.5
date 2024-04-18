Return-Path: <linux-kernel+bounces-150666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 200128AA294
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51CEF1C21249
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBBE17F36D;
	Thu, 18 Apr 2024 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/vXA7Y4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF0217AD9C;
	Thu, 18 Apr 2024 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713467674; cv=none; b=Wc/ao7g5PyudzqeDJVl7Jp8OqT2Xrl1kVcpZcGiz4WvBkR0xPvNWKUU0xoKDNaxkq8/HUl/6JvIVbG6Zpdqx9GBGfZmzPAflq57xx1zeamUKiMh8zynSe6bhArhNfNG+j8TIL1yYrqVp+FxdtpoDF2vSaltvQsm+yYv/VLdFl1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713467674; c=relaxed/simple;
	bh=nFoKo1xuaXZSvIzO5GlLMDjGiqvk6Nv48usVZZ8JbCU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lT/8aa0LiSxpt8eDB48leemR8XpCLxryuyypJTxqJSVvo1IUX0vOgbOtPkMTPhEW+quiuRDoJkoyZnBw8LYjlfx0p1nRlkKn2yfH+IlW/EmYFEvqu/Yt+4xMToQZKSHonP5Ig1uLnayXxvlaoQ+PZko2PFWjwFWu5+V0HYELwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/vXA7Y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96FD7C116B1;
	Thu, 18 Apr 2024 19:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713467674;
	bh=nFoKo1xuaXZSvIzO5GlLMDjGiqvk6Nv48usVZZ8JbCU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=r/vXA7Y4vjy8K7s3ioL+IocXsRkLG6p3ewXIqO44ikFenlH7SDyWPPOtv+zv3Y9ON
	 x77zKW5Yrqm8+Rf+q3jkBLoCmOFxBNGOuGLZ1P5Jkda6ENflzkf4xIaWELWaTGv6ps
	 InA0wBkz0T27xwkVB1mN4Fi3DDLgpvq5zNthjb/a/EMKO5lxa1WJ+pFitlZ+kfrnz3
	 uV0nbFQcPUaUIfWu0vTakjXg0eR9Mv/TuHwrmpV0DxrAvnW2Usns2k5Sqrd2mQtfya
	 pDrpVlM1o4Gm26lNeFm1Xy7hMA2UjyyKBY1lALyB6ZsAAqLd8O4doU0J1AX314e7Wd
	 Wb71FSW6VE0BA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89E22C43619;
	Thu, 18 Apr 2024 19:14:34 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <14ac270fbf39d20eb8fd8a94a73cb2ae75d9acec.camel@HansenPartnership.com>
References: <14ac270fbf39d20eb8fd8a94a73cb2ae75d9acec.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <14ac270fbf39d20eb8fd8a94a73cb2ae75d9acec.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: ca91259b775f6fd98ae5d23bb4eec101d468ba8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2668e3ae2ef36d5e7c52f818ad7d90822c037de4
Message-Id: <171346767455.7721.654682711532032513.pr-tracker-bot@kernel.org>
Date: Thu, 18 Apr 2024 19:14:34 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Apr 2024 14:39:42 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2668e3ae2ef36d5e7c52f818ad7d90822c037de4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

