Return-Path: <linux-kernel+bounces-43469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA84841455
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F259B248E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A658158D6A;
	Mon, 29 Jan 2024 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iqi35FLe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B92157E6A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560171; cv=none; b=N3M8Oux6kF2D4A2jXTo1kqUZYvhhmRXKUIEmX1ke0J0Mj7e5BeYa1D6D3/hQqN2tNUlZB4jj5BHyEDeDzQbU1II6l9T/mZBuLP6qjgNL7mrG8XqumeVmNhoMpSSy6jJfaiq9zdhU6mr4IR7MgC7nct70ZJW2UwfYhXMQolmuwbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560171; c=relaxed/simple;
	bh=SQvwe0KRiHiPwuYKPEiT60vxLx2ZZ9hEflej5w8CJWo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fMgF8XaOLWMhOYYfKea3z6Bhr0cSBixp+d2ZIFXWPjeHSVw6uZx34yCMCM0fVGnKNmbv1ilmH5yPU9BfCoZ/lexnGbJ7G7FLjJpa46NNVhXpqtBcKbi4fB7/NV8BSxoNA1TqER0nvOnlHoz3TbjxmBcHnFdx1wo065A+rnPKPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iqi35FLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A49FC433A6;
	Mon, 29 Jan 2024 20:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706560171;
	bh=SQvwe0KRiHiPwuYKPEiT60vxLx2ZZ9hEflej5w8CJWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Iqi35FLedO3/mPZyzKC1IpFcnB3HyeDKbRD2jD09jwyQeVmUDSJ5bGiYoHZGbo1Pm
	 Vn0oaRl1tbg9XA2oADo5Ng+7927oXzy6iet/aKGSIsOh2UViuJ558ixlgLRv0slyXu
	 YOU0p16d29j+HtGg2Ph+rvJgFOWZUEwcX1NqhSPanyQvnAYRUIgHxl7fg2ZydGZMSk
	 rwYK/GEKzBa7nPRvXiZ7BuiJGqVLhs4eyvohzSelrLzQCraZTcI9rGqJvO7okuNVH0
	 hraEmI8+P07vdIBkDVVdddmo+NO4c/rTQoQ+fLAcuzPbpO1vA9n8p7epsTJ15J9ZoC
	 1fChSamkIYTdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DBBC4C595C3;
	Mon, 29 Jan 2024 20:29:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: support printk_ratelimited() in
 f2fs_printk()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170656017089.16041.14974521466482956589.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 20:29:30 +0000
References: <20240126151917.837565-1-chao@kernel.org>
In-Reply-To: <20240126151917.837565-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 26 Jan 2024 23:19:16 +0800 you wrote:
> This patch supports using printk_ratelimited() in f2fs_printk(), and
> wrap ratelimited f2fs_printk() into f2fs_{err,warn,info}_ratelimited(),
> then, use these new helps to clean up codes.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/compress.c | 10 +++++-----
>  fs/f2fs/dir.c      |  5 ++---
>  fs/f2fs/f2fs.h     | 40 +++++++++++++++++++++++-----------------
>  fs/f2fs/super.c    | 11 ++++++++---
>  4 files changed, 38 insertions(+), 28 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: support printk_ratelimited() in f2fs_printk()
    https://git.kernel.org/jaegeuk/f2fs/c/83253fc066b9
  - [f2fs-dev,2/2] f2fs: use f2fs_err_ratelimited() to avoid redundant logs
    https://git.kernel.org/jaegeuk/f2fs/c/9a63d6e6382a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



