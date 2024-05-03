Return-Path: <linux-kernel+bounces-167906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F088BB0E9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6520DB213EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2544915538A;
	Fri,  3 May 2024 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evF39V9w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BA515359B;
	Fri,  3 May 2024 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753764; cv=none; b=Rx6VK+picNK4GBPwO69BsAgK0iq5Oeu97791lLbeuhKNBycuvzXvg6k79gBR7qgXUKfVzuvvt2kpaKsoyIibhrIIe6e4o6nv2ItZz4TFD5fhebu/AEa9hyfKrWZ219BxAJodvIYNnOqkoigOIqaRgj2+MzLq/D9d14yGazJeRn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753764; c=relaxed/simple;
	bh=yYP7xhUZg1D7GEsmha/5B+SXr45i426+DcPQGK2Yg3Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iAVL98a8vMnVYkgetmz6iY6tfwt560aDI4779r1joY/w0CpyF3injE19QSmHFRwf+kn2sn+Xr2bBg7g2yVxwAKIpwUPHQvFfE2jZ3QpB4OoGbidkbo1OzNFYk7cFEqevRf6UStE7Z7I8XPS5i91/xa8kNycAVpLJJcjip2KWbKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evF39V9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6719C116B1;
	Fri,  3 May 2024 16:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714753764;
	bh=yYP7xhUZg1D7GEsmha/5B+SXr45i426+DcPQGK2Yg3Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=evF39V9whIPq7MMfZ33dRo45OWlHERxysxu1xhzm0qqzK603go67qUjAMZe/llR98
	 orZAP1UiQp1G374pWTJjk5TGPawyNQihWBoZyKniv4GEXA+eS1TYpIjZ4XN+KLef96
	 h0JosKpcnOKw1tY9KZhrfqEY1r7YHPAtznmYGD5kIv8SSoBN4sDW8sp9xEAU3VaOxW
	 QHv5jvwxdzwNk/a9QlaI5gwnmZ28IHAP4+whF5RulVIioCMfaj1TVECmacjajoHKtH
	 ocaACxYcQ/WnqgFnQbrqvQtjQd+HQfbW3ur0oDvcfUbv2DhDyUT+DdE8kjw+3GHCvi
	 JOg7TzFFq5vTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE2DFC4339F;
	Fri,  3 May 2024 16:29:23 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.9-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <87y18rguz3.wl-tiwai@suse.de>
References: <87y18rguz3.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y18rguz3.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.9-rc7
X-PR-Tracked-Commit-Id: fdb3f29dfe0d51bdb8e7b3a6d876ea8339d44df8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7dc78c7b4411e942edcf3796d81c001069b15253
Message-Id: <171475376389.10066.2166355779039612387.pr-tracker-bot@kernel.org>
Date: Fri, 03 May 2024 16:29:23 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 03 May 2024 10:28:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.9-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7dc78c7b4411e942edcf3796d81c001069b15253

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

