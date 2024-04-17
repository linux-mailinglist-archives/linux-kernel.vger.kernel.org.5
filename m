Return-Path: <linux-kernel+bounces-147794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A8C8A79C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81622849C4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD38B6FA8;
	Wed, 17 Apr 2024 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2qfQtMt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7744811;
	Wed, 17 Apr 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313233; cv=none; b=I9vOxRIzQu1qpDESrs/yIUoGe647xdOdhpk735ybGWpnFHOQmZ6s+eOhb9dgDrdS9ulyD/S70Dn3z3+YtQUSH6gAt4M6ilPEwZb6iVhQSrXtIBYEnSdfSqXyJbJ1x+JiHO8TGOlAoJ3FKeME5KBgcpKAR9sAXO+2IfIdyK6a8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313233; c=relaxed/simple;
	bh=0Ckj8Hs6iWwJGXOoze4UaybZMjysV61Qjyb7fAuvvTo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Eex56nrmguW/Use61RCGVUGgrmTmcf3gOB4enio++Hi3QixfzmFA0daEsgcSiJ8YGmdyozF/PzcsQz2AsAHyXJ1cGApxYvuPgWbDdEp23zwsH/DYB8BFNWGEhI5jECkK+b9s4/5hs01YZuZWA6FYF7d+7nqwhE1cFocDjvevK0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2qfQtMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B09C5C4AF0C;
	Wed, 17 Apr 2024 00:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713313232;
	bh=0Ckj8Hs6iWwJGXOoze4UaybZMjysV61Qjyb7fAuvvTo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o2qfQtMtcZJsLpKRlEtwnveczuMYSTkZDbe92/3xOQ0sMf4nFXqsx9s1FTOoqXJCW
	 aeT34Wpba/Uz1wCC+uQ3jRSYwnG4m3zeTf9gsZDLwYwAA6L90mok7gfH12jbKnWTYS
	 Uf4hgERGtV3dl/k55z8Lwt3UpiyyzaBuKu0RGT4DUl+frDsE38+grfd7UOd/x+NN3c
	 RRoaGNf6hgr06xEsWDjsBWDhBQPlxoKf24TKOhQ8rsDBVohw5/23SwzkS9mYmKFj1m
	 E2vx3vJKxcFt8SvPKeGvAxSEjIzvaU6tjBZgszboiZMiTBez4cgIoi8nnKlEIj58x9
	 QHwbqLxuEKX5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A05D5C54BC8;
	Wed, 17 Apr 2024 00:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: net: nxp,dwmac-imx: allow nvmem cells property
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171331323265.29224.3287765599809023599.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 00:20:32 +0000
References: <20240415103621.1644735-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240415103621.1644735-1-peng.fan@oss.nxp.com>
To: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, xiaoning.wang@nxp.com, linux-imx@nxp.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 peng.fan@nxp.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Apr 2024 18:36:21 +0800 you wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Allow nvmem-cells and nvmem-cell-names to get mac_address from onchip
> fuse.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> 
> [...]

Here is the summary with links:
  - dt-bindings: net: nxp,dwmac-imx: allow nvmem cells property
    https://git.kernel.org/netdev/net-next/c/427f6acbc881

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



