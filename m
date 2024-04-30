Return-Path: <linux-kernel+bounces-163868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BD18B74D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE85283134
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E074013C908;
	Tue, 30 Apr 2024 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9r9azER"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD4512D76B;
	Tue, 30 Apr 2024 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477830; cv=none; b=VEaxzm0jbmPdPoWnn8Y2l66xH35/LdBzJr9iY0ke9A48nPUFeROpsBKQ9ozyhDTS8vp51oYoISLyholk7rtZ7jWbazBe5uPT+jKU6gUvAnm8TERjZ3IKLJJvji90i6H5A7raoj/QG0IWuDvR1IL2XzcGCuVRa2M4QLWRr6bP58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477830; c=relaxed/simple;
	bh=p+ENwJCsykCW/qhdhEg1FQUbh2EUt27b+foeevRiMcw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nHGWBVs0q1WJCHLIQQwdPX0dvFA9v6mgfSVAwaWQs8Sh43aOaYzsD3Z6geJt5LpB2Q0f2chC+ny3oNGemHQMqE99dGAU9PFqUaAhulafgQplbh480bk1rC3YMhDdU7qmNTw7VcBHOBoscCgr1bFZY0UMvY7Vvpylo1eSQ4p+zoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9r9azER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D1BCC4AF18;
	Tue, 30 Apr 2024 11:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714477829;
	bh=p+ENwJCsykCW/qhdhEg1FQUbh2EUt27b+foeevRiMcw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z9r9azER/+HcufesMEygLcC9skhZqlT25mKI/8CLRDemnzxbrKj0YD4cdB9P3IUSi
	 dyITdqORqwEWm68mYvn6LDFaNYKzoNS7Io3ML7Aye6vUidzjoY2bQFIZwtAgkgbsg+
	 voW+HRElcy/Kq13O4Q/DBSJPbn7wjwHRppVTmnjwk9dmJ4uVoFEBLXyZCWxV3NZDBg
	 8F28E07Ti1KcIcLzLU6uPGAKjadJbba4iIWmeunxNArzYv9WTfGjpQYa3qw+gZ+EPI
	 E0MLn4n7o2DyP6HDkahyTQbrQ9OyKg6X7ulCljdimGbT5MNeSSb5+6FnjaeDvZFiXQ
	 XURCV+Q/VMkUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B2BDC43444;
	Tue, 30 Apr 2024 11:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: dsa: mt7530: do not set MT7530_P5_DIS
 when PHY muxing is being used
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171447782956.17629.8692193318005326042.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 11:50:29 +0000
References: <20240428-for-netnext-mt7530-do-not-disable-port5-when-phy-muxing-v2-1-bb7c37d293f8@arinc9.com>
In-Reply-To: <20240428-for-netnext-mt7530-do-not-disable-port5-when-phy-muxing-v2-1-bb7c37d293f8@arinc9.com>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCB2aWEgQjQgUmVsYXkgPGRldm51bGwrYXJpbmMudW5hbC5h?=@codeaurora.org,
	=?utf-8?b?cmluYzkuY29tQGtlcm5lbC5vcmc+?=@codeaurora.org
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 arinc.unal@arinc9.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 28 Apr 2024 12:19:58 +0300 you wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> DSA initalises the ds->num_ports amount of ports in
> dsa_switch_touch_ports(). When the PHY muxing feature is in use, port 5
> won't be defined in the device tree. Because of this, the type member of
> the dsa_port structure for this port will be assigned DSA_PORT_TYPE_UNUSED.
> The dsa_port_setup() function calls ds->ops->port_disable() when the port
> type is DSA_PORT_TYPE_UNUSED.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: dsa: mt7530: do not set MT7530_P5_DIS when PHY muxing is being used
    https://git.kernel.org/netdev/net-next/c/16e6592cd5c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



