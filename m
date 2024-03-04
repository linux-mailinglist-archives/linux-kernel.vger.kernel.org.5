Return-Path: <linux-kernel+bounces-91086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CAD870964
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F441C2244C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052CD626CA;
	Mon,  4 Mar 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GafLWyUz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7D361694
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576429; cv=none; b=SN+FV03e8Lb7ubxZR2LzmRB50l0PPFv8x9VxaSZ9y57n2gaUjAidoqY3bRGFdR4sniykZwS/LiuZP4pdmZtM8A3eSeBEzAqH1DHp/1ibZNrqXOl2JunWUbny8YmTUDXzLhPH++8/991k0tbotGoUylkLScyUYaosDwoHxR3rydQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576429; c=relaxed/simple;
	bh=zBz/B0sPWT2Admpa/78zITi4LH0kZhVDwkb4NFeSsWM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h0nRGsS+t0BO52vbk5ZWnC5m4AQnWPWcp+ZtQMyEf8trOagLZ6Ax6tP00bSBKpDJ+4jTf8Wo5nnWIM6IkNJinziXiLsBe3coCSprIKZqKwlkuuOc1vm+0Du/RtjPBEHYhgCMQhomYBE2Qw4NuUWSJ0fcHwiyS9GR/Nk+MvTi+8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GafLWyUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFFEBC43399;
	Mon,  4 Mar 2024 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709576428;
	bh=zBz/B0sPWT2Admpa/78zITi4LH0kZhVDwkb4NFeSsWM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GafLWyUzmjeWoIBnnnYln5Nhx9tEkEO3bWDW0/2mgrMOGzo1wzMGo7hK/neWWgzNV
	 SgAo3xqrVcLntFh8uUWkKbJywVhAVo6soeKhZlTkyM4h95g2sYKsniqGjm6a5N3XMu
	 X83gggqeTexElXf1qelqwXW4ze+5D5dM+mHHZdRtqtRt2WdiJjxv77RqnMxTPyQcHO
	 jkT+esrTICpUVGqVMJGi9KHm1bbADQalSTltH2/gVM5sm2X2rIPwRGKfWhiMjStREE
	 hbOyUjIngKEEjU+ovl4dzLMFzyuxPHDrV6338Jsdi0es86uuoUbV+TGUyol6moDYsJ
	 BplU+QoHNnzpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA373D9A4B9;
	Mon,  4 Mar 2024 18:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce SEGS_TO_BLKS/BLKS_TO_SEGS for
 cleanup
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170957642882.16816.9297901358493884285.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 18:20:28 +0000
References: <20240304032855.1425579-1-chao@kernel.org>
In-Reply-To: <20240304032855.1425579-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  4 Mar 2024 11:28:55 +0800 you wrote:
> Just cleanup, no functional change.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - don't cast type of segment number from unsigned int
> to long long, because segs << log_blocks_per_seg won't
> overflow due to f2fs doesn't support 64-bits addressing.
>  fs/f2fs/debug.c   |  7 +++----
>  fs/f2fs/f2fs.h    | 14 ++++++++------
>  fs/f2fs/gc.c      | 10 +++++-----
>  fs/f2fs/gc.h      |  4 ++--
>  fs/f2fs/segment.c | 12 ++++++------
>  fs/f2fs/segment.h | 15 +++++++--------
>  fs/f2fs/super.c   | 16 ++++++++--------
>  fs/f2fs/sysfs.c   |  4 ++--
>  8 files changed, 41 insertions(+), 41 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: introduce SEGS_TO_BLKS/BLKS_TO_SEGS for cleanup
    https://git.kernel.org/jaegeuk/f2fs/c/45809cd3bdac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



