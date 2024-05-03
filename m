Return-Path: <linux-kernel+bounces-167907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26718BB0EB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2BADB21102
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3FE156872;
	Fri,  3 May 2024 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEVulvFj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD3155399;
	Fri,  3 May 2024 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753773; cv=none; b=cfpMYI5qN2NQ1mWGi644eVRuLqtoAYQoTJogOzub5Mvyk2tRGMCjm4xeyZ4WuY18Qqkv99oOqEWLyqqHSrhZqdq1oKq7HTSOEorDsaeBfY/+K+XMlUcItAd/cJI3AmWXNXFugwjE0rcbuKNnv7yfaILN8SQnQ/5yeXNKCZIYPbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753773; c=relaxed/simple;
	bh=hd/YZdWt6sgNbnIMIwH75QlFk1dGTnU0ogycEYwpb+k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iK2NauGNViJrr2DZbp6hCdkkxY6uEFUtOKjHYEddQuOgTB01Ip5ZGZtKUCq8ZYnKLqqvE088pUk/JLtqv+ppNoniHoxfxwKfPMrj8Z117tVtpRvMD6aI51S0e7npCkm62l6Jk/h5XCc8ZKBVPckfTOGbTes4cTdKJMUBbvsDbow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEVulvFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E0A0C116B1;
	Fri,  3 May 2024 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714753773;
	bh=hd/YZdWt6sgNbnIMIwH75QlFk1dGTnU0ogycEYwpb+k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oEVulvFjyL7iH4oq7JNYVZ+g28kPkoFCNiGb6IkOoekPKBeM78FbA/GX6jIkZ4+vT
	 ZGxq0tgdxd/V1IPrSbZk3R+osArDJFEq+JgVVqpKpnsoHPZQrf0fNMw9T7X2IYFvKv
	 zy8mLG1+4mbXDdjY/Dn+hFtWqt64Lb8Xq4fbGlc4VwYPOij+j+rGlSMod4gyqRrYxC
	 aWNfSF3VDitXl203CLATnteP9ug0xoTDw/Szc7DWVFE5cGjEIH5FZ9rYZIrXehFBM0
	 bJc3IhEkmazyFxT7XXctTNv2ckVCA0o2AARHtWQjiXmDEL3IeyC4IUcnmhq7sfJA2O
	 pHHhYkjnDaMcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0307CC4339F;
	Fri,  3 May 2024 16:29:33 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <5fbf754d3bc37a9d4f8c81c7adf78e11.broonie@kernel.org>
References: <5fbf754d3bc37a9d4f8c81c7adf78e11.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <5fbf754d3bc37a9d4f8c81c7adf78e11.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.9-rc6
X-PR-Tracked-Commit-Id: 4756fa529b2f12b7cb8f21fe229b0f6f47190829
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fbc8bdf17babc2c20dcd51ac25ed12e342dedd0
Message-Id: <171475377300.10066.17495402206141435197.pr-tracker-bot@kernel.org>
Date: Fri, 03 May 2024 16:29:33 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 03 May 2024 11:03:12 +0900:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fbc8bdf17babc2c20dcd51ac25ed12e342dedd0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

