Return-Path: <linux-kernel+bounces-42680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEFB8404D8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13CA6B22AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C768604D1;
	Mon, 29 Jan 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH4pY8st"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC945604C0;
	Mon, 29 Jan 2024 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530828; cv=none; b=juhUeY2PuwvbX9rMTSz67FuILxabo7rzPpF7V5Tc9oPZ4rq/PvKG/hPY6OvkMckYbJ2AEnLCxymth9lcH3C6PQYGEIUsUawH4gUtDnRYNYE7N5CeJV6i2k6AYko9ZfcoxP8U5qiZBQV7fvwuLqe8V7vfk5RVYDna0P9IcQXju8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530828; c=relaxed/simple;
	bh=vb6ZHCWhWRn/+U6tLwZ75y/Ma9C7AF5RLP1V28USN7w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HssVSmTOije7tPViQgGpVhKvmzpss3wnx4cCj85KmRSDYBlfBtbGRTVoEbL09xwuUq6HGO8pMVUBivBPoEkQXAaAdX2xSJfWno2aKQqes4JcwcBH+otOXGVxpOdjBnvreyexCRgdwZuoNPo9Z/oRDDE8z1KUJKjSj6BSDP9ckVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH4pY8st; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48FE8C433C7;
	Mon, 29 Jan 2024 12:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706530828;
	bh=vb6ZHCWhWRn/+U6tLwZ75y/Ma9C7AF5RLP1V28USN7w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KH4pY8st7Rx1BFZSfM35oQwHRIC2xlgtwKqNytSeGq1qxERdr9mbs0F1zb5kiMRRW
	 rsV+Fxwr7//Af3jM+gYJfSFKRaZMY2m56J83tpohTDwudJ6g/U8yUErYVh6DycBQzD
	 uDmkrbCMjUMb3nJfuJ2EXdAO5z2uN8EL5oJ+VHh1u6xBsH1klHfGvmLVnS4sPs1DK2
	 gNVQbINrs0qHAssaxYKHFLAFWA69eqs7xVajVo9zzaIaYVXvCz8LNqMImqknghGMqd
	 72NPLvihusfVsLmIZV3W9HuQcUI3XJUW790UzT88bTk1lvvcBXD8IGwNcTkQQ42csS
	 HhoHwMmN6j/Qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D823C561EE;
	Mon, 29 Jan 2024 12:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/10] Fix MODULE_DESCRIPTION() for net (p3)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170653082818.17887.7212554013876260614.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 12:20:28 +0000
References: <20240125193420.533604-1-leitao@debian.org>
In-Reply-To: <20240125193420.533604-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, weiwan@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 25 Jan 2024 11:34:10 -0800 you wrote:
> There are hundreds of network modules that misses MODULE_DESCRIPTION(),
> causing a warning when compiling with W=1. Example:
> 
>         WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com90io.o
>         WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/arc-rimi.o
>         WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com20020.o
> 
> [...]

Here is the summary with links:
  - [net,01/10] net: fill in MODULE_DESCRIPTION()s for encx24j600
    https://git.kernel.org/netdev/net-next/c/dec836ed69d1
  - [net,02/10] net: fill in MODULE_DESCRIPTION()s for ocelot
    https://git.kernel.org/netdev/net-next/c/1c870c63d7d2
  - [net,03/10] net: fill in MODULE_DESCRIPTION()s for SMSC drivers
    https://git.kernel.org/netdev/net-next/c/9ba4295b2eab
  - [net,04/10] net: fill in MODULE_DESCRIPTION()s for Qualcom drivers
    https://git.kernel.org/netdev/net-next/c/66c164633bb0
  - [net,05/10] net: fill in MODULE_DESCRIPTION()s for dwmac-socfpga
    https://git.kernel.org/netdev/net-next/c/23f487f70c73
  - [net,06/10] net: fill in MODULE_DESCRIPTION()s for cpsw-common
    https://git.kernel.org/netdev/net-next/c/3e4620c89148
  - [net,07/10] net: fill in MODULE_DESCRIPTION()s for ec_bhf
    https://git.kernel.org/netdev/net-next/c/ad979679d64b
  - [net,08/10] net: fill in MODULE_DESCRIPTION()s for PCS drivers
    https://git.kernel.org/netdev/net-next/c/be884c15de37
  - [net,09/10] net: fill in MODULE_DESCRIPTION()s for ieee802154
    https://git.kernel.org/netdev/net-next/c/6aa89bf8ac9a
  - [net,10/10] net: fill in MODULE_DESCRIPTION()s for arcnet
    https://git.kernel.org/netdev/net-next/c/d06aa0eb0a70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



