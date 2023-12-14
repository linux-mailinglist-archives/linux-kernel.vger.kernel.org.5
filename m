Return-Path: <linux-kernel+bounces-86-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46A7813BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7D028306D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2668B42049;
	Thu, 14 Dec 2023 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcV9ytAK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FB31EB2D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19FA0C433C8;
	Thu, 14 Dec 2023 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702587032;
	bh=exGfzJaHVz5AxP1KE0el+gwRexf5RDQkGq9tiG97kEk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kcV9ytAKzZeSCYwzRVXCRbTdVnoWKm3JdfZKpe+U4L5mni8X+5gr/CBFLvJ5l0h4N
	 O+EUjWCGU2eCUAOdaV5hEqg3NfdYk6Vj/4SatHRbVnDSKu0eXKJ7vV1OtEghtv8I8a
	 OYoYHfoLjaZUGbWOtKVkHvwrIx034wZV+ed/XJZe/sSB5w8qATavpgMZOeiP6qpQyP
	 zVZwUYtWQTK+3ZDFEIayGLErHxRFGsU+GuQgtBxyBIwmiWVP0fMwO0BaqSPvHAffhv
	 4eUDLMpMmi01gki00AKqOy6ar5+JHPeURp/IW6FZb3NjCapDtdh8EnIdsGUUBcnshL
	 2o0kOl8O18fvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E90E0DD4EFD;
	Thu, 14 Dec 2023 20:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/6] f2fs: fix to tag gcing flag on page during
 block migration
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170258703195.30587.3513758411413071845.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 20:50:31 +0000
References: <20231210113547.3412782-1-chao@kernel.org>
In-Reply-To: <20231210113547.3412782-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 10 Dec 2023 19:35:42 +0800 you wrote:
> It needs to add missing gcing flag on page during block migration,
> in order to garantee migrated data be persisted during checkpoint,
> otherwise out-of-order persistency between data and node may cause
> data corruption after SPOR.
> 
> Similar issue was fixed by commit 2d1fe8a86bf5 ("f2fs: fix to tag
> gcing flag on page during file defragment").
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/6] f2fs: fix to tag gcing flag on page during block migration
    https://git.kernel.org/jaegeuk/f2fs/c/4961acdd65c9
  - [f2fs-dev,2/6] f2fs: fix to wait on block writeback for post_read case
    https://git.kernel.org/jaegeuk/f2fs/c/55fdc1c24a1d
  - [f2fs-dev,3/6] f2fs: fix to check compress file in f2fs_move_file_range()
    https://git.kernel.org/jaegeuk/f2fs/c/fb9b65340c81
  - [f2fs-dev,4/6] f2fs: don't set FI_PREALLOCATED_ALL for partial write
    (no matching commit)
  - [f2fs-dev,5/6] f2fs: fix to restrict condition of compress inode conversion
    (no matching commit)
  - [f2fs-dev,6/6] f2fs: fix to update iostat correctly in f2fs_filemap_fault()
    https://git.kernel.org/jaegeuk/f2fs/c/bb34cc6ca87f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



