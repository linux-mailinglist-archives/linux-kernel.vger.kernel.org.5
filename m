Return-Path: <linux-kernel+bounces-85805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D349C86BAF9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976B4284E7D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B730A7290E;
	Wed, 28 Feb 2024 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mELIGUPl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AF63FB98
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160632; cv=none; b=mh2s+NPJp1FoYGqBz4Rag3gYUlntaFRdXfs5dQSbup4KMeA82y5uxsOxXZXXtV31warfXsvYS8pjZdAh7kTpwmwfIUBKwgtc+UleEcDC+gPXg9wExF0skgKzh/EXcf93zf1ixjzhAEz1Em3ADYgUQGIjlDsrTbTBJn8e5VJdXL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160632; c=relaxed/simple;
	bh=pq8vRdWD6j6IoWSZ4zPOwhJv/Db5Ok0GUTbeHCKV/+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VQ6rCZGKvPHQX81iFDvuPbxYmNWseDGWzeV8bwapjSFITKfiPS1S3D0DPRruDkhJDi/X6g4P1PjqF3ksnF7vkkTHBLjrkpruP52Qpuag4Zpt8/RzNU21ll3lics+PSB4RZRqKJkTxzqwEJecq4aWlSRx8Ul9ZZDDLJvAhVwTz5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mELIGUPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A09D2C43394;
	Wed, 28 Feb 2024 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709160631;
	bh=pq8vRdWD6j6IoWSZ4zPOwhJv/Db5Ok0GUTbeHCKV/+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mELIGUPldG1K0nHQYMA1MZ69VbmZPOymIuM6N7El4RCXHy4lO49sG+hlI7rFBXwOl
	 WEpUV9iPT70yi+N43akaTpqtSkdDFMv/wjkRaN8yJhBq4TX2GLWmp6anY0JK8pjWt/
	 zP4vV3JOF+25kSxpFTS4ROj0ws6Pd3mvtBrvKWSYxAQMuQrYeISKgApx+4tKaLbVKN
	 Ni1vGQd+dK2pxXlHtIOfLgjNj3IgzVzpcBxP/YRteIo9o5oTd7fn0cFFbjnbwG96ra
	 BM1pgb5SmhNrfT0Kd5SEvsPks5CDxkpL+8Apx3zrgsRqfShgOjyidyzHvydMdAX/UG
	 puiX6mZa90gyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7ACE9D88FAF;
	Wed, 28 Feb 2024 22:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: delete f2fs_get_new_segment()
 declaration
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170916063149.28690.12475647856104740303.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 22:50:31 +0000
References: <20240222121851.883141-1-chao@kernel.org>
In-Reply-To: <20240222121851.883141-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 22 Feb 2024 20:18:48 +0800 you wrote:
> Commit 093749e296e2 ("f2fs: support age threshold based garbage
> collection") added this declaration, but w/ definition, delete
> it.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/4] f2fs: delete f2fs_get_new_segment() declaration
    https://git.kernel.org/jaegeuk/f2fs/c/134c289f5e7d
  - [f2fs-dev,2/4] f2fs: fix to don't call f2fs_stop_checkpoint in spinlock coverage
    (no matching commit)
  - [f2fs-dev,3/4] f2fs: fix to handle segment allocation failure correctly
    https://git.kernel.org/jaegeuk/f2fs/c/6ca83e9cdc51
  - [f2fs-dev,4/4] f2fs: introduce FAULT_NO_SEGMENT
    https://git.kernel.org/jaegeuk/f2fs/c/251a769d3f50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



