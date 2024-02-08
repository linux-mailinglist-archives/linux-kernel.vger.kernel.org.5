Return-Path: <linux-kernel+bounces-57408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABDE84D835
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFDA2281C09
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9164A1DA2F;
	Thu,  8 Feb 2024 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsMbSDfe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B5F1D52C;
	Thu,  8 Feb 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707361831; cv=none; b=LthZ5AbWL2L659oSHR6Zc6NtLbElIhCCdfWk6oTBRkWk1UNcbSUsPJMuqNq6rc0y3feVTc/busIHjX+Mvp42QHe9iqbZ6L24Zq2x1GCH3zNp3O+E/iy5wacoTayKJXXhmEaoM/QJEpS5NQ6VFO7AYYDN0XEOXgbq5uoPmlUWEVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707361831; c=relaxed/simple;
	bh=QPH1yr6VHuRyaB6xH/FtQKMvMHLE/l58r4MMmJTwfmo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uu7TlnvwGbQ1JOpxVQBjmvYWpKLk7+r8BkVr6vFj975pDlvzxVuDDtPrufNnK/2tTDd8n22FgkbEjet3EZsfIeiFU0Jzz4jJJydgwKYOvRoa1FbL7xzXaqYhg1zflQoMWajuOCIC9WIpCWPZ0o3kIpsVtL18lod7r0VJa/Od+ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsMbSDfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 453E0C43394;
	Thu,  8 Feb 2024 03:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707361831;
	bh=QPH1yr6VHuRyaB6xH/FtQKMvMHLE/l58r4MMmJTwfmo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gsMbSDfezpPDvaH2NSZJXCJjbnoFukNxn4keKuVYtZzd3ZZbWV4NKGYtqxx+ujeiE
	 omGPpuHZtb/K1O6rZoESp9YcgrQ47/kZ6QWzcT/bjw/olF6td4Ia4DACQtJe8CxjZW
	 a2erQRvQFpDlE7uJhSoZIaiMEULipED8ibrd211ppS8b4rbiWMz0vn0qULIAg1elLy
	 vt2hUgmc2eO/a/zCeYgPKslzVR43JGZwxi1BuqHsxGJLu7c63xsatwTUkXSRIQG5TS
	 ogya1HH+8DPWjHSRvMJrwsjYZB7ZeESUrr5CWEAE+jdmfo/vGy3QtBf/kELl11DOrE
	 naz30cauu+0kA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F27AD8C97D;
	Thu,  8 Feb 2024 03:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/7] MT7530 DSA Subdriver Improvements Act II
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170736183112.28016.638375642700204813.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 03:10:31 +0000
References: <20240206-for-netnext-mt7530-improvements-2-v5-0-d7d92a185cb1@arinc9.com>
In-Reply-To: <20240206-for-netnext-mt7530-improvements-2-v5-0-d7d92a185cb1@arinc9.com>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCB2aWEgQjQgUmVsYXkgPGRldm51bGwrYXJpbmMudW5hbC5h?=@codeaurora.org,
	=?utf-8?b?cmluYzkuY29tQGtlcm5lbC5vcmc+?=@codeaurora.org
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux@armlinux.org.uk, mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 bartel.eerdekens@constell8.be, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, arinc.unal@arinc9.com,
 rmk+kernel@armlinux.org.uk

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 06 Feb 2024 01:08:01 +0300 you wrote:
> Hello!
> 
> This is the second patch series with the goal of simplifying the MT7530 DSA
> subdriver and improving support for MT7530, MT7531, and the switch on the
> MT7988 SoC.
> 
> I have done a simple ping test to confirm basic communication on all switch
> ports on MCM and standalone MT7530, and MT7531 switch with this patch
> series applied.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/7] net: dsa: mt7530: empty default case on mt7530_setup_port5()
    https://git.kernel.org/netdev/net-next/c/01fc42942e30
  - [net-next,v5,2/7] net: dsa: mt7530: move XTAL check to mt7530_setup()
    https://git.kernel.org/netdev/net-next/c/fd7929095a52
  - [net-next,v5,3/7] net: dsa: mt7530: simplify mt7530_pad_clk_setup()
    https://git.kernel.org/netdev/net-next/c/4eec447ef640
  - [net-next,v5,4/7] net: dsa: mt7530: call port 6 setup from mt7530_mac_config()
    https://git.kernel.org/netdev/net-next/c/4ea4c040ddc8
  - [net-next,v5,5/7] net: dsa: mt7530: remove pad_setup function pointer
    https://git.kernel.org/netdev/net-next/c/8c2703f55837
  - [net-next,v5,6/7] net: dsa: mt7530: correct port capabilities of MT7988
    https://git.kernel.org/netdev/net-next/c/c9d70a1d3d64
  - [net-next,v5,7/7] net: dsa: mt7530: do not clear config->supported_interfaces
    https://git.kernel.org/netdev/net-next/c/b43990bc552e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



