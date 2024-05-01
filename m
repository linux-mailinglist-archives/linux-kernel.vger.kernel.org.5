Return-Path: <linux-kernel+bounces-164868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B10EF8B8435
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C888283960
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9BA18E29;
	Wed,  1 May 2024 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WztpWvbI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38C614AB8;
	Wed,  1 May 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714529433; cv=none; b=ETYLTnu7/LfSFmGgS4uO8rNiHJHnWguy4nTyB9f1cjF52acRE9F83ajLFqdTJBpoAKa9eX6puM4jBwTxLrO9ub9qEtxCJqGcyO5shkZHfHMXVsUwbeaNrWxoojBD5/0xhZr/hp8quWDs5zLufToTJv2URwZ5ajU5vREVNeARqnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714529433; c=relaxed/simple;
	bh=y5/Bv7A2y009Vap3hu7nx7c3Igg/xranL15UDJAq04Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h201MiEAXqPq+B2KEgqMftmcqXNL37e96KB42wf1v7eInznHu2f0eT10niOjViXZwPFRFmjhmy1FmAbFMe3yMNgaZ9jXgdvuVq/Yh9LAeRqTitGlkeyxbLXo2tpp/Nv73tPMKyC8JS+NvU38oUqC7Q9qgL5GJ5TH47BBNpn9Yqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WztpWvbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B2CAC4AF1D;
	Wed,  1 May 2024 02:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714529432;
	bh=y5/Bv7A2y009Vap3hu7nx7c3Igg/xranL15UDJAq04Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WztpWvbIvciO7cJfpyuc9s8diV+qDyLoynWyBCcMlZXEXWTYWt3BNthSFnz8vWp+S
	 qch2QWm6cXZ6XTV5OMCmcM9Y5uDMm3HZm9Sn7ECh1wcnB0ctPm+2XF+b/5+OR+N/yP
	 QOtfakCN62gLDp7plYMNES3ER5S8OqKIHKUQulIvFqJzC8rClF3hEePHdZ3YkQCasf
	 Aemg62RLfhMAubmwa3yO+gJUJscR3ZnOjDWUIoTNtN+V59+prSvvUHYQQ4DkiIDPt2
	 zRztdxq3Xbo6duUO/1IJNkzq9N2IIU0SEFsDa+pzQ9g7q2dgIm/hcgz9Pg5lMBZlmA
	 RbPSXKOS9uUHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E9D6C43619;
	Wed,  1 May 2024 02:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/1] dt-bindings: net: snps,
 dwmac: remove tx-sched-sp property
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171452943244.31721.11324975670397906931.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 02:10:32 +0000
References: <20240429092654.31390-1-f.suligoi@asem.it>
In-Reply-To: <20240429092654.31390-1-f.suligoi@asem.it>
To: Flavio Suligoi <f.suligoi@asem.it>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
 joabreu@synopsys.com, aford173@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Apr 2024 11:26:53 +0200 you wrote:
> Strict priority for the tx scheduler is by default in Linux driver, so the
> tx-sched-sp property was removed in commit aed6864035b1 ("net: stmmac:
> platform: Delete a redundant condition branch").
> 
> This property is still in use in the following DT (and it will be removed
> in a separate patch series):
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/1] dt-bindings: net: snps, dwmac: remove tx-sched-sp property
    https://git.kernel.org/netdev/net-next/c/a2af49293db6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



