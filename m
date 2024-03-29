Return-Path: <linux-kernel+bounces-125483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59A38926F8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A301C210F6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3530B13D240;
	Fri, 29 Mar 2024 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQsKNKrc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C9029D03
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 22:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711753124; cv=none; b=XKxgYnDnVlCeH9Ogbe+xRfGB0TsH0BQ8u8ylKWCY5jJaPPGV0Bgt4xYHhHb06Zb8ApKGCBvFi9O+ZBH8VjOJhGsB2Ajbs4QXzYADJ+waJ6ztI1GscVz8kcm1EmGKHuiaH54+OlXKJjm1sAIqEl/2k+ZbC5bTraiNaTc07nGP/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711753124; c=relaxed/simple;
	bh=f0Qpk7qib2AGcBvYzgeXZvstWjnZ8QdP1Of80q5WTvk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pXrOPzJihlxg9SF64sfyoUcTV9w2PFssz7MtYLHhVUc2eDKadkEnSLafppzBoCmcPWw8u/pasQxPhWVeIeyjCxdjQNZeA6Zg40GBh8xf/D7lkHDXyBw/4kjNjUo0hXs46lIUaVTkLbYVUck+i/lYhYZTXU1Q+8DknEaOtQb08zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQsKNKrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 529C7C43390;
	Fri, 29 Mar 2024 22:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711753124;
	bh=f0Qpk7qib2AGcBvYzgeXZvstWjnZ8QdP1Of80q5WTvk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NQsKNKrcX0PRITxtqhVGUKSyE0i5sGhTfIXjjtXLHNr6Z89wbcDcHso4Hd+OXP5Zr
	 hcgs5WKWL3iwp70xTkHbvgH8Z5ZWmxNNC4EjgZ7ZY0uVW0tHzuynxoY0R97PAh79K2
	 2D4yDoL+2y0jHozEGUxcnQrhcwAKwTV6+2z91R5ZoV/qBuZsyMvyxzECiVoOrs9mIZ
	 LVionvClQ9mgXswgJ+ZeXFodLy6YHo1T7wSuOw9Ehrcqvv5cfUDgpaGMubLkYA/XeU
	 sWpCg9PEy+yBTeKDsZBdWTp/g+kasJckueOpy6iooRhpXgU3OMBXzM2yhWOfneV+S2
	 aH9IRX4ASnmhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48A68D2D0EE;
	Fri, 29 Mar 2024 22:58:44 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyTKh_qXRW8MaTrRnjN=Da_hLLm66dj2_WcwFQ3e3O+kg@mail.gmail.com>
References: <CAPM=9tyTKh_qXRW8MaTrRnjN=Da_hLLm66dj2_WcwFQ3e3O+kg@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyTKh_qXRW8MaTrRnjN=Da_hLLm66dj2_WcwFQ3e3O+kg@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-03-30
X-PR-Tracked-Commit-Id: b01f596ab1dd027ce937358007dc1fa3e5a25917
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 486291a0e6246364936df1ecd64c90affef4b9c5
Message-Id: <171175312427.6484.2452378294230925405.pr-tracker-bot@kernel.org>
Date: Fri, 29 Mar 2024 22:58:44 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 Mar 2024 06:29:04 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-03-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/486291a0e6246364936df1ecd64c90affef4b9c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

