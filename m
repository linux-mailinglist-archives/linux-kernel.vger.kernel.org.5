Return-Path: <linux-kernel+bounces-154370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8128ADB54
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363251F22AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582591B94F;
	Tue, 23 Apr 2024 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1c/iUJU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C90168BE;
	Tue, 23 Apr 2024 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713833593; cv=none; b=UA3UiXxJLlzoxCR41ND6rYCwvgoEBPJgzvMVdDV7UOF2bbYJBV4jpaXBtPE+9t+lPk/6rwYcIm47MgBvtqtL7gzW82dT267o/zJuasoP2iIu4fffmJzWfdAyPleJEuaNVNrtwVvqpAcwOYsgqDxiDoM3TJUp+2d7F2hWFQoaPAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713833593; c=relaxed/simple;
	bh=X6zsOWy7vicKD3IoC+qV0FUvApBvS4VYOoijstk0/7I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qoprcG20ZWy6Wd0fme893DPVQJMUTTjWCdmMGJtUnx8P/Z/oDrGDMTJDu8UUpbZYDClKcI01sSIVO28R2FBbz1a8wJcEmBW/zrWcG2QckQucvWrd9KjNXz+bQSgKdCyGTOy3t9At95mYYTNdTFbMb8wFunrCuDzqveJnUb/mOMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1c/iUJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59BC9C32783;
	Tue, 23 Apr 2024 00:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713833593;
	bh=X6zsOWy7vicKD3IoC+qV0FUvApBvS4VYOoijstk0/7I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P1c/iUJUemQCwnW6hdugDormtGp/YS5xgG4686FaBFth9Rd82T/aiFkHs/Jjjoag0
	 b1uBhbBIm7keE8m6h68M1avbjEj0ALvXXDqSSA/H2ox+haEgQrmrggTFbNoVuPvZj1
	 aeYGg6hGRP2R3jUkvmfWfQ1SHgXM8UbGpj88JdCsmQykyp6FHsCB39DZlWn9UKVml9
	 xIGRwKyWinjbahItb0cyO+t1MInCXCKhgDfLwdA01yK5zYpXVQX+bmNj/PLAPXYzq9
	 8DUPbX2jBpa+lpXgt0OlgnW3Vz2hb1UphDkrdLAZX+ndxNpbyEXpsijfMiymYHfMTa
	 CJ7/7LhvhDWjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49A93C43444;
	Tue, 23 Apr 2024 00:53:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: flower: validate control
 flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171383359329.888.2890410955575448362.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 00:53:13 +0000
References: <20240418161821.189263-1-ast@fiberby.net>
In-Reply-To: <20240418161821.189263-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, nbd@nbd.name,
 sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Apr 2024 16:18:15 +0000 you wrote:
> This driver currently doesn't support any control flags.
> 
> Use flow_rule_has_control_flags() to check for control flags,
> such as can be set through `tc flower ... ip_flags frag`.
> 
> In case any control flags are masked, flow_rule_has_control_flags()
> sets a NL extended error message, and we return -EOPNOTSUPP.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: mtk_eth_soc: flower: validate control flags
    https://git.kernel.org/netdev/net-next/c/077633afe07f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



