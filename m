Return-Path: <linux-kernel+bounces-89-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBFC813C06
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D139AB21B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4C26A35A;
	Thu, 14 Dec 2023 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqmFn5Ib"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D46282E6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 382F9C433CC;
	Thu, 14 Dec 2023 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702587032;
	bh=3Sg1Bp15Z7VsKSw5avAhEOsOLG+n/wcvl2qDa6EONC8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LqmFn5Ib6Pupfk2qF3etwq9EUTyKiUvIDZIiBX4CkJSANwHKlM4hMRecQrW0D8BP5
	 l2rdpOHSyB4efTuJqmVSYBykkdFQGAWBES75t7SnUDT6vcsKD65GzQtx8GVQn52iJJ
	 LtNuWMshvG929D3E/qIf7qxK1WJ6IarXiydv5xaA6i6a5Q8Vn55jwIhEoMe2HtNeSJ
	 nHlDuzR9KOy206K/iOWp6Wl+lYRI/xngrjywtgcLChFIJeRTzzcRKgGWbOEed1tg0Z
	 XomZWE/NQ8H9tnJ43qWsx0DiDC/2fFVoqtr5MjkHB0rWVhc74EnmKh8GdxrC5OzxyQ
	 oM/h9iqnmTrPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17BB8DD4F02;
	Thu, 14 Dec 2023 20:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow checkpoint=disable for zoned block
 device
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170258703209.30587.161998781327399194.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 20:50:32 +0000
References: <20231201230257.238513-1-jaegeuk@kernel.org>
In-Reply-To: <20231201230257.238513-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  1 Dec 2023 15:02:56 -0800 you wrote:
> Let's allow checkpoint=disable back for zoned block device. It's very risky
> as the feature relies on fsck or runtime recovery which matches the write
> pointers again if the device rebooted while disabling the checkpoint.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/super.c | 5 -----
>  1 file changed, 5 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: allow checkpoint=disable for zoned block device
    https://git.kernel.org/jaegeuk/f2fs/c/29215a7d43c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



