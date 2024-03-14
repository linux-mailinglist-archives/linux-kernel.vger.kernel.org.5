Return-Path: <linux-kernel+bounces-103657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F99487C281
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D321C21BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE6776052;
	Thu, 14 Mar 2024 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na9a34pi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F407581E;
	Thu, 14 Mar 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440434; cv=none; b=bcrGJQ9tZktvk22iCqIdSsgI44vyU9MCVeRoa4yTusCiu67aHlVwrWWVj1CsR4r5Bz39fF3m5Wst5fZ4r8gg43d0GFqVENWGrZvWINtfN652VPHkxl7eJ5rJxj+S56PAv90SmPHSMyxb4oIif+yMxSEf4kLZLOy5v8LByIBdfZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440434; c=relaxed/simple;
	bh=En9h4aM49K1ODmzZcrnUzkf49GvEV0uAo4ULw9O7InM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E/9qZY5RqkMaUsy6j0UwAOwvWcawHI37rFujcp2P7+d3Fj/DWgFp1jTxVBQf/zc0VbIwSrQzpozgDOScQy4ljPp2T+G2n+czDDqGs9TIygzRF4KTDRkYi/trt2vRh4EzF0pfyQ/FW/WaszUy/gEb7A+P5CTtrc2M6oXn9GxrWAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na9a34pi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2862CC433C7;
	Thu, 14 Mar 2024 18:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710440434;
	bh=En9h4aM49K1ODmzZcrnUzkf49GvEV0uAo4ULw9O7InM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=na9a34pin0xQj2UeBUMMV7xe8NY8YFJB1VERDBJPGgb/mChCDu1ouT7lVuYvbNiJf
	 rmXMBjtmDujZduOLWGKSH6bLgqRD+MppbSKiTp9La1dAz7IdXBihL93Ez4UiLAGaBW
	 /7ntbDMVuNh7hzHn1uUUee9bGqqeo3uRHwOQ7bHK9y+33WUjCpVEa1Sqmx5PpL6Ldt
	 CKjGmj1A6IEgDLgrF22XJ89B47WRxl+XZ6za6UmwsZDn3UxLMP4wSWkoECeqUBsJ7e
	 wEOLOnRxTyM51ztUAFn08HouEzSdowMxpZTxB5lRxvaIh2qhZccAibxJ7C/3rNiu/3
	 OQeit156YG93w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1DFC2D84BAA;
	Thu, 14 Mar 2024 18:20:34 +0000 (UTC)
Subject: Re: [GIT PULL] pin control changes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYZ01rEzd5d8RcDbZqBPdy4uVU1uYWH6q7XS1WjKNXrUA@mail.gmail.com>
References: <CACRpkdYZ01rEzd5d8RcDbZqBPdy4uVU1uYWH6q7XS1WjKNXrUA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYZ01rEzd5d8RcDbZqBPdy4uVU1uYWH6q7XS1WjKNXrUA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.9-1
X-PR-Tracked-Commit-Id: fa63587f94a77a49b53274dc0fd1ea41dfde5966
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3df5d5422b4edfcfe658d5057e7e059571e32ce
Message-Id: <171044043411.24196.17256053826707694115.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 18:20:34 +0000
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 23:24:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3df5d5422b4edfcfe658d5057e7e059571e32ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

