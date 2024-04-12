Return-Path: <linux-kernel+bounces-143294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DA68A36E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC92A1F21900
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBBD1514CA;
	Fri, 12 Apr 2024 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SN3gp99/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA4043AC1;
	Fri, 12 Apr 2024 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712953050; cv=none; b=W0xo7F7RHZfeigcIbRjLxPBxcdnTIfcsXVOtRn0fCv8OVjsu1CBgWS/Pn41ATxPPMoG1IUtqbuXaCd8Zw8+xA+7sQVWhmO41NTnwi3yJMWlNKeWInoLl4fRpLP8GQkasCOeOg5EoWZIqMeAPlSAZ/bNdrS8WtLUPwGFUyDgQers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712953050; c=relaxed/simple;
	bh=XeYKWDAmiU+ijMz8HvnN3e/s2DNlpRN1ouiSnlAL2dE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=koWjDOPTXttMMMrUm5BMucYw/kJdU0V2kFuuYFKpaelAhmm1cWFPhCkui8Pb71ZnoiUxRY7rgMqaGDFmqh1/QE7OgWTLJiiPz2P2VEE3WpUKuo5NSV7+uCAvp1di52VtZKoctZoFez6dSpS0ePCCgIK4JsFo5y29xRrSl4WQ8UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SN3gp99/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6E0FC113CC;
	Fri, 12 Apr 2024 20:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712953049;
	bh=XeYKWDAmiU+ijMz8HvnN3e/s2DNlpRN1ouiSnlAL2dE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SN3gp99/53jJDx5ugUHBXUjQz4RTb2Ri+pdkME+i+BNBLbL4C7BI0zoJW0jsg7+X4
	 dxGoJN8GXtqrGCROM7Jm6JF6hj5L0LRnZEnKb1g4orzut52xN48bn/wKJNHoCZvAr/
	 zEYac6FYSZjuRw53MnQV8nH4JrSuaq9LlzAL9kCAk3h2ncZ2TPah+gkWG/3/y+rrLZ
	 VvYYEY9DuLdJakN4enf2XSfDUMaxZwp0PARMlKAddNfP6TdQM7vySZtlM+KHjaMUOU
	 yXgcBsJYiUCiasZcpESexcQ1itnydIWpoubYQ2jnv/1mM1VEifHuxnepoVMMk3fLDj
	 n9npaCY41dZ1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD48DDF7855;
	Fri, 12 Apr 2024 20:17:29 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zhl3n4fWSWswqzpr@8bytes.org>
References: <Zhl3n4fWSWswqzpr@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <Zhl3n4fWSWswqzpr@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.9-rc3
X-PR-Tracked-Commit-Id: b8246a2ad80a810cafbeddb30525278f9d64bca3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7c4e1304c2ef69fc2b75b39e681d2c0cb9f1d55
Message-Id: <171295304976.15771.7288432007426362317.pr-tracker-bot@kernel.org>
Date: Fri, 12 Apr 2024 20:17:29 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Apr 2024 20:04:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7c4e1304c2ef69fc2b75b39e681d2c0cb9f1d55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

