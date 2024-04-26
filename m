Return-Path: <linux-kernel+bounces-160536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1E88B3EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C061C22563
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8682316E88D;
	Fri, 26 Apr 2024 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HA4ONEoe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87A52230C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714154999; cv=none; b=WD/hcCIEBq6Cm1dTkYYyGbf+/U6OGTeEe0UfsybztAdnz5EYnBUDK5uC2CkU58ITOB4QFFEbJ/xgpa/v3yd0sdsG470HKjcHv0EGZUjWxm5cvR93GsY4E9cgRxLYJ1O2BJj2mxtUVotIwZGWl1uL04VwGyLipgeUlyh/H3oN1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714154999; c=relaxed/simple;
	bh=JYRmKjYeeyfSPfIhg2ddbubocr3HKtws+FI4Stbneg4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C+dDcHKwT6X8etgPKDeUk7Jtyb/Ni6iRANGH016MB0TgXv8K5ziOvUH64DI9RvsNUfIH3HwI21Dk0WiNpLQqJEFPzttAgvsX7erz2V7fSbh4TMrCg51aAxL+wcM0borrUhvoM1qpQ3qvFA7vY/64h/r0vl28+qwJn7Ve9WBB6fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HA4ONEoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB324C113CD;
	Fri, 26 Apr 2024 18:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714154999;
	bh=JYRmKjYeeyfSPfIhg2ddbubocr3HKtws+FI4Stbneg4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HA4ONEoe9BtUco2mpWEli0LCEOiRGCJSpgamcvzt+5wu+3T0yF2RLfJog7p8MOlIC
	 5DBuCVyVkBdbPBD1QwP2PQ5dQ2IzXcwn76QwWEc5qGBsVizSWekEPDZsuPneZG26sS
	 9tJhUjGxlCg+GbbKkQNm4qN4Fj65IcAvvQOyVjWM8IxyOJ2iPRSGKibEJPiPincssh
	 1LtmJZHC1DumnHsYMjRg58LzbILjwbIYaXopSZ6TEca++8ZwEJQlgPEbcznvbTr16D
	 au60Ps37CPlqVwDV+laAHNpSPeWs4i7vSFL/AL9d4xYDHG/5GZl3stsdwNjd3jm1qz
	 zYqRzvTLz2hqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0199C433F2;
	Fri, 26 Apr 2024 18:09:59 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzOc8ybNWouvj+Zz2kZy1iXVDgJ9v3yi_Owfz+jp2tqkw@mail.gmail.com>
References: <CAPM=9tzOc8ybNWouvj+Zz2kZy1iXVDgJ9v3yi_Owfz+jp2tqkw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzOc8ybNWouvj+Zz2kZy1iXVDgJ9v3yi_Owfz+jp2tqkw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-04-26
X-PR-Tracked-Commit-Id: 3a8534035c0747610312f9552898a0ece10ef8a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61ef6208e0df073072a764eb5c5f5a6db3ffadb6
Message-Id: <171415499964.9216.14679560198090633431.pr-tracker-bot@kernel.org>
Date: Fri, 26 Apr 2024 18:09:59 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Apr 2024 13:12:03 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-04-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61ef6208e0df073072a764eb5c5f5a6db3ffadb6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

