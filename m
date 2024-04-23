Return-Path: <linux-kernel+bounces-155697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD038AF5B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C01D1C245AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F6B13E3F7;
	Tue, 23 Apr 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Km8eWQMm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4955313DDDC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894029; cv=none; b=F/e4jSItnHxcs/4e4FOx0Y8seOaJNdosy0zk+lnPZca+xot2UACFjlC/LLYBUqfO0IfcYyTvNLY4/psdf35/wAZykqXB+m1izNem9QmvzSbE6GnIniebErOWbBnn7mv2+d8BrS/BZrmjxQPMWbIjBbdzFvodDQF6LaSQwsfMdWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894029; c=relaxed/simple;
	bh=ZGVdiXH50qmWUKxvs/Sh72iae0mXIJYxi+k9XKbTZTE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hvyi0g67i2BJ97WBDr/ax4gjK+CAwfb0SAy/KCSR0ITbtLeajST7EQoJs6uIDcCF+Gam3KJeujWXYbIxH+6atwKpntE2bm9cZvh7fs6eCmuDfOJD3+F6lyy79oafvjNiWDFPilL06i16Gsqr0HjWWygOF+2XpOJwUv0W+g4Na5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Km8eWQMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC7A7C2BD11;
	Tue, 23 Apr 2024 17:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713894029;
	bh=ZGVdiXH50qmWUKxvs/Sh72iae0mXIJYxi+k9XKbTZTE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Km8eWQMmdI+N9W5/tFoMg2J/NS4lZLmsFHRpRevL0nL//3/qMUcjuFVb9D2cxUB8e
	 hgzY8hNFPGgORiBG68c19AGvA06Y6+8AAjYLWD14fUbigh4JQxFI9Z3ab945JlpLYm
	 8FKX3YKavNqvLzdGzDTMmdttclR8NIynini5/KVHIZrHf+1DOTd8kLW9TuxhQy2b6k
	 FQ/ETqiW4S2YrdolJeNmFSblx/bLyC2RBigojgIxFJtbC5LD74py7dVl7O6xAA6aMP
	 I6oJMUr7NXV2VlbKzkaV9pjnRjw9lnRM7ioNSQbZyEafK//xFeDmxbDN3AKlyfJZ79
	 MSG4QuxXfFSbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE48DDEC7E1;
	Tue, 23 Apr 2024 17:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix comment in sanity_check_raw_super()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171389402884.11756.5936531495937723538.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 17:40:28 +0000
References: <20240416072108.5819-1-chao@kernel.org>
In-Reply-To: <20240416072108.5819-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 16 Apr 2024 15:21:07 +0800 you wrote:
> Commit d7e9a9037de2 ("f2fs: Support Block Size == Page Size") missed to
> adjust comment in sanity_check_raw_super(), fix it.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix comment in sanity_check_raw_super()
    https://git.kernel.org/jaegeuk/f2fs/c/5bf624c01229
  - [f2fs-dev,2/2] f2fs: remove unnecessary block size check in init_f2fs_fs()
    https://git.kernel.org/jaegeuk/f2fs/c/06b206d9e2b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



