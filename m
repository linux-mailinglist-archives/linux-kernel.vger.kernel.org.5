Return-Path: <linux-kernel+bounces-156782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3148B0816
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1E51C22020
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D54715B124;
	Wed, 24 Apr 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrEmQpCl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD5D15A482;
	Wed, 24 Apr 2024 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957032; cv=none; b=o24btjS9IEFL8kZ0DWlEFvoRg/ud9cOPB87bdzgqsd4KllPAz3TqSB1Rme9NiS3NJeM1hCxubgLWn+D/tjMnZKudOxqYOpF43SB9IS2wt8AhcJCrIjb0e/DtIBOLpsWZSizn2j2TPKqWI1uyNkna/sAThMOR8c408RLVAfYv/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957032; c=relaxed/simple;
	bh=gqUwRpVOBrOCupCEmjKVghs27hLbcO22cVVu9ReSJc0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EmgYDi1wHmxjMYIv0pmMPh1Mtc2tlZEJegdOyiclnSW1FL8Dcq3gOdKsxbtclSI5VfZk0NPVyfdJF+PNJ9kqntbumORBzdT/8uQDuB+OEbg7AjUJo06uJi42Caw9iczHrwHOkwEr8ewj8t/OLmx/A6FBqI/dRia2yCZcMfNi33U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrEmQpCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3ECBC4AF17;
	Wed, 24 Apr 2024 11:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713957031;
	bh=gqUwRpVOBrOCupCEmjKVghs27hLbcO22cVVu9ReSJc0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OrEmQpClgB7ghPcBbQXnD0fGvo60vZnrVDAEp4BtjvFtzItqvi+LVBmsH67JCOUPE
	 GcridA1t/7Hr8qzIcOg7/MrG6N9QLoS/5fjUoCQ30oszdlmEAVYwIDTBi0g9Wpxeq5
	 EQPjYNw4iX1MXlWedXINvXbBpwGjZm1Khe+D+m6qzVdXSJ2Z9dVrv7NDiyjtVW50G6
	 C/5rwbc1ph2lPAIYcglKzP+MdBpinTffVZsQjwvpq1PxEILltD9rxjx+0FeXREFvUz
	 SXhow9rP2IznyTIdxWhn0/Y8fkeKPdL/2FbFPl8Qtlhh8x3XPOr3VM1klNyPLjP1gC
	 dpcd7y8ZzjA/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B188EDEC7E3;
	Wed, 24 Apr 2024 11:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/15] MT7530 DSA Subdriver Improvements Act IV
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171395703172.12181.6567333903825850575.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 11:10:31 +0000
References: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>
In-Reply-To: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCB2aWEgQjQgUmVsYXkgPGRldm51bGwrYXJpbmMudW5hbC5h?=@codeaurora.org,
	=?utf-8?b?cmluYzkuY29tQGtlcm5lbC5vcmc+?=@codeaurora.org
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux@armlinux.org.uk, bartel.eerdekens@constell8.be,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, arinc.unal@arinc9.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 22 Apr 2024 10:15:07 +0300 you wrote:
> Hello!
> 
> This is the forth patch series with the goal of simplifying the MT7530 DSA
> subdriver and improving support for MT7530, MT7531, and the switch on the
> MT7988 SoC.
> 
> I have done a simple ping test to confirm basic communication on all switch
> ports on MCM and standalone MT7530, and MT7531 switch with this patch
> series applied.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/15] net: dsa: mt7530: disable EEE abilities on failure on MT7531 and MT7988
    https://git.kernel.org/netdev/net-next/c/385c22ee4ba4
  - [net-next,v2,02/15] net: dsa: mt7530: refactor MT7530_PMCR_P()
    https://git.kernel.org/netdev/net-next/c/883ea1c0ed48
  - [net-next,v2,03/15] net: dsa: mt7530: rename p5_intf_sel and use only for MT7530 switch
    https://git.kernel.org/netdev/net-next/c/eeaf9acbfc50
  - [net-next,v2,04/15] net: dsa: mt7530: rename mt753x_bpdu_port_fw enum to mt753x_to_cpu_fw
    https://git.kernel.org/netdev/net-next/c/7603a0c7d221
  - [net-next,v2,05/15] net: dsa: mt7530: refactor MT7530_MFC and MT7531_CFC, add MT7531_QRY_FFP
    https://git.kernel.org/netdev/net-next/c/9c7401dc1b13
  - [net-next,v2,06/15] net: dsa: mt7530: refactor MT7530_HWTRAP and MT7530_MHWTRAP
    https://git.kernel.org/netdev/net-next/c/7c8d14029dff
  - [net-next,v2,07/15] net: dsa: mt7530: move MT753X_MTRAP operations for MT7530
    https://git.kernel.org/netdev/net-next/c/377174c5760c
  - [net-next,v2,08/15] net: dsa: mt7530: return mt7530_setup_mdio & mt7531_setup_common on error
    https://git.kernel.org/netdev/net-next/c/7bf06bcd946e
  - [net-next,v2,09/15] net: dsa: mt7530: define MAC speed capabilities per switch model
    https://git.kernel.org/netdev/net-next/c/6512204b4d5b
  - [net-next,v2,10/15] net: dsa: mt7530: get rid of function sanity check
    https://git.kernel.org/netdev/net-next/c/379f7bf864f6
  - [net-next,v2,11/15] net: dsa: mt7530: refactor MT7530_PMEEECR_P()
    https://git.kernel.org/netdev/net-next/c/99acfa82ddb1
  - [net-next,v2,12/15] net: dsa: mt7530: get rid of mac_port_validate member of mt753x_info
    https://git.kernel.org/netdev/net-next/c/aa16e1fc9ea8
  - [net-next,v2,13/15] net: dsa: mt7530: use priv->ds->num_ports instead of MT7530_NUM_PORTS
    https://git.kernel.org/netdev/net-next/c/318c1944710a
  - [net-next,v2,14/15] net: dsa: mt7530: do not pass port variable to mt7531_rgmii_setup()
    https://git.kernel.org/netdev/net-next/c/9df9aec174f5
  - [net-next,v2,15/15] net: dsa: mt7530: explain exposing MDIO bus of MT7531AE better
    https://git.kernel.org/netdev/net-next/c/bf1774491eea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



