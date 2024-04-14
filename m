Return-Path: <linux-kernel+bounces-144236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D1C8A4374
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8C21F212FF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2E1369B7;
	Sun, 14 Apr 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3U58jXb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35BE134CD4
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713108765; cv=none; b=bx7bJJz0NTl4Xxja8RMZMmECGGIdCjb6MJFcBi5YbcxP2tCNNfRktJaX9ncegdcNeTuLpTtl4SiCaak8HrPIZdjzs0RJT9G/wvnojWfviFqHSkwSe4gt15sMcK3trUb6MFboB499stA2VM8+7aG42xxGpKacBYhDlt2Sn0prK6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713108765; c=relaxed/simple;
	bh=XP5r+tNZIfyjBLUcPRFNA+/n86YrbrAy+1USxl2Yb7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zu9IUdNg2rq0ITKfs1buAhwb3HhSY7t661cQLnYdQIN0ThIIEKLDkB6Y6nUWsg7wcqTW7NDNRVSMEZMljSAtUA8jEOusY8w3CrR7lBo3IiCQDk7n3wbuDDb8MA6mCqko2n95AZu+Pxe+ZsS5o4sivxloDtDl/OSSyU0Yg+gQHZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3U58jXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68F84C4AF15;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713108765;
	bh=XP5r+tNZIfyjBLUcPRFNA+/n86YrbrAy+1USxl2Yb7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b3U58jXbhiRcixO7SxrYeN3viaP5f1TiuTsO1SpmAJRY7JyWjROe4LWMxnzz29f6e
	 MV6LOHdA5vX6GtCj2Gp6ec2vELA+yiWuqxZx9LTKecljVyl9UkfElo0VswXoIcLZLE
	 7RisxD2V51dxzqBv3vZD5xM+cbg6zbd6MK/DlMjEbZz1iih20rEsZuCRaiSY/Euz11
	 7Y+aZUjkW3IM9fg9ONQ6mhACjMSQd5zJO3zsRyNH+K5MLFxLULoY9i2x3kWQTvHAwY
	 EupD+O4K5JYC96AwrG6UQshAtuaYIg8w84vI6Kk6/UreaZTbuLleS1tUAsSrRfK1SC
	 Pm5F95OsA5n7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EBA5C54BD2;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
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
 <171310876538.3156.13252543010305378253.git-patchwork-notify@kernel.org>
Date: Sun, 14 Apr 2024 15:32:45 +0000
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
    https://git.kernel.org/jaegeuk/f2fs/c/16778aea9186
  - [f2fs-dev,2/3] f2fs: clear writeback when compression failed
    (no matching commit)
  - [f2fs-dev,3/3] f2fs: fix false alarm on invalid block address
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



