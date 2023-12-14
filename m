Return-Path: <linux-kernel+bounces-90-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0F1813C03
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509731F21467
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4BE6A359;
	Thu, 14 Dec 2023 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXA18eN1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CD7282E5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23713C433C9;
	Thu, 14 Dec 2023 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702587032;
	bh=oqqO0nkKDRdMtOwZP+eVqIh58wtlWupnsscuz8xF/A4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oXA18eN1/hez8NFiRN18Zsc5dzffCUZMJ2ymNWxkk7JPiJhnsGABj3mUe20HDH67E
	 6YVzQgjeIi7Og5P9O+phWcwE3rwKMfJbmfvrgtf/lGlS5ERy5WV9QLdeT4ZwnF0w9Z
	 vugoEpGFWA/ORT8e//3F6TJn2Mxjcn+Mh5Sl1qxPge+b3VRWBStndOpyRCokDgdLyc
	 KHQEH7cxRfJmbHG7gGyw4CIYwjOzUhWUAA60v0jSIpMima9P6ajKUSKMIkBX1OmBOB
	 R6wWBEHppfwTFVueBL1wz7XXzUKdT4yB8xoKeYxvcKyMq3qij6U+32dMp6xDND3EiN
	 YWphxmqKHOfyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06A1ADD4F00;
	Thu, 14 Dec 2023 20:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: Restrict max filesize for 16K f2fs
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170258703202.30587.16093975604922475515.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 20:50:32 +0000
References: <20231205023801.3669458-1-drosen@google.com>
In-Reply-To: <20231205023801.3669458-1-drosen@google.com>
To: Daniel Rosenberg <drosen@google.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
 kernel-team@android.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  4 Dec 2023 18:38:01 -0800 you wrote:
> Blocks are tracked by u32, so the max permitted filesize is
> (U32_MAX + 1) * BLOCK_SIZE. Additionally, in order to support crypto
> data unit sizes of 4K with a 16K block with IV_INO_LBLK_{32,64}, we must
> further restrict max filesize to (U32_MAX + 1) * 4096. This does not
> affect 4K blocksize f2fs as the natural limit for files are well below
> that.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: Restrict max filesize for 16K f2fs
    https://git.kernel.org/jaegeuk/f2fs/c/a6a010f5def5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



