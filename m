Return-Path: <linux-kernel+bounces-132230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF51C8991AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE7D1C210DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6804F13C671;
	Thu,  4 Apr 2024 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eh0hmAk1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE05130486;
	Thu,  4 Apr 2024 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271489; cv=none; b=mHaoLznYHq8sBWBWOTKJ2nMgxlGQpkScIxo/dZRxB4a3bRZMkgRKPTFuIIMyimPWmB0/tZc+1NjkbktODm3LxrxeC//0kiYKO6euXdPkTABAzWdkS5APFfPE5mtox3KFAd+PIWYrRoAP1N0unlIQ04cUNYk644Qdm9FHSA+QmHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271489; c=relaxed/simple;
	bh=PezbfKWA9/zLRq5U0KKUBbgjiHoTTX4v6n8hqaaXERY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KMciqon0dLai6S5d/PSCtLBuqLZPVu1hpBPc50dkfsCd7xyf07FhcZoZPSltuws8atMtFmGFzAH1nFi1yyWltEht/dO+NY1GQb8tjn0kIAbNn9i39F/Ek3FFMdZhQiptrEIcNuNQykRQaF9W0ao0Up9utlNE6uNkX4V8W7kGogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eh0hmAk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7540EC433F1;
	Thu,  4 Apr 2024 22:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712271489;
	bh=PezbfKWA9/zLRq5U0KKUBbgjiHoTTX4v6n8hqaaXERY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Eh0hmAk1WUPPuAVhDKb0YlcajjCBN2eMhdnOlW0Hle5wLbmStr5VEa5MdEASIQnLS
	 s9k12FxE8dvBu8jX4HaF9GQOMCvZKpqgApwHn3XetK+ta/UCT8VoAo/HkXmH6zVcE8
	 beyXRmYcOrv28PcwD5MXL9bYjUtJIslvbJyqEwFTW2SQLHhvH/GbgrJyCifJDUF4HE
	 004keZmoDCeTqDzO8RHmFSEAwTU8+vHzbuPZUuBy1xfZNm0phJ+zw13vBkODgBoWrI
	 GR0e+K8xjXRFsXIir30qDvD4YUNDaXucoUQmauBbZyCZcQQMlemv3coGufF2OG05hJ
	 j2/LR191a3GEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CA4ED9A150;
	Thu,  4 Apr 2024 22:58:09 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240404211803.2089033-1-kuba@kernel.org>
References: <20240404211803.2089033-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240404211803.2089033-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.9-rc3
X-PR-Tracked-Commit-Id: 1cfa2f10f4e90a353c3ee2150866b4cf72579153
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c88b9b4cde17aec34fb9bfaf69f9f72a1c44f511
Message-Id: <171227148943.29192.3334113390444751593.pr-tracker-bot@kernel.org>
Date: Thu, 04 Apr 2024 22:58:09 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  4 Apr 2024 14:18:03 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c88b9b4cde17aec34fb9bfaf69f9f72a1c44f511

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

