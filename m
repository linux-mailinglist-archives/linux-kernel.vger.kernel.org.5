Return-Path: <linux-kernel+bounces-103651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840A087C279
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B401F2288E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603C074C19;
	Thu, 14 Mar 2024 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onZjC/FC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9571974E0C;
	Thu, 14 Mar 2024 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440418; cv=none; b=k59RTjr3TKd2AEBzUnws/yiWTfgctgV0PoN4iiU7K7EiExYi0WbM0UWNkAnWtmZ+2OjkUK3LVtDjP4A1htiK7HNEMWqoYWrxNReWTIPA9dRVkE2CIsVIUBaHU3deW9t7T3xggMfdYwJzaCt5H/w3hsIjLBk+xudYrRJb19ZHXEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440418; c=relaxed/simple;
	bh=KDM7jL/NItsAlRX9ILapDaR20pwCqQ7VGHqbXb7CrIY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NskU9P16tcEJ026iOwePG5diVlQGgaw5e3Cm8YqtHKmUiZOssWx+6E7Z7ODt0gtFEsQfJmLruNlPXfnFIrweC4YijZbocijYbtA8Ys2mSaDDyV6a5AmFzKp1JDQTJSdqkTRrhl+CugX36TgjPnLvqaGUoqtHyleT98t1BxGL02o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onZjC/FC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77873C433C7;
	Thu, 14 Mar 2024 18:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710440418;
	bh=KDM7jL/NItsAlRX9ILapDaR20pwCqQ7VGHqbXb7CrIY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=onZjC/FCCiWlMBtA9NaO7JvjzT5DOMCEEFdy9qPUiKxMsCQP4pu/14b5Fr1q4XsCs
	 3jbVoG/iExX2CjHzEb47rTr3g7hOdNENhfwaXIxiJok87+u3eao4qxy8GrWDg72BuE
	 AfIuxS1fq/2UXlqlYD0GLk7SUC6U0AguuMPaV75THfTH4H7KD8atFUa6GcBI1XVs2S
	 yXcnUCf6sc0sWv+U2kfsu/mSvRqMQjT8TOkW7r8fdE29kn/Z2r4KG5kYMVXPvxZeCg
	 S6TwoaYKn5UAmWvLsW9VCu/2GWjJvBxZeA0cArVtnm3f5Ie8YbQUXEZu7c/tW1FluE
	 WkYGc0mtOvHVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69622D95055;
	Thu, 14 Mar 2024 18:20:18 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.9-1
From: pr-tracker-bot@kernel.org
In-Reply-To: <4844b67c9b1feca386eb739a4592bdbf.=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>>
References: <4844b67c9b1feca386eb739a4592bdbf.=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <4844b67c9b1feca386eb739a4592bdbf.=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.9-1
X-PR-Tracked-Commit-Id: 16f8091b49175f327120cdbbdde135d38a853ae1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66fd6d0bd7572fcb7859ebd4dbfb133881e1cd66
Message-Id: <171044041842.24196.11195751085454538927.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 18:20:18 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Mar 2024 12:42:27 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66fd6d0bd7572fcb7859ebd4dbfb133881e1cd66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

