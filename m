Return-Path: <linux-kernel+bounces-75256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B508A85E548
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701B7284E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461BE85C7A;
	Wed, 21 Feb 2024 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYth7c4v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA5785272
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539031; cv=none; b=mGcnk7UdPK7IUrWU3A44DRtV772xb4aJ4UbRkwEZLkVtiwmnXEk/B/NQfqOTuwzBJVMXe/dgFliuPlt756epOv9D4E1LuVsGvK0FVFuIbqnaKGdv5lrt2ew/BkH4FIBQ9SeQKoQweN1/3M8ks7rWjvPDjdGcOiIyZCUIYf4HHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539031; c=relaxed/simple;
	bh=Eiv/YLnfASz+VNUWTijOLpOzpUDiDbtt+b2dmVCeOvM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fOSEBKkgDITcjK9NaIl+FfzjnVdSQRoxJymsw8KjFmfun211H72kIHX2R8QIBcD1HZpCfULVrVp+sIqI1K1W4rzvFF5OzHgMLCVnPFWf2rNKtwzlrucpjgGYlC+m1rGliDbjPCzZZgZZm/VUAQL0cSqYPhzspsIcFshtNu0Tt4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYth7c4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31AD3C43142;
	Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708539031;
	bh=Eiv/YLnfASz+VNUWTijOLpOzpUDiDbtt+b2dmVCeOvM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hYth7c4vF1UPaQ/l41N8pJ+nNr7wDyHwM0Xecblvj7Ian91PAzjFyCoIlPRsLyvap
	 JaBmOmZ6ClvhEkuVI0v2ra+f/3ZPe7fFQX6YEWX4K614qlNbW0nKzk8E4CIt4j5pIa
	 S8FNn/A6+aYiwP/LFQ0T5hfiIVNfzHk8ylD7dl25qc5WosINLAyPzzzuqdmjLEZtZh
	 R/Mw2e/Y52pFheHvpSnrnPFRBWgQ+4yi2W2Zhr5SjJJdyMATJ/0Kje2F+0NIHnAK7U
	 OUTaOseRBFR6INjnEXj7AA7A2RGeC+u9WawQb+altx1oa5jDBriH7S6FtoTkVweLIQ
	 jMiaon8Bb3U2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 186D0C00446;
	Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: deprecate io_bits
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170853903109.7043.1946520344945151246.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 18:10:31 +0000
References: <20240207005105.3744811-1-jaegeuk@kernel.org>
In-Reply-To: <20240207005105.3744811-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  6 Feb 2024 16:51:03 -0800 you wrote:
> Let's deprecate an unused io_bits feature to save CPU cycles and memory.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  Documentation/filesystems/f2fs.rst |  2 -
>  fs/f2fs/data.c                     | 73 +------------------------
>  fs/f2fs/f2fs.h                     | 25 ++-------
>  fs/f2fs/file.c                     |  2 -
>  fs/f2fs/gc.c                       | 10 +---
>  fs/f2fs/segment.c                  |  9 +--
>  fs/f2fs/super.c                    | 88 +-----------------------------
>  include/linux/f2fs_fs.h            |  6 --
>  8 files changed, 10 insertions(+), 205 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/3] f2fs: deprecate io_bits
    https://git.kernel.org/jaegeuk/f2fs/c/87161a2b0aed
  - [f2fs-dev,2/3] f2fs: use BLKS_PER_SEG, BLKS_PER_SEC, and SEGS_PER_SEC
    (no matching commit)
  - [f2fs-dev,3/3] f2fs: kill zone-capacity support
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



