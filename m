Return-Path: <linux-kernel+bounces-69039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2808583A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED78281BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DAD133987;
	Fri, 16 Feb 2024 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLKHDqLx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF73133422;
	Fri, 16 Feb 2024 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103467; cv=none; b=Pmtbmj6NfCHU65hQIxDsTXulw84TQlnMFWZ/GSEkD+pRHJf8Z1sKKBwMqcq3Y01/IeGHk5z+A3G4uaLVm1SQNgJ9lFoXouuqhqONjpde6KudaqK6fCs/GM+CfE5kp11kD5hO88Erwi3QiXO7jH7JIHbJHFyFt4Xu0kfkb4EUasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103467; c=relaxed/simple;
	bh=WXJAGYcUL3iK+dw7CPyuDAhQdeOfwhX+2DX7C567vWs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uSrcKQXL4lWNde7B7FN2iJvKPWvMCum6dISB/wueFYl65PrJvWsqdBmB/a42bEFY0GZYfavcBj9oTKyn46VcYYgLNKqloVQiAB8/O/uj1bvSAomBmdvcL3Do2tR3liZeg5Gy8tTXr3tv4MuGIRFJgkt6KaxtdcJCdPAMCEcvGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLKHDqLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5832BC433F1;
	Fri, 16 Feb 2024 17:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708103467;
	bh=WXJAGYcUL3iK+dw7CPyuDAhQdeOfwhX+2DX7C567vWs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OLKHDqLxMsqVsm0d65g2TLKCN/Vt76rLJWR0ddkKJEh4/NxO+6ecQFuKhgGNA7n2Y
	 L6gcxhAvgF1ETTze2T4CdtIgHB/4jmDJ2LBttkcknzHab+EPLnrcLp4InZeVDygm+C
	 Dv7xn+ru0nhBxCa30RAgCwhTfHFpo8TqyQSr7sK2N2AbnXzIuZWAjH1IhSWOEbxYZJ
	 +ui1MFF8vDV7HRM9c/4nceB1i0yS3GJ5gGKKf7fFjatRSnmmyaSwIyfgwfmou8l0RJ
	 WTtXLelHP7tARopSWItWjl4WBEghNCovxlMk79NhmhnliUscQrBIbTJepSclC6lAvx
	 OZYEkUb9yDaQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45B48D84BCD;
	Fri, 16 Feb 2024 17:11:07 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <875xyoijo5.wl-tiwai@suse.de>
References: <875xyoijo5.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <875xyoijo5.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.8-rc5
X-PR-Tracked-Commit-Id: 41c25e193b2befc22462aa41591d397fab174ca1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f1dd5e91e2ba3990143645faff2bcce2d99778e
Message-Id: <170810346727.29072.14572446337595903980.pr-tracker-bot@kernel.org>
Date: Fri, 16 Feb 2024 17:11:07 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Feb 2024 15:10:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f1dd5e91e2ba3990143645faff2bcce2d99778e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

