Return-Path: <linux-kernel+bounces-137351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 765D089E0F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30915285B71
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C66C13D2B7;
	Tue,  9 Apr 2024 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faIIQoRI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DDA15359B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682066; cv=none; b=Gu5J+Y2G4BHmx5jGqNuVbYFlr7RAgLP5j3tDLefQYeKnaJ9CPqtnz+4+AOEruhrj0Tx5MJ2D6NIylY0AoEc1kmkmqR1Y+kqwVTulHm0zgjcEJ4SUlRbjqA/L9XPAsQZThGEGm03kpREisbiWRllsuDYNxWs51N+1gM5fR54CTeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682066; c=relaxed/simple;
	bh=zkfEmDXLMJHk1BR2ziIl//FuBOqoV+3WVkeQldg5bOA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ic7HGd9nJYvE6fLabkA5Z26z/5IofCgmgL0qaC50lgsj7KtEo+bbVS0hpMfAp8Y3aCzmkvAhPu1Qgr7F8/hk6Co8wSCGsul/w1EmzNDQRO7sKVoPOVIDls5Nw4hFyAM+Mqk06FoJZU10xQSDIhz5dkXBKkQz2f+il40bz0JQ94I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faIIQoRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 506CFC433C7;
	Tue,  9 Apr 2024 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712682066;
	bh=zkfEmDXLMJHk1BR2ziIl//FuBOqoV+3WVkeQldg5bOA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=faIIQoRI74JerS0dTL3g2jeqt9cWCJvt75BREWksBvB0NA0GQCg9WQxAXBTC0VyKp
	 oGn4YckMJBjQ4Ex1B48m2BeFOBNYMvUb84OEXjs+SiAlbFPGsOw0pL93tdL3kRhtJn
	 1d16+sjZFxvVxR+iY+IS5a7HGrD5QsKB6nEJMmVk+uQVR1/TqMOF5xMYdfsNun8PwK
	 RP4nDfkWTRq5Qa+Je5k7GTHW6DbXYjh/zD4r1t8Xd1IBWb1i42RRxyUk0/Bf0snUcs
	 vR4IOWKKxRuRjyGtg/J8Yj5ctlJAESPXCgfBPORx/9HYlGjKVxaqN5zSeycFbjo8V1
	 z0g+7EMZt+FOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 449C9D6030D;
	Tue,  9 Apr 2024 17:01:06 +0000 (UTC)
Subject: Re: [git pull] drm urgent fix for 6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tysq6sxv-HRUf4+AoAoC0YA_s0tUz6ujms0FcxrgtOUdQ@mail.gmail.com>
References: <CAPM=9tysq6sxv-HRUf4+AoAoC0YA_s0tUz6ujms0FcxrgtOUdQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tysq6sxv-HRUf4+AoAoC0YA_s0tUz6ujms0FcxrgtOUdQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-04-09
X-PR-Tracked-Commit-Id: 718c4fb221dbeff9072810841b949413c5ffc345
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
Message-Id: <171268206626.20201.11838545735612957768.pr-tracker-bot@kernel.org>
Date: Tue, 09 Apr 2024 17:01:06 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 9 Apr 2024 13:29:41 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-04-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c71fdf02a95b3dd425b42f28fd47fb2b1d22702

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

