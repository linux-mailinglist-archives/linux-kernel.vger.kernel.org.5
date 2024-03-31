Return-Path: <linux-kernel+bounces-126344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E69E89355C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80611F235C8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE043145B2B;
	Sun, 31 Mar 2024 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4kc2SrL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C485145FE3
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711909251; cv=none; b=JgArlMrePSsqGCkmnLL5zfOc5kqenL4mYtcauV6P8vSMyhSvJ1so5U/C9DJhqHyHGM3qhX+jmaUKcwb8d592+CipgOPX8ul3c6PNhhuj6DDy9l2nvN7qXVR+bWIfmbH9JL4siP8j5cFpnO6Ca0pf4Gha7qx/iRm16hulZGF8fjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711909251; c=relaxed/simple;
	bh=XxyZTRiH4Lg+I25p9j5m+lw/Z4OSjOBnd3W5pt1TJAU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N87VDOCee6GpTyUf2S78eZ/RUjEMNEr59yC0FA1z9Wm/KRXSFMfhVEdtPY8yJ5zpgDPyXkM5bsYMwYwvDuAyTvTkEV07vRcuseBf/3x4cZwT7Nh3qGHRdxus7vGvtJh17KKCTNFvJFqVA/vNkq2r0Ezmcu43WKThbGGCFYD/PmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4kc2SrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F124C43330;
	Sun, 31 Mar 2024 18:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711909251;
	bh=XxyZTRiH4Lg+I25p9j5m+lw/Z4OSjOBnd3W5pt1TJAU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t4kc2SrL5XdPXeJqiB0ibAU0t/UAXyd1/jqjz83C+O3b3b9ddOOfmFDs9g/9eoK28
	 zQ3tY/lf6W0iuGmCSzh5RQyf60VeGN+2bh3MPy6s0/LxfvodFJXHJBHbyfEeBcLrr+
	 n81BR+j0NSPRV1uuLDt1sMvvaMjxoYQ0w6e5JmPla863GE2As48IoFjVpdEF7XSte8
	 h6ztbibcDHZqOI/cnqoAqibuHGqOiJrRSWnUA6fvowkt2ITuvqhfF1zWC2d4NGGFGk
	 FGRV4lZgiGtPf6dddnCEWiamnIeqZKdvGXgL5dxz0dYDkwcLj2DEISYfAL15WvGkzj
	 7++PWEtffOdWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1516AD84BAA;
	Sun, 31 Mar 2024 18:20:51 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240331113204.GAZglJtCst_SqlTfJ3@fat_crate.local>
References: <20240331113204.GAZglJtCst_SqlTfJ3@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240331113204.GAZglJtCst_SqlTfJ3@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.9_rc2
X-PR-Tracked-Commit-Id: 9e81e329508576b499b5c47ab106b5fa45ce96d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5dad26235c4adde4199c7750c696fd729e5020ae
Message-Id: <171190925108.27603.17572976848759048157.pr-tracker-bot@kernel.org>
Date: Sun, 31 Mar 2024 18:20:51 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 31 Mar 2024 13:32:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.9_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5dad26235c4adde4199c7750c696fd729e5020ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

