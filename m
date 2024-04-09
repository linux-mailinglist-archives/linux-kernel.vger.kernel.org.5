Return-Path: <linux-kernel+bounces-136738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234A389D7C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A622E284686
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D567128818;
	Tue,  9 Apr 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4HyrJxt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5201B1272A7;
	Tue,  9 Apr 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661627; cv=none; b=GbCUomljji7dvwFZ3wUMHv1vQdEPw3nsAmoizpp3DMA6246U5ykbzHMH/ChEGnqLa+HXARqz+1OiV5OhoOn3QE1Zr1kqOivnb5I2fVrKsbcLNf1WHYTX2cE5IQB18bydEVwzmSDggsiAlaLNTaKG9mNyBRLgRCNgF6M2bMDM2Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661627; c=relaxed/simple;
	bh=WZ8PSReSVvOlS6rKHacwYvIcpPb3u1xgWFdo685nbps=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sBQ+2sBytstve0bz+BrOA9gN4D8thWlk//MDV2afDY/PBsPAWXXapAusepw07g3I8vG0h8ONyhJ1RBXlYEloYLdklaam8uNd4kTsOPuRiyuU9gEbDc0T8AnEBCDS2m+PMhkeYyonV6VjzAYcdltnBnc/bX+UBJOzc3uW1CrwFHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4HyrJxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5B78C433C7;
	Tue,  9 Apr 2024 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712661626;
	bh=WZ8PSReSVvOlS6rKHacwYvIcpPb3u1xgWFdo685nbps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y4HyrJxt0RJAtNkABWoW5AG98JXvnQadPRahI1DhNTrVJcvs8U1mOijPXMDzQHmG1
	 At2sYH0QuzjjHQtcwdmaeMMvWl7qtyQbeZ7vXt2DK7TbN97TNFKyVqyMi1weW2340N
	 hl7zlH0mDS1XAUnVvzmDKfLKZeVLKdt6LfRjGEYkAxDRl9THJqDNjxgcOMj/V4fOtw
	 UnHEQvrKua5CfFIczzQd7W5q3hDAdASnhcq3LKxhMsWbz0REaHCCA3sCtYphJS7scb
	 RT8yemf9oqKNyUZ3zsUTYe3fVHXucgH6d4S1IhTYTmwM33vePuFMSu6LEqNJTEhps1
	 fG0sILAZkRC3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C88A6D6030D;
	Tue,  9 Apr 2024 11:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-af: Fix NIX SQ mode and BP config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171266162681.18559.12947263220508270217.git-patchwork-notify@kernel.org>
Date: Tue, 09 Apr 2024 11:20:26 +0000
References: <20240408063643.26288-1-gakula@marvell.com>
In-Reply-To: <20240408063643.26288-1-gakula@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 8 Apr 2024 12:06:43 +0530 you wrote:
> NIX SQ mode and link backpressure configuration is required for
> all platforms. But in current driver this code is wrongly placed
> under specific platform check. This patch fixes the issue by
> moving the code out of platform check.
> 
> Fixes: 5d9b976d4480 ("octeontx2-af: Support fixed transmit scheduler topology")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix NIX SQ mode and BP config
    https://git.kernel.org/netdev/net/c/faf23006185e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



