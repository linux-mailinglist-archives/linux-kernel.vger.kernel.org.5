Return-Path: <linux-kernel+bounces-157412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD40F8B1151
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D321C2556B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CAC16D4DF;
	Wed, 24 Apr 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJhb4G21"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B813777A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980429; cv=none; b=XLyIAESHAsHIctAfSfLBNzckYMrcuajB1uiY5Tm5GEJrj+nHi6Gejc7Y5AnV1mWwJqaHf++2fNd8vFofbRrKFnbigLiAPyeB62x1fGpOk5fTrWpUjM7YZwgKoOtrUPnf3QMpds4yHW6yOBDLdpfBmTOudAau+8wMKB27dMzreug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980429; c=relaxed/simple;
	bh=cnMh4lZ8/DF2nts885keD3oVXLmD1/qliCT2gQ+qeR8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FTMxGdWHbmGEEP3TTxfW3afOJlfweakAkjZWK0PDQ3Q6Y0WAMTJeM21JFyPOBiNSqBfnIi9xoD38/kjR5zmgzxNl1WBthF98AwlVbmLCk7+KcJkAoh4ia0meHv/zaptYpBLjEC6Xvc9+Xgrtfzh+WFYOw3pjnPm2xPmPcp1UZfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJhb4G21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A99A1C2BD11;
	Wed, 24 Apr 2024 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713980429;
	bh=cnMh4lZ8/DF2nts885keD3oVXLmD1/qliCT2gQ+qeR8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MJhb4G212OVVVFLWHMt8RXJ9Y735f1eTRks8+loZ8XR2iJGoHvjNweOgmLCk+VVvT
	 2mxreSsKbVbzop6g+K7+LLHIcShmtQuzBQ+cLd3EPekMc37Cmj2NgfjUJ/ETD/NdZA
	 cfeih1xiGj3OZsQAdV8CuGUgBIeoallpp3Ax2pnt2lqXOZbdIhLXipKlXJKHRx82jG
	 hW8LzOn7TRUiIgm9p9/v6ckSAfk9vnErUrcUGJVe4DtbqTNqWeNvVSA+Vo8FNpzXcF
	 37Vc1URkXcgmJHPJ6dRZjEgbTeelrISV4JAvAQlBOTmjt0uL263/X+2MwuSA3XCvbv
	 xJafJ6eKK6j+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91EF2C00448;
	Wed, 24 Apr 2024 17:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: use folio_test_writeback
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171398042958.20673.10102364996945847109.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 17:40:29 +0000
References: <20240409203411.1885121-1-jaegeuk@kernel.org>
In-Reply-To: <20240409203411.1885121-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  9 Apr 2024 20:34:09 +0000 you wrote:
> Let's convert PageWriteback to folio_test_writeback.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/compress.c |  2 +-
>  fs/f2fs/data.c     |  3 +--
>  fs/f2fs/f2fs.h     |  2 +-
>  fs/f2fs/gc.c       |  2 +-
>  fs/f2fs/inline.c   |  2 +-
>  fs/f2fs/inode.c    |  3 ++-
>  fs/f2fs/node.c     |  2 +-
>  fs/f2fs/segment.c  | 10 +++++-----
>  8 files changed, 13 insertions(+), 13 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/3] f2fs: use folio_test_writeback
    (no matching commit)
  - [f2fs-dev,2/3] f2fs: clear writeback when compression failed
    (no matching commit)
  - [f2fs-dev,3/3] f2fs: fix false alarm on invalid block address
    https://git.kernel.org/jaegeuk/f2fs/c/04890641bf1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



