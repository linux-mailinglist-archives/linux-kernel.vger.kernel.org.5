Return-Path: <linux-kernel+bounces-154745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603098AE076
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EDC1C21DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490C159151;
	Tue, 23 Apr 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffDiCOhO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6CA56B73;
	Tue, 23 Apr 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862829; cv=none; b=mfUytNjoPjtOwDqJSeZnucifGBuvGqZN8FqLzq/H2HWN+tU8mMi3yU9He7Oe/aZtacqKTZ1e6xyCmTxYeUjKF5Q5YKMXYJ6rnjjCCN6g5u9yWPmBf5Yw5DhJUfSd8CQvhFjZOVhkql2FKzd2b/BsjGJob5c20hXC+vzmpbDuW+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862829; c=relaxed/simple;
	bh=nE8DnFAjlXYHaUIN1qirvqDi+c0X4LQGHB4IF21MuZU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hxwb+OQf4K/U5VONNSAOIr2kBGi+PhsRGJ2UUekblU8yaKR5zHDS4OiHUjINpYIz3SfkE7IH2gxNGgbJ+LH4oGDQiVg/tcD3RNuJwQssNvll8kIKFDSCIxOHVn+MTENq4Liy0ucvSEJSefr/zplUwlWfAHjxPbLd7LDsZwkn8Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffDiCOhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F410FC2BD11;
	Tue, 23 Apr 2024 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713862829;
	bh=nE8DnFAjlXYHaUIN1qirvqDi+c0X4LQGHB4IF21MuZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ffDiCOhOXgB1vtYuHtskFOzrmJPR48sXJuIs0EAloKkXE4BGyvLJzrJ21OWoetBSk
	 IJOOFoN8WGP1Bo8Vaj0wW+vu4ckwjFOiJT+bheMARzCE42j2BaikPJirx3UtYtynFW
	 PlaV4m9l+bDjqfZ9LjL9jbGN43KmCxbKF4opiiQ9/4Wpm4GWPBs4s7Lg+BVVvJ0FsU
	 iWKdZSo2U/rvRday6FBau0M2kTLRN/qdOwX6AcwQDWNWfZOj3ECEB+WPMOmPlAktlP
	 YyJaJ2+pgggh78adxIzT5UtKcMujMr2G+AyHxzzA7QVbYH1zp3Owv9sjRmiENsGuOD
	 HH3cxEjbDHW2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D44B2C595D1;
	Tue, 23 Apr 2024 09:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] Read PHY address of switch from device
 tree on MT7530 DSA subdriver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171386282885.3533.16186593968313244252.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 09:00:28 +0000
References: <20240418-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v3-0-3b5fb249b004@arinc9.com>
In-Reply-To: <20240418-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v3-0-3b5fb249b004@arinc9.com>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCB2aWEgQjQgUmVsYXkgPGRldm51bGwrYXJpbmMudW5hbC5h?=@codeaurora.org,
	=?utf-8?b?cmluYzkuY29tQGtlcm5lbC5vcmc+?=@codeaurora.org
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 bartel.eerdekens@constell8.be, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, arinc.unal@arinc9.com,
 florian.fainelli@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 18 Apr 2024 08:35:29 +0300 you wrote:
> This patch series makes the driver read the PHY address the switch listens
> on from the device tree which, in result, brings support for MT7530
> switches listening on a different PHY address than 31. And the patch series
> simplifies the core operations.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: dsa: mt7530-mdio: read PHY address of switch from device tree
    https://git.kernel.org/netdev/net-next/c/868ff5f4944a
  - [net-next,v3,2/2] net: dsa: mt7530: simplify core operations
    https://git.kernel.org/netdev/net-next/c/7c5e37d7ee78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



