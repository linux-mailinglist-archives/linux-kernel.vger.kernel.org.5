Return-Path: <linux-kernel+bounces-160667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF968B40CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85811F2281E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7888C2C1A2;
	Fri, 26 Apr 2024 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7/GzQjN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01BE28389
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 20:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714163106; cv=none; b=txkXPwovMFEiWvfLmi/YQcpgBzoh/DtiC3xfmNNCSvel4RPnmrjtWN+qnC8B+ila/TTfGVWpj7KZSZiTqYb7yArB0vn+Xl3MgK3j5MVRnPKj2EU8KTTdXoHFuXTVMcKvV7GBgw9SjXEkDABPzZ/i0+1rJEmYMtaIyIXlIVPQwns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714163106; c=relaxed/simple;
	bh=MEVyrFlUd7u5DWvBZ8n6AEZ6PIKzQfICKwqbVv0er9s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Fv8/+/GaLi1RbFN0+Hicre/a+hHy0z459ZiV7uVpF/WqHHi3toZam3T87fFc9tEmGMVWk/MPjCnXk4o2EYfGhaCXzln8hEok5h8emctGpCyj9WDh7Km70pSueyYRAnIuTTwFQsCUurervARFFfyAQOzC45+EqevkxbLM/h5sqkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7/GzQjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 972A3C2BD11;
	Fri, 26 Apr 2024 20:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714163106;
	bh=MEVyrFlUd7u5DWvBZ8n6AEZ6PIKzQfICKwqbVv0er9s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=J7/GzQjNvrEOoDBQ/mjbDxkU+/xiYNeNxUQZ6mfvHLM8UjIWT4sj81OyFAo5/39ZX
	 ZlgiHFI6IOjbMsE4//yFZELLatweLBqosOqbJ7n0gKLfuQAdbfYL06cppIfPzy9bZO
	 3hu3kqBBsIiXtk4VzvaalW1WaoigTLNINM35LTUdmXeCRbc3aRW0PALwWxIWKLnm60
	 byLkDACbsLRK1/BeULudhho0VHomCuNFfcRVdRyuhP9SWFQzgKHOC70V9BdSgwLXIB
	 f4eWhW67bdonLRshD2347Hni9FplySkxMaOJDRojchZW6k175LxqoIJeq7h4jGPhAG
	 v8lkR+jTyrN9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72ECDD2D0F9;
	Fri, 26 Apr 2024 20:25:06 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Fixes for v6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240426205120.36804cea@xps-13>
References: <20240426205120.36804cea@xps-13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240426205120.36804cea@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.9-rc6
X-PR-Tracked-Commit-Id: d2d73a6dd17365c43e109263841f7c26da55cfb0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbacf717de8aac61e45764951646b54471b22bf3
Message-Id: <171416310646.19521.2945584292568770834.pr-tracker-bot@kernel.org>
Date: Fri, 26 Apr 2024 20:25:06 +0000
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, Tudor Ambarus <Tudor.Ambarus@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, Michael Walle <michael@walle.cc>, Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Apr 2024 20:51:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbacf717de8aac61e45764951646b54471b22bf3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

