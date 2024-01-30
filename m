Return-Path: <linux-kernel+bounces-45298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAE0842E38
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02C1282402
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19089762DC;
	Tue, 30 Jan 2024 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2qgXbTK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC2271B48
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647826; cv=none; b=sTZntQBLCtzJLuaRZigkKd0830S0sQsKVQBVNI16i9SjkB6cX4ekI5YhZmvoUb5jBHjS6x1KjnWCiIuHSCLyxrs+z5OJzizNt/BAR26cIlqEMgzPrvj+XgEPOTM0u0dDdV5ufeHd0ai5Ikr53NRfC/JgBaDQsdB6BTwSalCha2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647826; c=relaxed/simple;
	bh=sQMc1IpzbU1LGaOI5Qb27si2nqTsv75Gb9RB6VNreKg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D2ywmKMKC23iuOpDzmCag297eH4HNkuJA2w+Vq9iuM11ogWTwzG6KNV+snoDnrOdAc6/RUo15tohoHBhWQ3SV9GUH66oSXRFHSfP5NEPvvhqqQDZWmifwvwXgOrx8lSI51yeN7lVMLx7aN2DW7gDvo0PMeCitOh9+G9pIRnuVJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2qgXbTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE4F9C433B2;
	Tue, 30 Jan 2024 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706647826;
	bh=sQMc1IpzbU1LGaOI5Qb27si2nqTsv75Gb9RB6VNreKg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S2qgXbTKvGejivnNf9dn+MBpdfRKqz8haSykjAGabtKAPu2UrWG/3tqxnOxAgfYsm
	 anwR44/uOSCPA6n6rFcGgRzzNzw+7Svn6SWFL9AHew1ts5Tk96IEbEh9QCXEV765ED
	 9nwOO737ATUgzwTLM51yPgyP2EUb/Jm765YeO3r4VldRV/eVqF8uNrjpgGVJvUFMtK
	 qzHyXe5Zgg85EDMMu3M8M5HCT8oySpbH1l8JS0hq7OS2vXN4jBAM0bO+RDTswyNyob
	 fjruSQe9iAeQP/5ruT089WR9GcsTQHLUvt05a4IrZDgC0PMo43bZiw3DjbN4tqrbvj
	 4s1KhGEylbDmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D78A2C595C4;
	Tue, 30 Jan 2024 20:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: remove some redundant codes in
 f2fs_cache_compressed_page
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170664782587.32692.11414863137927185609.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 20:50:25 +0000
References: <1705556911-24117-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1705556911-24117-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 niuzhiguo84@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 18 Jan 2024 13:48:31 +0800 you wrote:
> Just remove some redundant codes, no logic change.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/f2fs/compress.c | 4 ----
>  1 file changed, 4 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: compress: remove some redundant codes in f2fs_cache_compressed_page
    https://git.kernel.org/jaegeuk/f2fs/c/16c326c7a519

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



