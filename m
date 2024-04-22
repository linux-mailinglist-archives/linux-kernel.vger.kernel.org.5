Return-Path: <linux-kernel+bounces-153163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E29308ACA76
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7359DB212DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0C213E3ED;
	Mon, 22 Apr 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJpsG7u+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F95913E400;
	Mon, 22 Apr 2024 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781226; cv=none; b=Z2pNK4MayppOdaIVO1wrjMMdGvmhyovGpu6t4RA8p9zd1w5iQQ5SpuGT0dJYQr5Tdibv07jBXhfk1IXwBhmI7CyMtXrKc4n3fjBshskjHDAKSKxlYaAADDwLjEN/AV8EQGJOTfVS/WFEjRyQm/qCim0DjwniJ1n0Gm7HEL3d4bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781226; c=relaxed/simple;
	bh=KWnDJr/vke6VyUyWZSFuKxAuSKm3NU6ZKvea+XUVAG0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J5uUvmh8bwxgKRIn6avgryCVS4EKF1Zh8c2xoiYnYDC3EluqUYhh7C/kYIzdwmwl797NeU3fchwTHAB4ieeUqTz2MwUGXuMsX52y66zgsgH1a4jnfiCqLKe09n6844V/wKvtHp3GIV7uXcErjjCXBIH3y/u1HNywxq4/6AQ1J7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJpsG7u+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F06AFC3277B;
	Mon, 22 Apr 2024 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713781226;
	bh=KWnDJr/vke6VyUyWZSFuKxAuSKm3NU6ZKvea+XUVAG0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VJpsG7u+Vu/rK06JTFF83QpByhgS9QJxiuUT719r6Fj0e2EXuwO+HcZbNcK1OQUYf
	 Er95kSJ6/RqEMvBcwYyNyiZzg3jeFkmw4t8hhc0kW2UzEDBhV/lwmIVQ/ZrA+mN0Jk
	 r/jjP96xeN1WpiCfH1QFcF8mRbtypsba6W7RKe8nbTTtMp8+uGQ1GLtiHNJrpNJxjv
	 cFuoOxYktc6evPkLOPiKIDpq5cmy5R4HQGyMaB5WnxHe/cIPAC4F67ZmUtYcXDR7jb
	 f+cCBfOBpThSn1ypeRFP+nAkUuD+Q452h1Hegj/cSHT48Sb49Ce3EYjDxSFvZC+qOz
	 YNJJHmUF51uRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE602C4339F;
	Mon, 22 Apr 2024 10:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mailmap: add entries for Alex Elder
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171378122590.13831.3067166469576978992.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 10:20:25 +0000
References: <20240421194458.2205779-1-elder@linaro.org>
In-Reply-To: <20240421194458.2205779-1-elder@linaro.org>
To: Alex Elder <elder@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, akpm@linux-foundation.org, andersson@kernel.org,
 cdleonard@gmail.com, elder@kernel.org, geliang@kernel.org, heiko@sntech.de,
 matt@ranostay.sg, matttbe@kernel.org, mka@chromium.org,
 o.rempel@pengutronix.de, quic_avuyyuru@quicinc.com,
 quic_bjorande@quicinc.com, quic_cpratapa@quicinc.com,
 quic_jponduru@quicinc.com, quic_subashab@quicinc.com, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 21 Apr 2024 14:44:58 -0500 you wrote:
> Define my kernel.org address to be the canonical one, and add mailmap
> entries for the various addresses (including typos) that have been
> used over the years.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
> v2: Deleted two unnecessary lines, after prompting by Bjorn.
>     Also copied those suggested by get_maintainer.pl.
> 
> [...]

Here is the summary with links:
  - mailmap: add entries for Alex Elder
    https://git.kernel.org/netdev/net/c/70dcdf5f8c41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



