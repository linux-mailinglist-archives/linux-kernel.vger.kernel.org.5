Return-Path: <linux-kernel+bounces-102705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12EE87B63C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B2A287A22
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D0F5CBD;
	Thu, 14 Mar 2024 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ6Q5+LR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066385382
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710381519; cv=none; b=Jm3XCTYb/ABgaBZfP6Vta0kfMIg6lNaGRYcTS6tnnRm+XQtRv0OBg6zGBB+K4hEwDwiQHWRZ6XymHNeoFAMu2UvbN+YLkzpdvnLhQvZgmSMuJ6RSPpmB0q4iVzduMfxFaEiDF8k5MR+/Ss/TbNGZ/kMPk5180QrFUtBK11+42gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710381519; c=relaxed/simple;
	bh=i/dPWeOPGxBQUNL9blN/rJhePMxL9A/Deg1YVr3iEq0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WwzUDFL46jYlmYfIan81RE9cfjRt0odrUgy/gXiMVcrQzeWEX9SF1vC8dvn+HfB0kF0sgZt3ckrr2XkiyNH+6xTWCupKgIjTkWAncRkq2YeotPOBg/rHUpt8e06Om4g7yx6ddtgBnOnDGMC4nnTYk8jj4P+9fAu4KlgKJqfXsrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ6Q5+LR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD95EC433F1;
	Thu, 14 Mar 2024 01:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710381518;
	bh=i/dPWeOPGxBQUNL9blN/rJhePMxL9A/Deg1YVr3iEq0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IQ6Q5+LRJhHj/fIMlfJDd/yHXNIEmyE7Y8rbrNG5gUHF30Exb3srWFBLW4JvS+NK6
	 jAH2uDVMtpb485CgUV3CX68NBVsiB6tOoy7IuXD3v5vyOLZUMtCtE0JD2KoB2vNTTt
	 jpD67MgPm0mCV7IOoAhf5QI51cZzBhCz8MhvI04msEgTPdeBN25RapoJXOaOkVz1DY
	 lhaMnyF1EewdJMyUJ/NlkFHGOK2e4BT1Fr1AHowsPJuWo8Txp1QCTScWsE5afC6K/3
	 3UGZ3jPNhGlnzX71tDPI6rLdzUHv0CVphGp4ttPLwcMdXRudOM8ldrIyjpZRdRc6OH
	 Mrbrxm1o6R3jA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9C41D9505F;
	Thu, 14 Mar 2024 01:58:38 +0000 (UTC)
Subject: Re: [git pull] drm for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twR+WnE3GGqyeh1cuGVmpADPTwDPK10625RP--rLrqkxA@mail.gmail.com>
References: <CAPM=9twR+WnE3GGqyeh1cuGVmpADPTwDPK10625RP--rLrqkxA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twR+WnE3GGqyeh1cuGVmpADPTwDPK10625RP--rLrqkxA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-03-13
X-PR-Tracked-Commit-Id: 119b225f01e4d3ce974cd3b4d982c76a380c796d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 480e035fc4c714fb5536e64ab9db04fedc89e910
Message-Id: <171038151881.20141.4101433012400911589.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 01:58:38 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 14:06:52 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-03-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/480e035fc4c714fb5536e64ab9db04fedc89e910

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

