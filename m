Return-Path: <linux-kernel+bounces-103653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5FC87C27B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E981F2283F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB8E7580A;
	Thu, 14 Mar 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pf+r9QY2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD54F74E3D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440432; cv=none; b=LYo660g7DASsI7NDeP1G/1Ep6jbqWINen1MKSv2fWIvod3L97P3WUwPP1otoW6m9t9sZNqarAbcr5xVz9zTuNHGlz/hFA760X0YprenR4uupKtRqcNZEC0h/yACVn/Q/hWwcIcg3jtzOn5g3fLHkKQ7wROdc9/jeaV32YZkhr0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440432; c=relaxed/simple;
	bh=Q/qcr2H83oCrBXgNeKCPLWiPtqF3fvQN5tl+ZKdEU7k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EEOIuEZlOaYgv/dk76T3ii5yuuVT7DCujEa7YFuVkHLjJLXYy20rEw4yg1sssFWMGhqN74784G13NbNKvYs32ztdNiSjtsuLJ9YUgdxx/MwduaNu0prqVkPKjo1KxvTaZxD44zwgtkMZKBNsyCD7dxMYu+LsrIoxbci67by10Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pf+r9QY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B021FC433C7;
	Thu, 14 Mar 2024 18:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710440432;
	bh=Q/qcr2H83oCrBXgNeKCPLWiPtqF3fvQN5tl+ZKdEU7k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Pf+r9QY25NxostDjcjLwb2lAtLTGgY7+JOSm5suCYpnvBxcreKhP0z7RCcrY/dxCJ
	 VGgUJ/qLskDxilkwETSAcU1zJnNO/pmA+hDSZmLL98SbSnmB6cQHAk0m8ERPvgqomP
	 9d686a6qH/hxp6e1dDb/CP23+1Wu9Olaq9tOyBe10pycez6gnprqbVLGGH922K+7Hb
	 68TTj77dLUR/L8bAd8kp2wd0OeSL50D7npXx489P3eABMAVza5fMf5bvIZoFEmyvFd
	 FNPpVdKXzwm53bXDHB67HxU5UUvWJEGRx+ZJIA/6z/4w95sw1Dum0je9110a6Q2N4/
	 lIGwgZIaz3zWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99F64D84BAA;
	Thu, 14 Mar 2024 18:20:32 +0000 (UTC)
Subject: Re: [GIT PULL] auxdisplay for 6.9-1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfG20vf2kW1h-xA2@black.fi.intel.com>
References: <ZfG20vf2kW1h-xA2@black.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfG20vf2kW1h-xA2@black.fi.intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git tags/auxdisplay-v6.9-1
X-PR-Tracked-Commit-Id: 5d9e12972259cd86ae9c3fc0d5338b15831b9929
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b345ff698ec7ed52d90bd5603ec8fc1802f40110
Message-Id: <171044043261.24196.856528875893736520.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 18:20:32 +0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Miguel Ojeda <ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 16:23:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git tags/auxdisplay-v6.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b345ff698ec7ed52d90bd5603ec8fc1802f40110

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

