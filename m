Return-Path: <linux-kernel+bounces-41153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C6183ECA9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5BED1C215AE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56A51F605;
	Sat, 27 Jan 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYoUDf7j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C951EA76;
	Sat, 27 Jan 2024 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706350226; cv=none; b=PXXWXVRqutHWfLCrRp+DIbsBkxHTJbdE8Req7OtGW78mu15RbTxlYg3jCN7Yr4EpqH1zRv5ae6J09EXSamht9pVBYYQDRj7zfTQ6bq/fYCXvzWuP1/9Pi0fIyhg4yflXSeQW3lsywmfLJx6MdhO4PO+MftdUna7+yor9o4PGwpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706350226; c=relaxed/simple;
	bh=CSEwLil2ay5z/RlWNEfcP1+bS17tOHTOtLTjMWdZNYA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bhIu07JPrnNQ781Bq4KBIf/Lu91PPi4B378nE0crnlB/vq/N9Aigc/nzes1QN69DdcCZR2V3LTSEdyiNCf3iqtyVzDaRec+Wl4cyv57feYJiAssnHxyWdgI2xvVzCB0rYEPBE52JE5Z/PsdMzEHiQKDAspvLfQF/Vb4/EAY53dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYoUDf7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0223C43390;
	Sat, 27 Jan 2024 10:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706350225;
	bh=CSEwLil2ay5z/RlWNEfcP1+bS17tOHTOtLTjMWdZNYA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DYoUDf7jZove8Xbm5Dh9c4GZpnPSEjewHWak+LdCaYXTzrxnfoChnRvTtcmFTXm4T
	 9ritZRmgHl6OuGOlcEbC3ihbYOffs97fsNxml7J5cBOBBTdGqXuWJthmM74CemuFY4
	 IDmJlWNz8EwziYcfJNFRQgo4AOewnv9q6oEDDEoV6701EbUN1TUS7P7J3hgeIo2+Nj
	 z3lqhzGDCfIUPD/gaCrzdP9K8Eps128z9arbjM6B0WAVsHx0gOu5viB7kt9SzW3fB3
	 tfZiwM4tsCb9pERdz2J0A5hLRqWXI5hqJDT1ulKAuM2UZCn/AnaNPVF5wwDFOfB3iB
	 syN1dzGVgQx7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A65C1D8C961;
	Sat, 27 Jan 2024 10:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: lan966x: Fix port configuration when using SGMII
 interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170635022567.6511.783790936110166222.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jan 2024 10:10:25 +0000
References: <20240124101758.406068-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240124101758.406068-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com, maxime.chevallier@bootlin.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 24 Jan 2024 11:17:58 +0100 you wrote:
> In case the interface between the MAC and the PHY is SGMII, then the bit
> GIGA_MODE on the MAC side needs to be set regardless of the speed at
> which it is running.
> 
> Fixes: d28d6d2e37d1 ("net: lan966x: add port module support")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: lan966x: Fix port configuration when using SGMII interface
    https://git.kernel.org/netdev/net/c/62b424810535

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



