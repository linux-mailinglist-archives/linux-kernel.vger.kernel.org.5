Return-Path: <linux-kernel+bounces-41891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E11F83F937
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B766B1F21E31
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB563C099;
	Sun, 28 Jan 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0NTWeQO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1CE3219F
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706467642; cv=none; b=KdLJqB2YfMX4CvGqyis/fNJqz2vCukijV3/qRZgfHTwinSgNghrG86+rZ93wXEYaZc/xlFMfmFY9zKS+M09J19/2uLxW6rTI8L/8KndN0WITEkOHV698uhkvnnQbHj2dJuiM6bIUjNnytXSPKnseAxy4VtuFUsJDuhAVHcpIISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706467642; c=relaxed/simple;
	bh=HjS4JJDi8ddizTBbFlWzcvpazJudUZFL/1J5BLHE2jU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=boQlMwvUJ4qqLneFyILg0GI+llVC6p1YZCZV9Enwpc5YePL9dH6b8FC8GwdF6frtvzA6rCqihvq0yoAPbeDWFsYa/H5a3nzz3/DLRwiKeFPpNFDehq4AjgEVCfMxH118bFdzE+ULgUul64ynZvGSKWMYdw6HpnA+CW1PRopiHXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0NTWeQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79E85C43330;
	Sun, 28 Jan 2024 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706467641;
	bh=HjS4JJDi8ddizTBbFlWzcvpazJudUZFL/1J5BLHE2jU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K0NTWeQOsNNuzs6OZNbh62WmgXFsMktsemmt71Z46eP3basBGfizlWGiTovoOtQLE
	 dmkiiSWjma6eQWBETDky2dH/UM/pGEJMYw3cdwrG7cv/Sn1/5x6NetGIpDFvOQk4YT
	 NusUHLsuOMw8+Ie1jmT5G8VWtW3zFm2h7FQMPcrwCmuU0zjfKlXoTdvu85ckxlYwMY
	 UekwmIpCR1eVjWqN03I1DyfQJLcLMNbvFqAuv1NaltVETkHHTE7k5i1+v6i0K6r+tS
	 +XJQUjMIlYTeX/lFL7StxZaBYkrcc3aE+RBbfeBB1BlP5nYQ0AleYlo7HBthyXZ+7Z
	 er55SoVZcENWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60B6CD8C962;
	Sun, 28 Jan 2024 18:47:21 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240128100657.GAZbYnQVcyLF9Vm5KR@fat_crate.local>
References: <20240128100657.GAZbYnQVcyLF9Vm5KR@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240128100657.GAZbYnQVcyLF9Vm5KR@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.8_rc2
X-PR-Tracked-Commit-Id: b9328fd636bd50da89e792e135b234ba8e6fe59f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d451912dbef72b4b4dcaa99229f98b309338b39
Message-Id: <170646764137.17624.9737214569089776178.pr-tracker-bot@kernel.org>
Date: Sun, 28 Jan 2024 18:47:21 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Jan 2024 11:06:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.8_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d451912dbef72b4b4dcaa99229f98b309338b39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

