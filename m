Return-Path: <linux-kernel+bounces-101019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C85687A0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B824FB2213E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1749D10953;
	Wed, 13 Mar 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4PzfoP9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB36C13D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293430; cv=none; b=C+lYcmM7ooozNFGESde/aR6M40aHTnrYVR3HGxEo4FOycZJ18yJRi8FuSoY2ZrbTfS14eskSA2tQ0wsOSnHlJ22wWOwE8wO9l8TwJihNwLRLJkaYB+Yzbi8j+FxufS7zEmezdOLIIqFgrS4sFpi00PZvHpPBPiEX0ZBpIz6LBQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293430; c=relaxed/simple;
	bh=h8pOeiSdPI8iajU4IaZNdfrgsdrTQVx5B+jm+TWhEWg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jh41FTbsfVqPS3cEmLI+70KK+IlFstdNp1Dfb507B6Fx3d4c8vJuFeyeYKf6HP8BhUShlNWHJ+Mixp+MdjPcG4+c288EA3jD/SApHoGb0Bu8IFU8zX0ZDAxYT1xECRvrGyklXlfd5tBhIP1PBBEMrIrlEioHajc1ClS9yPYPlZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4PzfoP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07E8CC433C7;
	Wed, 13 Mar 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710293430;
	bh=h8pOeiSdPI8iajU4IaZNdfrgsdrTQVx5B+jm+TWhEWg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L4PzfoP9Wo383wNbc5BDShHMAaUAteOMrpcRwlP9W+XkyacJQL7EAW8RvpSMUsl/i
	 c33IceUb9vKGv2iwCwCzhNpKFiamzAO2Sn2i1yQna6ml9XsyXc4tJoFZ1f60so+w/X
	 UsQzNXjM7/k3i4TaVWx6F946oaFNsi+tg4bMIoJ9uwy74exGV3ofvjwfpt8AuOkq7L
	 aXqmOYP0vbXMn6e6RKxGWJigF4zcZf1leYFnXxx3nJ5miZJfoD8nvIi6IyKuzNalUA
	 h+VMpMMLrH2AuA/dRFgjmRECxaXXwhCrZMV9w1PlOWk0oXSp98uWSq/w1F90EAdKi/
	 axu5hHpZDF+ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8054D84BAC;
	Wed, 13 Mar 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: zone: fix to remove pow2 check condition
 for zoned block device
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171029342988.17296.17999527024833802144.git-patchwork-notify@kernel.org>
Date: Wed, 13 Mar 2024 01:30:29 +0000
References: <20240308035057.62660-1-chao@kernel.org>
In-Reply-To: <20240308035057.62660-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, songfeng@oppo.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  8 Mar 2024 11:50:57 +0800 you wrote:
> Commit 2e2c6e9b72ce ("f2fs: remove power-of-two limitation of zoned
> device") missed to remove pow2 check condition in init_blkz_info(),
> fix it.
> 
> Fixes: 2e2c6e9b72ce ("f2fs: remove power-of-two limitation of zoned device")
> Signed-off-by: Feng Song <songfeng@oppo.com>
> Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: zone: fix to remove pow2 check condition for zoned block device
    https://git.kernel.org/jaegeuk/f2fs/c/11bec96afbfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



