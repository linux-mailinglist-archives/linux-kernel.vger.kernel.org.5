Return-Path: <linux-kernel+bounces-105247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7289987DB0A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10EBE1F21A3C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0051C69E;
	Sat, 16 Mar 2024 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tybvwkyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C4D1C68A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710609779; cv=none; b=oxyeh67Pew7EvCVxiYXR1EEAoMAuVul5y1QRkDjn/fmOWK2YrpOjUlTQlPCxCxVFlN1ngR6Yl+6Wp0gbNW3IISBTnVB2sRcp+pX0dnjDmBD9Q14m1wgx+9gFjfTwTsL5CP1T6rqTkie9cLnzaWSsBVF77VPTtb4O/4H2lJZ7qxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710609779; c=relaxed/simple;
	bh=RHiCHySFwMLdaiN5efiUfydHTtZmEujXbTlhJH3krSU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mT2JzjsITgUzX8wtPkbkBGD0yLSTmEDCr7X5RkTk9s9m+iyjXPldX3PBH7/JTiEoSmkfZVC5rnNRLOjDRf4nJPtQ0cGSedkgtn4DnIBSPB73743l3pZIrAoPNaI9ASPYaikzgseVJnisV3YdGhjr1nqBIpuwk7zlXSi+5NsBuvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tybvwkyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EF51C433C7;
	Sat, 16 Mar 2024 17:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710609779;
	bh=RHiCHySFwMLdaiN5efiUfydHTtZmEujXbTlhJH3krSU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Tybvwkyy8IpzWRWgN884+HPcg9uIC7wdrBVXzcE5Y2j7TD3dLgw7UI4clsffK7C1K
	 NvHYE5iPXU4yzDRDC1rZUfDu06H6hfyS2120yd1Qq7WWED3/hBMTdha3u+86bdJzpP
	 68BogptKgntIuf3zjA9ameDKwIcT5mBx6WX54g4Kb+gHmAasKpgRsP6Ej1e/ucs/C5
	 qujNk79YRlpUksk8YL7D8zHGzR0iZahOrHyxmSLNldzlLFRTQB7W9xjj3/vR6qXdal
	 61lw8j4e789TH2QX1RRfL0Up93MyIRDcPpST3pMbgpNNp6fqoP82o7srq1xhWRkHuH
	 u0JYWeos0sjLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 379D4D95055;
	Sat, 16 Mar 2024 17:22:59 +0000 (UTC)
Subject: Re: [GIT PULL] firewire updates for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240316080544.GA395657@workstation.local>
References: <20240316080544.GA395657@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240316080544.GA395657@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.9
X-PR-Tracked-Commit-Id: 04f082d39b99f0b7b4b1cada14280f41d99f1e1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4438a810f3962a65d1d7259ee4195853a4d21a00
Message-Id: <171060977922.10702.8063974855756052072.pr-tracker-bot@kernel.org>
Date: Sat, 16 Mar 2024 17:22:59 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 16 Mar 2024 17:05:44 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4438a810f3962a65d1d7259ee4195853a4d21a00

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

