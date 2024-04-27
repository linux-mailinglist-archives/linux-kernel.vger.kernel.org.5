Return-Path: <linux-kernel+bounces-161129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B13FE8B4771
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B791C20C78
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 18:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF333145B05;
	Sat, 27 Apr 2024 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6IcTWi3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14821442E3;
	Sat, 27 Apr 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714242491; cv=none; b=jow1AvbaT4PFKoTSKIKqPV+DsXWPSti41Uyxi3NE7RICr1RSqXsGxuW0jGQwMmQ6VY+qf67EtYFZwiVvh7bbedvNXj91682BcTcWXF7LMtv68KOxsLQ6wHFFXC+CjEtQnACfBn+eAtBoq4U0YZQavGbpsmdnUujYCGET0yG7y/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714242491; c=relaxed/simple;
	bh=auEZawbxgUMdh56hGjSFbOIhfXBvS6PkZBEzxWBHIfE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NsNRYd23EJ2o/opCURcymOjjppTAl7xf1x+R1KGcjlVH7QMgDreLj1U8AGy9so47ZzLWBxEzAk00PPEe6zU/bdrSZPSSU1hhG9Qal1lURGlIlS6rFtBz24AixTm5Jmt7U27X2O8XkD/4Li+7lzEZn9sBSZLnuSdsciOYn/c8qdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6IcTWi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8AABC32786;
	Sat, 27 Apr 2024 18:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714242490;
	bh=auEZawbxgUMdh56hGjSFbOIhfXBvS6PkZBEzxWBHIfE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=C6IcTWi3lRanSLo4fhf4f2oKHBMrtMELyrj5pg+JyU2ANIRL5/M5HQGOlWXplS6mi
	 JCWN6NgyDhEimaEJqhkkP9ahm0FHCTHLRXaqpoMdCT3UAEQR69nj1T17D7uG6kuhj2
	 TEo32QxFRCY6Ouk9hNqDaK8IsMu3+F+Jq+s0LI5xwG4C9osHjyBdtWfaZ8oCYDe6bU
	 vGF0bBA75gITbKX2IMaYGz0NqpOcGNqAQKHPNCl2ptDrV1UsGTP3aNR6Bd3ZU4luGp
	 FyhUoUf4PHTlVJxu1hIqKWieH9eQz4ApPfCfuDBG3xLPXM08UtHuYvMVkUQDqNDNd7
	 fGmqs86qd+uHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BAE37DF3C9F;
	Sat, 27 Apr 2024 18:28:10 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZizdzEvh4juwfQCb@ninjato>
References: <ZizdzEvh4juwfQCb@ninjato>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZizdzEvh4juwfQCb@ninjato>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.9-rc6
X-PR-Tracked-Commit-Id: 91811a31b68d3765b3065f4bb6d7d6d84a7cfc9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d12ed4bea4343ca3adbe3c23c8d149485de5010
Message-Id: <171424249076.21148.729077537287796049.pr-tracker-bot@kernel.org>
Date: Sat, 27 Apr 2024 18:28:10 +0000
To: Wolfram Sang <wsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Apr 2024 13:13:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d12ed4bea4343ca3adbe3c23c8d149485de5010

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

