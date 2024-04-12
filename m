Return-Path: <linux-kernel+bounces-143010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8493E8A332D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDC81C21A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22628148857;
	Fri, 12 Apr 2024 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHz4dGyU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B00143899
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938113; cv=none; b=JzaF8iA0QXGUm/XFjKqCyqMYxlxCvrHME1tRz11fhN9GzAumEgxEnNSddI2kB0R46MzQCzYMKIyqdzrMs0L/JAwbBl8jOyw5ofTD6rKU3omYSmuje3fnXsc9xUPLOgGuaMwmUIfNB3ggRDguY+kRX3Viruc4YluWWsapIhxpFkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938113; c=relaxed/simple;
	bh=8qkYX1O+0T1AeF5thKpWU1Y7WZ6HUyboKnu0kADCcBM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tCkNXJUw5qWs8xaytvC0+wyeSPuqPsbEZBJ96xqm9lt4jBOvKskheoZvwzBOYVhe6BWEVvtVrZDgPokTnYJdK49DPw1L5gB3neWgq9wN8uOIvbP4YQKoitq2x3GCpvXY/2nsQ61/3NsNqOW/dvsi0QXywOrjN7iV5g67MAQI8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHz4dGyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4872DC113CC;
	Fri, 12 Apr 2024 16:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712938113;
	bh=8qkYX1O+0T1AeF5thKpWU1Y7WZ6HUyboKnu0kADCcBM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BHz4dGyUObmKYA17DhdSbHejDT2JPm61fRnUyW48Gzevl7yEzKNZf27ssfZU9v04P
	 ewNwUjZo/Fp+Ae/qakbA5pTvRB45Y2bXaIu4U1U+BnlEvyaD5Q3fuSFi2qr2sEzOvJ
	 JCs9OluRtiKYCJKZ3ZF6XCiQh5xqG8A8x1wYOnz4HdoNXLdo3G6g3FpMsopE3op0Yt
	 UKarNBIvm16Uie1PvEgSDIpI3okZHR9qp07+D3BKIWWW5nTPPycLcgVaXjEAiRDzQA
	 eBUHJQl7GuoWPVutcNbYv0fcFWBloUo5JxRDmPysgU/VYTsMpSWtqF+6801w9ZrICR
	 AgVyubK3jgSjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FE9DDF7857;
	Fri, 12 Apr 2024 16:08:33 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txv4MKXFj67mKAV8BZ_uyW2cVz9rUioHfSAsCPVQYgkxQ@mail.gmail.com>
References: <CAPM=9txv4MKXFj67mKAV8BZ_uyW2cVz9rUioHfSAsCPVQYgkxQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txv4MKXFj67mKAV8BZ_uyW2cVz9rUioHfSAsCPVQYgkxQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-04-12
X-PR-Tracked-Commit-Id: 3b0daecfeac0103aba8b293df07a0cbaf8b43f29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1c13e80049d927c88021e3180d5103f2e6f55c4
Message-Id: <171293811325.2506.4766258602336377769.pr-tracker-bot@kernel.org>
Date: Fri, 12 Apr 2024 16:08:33 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Apr 2024 11:34:33 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-04-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1c13e80049d927c88021e3180d5103f2e6f55c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

