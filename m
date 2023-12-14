Return-Path: <linux-kernel+bounces-88-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C96F813BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D811F21640
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DD16A001;
	Thu, 14 Dec 2023 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSU6UZBo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F8E273FB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F6C6C43391;
	Thu, 14 Dec 2023 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702587032;
	bh=giIJJNHa79sB0uALPwRRpHKv5T4mQDGH2IspWi9ybL8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qSU6UZBovSYH49iaCntw78CR6ewX4MpTkVSb8c+wfYeWngmlPKCZJdAZbQybjdzfp
	 WQA05Seg5gAYPG6QTHBBDOdgO6uy7uvECN+ID+urjHLRS6D/3IsRz12WH6h0mfBtNC
	 KmFCV44o2JuVhmqR27ZWlP9ETa1QVsA52WBrc1N44yLrgs7AE0m2hfPTPktIlOhbsm
	 DzwtyZxduquidrYNVXC/ktNpZ3Rr+oDz1mIIZLeNthutagNrqqwiASyHPOBOtl9dbn
	 X4fMsjWHU1vRRw2uvTuSfmI+Z75YoImWLPWOESON1uk7wVmyQZbNMBuCxc8Zmzg04N
	 2EOpPQpdxayTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FC10DD4EFA;
	Thu, 14 Dec 2023 20:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 4/6] f2fs: don't set FI_PREALLOCATED_ALL for
 partial write
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170258703212.30587.8025897708876464523.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 20:50:32 +0000
References: <20231212010120.252763-1-chao@kernel.org>
In-Reply-To: <20231212010120.252763-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, ebiggers@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 12 Dec 2023 09:01:20 +0800 you wrote:
> In f2fs_preallocate_blocks(), if it is partial write in 4KB, it's not
> necessary to call f2fs_map_blocks() and set FI_PREALLOCATED_ALL flag.
> 
> Cc: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - clean up codes
>  fs/f2fs/file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev,v2,4/6] f2fs: don't set FI_PREALLOCATED_ALL for partial write
    https://git.kernel.org/jaegeuk/f2fs/c/394e7f4dbb32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



