Return-Path: <linux-kernel+bounces-159332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A098B2D39
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC0E1F21997
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1035B156228;
	Thu, 25 Apr 2024 22:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvAUAiqd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492D03EA9B;
	Thu, 25 Apr 2024 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714085003; cv=none; b=Hio27kiGApfrLad5RFjIln952M3s+X4Be9GzcWLrgtlAJUmAqpKmAvQ4xvJpq/sOtGU6aYtB/x9H/zRF32PRZD/oq+v/6AT+ZqsBzM5UogSkTStk/t0ei1YK3IWUrNtEr6bDO3AWRPIlFFq/YZRSofYfx0lXOTGkyXJK63djitg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714085003; c=relaxed/simple;
	bh=zdLuVH84OGqw7RgBSDevcy3yPUi7yV0lCoRUme7EejI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jXREna2jfw4VqjuuBRS2wm1oaLpR4Hs78BR18Nj7nriq6nmESL5FuJGp+1ib0GccHYYRaV1UGvv029sh4raWtpbIQy1vVOlUR3W/oc27ZXLfVFNJGV+XPjOiYjYKdndrbTBLB4SSjfFnRTB8oadNk92MPV0B8ktRPyfR1gPO2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvAUAiqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3742C113CC;
	Thu, 25 Apr 2024 22:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714085002;
	bh=zdLuVH84OGqw7RgBSDevcy3yPUi7yV0lCoRUme7EejI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bvAUAiqdnVhUoT90KfLZoWMIloxHKzb83Ho6Ug5u3u4adNoK98VmNcbreqHLpVLxI
	 wWAOF9gnHljJyfDMX66bL/iG4rY8JT+AtpyhrLchQvZtd8tSQAfR0hk4tFEF5RfqCn
	 wXX2IwopietaS1EZQUVdiMswdkmbTKj625nvueY9RyJ2Czom69c0qrs5tjXThrcb0+
	 +3w1enj398oY/YVU7oFeoBQ4MYxctgOV9KjZ/zo+FuSgm+BDO8/PhtMhzaGDgzQxMi
	 Ms4s48fxQRLyLQP2xCgsbU6hxP6glFC/QDKKfs5YN2rtlhN33RUGmmB4HngCh+0xNv
	 oKRoDTXIWpvtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BAC5DC43614;
	Thu, 25 Apr 2024 22:43:22 +0000 (UTC)
Subject: Re: [GIT PULL] virtio: bugfix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240425180106-mutt-send-email-mst@kernel.org>
References: <20240425180106-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240425180106-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 98a821546b3919a10a58faa12ebe5e9a55cd638e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c942a0cd3603e34dd2d7237e064d9318cb7f9654
Message-Id: <171408500275.32202.9237906041561329048.pr-tracker-bot@kernel.org>
Date: Thu, 25 Apr 2024 22:43:22 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lingshan.zhu@intel.com, mst@redhat.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Apr 2024 18:01:06 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c942a0cd3603e34dd2d7237e064d9318cb7f9654

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

