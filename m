Return-Path: <linux-kernel+bounces-102184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B5287AF37
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89B93B23393
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBD760DD5;
	Wed, 13 Mar 2024 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQCPgICD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6044A19AF16;
	Wed, 13 Mar 2024 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349455; cv=none; b=kCgl9rm0EwU1SD1s7nW8liVfJ4WkyMs38NvGMEAjlqGY2L/NwwNkSGcQTI7TwsE+EnixV8VPcwENs7IIDLE5MCNyHsdAA/bE7jWQ7EnhLsiSt/VlZgarR+jsP6jjY6spm5dJAz+3zjRGK/wKL1DJjXmiI7tx8rieZm2//h8ry+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349455; c=relaxed/simple;
	bh=a5rL3uSoSHvr2K1AY766Kvm6v6xSi+TSjOcPGaijD7s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BxZsARv6rVMQ4AUBELgo2TBI932AtsXlMwG04ecsxZwz+f1fZ3f2nvDoalqPDA2P3jDxV+1jj5js85k3Q0jSqipdWNHk6gHLs5fVr3P/o4gNpXhmO3eUR4v6FGt+rnCPe/il4mn1AZwQdggv/FjKpqPmpEWxZqmciLPSFGxqa9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQCPgICD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4226BC433C7;
	Wed, 13 Mar 2024 17:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349455;
	bh=a5rL3uSoSHvr2K1AY766Kvm6v6xSi+TSjOcPGaijD7s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JQCPgICDGMeT5jMU0ofx/08744EI4nSJzxlE79CV6TiLksQuEgSphh7DEpezgUF0O
	 7S9LT5hqWvYN1iKU5idyYHY6CU+QOv8aoWoxxi5qMfFeNueX7RYKoZLwcXwXHPvigJ
	 zRkPjFRsh2AfizJbQ9Vl7sEFt6e0G/WL5+oIMl39Z+2p32GDHqpdcc7NZshHvnXNFg
	 mD8xXs1IziUNSlC81eUS4oqobhxKohsB4CpN3G4EEULWCzo6HZXiY5aON0J9hBCSE3
	 3kwhakW9en110SSAV0M2AlJV08xR6mAQQvANvr2MvyCiJau5wTNrDrgvSvFX6PUTjH
	 MTHSVPRCSv5Xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30490D9505F;
	Wed, 13 Mar 2024 17:04:15 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <Ze8HJco2qTcDcxDn@infradead.org>
References: <Ze8HJco2qTcDcxDn@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <Ze8HJco2qTcDcxDn@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.9-2024-03-11
X-PR-Tracked-Commit-Id: b9fa16949d18e06bdf728a560f5c8af56d2bdcaf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d62cb2a59f4267191cf89f55f1bdf5ab617c123
Message-Id: <171034945519.7471.9436451160191471117.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 17:04:15 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 07:29:09 -0600:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.9-2024-03-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d62cb2a59f4267191cf89f55f1bdf5ab617c123

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

