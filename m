Return-Path: <linux-kernel+bounces-110502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C70B0885FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BA21F240CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D568D12BF3E;
	Thu, 21 Mar 2024 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFywp6ZE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213D48592D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042480; cv=none; b=mNjvW2cIZLn6vu+UwbDPnjcdpZ2YaZpcDMjis4JlrwV5kTwkq8YXJ2ek+5eToPU8ENZ3+2k/yh32vM5t/y8XOFP5Gx2iC6MV0h5Ctnp1eyiC2W9ZU6RYn8596F7HTm/jiW2Tkhgypf7nPbfQ6ohU69qwUz67Z7xdgVhF8L7U2do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042480; c=relaxed/simple;
	bh=HRI2HjXSc9eZLykDLwiLkxrb1PoD7ko13TaNRdu4BJE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oJOsM3+ffvP2517vFbpIzDwLnF5DxvhtD0c/s9suSrxS8Yvo1ipdV3RR326yBagEqPlpu+oEW8GUQ+GEU49jOBCogG6Lr5msXPtrwpuKIppi4K77PSq0T6hI+fC6GHVsG3a9PCNILr0yz3J76t4o2G4KO/9dlCQ+wmo6oY/Zlp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFywp6ZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01A1DC433F1;
	Thu, 21 Mar 2024 17:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711042480;
	bh=HRI2HjXSc9eZLykDLwiLkxrb1PoD7ko13TaNRdu4BJE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QFywp6ZE74tGNBDDqjYS8sLjH8Cq70OqbTKbOe7/qpJ1rfyqcJY4nLgu8IuKnSXIp
	 rSwv/mQCFeW5dvXbMPUFyW29Yv7x3cFFQnEz8R3Tw+Y10y4/z8DjayBqyoB7qeXQeu
	 hjpOW/f+mSFvAm8ZIdjx5OF12BZO1TSkUexSRWEscZ0E6QWQImaX6pS9wlztzm5Mg2
	 +/dtpPmyqei2zqjIzdK7Aa5LRlpE9T7BZt4C1BQPS7/8Rei45/TqhILq3GHkiWmu4p
	 SnhFI11vxBSXKHz4wickSXWC8hkzspO9BTB7RG2+FwX5mIzJ+HZ3sl9GO82ziSYsjx
	 Lf+BbCy7+TwyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E40DAD84BA6;
	Thu, 21 Mar 2024 17:34:39 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd-iGLkXgDa8cj8Un7xz_8zW-AYncpyfy16-2y9KNLNJig@mail.gmail.com>
References: <CAKYAXd-iGLkXgDa8cj8Un7xz_8zW-AYncpyfy16-2y9KNLNJig@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd-iGLkXgDa8cj8Un7xz_8zW-AYncpyfy16-2y9KNLNJig@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.9-rc1
X-PR-Tracked-Commit-Id: dc38fdc51ba650871f12e4032bfe170f5b0e8ed0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b3e2513730942f87dca2d436b797d17de1befef
Message-Id: <171104247992.9254.8622556479589349408.pr-tracker-bot@kernel.org>
Date: Thu, 21 Mar 2024 17:34:39 +0000
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Mar 2024 11:42:38 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b3e2513730942f87dca2d436b797d17de1befef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

