Return-Path: <linux-kernel+bounces-139644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D068A05B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5544A1C223C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02AB657A7;
	Thu, 11 Apr 2024 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGqllrxs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C94E61674;
	Thu, 11 Apr 2024 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712800836; cv=none; b=fHMfKvnSUF1ebCUdXXsbDRvK6TX1PBqAmETpMKV6uhym/npmyOLyFOHqiAMshndagSfVibrpHnc1i4If3/GfWBtouCP7lSuE+u83SxmW7u1QMgw4D375AU3PtWaV/Emg8aEikIKVCmUgHRJ1ErNrTdyo3EcGVyQ9Gz7dsNTt9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712800836; c=relaxed/simple;
	bh=6Cij9gk2+tshYEQ8bidf1LIXaouxOi54fCmkbe6echc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H8jMGslu5rp0k6nsmwtER+HWOmv0PtSgnUGksHdlszKIPKW6p9X6FBwfmwqcH8/SUcPCfmUKEkuJuA5xxEkY0MQoMF5l7kuy3BLquM8HYj2hFr4wSE+wGyXKHVs9qb3jc+2lO5sZGm7Ryiqs7IuIU8Z6+q99bjBUUktPIckCDlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGqllrxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83B07C43394;
	Thu, 11 Apr 2024 02:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712800835;
	bh=6Cij9gk2+tshYEQ8bidf1LIXaouxOi54fCmkbe6echc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DGqllrxs7/KWcrtpvjksskac53m2Lh2RJ/0d8Vl+Pb7sx5QA1m4zFtZTz/ToiUZgd
	 gTmKE7Ts7UcsStFbw9hdgyjFQnLq0JlBen6IPkzKWTpmm2IOkMjIsvTEyBDv7TEdPx
	 HedYd0AhaAPPUg3Bb/bKz4C9Htct4kDspcxvccxhU7bxAqisUvjQdcmUGabKg5ETws
	 u/d52OwiG+jYNZCBY+rQQj0OQ8I8G/SHn8+MYjjhaDd8NlgD/1fJwHr67+vNNgQiv9
	 pt0AH6j5HOq8KNGhrviFYhto5PRpzi0BG6mesPeQYhDipEKQFy1KnaOquDJ7V3aEA6
	 zEfYhJwf5ecew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61167CF21C5;
	Thu, 11 Apr 2024 02:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: dsa: mt7530: fix enabling EEE on MT7531 switch
 on all boards
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171280083539.2701.12891198240380123867.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 02:00:35 +0000
References: <20240408-for-net-mt7530-fix-eee-for-mt7531-mt7988-v3-1-84fdef1f008b@arinc9.com>
In-Reply-To: <20240408-for-net-mt7530-fix-eee-for-mt7531-mt7988-v3-1-84fdef1f008b@arinc9.com>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCB2aWEgQjQgUmVsYXkgPGRldm51bGwrYXJpbmMudW5hbC5h?=@codeaurora.org,
	=?utf-8?b?cmluYzkuY29tQGtlcm5lbC5vcmc+?=@codeaurora.org
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 opensource@vdorst.com, linux@armlinux.org.uk, SkyLake.Huang@mediatek.com,
 hkallweit1@gmail.com, bartel.eerdekens@constell8.be, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, florian.fainelli@broadcom.com,
 arinc.unal@arinc9.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 08 Apr 2024 10:08:53 +0300 you wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The commit 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
> brought EEE support but did not enable EEE on MT7531 switch MACs. EEE is
> enabled on MT7531 switch MACs by pulling the LAN2LED0 pin low on the board
> (bootstrapping), unsetting the EEE_DIS bit on the trap register, or setting
> the internal EEE switch bit on the CORE_PLL_GROUP4 register. Thanks to
> SkyLake Huang (黃啟澤) from MediaTek for providing information on the
> internal EEE switch bit.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: dsa: mt7530: fix enabling EEE on MT7531 switch on all boards
    https://git.kernel.org/netdev/net/c/06dfcd4098cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



