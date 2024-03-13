Return-Path: <linux-kernel+bounces-101018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E53D587A0C9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F5E281428
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172ED107B6;
	Wed, 13 Mar 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbriTUUK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF7C133
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293430; cv=none; b=FqHpBF4iHrVDfCAdIVyeR2xNIxa8fwVQ93abu2amYm+6rfs7d+qRYmYcE5WPyHXGeVol9D4AWJboYaAW9KWpw+Q/ZIY8g6wc+tYbpTsvO8xOfhEP6XX9PZADK7Ylrl1noPujihipNWCYnIX1dH+5Of1jhpUxkH9v1Oe6ViqRYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293430; c=relaxed/simple;
	bh=N5SuHqpo4Wvs9m5+Pv+s084wtJWSEaRs8gGJ7KkurNM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XYoVmOEJfCdISsGo/pkE8XxkPoYJ2yLdD2KJ7s9jQKPJyVxN5z4l6j0Ey1QVstJRhizId304bo3kgXMsMd8dDncj9vkWwLFbSwEiX5qwKO3tvj+QHHwqmsljaC5x+8E9DhFkIwNIEK/jQ3NY9KkyrtCWcaASfI7XKOMM1xONHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbriTUUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11FA9C43394;
	Wed, 13 Mar 2024 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710293430;
	bh=N5SuHqpo4Wvs9m5+Pv+s084wtJWSEaRs8gGJ7KkurNM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GbriTUUKKc93bTnzrbklUGkVJNIc45MIr9c58+DVV+Pk5bP4NwmrF4WTF4Dh47/Mk
	 eBggBh2aX9IXs6dYz+hjTIygJo0qF9HlZg3wPrN/sQizZWBEEZNn7AsXZLUKnSj/za
	 rRPVIbemlvBk57pLevHPSARHbz1R2H4iVUZIZ8hA9YJFK5JeKfR9mDH1dtCwc843pF
	 PYtdrlmv5BzCimYIUArPd0wdSZUugTx4FtuF8LYhLArKrrdrxJ75AEjO9ajYkDWTZ5
	 7XF1Uk0Xh/WAjv6aEUnr4HNup58bUArur780lo+ztjwI0sT7vTbAWafMGZZ50E/KFC
	 NH3zWrLOoMSfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0D95C595C3;
	Wed, 13 Mar 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to truncate meta inode pages forcely
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171029342991.17296.1644689290423723789.git-patchwork-notify@kernel.org>
Date: Wed, 13 Mar 2024 01:30:29 +0000
References: <20240308010834.4023772-1-chao@kernel.org>
In-Reply-To: <20240308010834.4023772-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  8 Mar 2024 09:08:34 +0800 you wrote:
> Below race case can cause data corruption:
> 
> Thread A				GC thread
> 					- gc_data_segment
> 					 - ra_data_block
> 					  - locked meta_inode page
> - f2fs_inplace_write_data
>  - invalidate_mapping_pages
>  : fail to invalidate meta_inode page
>    due to lock failure or dirty|writeback
>    status
>  - f2fs_submit_page_bio
>  : write last dirty data to old blkaddr
> 					 - move_data_block
> 					  - load old data from meta_inode page
> 					  - f2fs_submit_page_write
> 					  : write old data to new blkaddr
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to truncate meta inode pages forcely
    https://git.kernel.org/jaegeuk/f2fs/c/9f0c4a46be1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



