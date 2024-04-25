Return-Path: <linux-kernel+bounces-158825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D538B256A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7CA1C23195
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C563514D6E7;
	Thu, 25 Apr 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDQBt/Rn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D45214D2AC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059631; cv=none; b=XwAVOVx4zVqBR27l6xs09OFsaqzuMBvpb8uQl438q3JjLsLVAG7imoaQNrompB+icp4cLON0sYPHDdxFrPO9cc+p9hRJiiKcVLEsW5Gj9bp05d4Ux01o4g3/Vqdcty1yqbAKI9uo3lKsQryQe7W3zUXK+1Xc0NpRixHzS0ildXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059631; c=relaxed/simple;
	bh=+J9HVSfkiiiwIOMHIiD69N9uDI01zWrTSRF943HQCRM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sbn5iNU4AJIJ6F5uyjOPiq5iX0qIlFl/mSxc6Wliw4K2WEs2yueVce25o2PDFqm3lySk8L0dDdYtVoSmRTsZyK9ThhT+bKiAKT410zjLfkUGeJ28QAN8wyGCpw/pWB5f2WG8aRUPF2lu+rzpxBBqIHipXchtj3wBnMdQZm+c7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDQBt/Rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D476DC4AF0C;
	Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714059630;
	bh=+J9HVSfkiiiwIOMHIiD69N9uDI01zWrTSRF943HQCRM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CDQBt/RnL+hCvvecUUxLvjOWHEDFZtqpVeAA/GtJzqsA9z+gI5rVbVSm60OywPEAY
	 KrYOHF2eB4FFGhSDEqS+FGeZGPFijTYDf+CbNA4RT1ITOE8QO3Pgk868icottoNcIc
	 9M8540txYpY2D2DteERQYNPYJq1yhlQFX86IVeD5rIOSRuszDHZgFR+xh8f+/939HH
	 k3MRBvvnyiKHcwFx/P1b2lG0LnV7E+t1vcIjJhtQAd4fjPjDFZEzUk4Ru/kntk2a93
	 Mp6cput4H2azdK64RGx/7y+OMTnyZp6IwF8WgWjinEs9P9RJjcxiqXVSJhOJeMzOzG
	 1I4dVLO1pihlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9556CF21C2;
	Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: use helper to print zone condition
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171405963082.10966.9576807283536776270.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 15:40:30 +0000
References: <20240423112759.4081008-1-bo.wu@vivo.com>
In-Reply-To: <20240423112759.4081008-1-bo.wu@vivo.com>
To: Wu Bo <bo.wu@vivo.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, wubo.oduw@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 23 Apr 2024 05:27:59 -0600 you wrote:
> To make code clean, use blk_zone_cond_str() to print debug information.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  fs/f2fs/segment.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: use helper to print zone condition
    https://git.kernel.org/jaegeuk/f2fs/c/3763f9effcdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



