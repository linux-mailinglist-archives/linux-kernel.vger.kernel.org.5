Return-Path: <linux-kernel+bounces-161127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58C98B476F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12EFF1C20EA4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D834144D22;
	Sat, 27 Apr 2024 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCQiZRGO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D577E8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714242490; cv=none; b=UN96Qp/qR6PJ2C8bwJ9wuwHxMCN1lwa1hea2NSWDifBL8YdadoNIFeeVjnwWw5/BuVIDBIDwcim+EaW1idZuqs8mC+rN+3IbQpn0p38dKwqXhEXkfRcce1XbG0VSJIRDycWSBsSnryKHBDFwc3AKF0eF1qwBCiAyL2tJvQrH4vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714242490; c=relaxed/simple;
	bh=E7aS3cpwnxTONVAndgOYn0vCgr6CWehlZe0mLMviDrQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LNcIJZFNNb74CyJqbq4mKaWRL0amxq+nGJQlBJ2CREVy5xwnCT71IoyyAFUw6Zyz7NIc/NvI9O0OzN4TS2vWpGLa8AWSxk5Th427W+3ihMOFxZhnGajGb7XJ9kyxPvPGf551tL9WD30n8SAdleWih3CCccNhEeVWB9a+1RYxj9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCQiZRGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 762B3C113CE;
	Sat, 27 Apr 2024 18:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714242490;
	bh=E7aS3cpwnxTONVAndgOYn0vCgr6CWehlZe0mLMviDrQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WCQiZRGO1ahpU7VnA+8awbJLpWMrfn/ngedJQGXV/C/FQSia5SFyikq7p4KV+U6iv
	 4VyJDeGmPug1qpVZrozo0MhrDuJ2wl3CbiQbmdiS0GS2qsZGNQkIRlXsIumRh96/Oa
	 PP1riR4EF7f1dZU2NoFbxh/5iajGYPUEb+mfzcE74Cht63FOUin0XVkuWf83pgxe2B
	 kRrRtOxRXKgcpQIhwLNfS+SrARaKPK0Ibzr3Byp8moDW63jN87wCA9WqU99giu7TFd
	 Ol/4rVsull+3nlppkw8X08f3AlmY4nlDyO8tyK+Ypib179HS6zH5TizaS1fGz2UY1P
	 XM4ejmGZ+16UQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 641A1C433F2;
	Sat, 27 Apr 2024 18:28:10 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy fixes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZiyNOxDiY_Y7TucF@matsya>
References: <ZiyNOxDiY_Y7TucF@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZiyNOxDiY_Y7TucF@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.9
X-PR-Tracked-Commit-Id: bf6e4ee5c43690e4c5a8a057bbcd4ff986bed052
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63407d3081a6b406d94bd7d96ff2ca38fa7df236
Message-Id: <171424249040.21148.5773415868515226578.pr-tracker-bot@kernel.org>
Date: Sat, 27 Apr 2024 18:28:10 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Apr 2024 10:59:31 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63407d3081a6b406d94bd7d96ff2ca38fa7df236

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

