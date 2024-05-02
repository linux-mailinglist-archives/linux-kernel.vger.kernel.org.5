Return-Path: <linux-kernel+bounces-166814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B1A8B9FE2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00391B2277B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2728171084;
	Thu,  2 May 2024 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvkJkCtb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217FD17107B;
	Thu,  2 May 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672672; cv=none; b=CGawM10VSpEBAm5GGxtT4I3Ib9EvayfCCJO2pZKB5CuM50cOsTft2D50haztSBBXQsrXq4cGde4x6s0X1oCsRPmL/k9AGyeywusytV/91yLkwUXay8MsII0+TUIRgMD6e0/h2GD+lWoJpYvRXPFX0kVmBMwjXh514WskxPRj8co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672672; c=relaxed/simple;
	bh=mo3KkMdvlHZH2LdnRXWAzCkeOi77WBwbcDcaxwdcuPY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hG7JPcYKEDjjX0dtIwvZMaa6T47iE6gNvhDYYeKqcTxilmr7tz8JDIvozBZeEPd+wOwe3OuDUi/gFb7DxFMC1/Bluw1dk/fsKHvT2GuJmw1gSr/0JXSlS7TBegNEnRNfNhyZ7eTNu6lzq+qFLjJ5KyvXcBpW2g/WeV896U9sLx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvkJkCtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 911C1C113CC;
	Thu,  2 May 2024 17:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714672671;
	bh=mo3KkMdvlHZH2LdnRXWAzCkeOi77WBwbcDcaxwdcuPY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fvkJkCtbWko0CtNi/lK1vEbwStVV8kphiJqXfM7B4dxUNx4Gqgzi51cqR9xk8KT+h
	 Ka4j1azwB3BAaBRWWOepQZov9gQ5ijeEXW1bklOz2W+YBdj8/Y/PLJRbgUdfllVUbF
	 HcL64EJa4uEuE86t28Zf0SxCKn2/sukOhfd1GavpF8WiIui5po/JBzRJpSYa+5gHDG
	 +0qeUjMRPAyOeEKQbbwfLDEKbJAAYdyv/ogXPmQ5a1P7u24G9LHY79vA+wF+MMmnlE
	 P8nFFoYWU6A+3kz6fxHo1GKDvrPpgJezIbLE0q199eDKLp4RERnYku06Vi9I49KiPz
	 TVzWNkMO1/07A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 857F2C43443;
	Thu,  2 May 2024 17:57:51 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.9-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZjO+p5wo9s16F+hU@tuxmaker.boeblingen.de.ibm.com>
References: <ZjO+p5wo9s16F+hU@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZjO+p5wo9s16F+hU@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.9-6
X-PR-Tracked-Commit-Id: 7bbe449d0bdb68892cc67e9f5f1bfa106a3588d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da87c77ebba3ab79c4d41c678d2c703e36b02f0c
Message-Id: <171467267153.26516.8865215785529566089.pr-tracker-bot@kernel.org>
Date: Thu, 02 May 2024 17:57:51 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 2 May 2024 18:26:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.9-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da87c77ebba3ab79c4d41c678d2c703e36b02f0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

