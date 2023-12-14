Return-Path: <linux-kernel+bounces-87-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7B8813BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD441C20AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3990F54279;
	Thu, 14 Dec 2023 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwHntRQY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7BE27249
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2717FC433CA;
	Thu, 14 Dec 2023 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702587032;
	bh=kpVZaBnbBVpU9K7kulvZHkmJ7TFYh37EGAdPJUXKfUA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kwHntRQY97j/6XZiGfcDYn9fvWBA7Sp7zR8jFozYv9cLbq9R8y4ktt17M948Y08Wv
	 XJNSTImWvL1rIpFOGFEtTIqul6AJuNECLQ9YSxUuu0hEYucw15X/m4GSz8n8h6wWKz
	 YXg5OqQmE7AcWO7Hz0WCrBx6RigzAvmajP8DS+qKNSZu2bu5RYhzSkqBdx92+k7eGm
	 knbWXJMGgjLAIM1ykLGq5IuJ3ZaZ1VszsJUpAsGJiw7HgFX6TJiaJ3jYOZc40mtHB9
	 7Q9z0KHayydFUI0Q9BIfwpV0gv87RnJt+PN30ThFRrxDjIzCxt5BzWd1GieRxKrz97
	 cAM7B5Ycdh9ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F20EDDD4EF9;
	Thu, 14 Dec 2023 20:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/6] f2fs: delete obsolete FI_FIRST_BLOCK_WRITTEN
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170258703198.30587.14823724778977847015.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 20:50:31 +0000
References: <20231210092040.3374741-1-chao@kernel.org>
In-Reply-To: <20231210092040.3374741-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 10 Dec 2023 17:20:35 +0800 you wrote:
> Commit 3c6c2bebef79 ("f2fs: avoid punch_hole overhead when releasing
> volatile data") introduced FI_FIRST_BLOCK_WRITTEN as below reason:
> 
> This patch is to avoid some punch_hole overhead when releasing volatile
> data. If volatile data was not written yet, we just can make the first
> page as zero.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/6] f2fs: delete obsolete FI_FIRST_BLOCK_WRITTEN
    https://git.kernel.org/jaegeuk/f2fs/c/a53936361330
  - [f2fs-dev,2/6] f2fs: delete obsolete FI_DROP_CACHE
    https://git.kernel.org/jaegeuk/f2fs/c/bb6e1c8fa5b9
  - [f2fs-dev,3/6] f2fs: introduce get_dnode_addr() to clean up codes
    https://git.kernel.org/jaegeuk/f2fs/c/2020cd48e41c
  - [f2fs-dev,4/6] f2fs: update blkaddr in __set_data_blkaddr() for cleanup
    https://git.kernel.org/jaegeuk/f2fs/c/59d0d4c3eae0
  - [f2fs-dev,5/6] f2fs: introduce f2fs_invalidate_internal_cache() for cleanup
    https://git.kernel.org/jaegeuk/f2fs/c/4e4f1eb9949b
  - [f2fs-dev,6/6] f2fs: add tracepoint for f2fs_vm_page_mkwrite()
    https://git.kernel.org/jaegeuk/f2fs/c/87f3afd366f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



