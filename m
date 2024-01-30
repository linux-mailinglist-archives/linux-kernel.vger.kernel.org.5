Return-Path: <linux-kernel+bounces-45297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBE8842E37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DEB11C23152
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1183762D7;
	Tue, 30 Jan 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pK46OP+W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D7471B32
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647826; cv=none; b=STc50yTG4WjGJVKSQ7igsEnlRMMVE+pdLR16yto+IyRNrL02tkyzqX3mtWoqDd4Nm+WRo5BpOZ8UTHR2rCXKKy9tPD9BaLgpMqyvgiZDHf1oSCM5uojHEWnVB2RE8NNWCU3E8g7Qe/d/NDQnV+bn2FjafQyyxnavasK0kYFSVaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647826; c=relaxed/simple;
	bh=K25gE3Wo83qSLGvuRVPDt9LO7PHsrUC7qYhPro/+GL0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gRSU2e3zWWH5NKdzy+31zO/86jLTAIMH8qIeEeoAwfyGJmVLJfZLUWJWqqjCHScjqJ331SnMmtBK88omZGwnsaLsMGlQZ/nfOLhQ2AYE9jiTtmBfyRRaddV2QNnXp48UXQllVhTok1BzAOkDcKrpEmgTyWwyWwGensqIOHIVXEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pK46OP+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D971AC43399;
	Tue, 30 Jan 2024 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706647825;
	bh=K25gE3Wo83qSLGvuRVPDt9LO7PHsrUC7qYhPro/+GL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pK46OP+WvaAEiZ5z75KHNWIrKHOSpbGy6i78zRrrycyDzu01qoBtQ72XYvwPefB5y
	 Ki1YQgCByViYH0BWGHkBQHNqOOHTYLqckKJr0+jKsktktFmtoTv8C53lRZ/ev6ctDT
	 YXlGRiG15/Cru6ABhq3gxIGiECAbn+kdKplkKWzruTJZRcsU5u202MUKdLxQvTUVqg
	 AsRDCKpI7Ypl2yD+ZXZfvlgcGiBzt+41g+RNfFuVTOh7mfWsxiC4bi6PjxMWNGv3XZ
	 ok6cnzY0HBWFt6s6XiDaJt69hpBhZb1tDr/9pKVU/hkEhrFs6EmOuiJGjOd7/pFNUz
	 IzkqZiq7MNg6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD10CE3237E;
	Tue, 30 Jan 2024 20:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid potential panic during
 recovery
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170664782577.32692.11682898649135634393.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 20:50:25 +0000
References: <20240124144915.19445-1-chao@kernel.org>
In-Reply-To: <20240124144915.19445-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, zhiguo.niu@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 24 Jan 2024 22:49:15 +0800 you wrote:
> During recovery, if FAULT_BLOCK is on, it is possible that
> f2fs_reserve_new_block() will return -ENOSPC during recovery,
> then it may trigger panic.
> 
> Also, if fault injection rate is 1 and only FAULT_BLOCK fault
> type is on, it may encounter deadloop in loop of block reservation.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid potential panic during recovery
    https://git.kernel.org/jaegeuk/f2fs/c/f31438c16879

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



