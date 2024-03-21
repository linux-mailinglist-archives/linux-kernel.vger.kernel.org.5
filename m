Return-Path: <linux-kernel+bounces-110684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B118D886259
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 416A8B23CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0A91384AD;
	Thu, 21 Mar 2024 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svvgJfAi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F0F1384A8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055412; cv=none; b=N+MGDuIUOjsJ2ZBsxPYlz/IzgtPpj0SU/0pQ0i8mOxmH9PKUG2G6BNzDNzydo/BhKUHyHWTmRVmVLHyAj5+kxeOcojbY96Jpc7cOpu82hIBB/dYBuc0h+NZQQKecGG6g30naxjc7QzdvCbSearQQYtQunmaN0LC9Lv/XGyK8o00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055412; c=relaxed/simple;
	bh=s6MhBKvH/xClF8aMGDp/voXgERFIfoTmw+VDFzBg49o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XMbYHy7LP0zRfq1eUQruTT+E/A4Wd0Y/A/yEuExxUmrpbB8sBz2EzUFUEYl+rIYlMjU0eQJXDl3+dzPpRxcBc0RZ3dmXuqFIjKHlVGORTscmLaVA79ixVK8mWfMnUV5d7J81lafBmDd+LAAceIx12TVfRFFoDIfjQnn8d6CR1Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svvgJfAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7839DC43399;
	Thu, 21 Mar 2024 21:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711055412;
	bh=s6MhBKvH/xClF8aMGDp/voXgERFIfoTmw+VDFzBg49o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=svvgJfAik5MZ9RhzacYEbEEQP+yIda80PXx+OjXOvEk/WCZyyDA1gNBKP+DxCRywX
	 seWVIZebvwr5/d5yNuYd5b8vNBIZTXOayA6JksIqFbaCzzrwKdhfV5F+CttZk5rDY8
	 xdI2GS3WA4uINyYuteOWciMql3TFwb3OFADH7QIwztiD81t9+MPm7Abn3lXCzU22XA
	 zi+sMq5aayK/DxJ2k3TXXoO2Tm9reXBA68jIhhEvaztnnoYyu/Pn7bkfqsJVMkmQvy
	 5Sx1OKeog9h+92rV1NHOIF8AlysmJo0E+i7WGTkBpsRmuCfMNtgCnDe+DCiTumKaVW
	 JdV9k8U+SQVNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C48DD8C722;
	Thu, 21 Mar 2024 21:10:12 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver changes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zfwv2y7P7BneKqMZ@kroah.com>
References: <Zfwv2y7P7BneKqMZ@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zfwv2y7P7BneKqMZ@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.9-rc1
X-PR-Tracked-Commit-Id: 367b3560e10bbae3660d8ba4d0a7cc92170d8398
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb41fe35dce709ea8f91d313c558ee6c68f705ef
Message-Id: <171105541243.8284.6945957849027268942.pr-tracker-bot@kernel.org>
Date: Thu, 21 Mar 2024 21:10:12 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Mar 2024 14:02:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb41fe35dce709ea8f91d313c558ee6c68f705ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

