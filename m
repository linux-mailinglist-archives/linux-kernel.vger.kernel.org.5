Return-Path: <linux-kernel+bounces-134039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D1A89AC72
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 19:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF391F218F8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695A445957;
	Sat,  6 Apr 2024 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwxzjX4M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43D03FE2A;
	Sat,  6 Apr 2024 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712424629; cv=none; b=hOCQqs4pxp8DrSBdL9DcfB0amrda2dyA4opIeHDDYdsHCrsPxKqvrK69+/6cg8QxtOLx3bjhj46TzvBvgQAs8nrr+EpRwk8I74QN3uxKAN725aGcF4YJLaTpfitk5UrOcpab6q6cIBBzXfbiPNyGvPPJgU67MERXfwppT8AyMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712424629; c=relaxed/simple;
	bh=yJRmQgFu+F2rTSQx2p6HruWVEHFTJ32xT8BsTnWnSfM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RXmHQ8/FahFggCQDMSIYVquCb0Dq0FY3OqEGiLvxYPBF9NsEskeL0ttwH1H64s9uY2NMI5KtFe/0X7dWwtvaG2mMEuHsdRSRjoICIXruEmxzTbhQ9DFmGkz4Hzyb6NuGcycc1gHLpJhQS2tqXUFQ30STuyqGbXqjDPbOMzNzgAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwxzjX4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51763C43399;
	Sat,  6 Apr 2024 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712424629;
	bh=yJRmQgFu+F2rTSQx2p6HruWVEHFTJ32xT8BsTnWnSfM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pwxzjX4MhCr9p/kaPXVsYBVSdVkA5PRndRdUf0XgxrdGqG/M+ve/JLdyipR7AlyB0
	 lwlZrhRvdLVRTCWe1fuPLVGBJNIrDJ8gkTuy5zT9SbyAxgWSBCfHq3LehbSisQbizQ
	 h+/+QLZR1e/nEgxpo5n+S6lV+r0f2a+vQmeUtCa3jc1ikMHRZ8kSQLhCdmrWfwcItk
	 U5C9b4pwSpmKfg6OTFEg/rNDXvmvF8W3ANV2S5vFrJmiMpzpxLOxNotfQ/ymm8saRf
	 yTlyTipKHnVuqr/FjhAEoVecPTTZ5KzY6jtWpNUm78i/NQnLKfeymVAPEeB98WvaMh
	 Hn4UqS6g0BOtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3ADA0D8A106;
	Sat,  6 Apr 2024 17:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: marvell: implement cable test for 88E1111
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171242462923.4000.7668978592915743020.git-patchwork-notify@kernel.org>
Date: Sat, 06 Apr 2024 17:30:29 +0000
References: <20240404090726.3059610-1-paweldembicki@gmail.com>
In-Reply-To: <20240404090726.3059610-1-paweldembicki@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  4 Apr 2024 11:07:26 +0200 you wrote:
> The same implementation is also valid for 88E1145. VCT in 88E1111 is
> similar to the 88E609x family. The main difference lies in register
> organization and required workarounds.
> 
> It utilizes the same fields in registers but requires a simpler
> implementation.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: marvell: implement cable test for 88E1111
    https://git.kernel.org/netdev/net-next/c/d133ef1ee2a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



