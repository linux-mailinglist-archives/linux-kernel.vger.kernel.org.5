Return-Path: <linux-kernel+bounces-123869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E53890F13
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACED1C252C9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B56EDC;
	Fri, 29 Mar 2024 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCNsk5DT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA22101E2;
	Fri, 29 Mar 2024 00:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671571; cv=none; b=lWxjaYOIhjYDMMcgoPHYcIjgSYqj+mPmmRNjNgd947kLxLswA3L+y+l0qZHwVCyTK1/khI47ORKv1hTU/MlN9x2JTVpJawMixquiuOYuc41ISZLWjKgEbxp4ru8pJo6rU3l0Ude6CXAGbxh3B3Ar2M1sXIcWMq4v5DP0p060e4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671571; c=relaxed/simple;
	bh=/CNN2O3vc/GPE4Zd7unAHRAs4SXJG1wcPlfFauleMBE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lVrBRR9VuKuA7OyBYc+o9zXRRI71gKTScPV2PmyconFZZi4xiTTTzeOF+wYp00Q/WqYOdj6EiplrGPahkul1Rcw/nJ4Wc8TsfiiWyG86NFHOX1jpHiFDgJF7doQfTOLeGBUfP+AgnuuKPAygumSegdDB8avMb26lNrGDnHK/QIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCNsk5DT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEA79C433F1;
	Fri, 29 Mar 2024 00:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711671571;
	bh=/CNN2O3vc/GPE4Zd7unAHRAs4SXJG1wcPlfFauleMBE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DCNsk5DTZbYiFArK3wT5c6BF3Hrq2vM+NCGoVtaLGBe8ZUDqWFvcpx1DpQExspCrX
	 T0j3aJemuJJPxSXXAJvf8ha40bmJXp2Q5rcSenw0Igh2pPqj2R6bgAYLTrdiCyNaps
	 bdcSVo7IFz+2vzZYzH+sg5u9+NmX52d5j2Dd+6Hc1CebY2dPus6BbO84PNu4tnC9WZ
	 b4u67QdJnwQthCzv1Oi1f5zDMkO0kl7J1Eqnlthd74NH51kOHAdjTAulJyf/L6m2gM
	 SL6CDprBo255Eu+ZF2+Cc1cUtp+PUiW4+GCDJK50/t+o1XMHWbG7crV8Hmb3UaOeVb
	 CYb4zpWYGCpfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E720ED2D0EB;
	Fri, 29 Mar 2024 00:19:30 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZgUnyqosVrEtULhz@8bytes.org>
References: <ZgUnyqosVrEtULhz@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZgUnyqosVrEtULhz@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.9-rc1
X-PR-Tracked-Commit-Id: c404f55c26fc23c70a9f2262f3f36a69fc46289b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e7a2ffd209b59e98b6617d4b8be01af2391b580
Message-Id: <171167157093.21457.2326718701861092941.pr-tracker-bot@kernel.org>
Date: Fri, 29 Mar 2024 00:19:30 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Mar 2024 09:18:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e7a2ffd209b59e98b6617d4b8be01af2391b580

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

