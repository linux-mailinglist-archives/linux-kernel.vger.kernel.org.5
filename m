Return-Path: <linux-kernel+bounces-85803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 345C086BAF8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C811C214BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FBF7290D;
	Wed, 28 Feb 2024 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR3qF4fP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AC31EEE7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160632; cv=none; b=pI/EZG3e4VHP5+dA0ZthU27yfugnG7/WFYNVkc+H2EH0M9uaIWNjHh7qYlUyLXq5H5bde3PAqMtcYm1B1+tW2kjzZzHrWFTVv/VwPJnowFp0HDq5hlaw/2tNpOnsMLd6Rrt8vqwzouzSTFVQjawFaKDK2ZKPFbphtXZnl9hd6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160632; c=relaxed/simple;
	bh=examtTGxF0eDbGWdJnoARMLc/WduLuup5xEbQ5qHBY8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NABKSrWb5LIYNkfhhGUgixZykItlNy9nLcuTztT4RxHhQdZQCW06fRcMdIbk6XVFf6z94qi8ARdYF7Tr5yilgkDS/1l9Gmu/fEOSGzryGDGQuXbN5hgoJ8BbxfvlsPKjALYhXYciV5b6NcXb8ov876Th/KEQdLUdB+qa++nImbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR3qF4fP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AB46C43390;
	Wed, 28 Feb 2024 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709160631;
	bh=examtTGxF0eDbGWdJnoARMLc/WduLuup5xEbQ5qHBY8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SR3qF4fPQpler/7MPquVmdcWZnMYumxsTm1FOE46EHgOjuZQym+SGKaif+4zRqEt2
	 eSBciKpZvwbwuIh9rMXPHoEdE0vJ8HxKxg3r1FcwZB/pSBo7IUR1k9Bm7eRP45FIKV
	 2asDOcrXyuSRSNKfibHkPK9GBax1u/RFsDgde10vwRe75WFyiIpK1Sowh1eIiJVYBz
	 vpETTdtVXU/HuMBQneEkvWAA+/kiwZeRvCGK62Me9CkUL4Q6CgtkRu5ZWCrNFHXBTW
	 QY376f66XMZhicA3IcSsxtwiKd9zbH8UacURRU0nnhBYNjCN1YGropCvZuyF2Egzyc
	 DRI437fA3X2rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 734DED84BC5;
	Wed, 28 Feb 2024 22:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: check number of blocks in a current
 section
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170916063146.28690.11898550448489981752.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 22:50:31 +0000
References: <20240223205535.307307-1-jaegeuk@kernel.org>
In-Reply-To: <20240223205535.307307-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 23 Feb 2024 12:55:31 -0800 you wrote:
> In cfd66bb715fd ("f2fs: fix deadloop in foreground GC"), we needed to check
> the number of blocks in a section instead of the segment.
> 
> In addtion, let's check the entire node sections when checking the avaiable
> node block space. It does not match one to one per temperature, but currently
> we don't have exact dirty page count per temperature. Hence, use a rough
> estimation.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/5] f2fs: check number of blocks in a current section
    (no matching commit)
  - [f2fs-dev,2/5] f2fs: fix write pointers all the time
    (no matching commit)
  - [f2fs-dev,3/5] f2fs: print zone status in string and some log
    (no matching commit)
  - [f2fs-dev,4/5] f2fs: prevent an f2fs_gc loop during disable_checkpoint
    https://git.kernel.org/jaegeuk/f2fs/c/496b655d0460
  - [f2fs-dev,5/5] f2fs: allow to mount if cap is 100
    https://git.kernel.org/jaegeuk/f2fs/c/38fcb47642ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



