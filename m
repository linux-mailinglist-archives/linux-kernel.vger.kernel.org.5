Return-Path: <linux-kernel+bounces-151777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B198AB3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64AD71F2358D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB4113AD39;
	Fri, 19 Apr 2024 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyrLprQk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E83C13A3E5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545384; cv=none; b=He3zwA+3qpDTi6r5vff/bJTPUUZSe4kczguE8dYRB+ajETWCCGt3w6/Qx+bl8voPfX6tAE/e758oEniKtwDZuX5L6m/y3PiB1nlL3+izMZY7wjfsXuTWLRJ57p6hfZhTyiZBi9bXUKNFRMuYfIjaqbxcCwIHPy8sF7rvrRi3KD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545384; c=relaxed/simple;
	bh=EbhycsX6zJEnIO8RZ9g+UJnYdP7P7PgHJIdmfWoOo2o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PX0BlcqTd3gVOqlPJLs6dOaqqkM9/9/uNo1sZiUayfBiv7dA1MldC09CZTl4JePSFlLyqR3HSy1mAZL045HAxjwcCGo9kAlLhJPg7zZ2++URmWuXGhXAYD8v2rU499sHP3h9Ov9QFmDgAw6zt/n+ymujyDYSyp45IxWTyzai8dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyrLprQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21FACC4AF68;
	Fri, 19 Apr 2024 16:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713545384;
	bh=EbhycsX6zJEnIO8RZ9g+UJnYdP7P7PgHJIdmfWoOo2o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FyrLprQksI/p4pxC/5y+WiVU39hJVFkmPg1LJ0K2p8oU1xTeQ/O6yn0BpvP7KXnLf
	 X8K6rVyQHh30pufZ6HzvoEDRyuyw0s5BIDidyfqHmCCuf+9boI7WyoaIJPDveMljyA
	 nazXLPaVFeT6OgQpEDPaLLVIkb6kc9sMT+xa2Xbm3/cQcFuimZ/rmHEUAS88JD7CyL
	 pE17tDkdlRQ+jGKiOxYep4S4riOFLMmaIM1ntNyjGl/8j6o1HRkmCJ/wZ2I2tiXtTB
	 ynMRzucU28tX29uA+7MWp7PHg6Yxwysp5iYvNAgZ2rGrXOIRpuTq3ucKO0T9pq64fb
	 /M9niJ+sdHa9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16DE9C43616;
	Fri, 19 Apr 2024 16:49:44 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyKSyw-hDGcGSHom+C0iiagDbgrX=1oxv08jV+KRL=m8w@mail.gmail.com>
References: <CAPM=9tyKSyw-hDGcGSHom+C0iiagDbgrX=1oxv08jV+KRL=m8w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyKSyw-hDGcGSHom+C0iiagDbgrX=1oxv08jV+KRL=m8w@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-04-19
X-PR-Tracked-Commit-Id: 52c8b6e1c007b93d35058508fbe1ec80a1d9ca39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce944f3f97cf1bc813003ea2f3bf2abefa87dbd7
Message-Id: <171354538408.26173.17984370586544920365.pr-tracker-bot@kernel.org>
Date: Fri, 19 Apr 2024 16:49:44 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Apr 2024 10:53:05 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-04-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce944f3f97cf1bc813003ea2f3bf2abefa87dbd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

