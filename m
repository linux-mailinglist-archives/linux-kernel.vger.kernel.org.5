Return-Path: <linux-kernel+bounces-31572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C63183303D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A681C230D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E22358ADC;
	Fri, 19 Jan 2024 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX8K8w4B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E758ACC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699647; cv=none; b=VqIpnsRxW4WD0za8VY7+L2UtTzeUMXo1Ik/E07tO9tZ1iRQWY2NiKaKq2rjndYMlarSuH+WdETEaz5uAyaBNkW1Fhn222MqACzFwkSx5ib+d9fExXSBUI1yJLvmsO0dSF15XDwrJmGmtNUwAzzJnFGVH9r2Ohl8A7Z632Gc0zJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699647; c=relaxed/simple;
	bh=MUPwA4IFefntHztqjaV/D/3z0tkRyR7m6xm0RVOB31k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TStYfxroVFRFIiqJL6tFrRRqueBkKElFgD7gddabUdjgl5OvvqsXWYS2EEnfnYB2YwlRYVmTAIShRsp4uKlbQO6RQkRuOUGaWxiQpaiBO6JJ58vYY+c1A12QasOFjHHrvxp2gm3x6w9857P/e7pqKVVYUz/wXIJNonCP/f6XwkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dX8K8w4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC90BC43390;
	Fri, 19 Jan 2024 21:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705699646;
	bh=MUPwA4IFefntHztqjaV/D/3z0tkRyR7m6xm0RVOB31k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dX8K8w4B1JGo5XA4hN/tMPjzlIKcjOCCNtk674FDneyCglLcvqUqVMN82nGwiNfAs
	 DXc2zktKF9bEVGCDSgak/tA9nXqWvFiHnho0nHvFYaAZFydB1aD2Bj5/rDci5bYPW3
	 PvB/Edbp9eh/xTSw532OZBYnwOz6lO5iy7YQ1iOcJaKjuhC+t8nFdi5YvbbEyuBvwb
	 wK5XKE6xkp9mwsjeOsgemMLkXgEeeVX9cUDM+1pQ+SkIjkQrNn1+G8vA/Q7eMXCZG6
	 nj8/OvThvGqVNRfmuyDvwj9vMusR/5MUfpP9aQ3DudE2dJUHERS/xi+mLFzjS5p4NG
	 7zJqh0Kr90Dng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD390D8C96C;
	Fri, 19 Jan 2024 21:27:26 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.8-rc1 (part two)
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txpkzp1nciq+8TrVU1pmsRC9LEVqLaQV9ug=XX0hnmLmw@mail.gmail.com>
References: <CAPM=9txpkzp1nciq+8TrVU1pmsRC9LEVqLaQV9ug=XX0hnmLmw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txpkzp1nciq+8TrVU1pmsRC9LEVqLaQV9ug=XX0hnmLmw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2024-01-19
X-PR-Tracked-Commit-Id: 009f0a64f9ccee9db9d758b883059e5c74bb7330
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e08b5758153981ca812c5991209a6133c732e799
Message-Id: <170569964670.21908.6698361087157315155.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 21:27:26 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jan 2024 16:58:59 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2024-01-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e08b5758153981ca812c5991209a6133c732e799

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

