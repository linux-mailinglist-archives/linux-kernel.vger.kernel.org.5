Return-Path: <linux-kernel+bounces-152543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CC48AC04B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560981F21043
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 17:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571203B2AD;
	Sun, 21 Apr 2024 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGQMHrue"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A438DC9;
	Sun, 21 Apr 2024 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713721014; cv=none; b=SJgOM2iwx6M9RVz6cCxiw7lhTeWIqnKdNcBcT/o9wgnf1pbUq0hlAWcB+V8RbxR5GE210nvl8I6eluhVfwMG6U943vo4o4RpaSL0OSgdaFk5vcHTP4gY4TU5/gLT4xjqv5F9KAVwqNQ/xnz226/KkrtVlyeAjq/EGjhCVKhm5AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713721014; c=relaxed/simple;
	bh=Md1QKllola5dBA2g6a+q5M6coorF+C9NyA+tmqQTTcU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LG5xItw0zRvF0fMwIW+DzkEXvEUZ74qeRySPO7RBBn9CC9eB76CwiR1hRk5trf2Twm+re+iDvb7YiuOHxwIYXgstWrxRMVWs8BgAIVQLquhfeR36iBiTN15LinQ3YIfRg5XQ+0CuWOFT8V0UrOtTGvLvDkXiO6wosA182ULfM0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGQMHrue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34E41C113CE;
	Sun, 21 Apr 2024 17:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713721014;
	bh=Md1QKllola5dBA2g6a+q5M6coorF+C9NyA+tmqQTTcU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oGQMHruey/QaCqVXqxjEX+NzUO8PA1WvvJBPBR95HMiqGW7KK9x6JfeL9O+7mqOQn
	 LQKzdazW7dfv/2lSGDPiuYWgrjXruQ2Y7UU2kb6+LcuvB6uznIVr69//ELaiv82jkM
	 lZCOJsFcMwuYH4lQLC8zRfk21ANVaebJrURCSrpN2klKmIpxK2IfnqkumFfV1xxlDO
	 JTSEUjlb4w/dWfTUtmBTVuBZv5RMVh4aLqpSCZ34qPvCwlu83fClUbhhw2++cFS6Zw
	 AzW3rpbcGpzHWe6OFvq6mrKY/sfXDAjd+sExsgSUnTxveUuGs4S1JLvo1izpkMYPQI
	 77apdMo0k+jAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D461C433E9;
	Sun, 21 Apr 2024 17:36:54 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt driver fixes for 6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZiT6LyZvHAwg7Vye@kroah.com>
References: <ZiT6LyZvHAwg7Vye@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZiT6LyZvHAwg7Vye@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.9-rc5
X-PR-Tracked-Commit-Id: 7a9a304069810c0c5296b851f228f8966d3a030e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5fa0ab4547ceb1a0f839ac0b8ca5f7f14179b0e4
Message-Id: <171372101417.14492.18106666329000427892.pr-tracker-bot@kernel.org>
Date: Sun, 21 Apr 2024 17:36:54 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 21 Apr 2024 13:36:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5fa0ab4547ceb1a0f839ac0b8ca5f7f14179b0e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

