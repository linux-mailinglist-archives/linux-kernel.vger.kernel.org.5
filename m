Return-Path: <linux-kernel+bounces-43798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166EB8418F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6970289B70
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3425D36AFB;
	Tue, 30 Jan 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgC+4ANf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57B37145;
	Tue, 30 Jan 2024 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580627; cv=none; b=OzvBEJzc5RvvfjPuWlR8L7TFR1PCNhNx/8YSB9aVSHo028ewKeNcr+7XHWmla6weFT8ZGrKmzMVax87pxMVzU1KcCyzqgKGOiiC7xzEcsjDak9nF2vjC5oNP6J/a5LEL2IaL2QIh+SwS3+KPVc/a8WIQO1zRrrHjCBsKfOsLh8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580627; c=relaxed/simple;
	bh=4+POrROwPnatEmM5H95Kp47HMH+fWtriY394HxDqm4w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TNsZU1/0nWucO9Rz5p1qSleYHQU2OfJwhcJJOHFLZs/f3vM2yxzxbKb5ENC7u9ZOBlZEvLQa7pdfUj9bDa792HNvDfe/HXMD7mXfhX6TvAkvc2w/hJIgH9pf5pMKa5sfs/+HDRyofID2brShXL5q2f2PG1Wrh4GsTe2X/yPA8c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgC+4ANf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C84D9C43390;
	Tue, 30 Jan 2024 02:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706580626;
	bh=4+POrROwPnatEmM5H95Kp47HMH+fWtriY394HxDqm4w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XgC+4ANf7/FtsIREu2/ImCQS+UqIYlntE3DhKgXU3wCsqhk4QKGgS+c/NvP04IoXW
	 Z5ld4+b0LiQNG9zzfm6hM3eQrbcq3gMsppMJ2k1n4t37PeKqikB0lkCLMqB9BLsXhC
	 eR4zVUHMniPARwlTFCd1HZrX/z798PeBFF2bZ9l9EKAUIf0amtv2W4t3j7vjLrIGjW
	 1hlFYFUuxxuVHWYp0UFTS+cnggC6qYDHTbNLTvw3PdLbKrp65TH9KXjeSqZoB9t4NX
	 AdQR57LgpgBVpTC8jyJWXklG3XQuAhNtoA7AW9iuJ7FXL5SaP3mrDefJwDZLo+BcAy
	 GF3Pn6yTo+bAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACE77C00448;
	Tue, 30 Jan 2024 02:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/7] MT7530 DSA Subdriver Improvements Act I
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170658062670.15779.8221227198505165496.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 02:10:26 +0000
References: <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
In-Reply-To: <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCB2aWEgQjQgUmVsYXkgPGRldm51bGwrYXJpbmMudW5hbC5h?=@codeaurora.org,
	=?utf-8?b?cmluYzkuY29tQGtlcm5lbC5vcmc+?=@codeaurora.org
Cc: daniel@makrotopia.org, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux@armlinux.org.uk,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 bartel.eerdekens@constell8.be, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, arinc.unal@arinc9.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jan 2024 08:35:51 +0300 you wrote:
> Hello!
> 
> This patch series simplifies the MT7530 DSA subdriver and improves the
> logic of the support for MT7530, MT7531, and the switch on the MT7988 SoC.
> 
> I have done a simple ping test to confirm basic communication on all switch
> ports on MCM and standalone MT7530, and MT7531 switch with this patch
> series applied.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/7] net: dsa: mt7530: always trap frames to active CPU port on MT7530
    https://git.kernel.org/netdev/net-next/c/024d8577f534
  - [net-next,v3,2/7] net: dsa: mt7530: use p5_interface_select as data type for p5_intf_sel
    https://git.kernel.org/netdev/net-next/c/b198c9097f06
  - [net-next,v3,3/7] net: dsa: mt7530: store port 5 SGMII capability of MT7531
    https://git.kernel.org/netdev/net-next/c/1f4a85f2eaa8
  - [net-next,v3,4/7] net: dsa: mt7530: improve comments regarding switch ports
    https://git.kernel.org/netdev/net-next/c/05957aa77ed8
  - [net-next,v3,5/7] net: dsa: mt7530: improve code path for setting up port 5
    https://git.kernel.org/netdev/net-next/c/152f8e8e7458
  - [net-next,v3,6/7] net: dsa: mt7530: do not set priv->p5_interface on mt7530_setup_port5()
    https://git.kernel.org/netdev/net-next/c/6537973f2a5d
  - [net-next,v3,7/7] net: dsa: mt7530: do not run mt7530_setup_port5() if port 5 is disabled
    https://git.kernel.org/netdev/net-next/c/04a22bef5fc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



