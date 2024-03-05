Return-Path: <linux-kernel+bounces-92321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976F8871E70
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5347E28511D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4D65A793;
	Tue,  5 Mar 2024 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX+Nvu4f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9659146;
	Tue,  5 Mar 2024 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640032; cv=none; b=Ktua6ZK4N4wpvkMUTWUVKebGqiKENgUlN7e7k1XL4dPbhHDkPJEl2TInGgXDROkRUvDtJEcD1dTkK0gpykg1CKcn3QCyAPunPg8DPq5Rzmo5ttCKatj6xPK1WdCoueDV3RWw96BtZxcHb8Pv+5pyj+UQ+K640JLFxfk5h8bGfgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640032; c=relaxed/simple;
	bh=dksLaDVSy6nq7bP4e4YeQwSAmypjMREMKHNjaEVWxwQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EEafmE3INa2nAlKucUPQIf3pArdiYsw0BiTzHST6EQSONbb/FemyfNZ0VFxJFKJJslLXmv4nKWTtGX2bNb1T7bcCZu0HAF9HAzUw9DSIbulWOZAMG5ouzVWYP9kojz9m7Ik9kZ0+cfNtfXfHZBh58PRlKzHwJPjmiRlsYuVL0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX+Nvu4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 195C8C43390;
	Tue,  5 Mar 2024 12:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709640032;
	bh=dksLaDVSy6nq7bP4e4YeQwSAmypjMREMKHNjaEVWxwQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iX+Nvu4f89MlkCTlP8LkvOL+xzTIElbLQkK1ES/qoNu9WG6d8FTflxfdESs2PSYcb
	 WGzbhP6RIvkRXlqX/D6Tj82ZCceKF/ZGDRqYI+fCoOV52NXAMQaeWB+TqBtbHaVWPz
	 R2DMiRBj5AreLzi9BOOhaRNqMP3owHpMvcEhp+TysDU39AWRBCsJ46aCIptK7IE87A
	 lchgT9n01mEeXfx32D7JBZxCn1TH5LY3Ujppkfnss0DAt/z9H7iftkExyoC21Tpmvt
	 nzPRVf8Bf+ApB0kou3XaqEH71w++ZrBPtAnEuJSdtrLoDGWF3ycurkILxu/iYkdrwr
	 Z770SFr6giXLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7A59D84BDF;
	Tue,  5 Mar 2024 12:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/9] MT7530 DSA Subdriver Improvements Act III
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170964003194.11081.15831016567274956859.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 12:00:31 +0000
References: <20240301-for-netnext-mt7530-improvements-3-v3-0-449f4f166454@arinc9.com>
In-Reply-To: <20240301-for-netnext-mt7530-improvements-3-v3-0-449f4f166454@arinc9.com>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCB2aWEgQjQgUmVsYXkgPGRldm51bGwrYXJpbmMudW5hbC5h?=@codeaurora.org,
	=?utf-8?b?cmluYzkuY29tQGtlcm5lbC5vcmc+?=@codeaurora.org
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux@armlinux.org.uk, mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 bartel.eerdekens@constell8.be, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, arinc.unal@arinc9.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 01 Mar 2024 12:42:56 +0200 you wrote:
> Hello!
> 
> This is the third patch series with the goal of simplifying the MT7530 DSA
> subdriver and improving support for MT7530, MT7531, and the switch on the
> MT7988 SoC.
> 
> I have done a simple ping test to confirm basic communication on all switch
> ports on MCM and standalone MT7530, and MT7531 switch with this patch
> series applied.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/9] net: dsa: mt7530: remove .mac_port_config for MT7988 and make it optional
    https://git.kernel.org/netdev/net-next/c/6ebe414b48cf
  - [net-next,v3,2/9] net: dsa: mt7530: set interrupt register only for MT7530
    https://git.kernel.org/netdev/net-next/c/804cd5f7059e
  - [net-next,v3,3/9] net: dsa: mt7530: do not use SW_PHY_RST to reset MT7531 switch
    https://git.kernel.org/netdev/net-next/c/a565f98d7d25
  - [net-next,v3,4/9] net: dsa: mt7530: get rid of useless error returns on phylink code path
    https://git.kernel.org/netdev/net-next/c/adf4ae24ba42
  - [net-next,v3,5/9] net: dsa: mt7530: get rid of priv->info->cpu_port_config()
    https://git.kernel.org/netdev/net-next/c/22fa10170af5
  - [net-next,v3,6/9] net: dsa: mt7530: get rid of mt753x_mac_config()
    https://git.kernel.org/netdev/net-next/c/1192ed898c97
  - [net-next,v3,7/9] net: dsa: mt7530: put initialising PCS devices code back to original order
    https://git.kernel.org/netdev/net-next/c/3a87131e3d72
  - [net-next,v3,8/9] net: dsa: mt7530: sort link settings ops and force link down on all ports
    https://git.kernel.org/netdev/net-next/c/6324230b3b67
  - [net-next,v3,9/9] net: dsa: mt7530: simplify link operations
    https://git.kernel.org/netdev/net-next/c/b04097c7a745

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



