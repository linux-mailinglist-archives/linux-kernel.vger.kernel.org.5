Return-Path: <linux-kernel+bounces-148090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5328A7D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DB8FB21F1B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC5C70CCB;
	Wed, 17 Apr 2024 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8LTOOAL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765AA74BF5;
	Wed, 17 Apr 2024 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340832; cv=none; b=pc8FNoS5KvKPmVEDv0Elu3O9c7aGLfHBCksvgVL15/+MFi7yWnZw1MfWtjmcnAq8hc+8wPi4+GO3NOiBGOnqjupXtvF4IYXy8f8Bp3ZYwlWBB/Oa9uXg3mEuboXzfd1sgwNF8HMpgPOTFqrJ6twhBhFTjSkv9VSo7ORZxGX3TFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340832; c=relaxed/simple;
	bh=oEQgw93Cov2umXAsjiuN9cm/AxuQU4zSu7ix8xBpZsQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ndEUIJfK7mMs2DhUg00TdO/NXL7fuyDafPLn8Zq5uYSfGKxCMU0r7QzhMFeVwjBl1X6NBtUf/xEPCQWgFtltP68My0G3lpRYJk+214+zDYuTd4nQtTECKpdc9RJsQlQZlj+2KvAD6wPHFjBH260Bk0dNIeKZlc2D/LK2H+79IVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8LTOOAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3BC5C32781;
	Wed, 17 Apr 2024 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713340831;
	bh=oEQgw93Cov2umXAsjiuN9cm/AxuQU4zSu7ix8xBpZsQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X8LTOOALhbI5/bnuhZXwxMGCrLlwBKcCPsU+v/n08hYKD7kbLilKLS5e41s9H+iQa
	 ZEHWI+BLCATu6S/F9HuHRtQKwyw5eybpRLXKNZ5bjK25CYJBCGNJg2PmqyR8zRgwWG
	 53wcjsj3OX4ktA/yuoOUdpY45guRAUG0nrmnhEMYVIaL2j9T/TqkE+92NUOGkTeyyA
	 HTOBx3n32eUL2dlCahLvzlyhzxwStDvCNb8W6EwC6IxQQWfOK9j39nOAAfkXVnN0Pn
	 sijcC3X4F49/9tJq1YvpOzhDKX/eYNIRYdeZYmDqfYuBkF3gMd00+r4Fdo0vUkPaoL
	 /xNPYb5/+ROnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5EE5D5B3FF;
	Wed, 17 Apr 2024 08:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] Fix port mirroring on MT7530 DSA subdriver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171334083086.1461.14636721457628814593.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 08:00:30 +0000
References: <20240413-b4-for-net-mt7530-fix-mirroring-to-local-port-and-mt7988-v1-0-476deff8cc06@arinc9.com>
In-Reply-To: <20240413-b4-for-net-mt7530-fix-mirroring-to-local-port-and-mt7988-v1-0-476deff8cc06@arinc9.com>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCB2aWEgQjQgUmVsYXkgPGRldm51bGwrYXJpbmMudW5hbC5h?=@codeaurora.org,
	=?utf-8?b?cmluYzkuY29tQGtlcm5lbC5vcmc+?=@codeaurora.org
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, hs@giax.de,
 bartel.eerdekens@constell8.be, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, arinc.unal@arinc9.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 13 Apr 2024 16:01:38 +0300 you wrote:
> Hi.
> 
> This patch series fixes the frames received on the local port (monitor
> port) not being mirrored, and port mirroring for the MT7988 SoC switch.
> 
> Arınç
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: dsa: mt7530: fix mirroring frames received on local port
    https://git.kernel.org/netdev/net/c/d59cf049c837
  - [net,2/2] net: dsa: mt7530: fix port mirroring for MT7988 SoC switch
    https://git.kernel.org/netdev/net/c/2c606d138518

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



