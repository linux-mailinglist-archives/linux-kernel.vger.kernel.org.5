Return-Path: <linux-kernel+bounces-30712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0AB83236D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47A46B23366
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE8C208A4;
	Fri, 19 Jan 2024 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEa3oi/7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A65DF59
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705632025; cv=none; b=nZwEoyYQvGBFEQMTMjpKW4FS00TxG09r7Tk4aN5M0P9l9s0uEQdx0OaEWsV+ZdRrt2A2pRn6ktLPTA0KMjV6xjZnfcchy3Ba1o11P0kIFL1byuJ0GWm8MjJo9Zt1LO3bN7fOL8HlIBauNHqM05FWFu4iACyDAb0wFVhjrjU8TtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705632025; c=relaxed/simple;
	bh=E+fCYB/sEqtPWfPMF/dlJXR0QCe7flp8ThhyzfjxGV0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t5Q/odgd0wKmBIRq3gXCp4Y4U4yv5nKGjfggzakPm3wMeVxdogpl2jvCJ9iiVnwDYyKcyWXtQ0FkA/jM6J6ZaaHchrx+DLszCb74G/LNiO4UKcfr25MCMYCtTMbzqoqEwzOgXFHkNZagiCbaKQ8ceteLVAD05qCJ8382Q3y+60A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEa3oi/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD526C433B1;
	Fri, 19 Jan 2024 02:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705632024;
	bh=E+fCYB/sEqtPWfPMF/dlJXR0QCe7flp8ThhyzfjxGV0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qEa3oi/7zC07azFspGXKvgaZfFTHdc6LALdeklhiwwJcITVOSGCEgW5ZDXatUA4xp
	 skO54gKwgJ+sIrDyqxLiyH3t7jmtVCCyn4f3RyRaGUDInYqdo7jF96NyKZVBFc6g52
	 IGzfXKQ4TrBR/YG8mMvvMWOfFXNOCswSiAPHzYdkZ+pMIdzdhCaPmXtbdhYiFp7zhs
	 1GCCUh43hYw3Hyb/L+SENtkoEBO161+EuhkXjylwJGlt0DsaR1eK9wRqV/DtZsIERi
	 z6sp8tJKvDk3VXV+s7hkN1j5uZLN5S6pjgpheXEuXOwVtMDHjFvTDPK/9qmHn8OLyC
	 PC8xEwTw/P3Lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE4C8D8C970;
	Fri, 19 Jan 2024 02:40:24 +0000 (UTC)
Subject: Re: [GIT PULL] kgdb changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240118142748.GA109045@aspen.lan>
References: <20240118142748.GA109045@aspen.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240118142748.GA109045@aspen.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.8-rc1
X-PR-Tracked-Commit-Id: 4f41d30cd6dc865c3cbc1a852372321eba6d4e4c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a668d217676c642bec02ee3b5b73a623f194f7a
Message-Id: <170563202477.16016.11602693942016633289.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 02:40:24 +0000
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jan 2024 14:27:48 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a668d217676c642bec02ee3b5b73a623f194f7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

