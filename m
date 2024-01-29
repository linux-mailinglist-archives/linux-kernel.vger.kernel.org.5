Return-Path: <linux-kernel+bounces-43473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB725841454
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB911C2405D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359D0158D7F;
	Mon, 29 Jan 2024 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORysDXHD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73779157E72
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560171; cv=none; b=ucNENNYPoxmGvAwsqX0IMmWt7N591CcV0tn3EaJf1VAXhI0QEHpUWU6VgraFu3JhqlAogocyzIaO/lNpRG10ea2YAgM0LHXT4/yQMBVw4KglEtXcybiuIQ2Tj5OqATGkpAegefQJCh1cnTWOSzfJ2P9gE24PLgEF5S2p/iLuj1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560171; c=relaxed/simple;
	bh=Ws3GNmP4bZcIK/lP0Akxr8I4gT6THkXk2sw+6WQGXT8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ql01cOweeNRGNpIIT31DuJAB79UKHNLvRKfac3XKA4q4LtMq9TKmlULaKEmtyTDKE9NzHJqvxkJu77jumF6P89H7d1p5mgmSHN3N12L8uNZM63vjYo2atg1JxpUc/y9ErrA/Z7pyKXPcR9j367yfelrljkG112ZGJQMNf2d1nqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORysDXHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A1C7C43601;
	Mon, 29 Jan 2024 20:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706560171;
	bh=Ws3GNmP4bZcIK/lP0Akxr8I4gT6THkXk2sw+6WQGXT8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ORysDXHDDYmGkBUYZUTEl8Hemjt+5THmch4CTAgEY8eJRp7eGCeO+eFWB91+va9ac
	 iWvGRYStOf9f/0ueiOQUgMZxeskdQ1wA9ns+ley9af8EHFJ6Q8Zyh8Atn2uInZwAgW
	 2VKES9l/KdLm82V7syjUE6DfVz2m9XMxfqtDS9idpi0lZ/kHLGtqaAdr1NqIa1vSJD
	 tpklRvsl7bzDuE5yoIDLJ7Bc27CjNdFCGJNSXGrHT0j7hcAyGTEVN3Z+hS45RAWoi1
	 /m1avBtUDpTQjWjCTrhD0xPRhguNsdxoj3JrxrpokpeP6eUh6xa2bxVvZltC6PGlXz
	 TQ6EWJWG93bvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F37EFC595D1;
	Mon, 29 Jan 2024 20:29:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: fix NULL pointer dereference in
 f2fs_submit_page_write()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170656017099.16041.13561924152211194606.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 20:29:30 +0000
References: <20240116141138.1245-1-qwjhust@gmail.com>
In-Reply-To: <20240116141138.1245-1-qwjhust@gmail.com>
To: Wenjie Qi <qwjhust@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 hustqwj@hust.edu.cn

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 16 Jan 2024 22:11:38 +0800 you wrote:
> BUG: kernel NULL pointer dereference, address: 0000000000000014
> RIP: 0010:f2fs_submit_page_write+0x6cf/0x780 [f2fs]
> Call Trace:
> <TASK>
> ? show_regs+0x6e/0x80
> ? __die+0x29/0x70
> ? page_fault_oops+0x154/0x4a0
> ? prb_read_valid+0x20/0x30
> ? __irq_work_queue_local+0x39/0xd0
> ? irq_work_queue+0x36/0x70
> ? do_user_addr_fault+0x314/0x6c0
> ? exc_page_fault+0x7d/0x190
> ? asm_exc_page_fault+0x2b/0x30
> ? f2fs_submit_page_write+0x6cf/0x780 [f2fs]
> ? f2fs_submit_page_write+0x736/0x780 [f2fs]
> do_write_page+0x50/0x170 [f2fs]
> f2fs_outplace_write_data+0x61/0xb0 [f2fs]
> f2fs_do_write_data_page+0x3f8/0x660 [f2fs]
> f2fs_write_single_data_page+0x5bb/0x7a0 [f2fs]
> f2fs_write_cache_pages+0x3da/0xbe0 [f2fs]
> ...
> It is possible that other threads have added this fio to io->bio
> and submitted the io->bio before entering f2fs_submit_page_write().
> At this point io->bio = NULL.
> If is_end_zone_blkaddr(sbi, fio->new_blkaddr) of this fio is true,
> then an NULL pointer dereference error occurs at bio_get(io->bio).
> The original code for determining zone end was after "out:",
> which would have missed some fio who is zone end. I've moved
>  this code before "skip:" to make sure it's done for each fio.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v1] f2fs: fix NULL pointer dereference in f2fs_submit_page_write()
    https://git.kernel.org/jaegeuk/f2fs/c/52434fdc4f86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



