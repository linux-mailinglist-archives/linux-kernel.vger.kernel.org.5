Return-Path: <linux-kernel+bounces-77119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C6C860169
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645871C24229
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040F915B0F7;
	Thu, 22 Feb 2024 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inTS2KZu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E6815AAD6;
	Thu, 22 Feb 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625915; cv=none; b=O8nSMaWv7uQ0X72UFDxyovC7ffu8WG898Es+85yTdggRSTBDL6QUF121JqYjAVcMLZQHKxQfPo33doKEH6hJ0Wd7Nqqx5LO3IHCVccwC8jzPOg8bqN0/vYLUKBJunTfteri3+u2pr+RSDhct8QthSTRcGGUr2VAiPiJDPXsd8g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625915; c=relaxed/simple;
	bh=u+9EN6ERKDE39SjxHFI1svM8GcW1/3jXcz3xYWOcp0k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ljAV+eS0Un5jDy2OWX5p6kPbtqAEcA4eG6rhPcfKa4ewrS3qfMKrynctpvMSi4zB61x+7IgpNwzRaZeh/o+UCEKtd8piVXYa+FJsr+za7PH2YeNuAjzVpeiT7upHlF3BdVaA3Dc+bHGOiMNMkhYQG6DVRbe487xZKyUDL6it3uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inTS2KZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEE76C433A6;
	Thu, 22 Feb 2024 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708625914;
	bh=u+9EN6ERKDE39SjxHFI1svM8GcW1/3jXcz3xYWOcp0k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=inTS2KZuJEhAznbI40WS5tFjtOn2jILZ0gOMcfkMRMtaAtR+k3l/XtI7rocah7z9l
	 9vEIQSZLHprPIjFwgiqq82vL5+C6XYGCgl3JLHlSipLf4CV2eqH3aSUjUgVMQ1TYbW
	 OejWgg1sTGzJ+7V25/A2X1JsjDBYPmUccffZKIIWRaJfR/m+fan9eaDWbl/5XOxvAo
	 UCjgC47AV2NI+z/9j3QP7gTu/kAQiCSEkaRRYlehL9oPSMJZL6mJjeZU7lef705hG6
	 RsWMQQUAdjG4zgj2U5hBk/RrD5iyABuox24ZLTOVTnR8XbLm170BjYjyJlYluJhs9f
	 N8veNlWuzyXXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B25BC395F1;
	Thu, 22 Feb 2024 18:18:34 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.8.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240222121950.35761-1-pabeni@redhat.com>
References: <20240222121950.35761-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240222121950.35761-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8.0-rc6
X-PR-Tracked-Commit-Id: 359e54a93ab43d32ee1bff3c2f9f10cb9f6b6e79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6714ebb922ab15a209dfc3c1ed29d4bb0abc9f02
Message-Id: <170862591463.18883.8556641238765747283.pr-tracker-bot@kernel.org>
Date: Thu, 22 Feb 2024 18:18:34 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 22 Feb 2024 13:19:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6714ebb922ab15a209dfc3c1ed29d4bb0abc9f02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

