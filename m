Return-Path: <linux-kernel+bounces-104484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6510D87CE8A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A10D1F22879
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC31C376F3;
	Fri, 15 Mar 2024 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ez//vUQc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC1937164;
	Fri, 15 Mar 2024 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710511881; cv=none; b=dJc6Ih0pPx74U3dzbRGOjsRdFqZdSeJfV9OfA/N8AEF3ysX8BHeqOO9UiTuIBo9+MRxf9PH0wkapI2IRFYcJ4yyL6Oz6CQgxfU0L9Zbho7P3yMfqfsVRAoirK8SQcFS7fS9Whe+9SnyuZnrA+DYJRq0hiooVGo0Y20Acl3u0jls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710511881; c=relaxed/simple;
	bh=xYmAthB11ki5pMUzbtNCl+cG0dk3Pap42GLMQ8EMeTE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gp8O4407EaWbwT0ESGNnYwGXE09U/BypW84Q0cSHl11UwVM2EwOFG2tPaYino1cN5xZ1ri4He0exYpan2cYC6Cm3gfWLn19DvOucDXb3bYqthkUcxdgSYbox1Xs+c6dgKRylS2/EsCrrPyreY+pM0KXC70bxKinytmUZ/0iWtKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ez//vUQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B3E3C433C7;
	Fri, 15 Mar 2024 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710511880;
	bh=xYmAthB11ki5pMUzbtNCl+cG0dk3Pap42GLMQ8EMeTE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ez//vUQcHaqHkEqhM6yLs7YMZlPo6c0DDwBTf9E+yHYUIWQXuKguB38bnOad5lIhy
	 hxU+leTls8Orl24viNxHKwj4sJ0Vo8cUvH/9be1E4/tcAoMy3MEpldRdr1cspoRJXT
	 7admbgk48qVAZBV1NTJWZE0UFatpFnm4CxRw+dB356fhWtP6G5gH14/ZCqXQXk1Nxj
	 Hame8Fca1TzsQaCGVw8G6pgCSls14Ktg0u8hh6HFFXdckG1jp3VSP0SkpDjskreVxb
	 9aI4ReDcgWX0hK9KrX9JkmhKca+AqOecORaXecS/2UqM5P9mU2qw+1L4WMxbajGLQV
	 870rV7iF79NCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F037D84BA8;
	Fri, 15 Mar 2024 14:11:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: mediatek: mtk_eth_soc: clear MAC_MCR_FORCE_LINK
 only when MAC is up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171051188051.5784.14743841618605304663.git-patchwork-notify@kernel.org>
Date: Fri, 15 Mar 2024 14:11:20 +0000
References: <7205ca7d3c5433214256df4672f7c1a49815a5a5.1710367570.git.daniel@makrotopia.org>
In-Reply-To: <7205ca7d3c5433214256df4672f7c1a49815a5a5.1710367570.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, opensource@vdorst.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 chad.monroe@adtran.com, steven.liu@mediatek.com, john@phrozen.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Mar 2024 22:50:18 +0000 you wrote:
> Clearing bit MAC_MCR_FORCE_LINK which forces the link down too early
> can result in MAC ending up in a broken/blocked state.
> 
> Fix this by handling this bit in the .mac_link_up and .mac_link_down
> calls instead of in .mac_finish.
> 
> Fixes: b8fc9f30821e ("net: ethernet: mediatek: Add basic PHYLINK support")
> Suggested-by: Mason-cw Chang <Mason-cw.Chang@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: mediatek: mtk_eth_soc: clear MAC_MCR_FORCE_LINK only when MAC is up
    https://git.kernel.org/netdev/net/c/f1b85ef15a99
  - [net,2/2] net: ethernet: mtk_eth_soc: fix PPE hanging issue
    https://git.kernel.org/netdev/net/c/ea80e3ed09ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



