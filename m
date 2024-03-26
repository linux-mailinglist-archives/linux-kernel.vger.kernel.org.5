Return-Path: <linux-kernel+bounces-118576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2381888BCCD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18B51F3AFEE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F0F1BF3A;
	Tue, 26 Mar 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMzQOZyU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B9814F62;
	Tue, 26 Mar 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443030; cv=none; b=QIBlYBaVwGNv9BtkiNndfqYsmXlFaedLcMSQZlnP/CtD3pNSE8kxYdHT696es3s5p1vuHlStN0JzZ8wMlzd7mc4RuEgWJUzLMj/IoPKpVACQWlFp5oAStXqDmlfwZFI90/igbgN2usehcQqCO4Q03GcO46kIGtlteCArgarekBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443030; c=relaxed/simple;
	bh=4X1Z3kvgSdNm/Ff7dFFnXnXj/MKpjiKYMAG4S+nj6rY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fJcu1aS3ydl+eCG+tgnPHL/c31IO9vUDO2uvRq9vxqq/4mEI5+vs5rRtJ245wEaYPXYDT6rGl1V3Wp4Dht20nspWUrwkZFaVfNCWHrOST6OfWCF7GpiZn+vPJLJF2MzavKXt8nid3Jb0rkbQa31nQsExugbzm3uEb6XkRWlCmlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMzQOZyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0CD0C43390;
	Tue, 26 Mar 2024 08:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711443029;
	bh=4X1Z3kvgSdNm/Ff7dFFnXnXj/MKpjiKYMAG4S+nj6rY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bMzQOZyUd//B/B/1Mhs5OviJK3RYqfO4NxyBm6TFNgBO6ql0hqh6PmXLOtnJ2xOFK
	 Tnv0jvVJC7WH+SweKyx3r3Oel1H89DK9Ouyvd7hBVkfrMPWSoqo+6Y1o6xKj8+0EGV
	 ehEhdJ7sJQS9WRsohNqoB+hZgqeFmyW6RCSbF/eL+ewPKrHS5f4eFSkUGL4eaSbove
	 keomdByrpeflobjpyb76QYRCU/w+XXu4fSLWpPgmgQQUfpihF6Mr1rL1Q7kvmzrQi2
	 zNXy47adMcpBN+Sn+RnnAFeq/JPSBeD9VkQbaLdxSlFbp0iSzJmaqtgj4Ez9jT62Cx
	 /t8/COWJAXTTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB22CD2D0E9;
	Tue, 26 Mar 2024 08:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: mt7530: fix improper frames on all 25MHz and
 40MHz XTAL MT7530
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171144302969.11902.10822860484949100289.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 08:50:29 +0000
References: <20240320-for-net-mt7530-fix-25mhz-xtal-with-direct-phy-access-v1-1-d92f605f1160@arinc9.com>
In-Reply-To: <20240320-for-net-mt7530-fix-25mhz-xtal-with-direct-phy-access-v1-1-d92f605f1160@arinc9.com>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCB2aWEgQjQgUmVsYXkgPGRldm51bGwrYXJpbmMudW5hbC5h?=@codeaurora.org,
	=?utf-8?b?cmluYzkuY29tQGtlcm5lbC5vcmc+?=@codeaurora.org
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 Landen.Chao@mediatek.com, bartel.eerdekens@constell8.be,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, arinc.unal@arinc9.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 20 Mar 2024 23:45:30 +0300 you wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The MT7530 switch after reset initialises with a core clock frequency that
> works with a 25MHz XTAL connected to it. For 40MHz XTAL, the core clock
> frequency must be set to 500MHz.
> 
> The mt7530_pll_setup() function is responsible of setting the core clock
> frequency. Currently, it runs on MT7530 with 25MHz and 40MHz XTAL. This
> causes MT7530 switch with 25MHz XTAL to egress and ingress frames
> improperly.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: mt7530: fix improper frames on all 25MHz and 40MHz XTAL MT7530
    https://git.kernel.org/netdev/net/c/5f563c31ff0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



