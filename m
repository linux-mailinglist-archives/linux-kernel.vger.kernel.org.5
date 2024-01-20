Return-Path: <linux-kernel+bounces-31937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC24833703
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 00:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4B21F226DF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 23:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB77A14F76;
	Sat, 20 Jan 2024 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvU16WEc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0817214290
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705792139; cv=none; b=uZIvIFdr+qrVNQu9/OCylUpYEjwT1FrQUFG/b0hnEjadEVM9IJnRX7CKNlE9gRulYeYAx1U/L9l9W4Yw079T28ANB8aUwtAK+2O5CnmRl3ixRUHxIZvaACZVw3lNsTqEVBUqU8AgdP8kqR6WynsNHYRMEKRjWiGG/EIYelBke1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705792139; c=relaxed/simple;
	bh=BY05ev5BIfiQRKzxvFHVMIvKEEN0ZZVDrW38cA/MI2s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HFlhwPM58U9TDqk5GO78rVDej8p1KthZY5AdYq/UTL9oeO88F6FVgVqc2K7dxVfz75kdyWOokyrN5UOfq06/ueOE1TbtyGjvlKbcMIV3+qK3d9SKoEIhAXhy3u4Vl7izp1Df/94t6htWm6W5MR6TJReaBrlB4S0xkuItH5JiWpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvU16WEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDC2DC433C7;
	Sat, 20 Jan 2024 23:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705792138;
	bh=BY05ev5BIfiQRKzxvFHVMIvKEEN0ZZVDrW38cA/MI2s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NvU16WEchaJ6pNFtum82r4yu1iNETzjrltH/oBmo3ywJwbjj42SzRAkskdFKdk/M+
	 FYFzLS3O1NGYOrGVG8QH390FBUdBOBDgKuABfVriWWm42CwA5uRND/kMP+g8Wuj3gt
	 2r+1kbtqm+eQynDbflKyX5NZVVSKCGwF8kfOXZqkJQMpF5ZMYFBqv8FL++TflILlPy
	 DlMnJ3TX01QfVjTRarM3OQqqg86+H3TqA1kWluO7zzw0SEQBSFoHVDLyCDgXf7koxv
	 j2yjwGcpDmDVi7yOgHIhetXJ+4sBV8y+1BIVDdn3aBzpTJZSKNTHeH28jXaJs9MiCj
	 Qif47eY6UxTQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B17F5D8C96C;
	Sat, 20 Jan 2024 23:08:58 +0000 (UTC)
Subject: Re: Re: [GIT PULL]: dmaengine updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZawhDA2SlQAVNsFO@matsya>
References: <ZalezMgxAVyu5WEE@matsya> <ZawhDA2SlQAVNsFO@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZawhDA2SlQAVNsFO@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.8-rc1
X-PR-Tracked-Commit-Id: cb95a4fa50bbc1262bfb7fea482388a50b12948f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65163d16fcaef37733b5f273ffe4d00d731b34de
Message-Id: <170579213872.25914.14124364631391817291.pr-tracker-bot@kernel.org>
Date: Sat, 20 Jan 2024 23:08:58 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 21 Jan 2024 01:07:48 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65163d16fcaef37733b5f273ffe4d00d731b34de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

