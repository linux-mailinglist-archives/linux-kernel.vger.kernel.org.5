Return-Path: <linux-kernel+bounces-144231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCEA8A4370
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5981F2123D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6298D1369AC;
	Sun, 14 Apr 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKhHZbrH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA7F13475B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713108765; cv=none; b=PxuilY7CUn3oP7Sjbwy3WEMVPBaMg0QKxTHCh+BFvWBkyCn/bPgso9bGbzTJkPk5kSc5nf01gH976XnwIBOSCMJq59s/9/gSIWuDKctKhHAoWNO6lle7VQrtmLyrbwrn1vAsrWVVjjIJ29pSobXAwUSWqjQA+Go6vKRvQHR5Dnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713108765; c=relaxed/simple;
	bh=aCUWzSW3nnOCWJY6Wih6C6rNM9RCw6Fje6P5C4uUrFU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X3xASBXPrp5YJfhIlx2e87CbnU2m3EUCy0471ZF/sAOSJXSWZWtzq21ZyrflhtbtvHr3eoaJrph3g9GMR/geOAzRYphTPSoIPpb0zNsQXB9tyvoJiP93uMquAOMbaCjVEEOL2nt25uyYattClGnLpC5aYatZwr98LIr+rTd+vpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKhHZbrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 776BDC4AF1A;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713108765;
	bh=aCUWzSW3nnOCWJY6Wih6C6rNM9RCw6Fje6P5C4uUrFU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iKhHZbrH4yK4TpodU1SaUctxEHf4l2i9OPpl24g2y42r+srMG32IQb7O15I5WwA5O
	 stfQvJK7KCywmrOcCPogx1ETwr+wuyAJJClGyyiidm/oip4xwXO1VKGCKbvrZUS7gb
	 XhK1h0/Xw5Z098phPN6yoTFsUYoHq9ORfit6yziXZ0j7a16ECyaNYxI0YbJZzD39+m
	 30OLMmoftHwUN2Y3Vs8FGbZ8TwZh5paVwpXobfut3a3QWUbbHi5d5209OKoe2Bvl9i
	 4nCnV9j+IzXpRlx0aFXHpfem0YjJ7FI2rwQCXFPdFj3wDIGx/pU7cfBQF9fwAFOMes
	 7Atl7NguR11Zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68FD9C43140;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to detect inconsistent nat entry
 during truncation
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171310876541.3156.7562582983890566171.git-patchwork-notify@kernel.org>
Date: Sun, 14 Apr 2024 15:32:45 +0000
References: <20240322145955.2959257-1-chao@kernel.org>
In-Reply-To: <20240322145955.2959257-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, r.smirnov@omp.ru, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 22 Mar 2024 22:59:55 +0800 you wrote:
> As Roman Smirnov reported as below:
> 
> "
> There is a possible bug in f2fs_truncate_inode_blocks():
> 
>     if (err < 0 && err != -ENOENT)
>     			goto fail;
>         ...
>         offset[1] = 0;
>         offset[0]++;
>         nofs += err;
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to detect inconsistent nat entry during truncation
    https://git.kernel.org/jaegeuk/f2fs/c/92c556ed6318

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



