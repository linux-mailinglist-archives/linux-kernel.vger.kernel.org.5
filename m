Return-Path: <linux-kernel+bounces-144226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE468A436B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AAA4B211CD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF371350DD;
	Sun, 14 Apr 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyfkZo1l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805C5134725
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713108765; cv=none; b=J3Du//CQwoPFcwbRvCDe24mqRe6ii1NSvzU951p6lo9HdjlpWWI/XjNGuv1xSOU7cNJZB3cVJ8kZF11ZFIrPqVGcBeYy/Sc8NVwVUYPT93yNCMYVFXLXRooqhGtoeUvg6ngt21FszcKeUKSzc9KUM/VGswxRqww3SonmQHdG4GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713108765; c=relaxed/simple;
	bh=1+MvVzHCjdnOAPGRAAgFhpSlsBWkDBjSaeiuc9GYhWY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FnMINo7fRfKVJ1AN1SvQLo+O781V3VqUbRW4Hb18yLoT6iDVB170Ht5/3v2cossM7vM1At2JQp5YJQJAcWLPpLzth30jJxYfNfhAGtq65S9PqLxNtWGSHe5B24zPJVRxoUwdFs+dODiccOAdVrWE5UfupbBZZ6yzjUkx06g6FrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyfkZo1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3616CC2BD11;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713108765;
	bh=1+MvVzHCjdnOAPGRAAgFhpSlsBWkDBjSaeiuc9GYhWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qyfkZo1lvO/Sw6BNSwNPPGo6RDIhkLY3sKZqEgvB8DLak/Vf4P0mK9BHYuh8xVTz7
	 R5FS22TpIW+mwN72PC6o4VMch9MbC2AUwIuPIT+jXjrfrWvyg3jsQ9cgGhkoiB/hep
	 pe8bjVtBBSzJYQJgAYsNwcIHVdEujFA3BXsIn0Sqs4w47+iV6/KKUnnOgJTxOl/qSz
	 PCwADCAJRewhwMoSO+HzEHtyVzUrrrxuMmIEyWEQM0zqWaptydeohUCy2w9ip3G0oe
	 OYVJ/kjvqt8rzvobbwGRtDD/rkI50T2uvSM6vvZrLepc4Cao6Hf22WxqMTCls7PnV+
	 SzX00aNligYkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24C74DF7857;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: introduce map_is_mergeable() for
 cleanup
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171310876514.3156.10934685583605806738.git-patchwork-notify@kernel.org>
Date: Sun, 14 Apr 2024 15:32:45 +0000
References: <20240325152726.797423-1-chao@kernel.org>
In-Reply-To: <20240325152726.797423-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 25 Mar 2024 23:27:25 +0800 you wrote:
> No logic changes.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: introduce map_is_mergeable() for cleanup
    (no matching commit)
  - [f2fs-dev,2/2] f2fs: support to map continuous holes or preallocated address
    https://git.kernel.org/jaegeuk/f2fs/c/9f0f6bf42714

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



