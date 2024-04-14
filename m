Return-Path: <linux-kernel+bounces-144305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8798A445F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7720028256E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7237D135A57;
	Sun, 14 Apr 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6E/LxAl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB3135A44;
	Sun, 14 Apr 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713114775; cv=none; b=c4tnuAQBAXVG5WFBpB00fJghNRGjobLQODsoSNi9FVfXRXaKMCT0IHVundzia3Rzzsd9CXrbsAydrY/I5grDxPyuMms09ZtO8d4O5Av7vlqAiJPdMAco9xiDS0m9AAp7BWCqWrRwcbKW4HAVilrQdTjGbtuTtI/6syFlrQPeKOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713114775; c=relaxed/simple;
	bh=wPShx1ersxdUFz3CaYjPcvCbuCdd5LFEfvx3eDR/03I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=etmPT3WOEx+uMhLHSI4RmgF+PuLwiQ2ZT9DvXJj2LMVWf3lDbKFNNfW01TFoaFWOi7MwoZj42Ef83YE0wSbc2tImGrW7IsxGrsvBA2aorY9qWkqJqa8WiTK5hIof1Fk5uwZyI5nGbsH/ogYqZ2TlQvvUhRsLfmFSK8Lq/xBsKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6E/LxAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D75CC32781;
	Sun, 14 Apr 2024 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713114775;
	bh=wPShx1ersxdUFz3CaYjPcvCbuCdd5LFEfvx3eDR/03I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o6E/LxAl/zZBPJFhWx1MRVIp6drGPrhXNw3T7kikxQhzc23pHj7jceubnAos2r0lQ
	 F4gRN/nCnnG76aSE7mIaGvNJz+MvZx/oh41XIY43wZlzKZN8mBUZKzsV2OfUdaU/lo
	 Jplqglnb5BDsIelUE8X0S6eOjBIHqFBl6/YswkcJTnGvx0p7eNfThQRfBgXJBKc3/n
	 fC5KHmdtb55qOUvBdtPvUksqoL196IMbu+aROdosG0/45fvqgdD64zP3bN0Y2Xmj1n
	 aaryi7UrDrUNzr4NRTQ4NzsJSHwquQ2avLoZthOiZx6shz7grrZyUmf5OFDsRBNTue
	 w1zhuHavTayUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 438DEC43140;
	Sun, 14 Apr 2024 17:12:55 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping =?utf-8?B?ZtGWeGU=?= =?utf-8?Q?s?= for Linux
 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZhtlGONZlLq-U0B9@infradead.org>
References: <ZhtlGONZlLq-U0B9@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZhtlGONZlLq-U0B9@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-maping-6.9-2024-04-14
X-PR-Tracked-Commit-Id: a1255ccab8ecee89905ddb12161139b0d878a7f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddd7ad5cf1525b59c8231a6914156ebb09398cfd
Message-Id: <171311477527.23099.7650523854931386399.pr-tracker-bot@kernel.org>
Date: Sun, 14 Apr 2024 17:12:55 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Apr 2024 07:09:44 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-maping-6.9-2024-04-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddd7ad5cf1525b59c8231a6914156ebb09398cfd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

