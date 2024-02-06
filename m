Return-Path: <linux-kernel+bounces-54655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92CF84B216
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453FF1F25052
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DFB12E1E2;
	Tue,  6 Feb 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lA4o+ehM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9994D12E1C3;
	Tue,  6 Feb 2024 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214226; cv=none; b=JF6qyXmj8Pqk/f6jpfW+kK5Y4CcLUr9xtRn3ziPukDRjUVUTmPemTi6eqzPj6o9cZeXCCw61hActGfPx38ciRDbJKqOLZI5pDOqTVliJ0WKXK2XfNm8yJmsLjhLaLjdzkS/i33to5Ttg00kGoCCQWsp0d0sSQtja6ziuRovTY8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214226; c=relaxed/simple;
	bh=6D/B5lAClzbE9Oor3JTwoXAHx41Tq91weyx6abcRiLs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aNcIeQOt2Dj3vyEUGmclSpyjOXfG4hPATRyISIR4vXVBuNbkbS3XZTK520twI6LKPJ36A53udYwadJrhHTZ9HyxGXBak+Ho9k11Gg7x0CFOV9+LUEl8Ev/oMJ8T8UyTi8AaOqrOuo5xMApAmk6djzjBGxCpSE/prRItm5qkG6lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lA4o+ehM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85691C43394;
	Tue,  6 Feb 2024 10:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707214225;
	bh=6D/B5lAClzbE9Oor3JTwoXAHx41Tq91weyx6abcRiLs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lA4o+ehMHowkSVlPWQ2OjGyRQFUBq4ovzMBfNI1bA8pB0kM+dnKx+4RmOxuPu5JSE
	 BmZLC8hziNWj+cgJLf2Y/zno29UOKjTH4fNCbVi1lAkFUABfliVRm6rqRrhMT8uWi3
	 7iPkoZZ8IWBXH8SOZSu+Zn39bRc3UGZps1wLwwGiiPe7yk+kVmspQe0+iAYorCkpYO
	 MzTrsrOgTqVFjg6yiSmZqdmPql8vSI7aTem7trnQjjdM+bdY5iHcgSuHgrhF+M9Z6S
	 SOoO7XH4o8jS8KlqwanujZbxFo+WczSIozd+6UEo7FT4hoGXIMP7AHm3Rfaki+oj6/
	 FRVs0YfgPx5zQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F670E2F31F;
	Tue,  6 Feb 2024 10:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: encx24j600: convert to use maple tree register cache
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170721422545.1213.14720345112129809334.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 10:10:25 +0000
References: <20240202064336.39138-1-liubo03@inspur.com>
In-Reply-To: <20240202064336.39138-1-liubo03@inspur.com>
To: Bo Liu <liubo03@inspur.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 2 Feb 2024 01:43:36 -0500 you wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/net/ethernet/microchip/encx24j600-regmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - net: encx24j600: convert to use maple tree register cache
    https://git.kernel.org/netdev/net-next/c/3c974cdce8dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



