Return-Path: <linux-kernel+bounces-136795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FFD89D843
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B20D1C2363A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E0512A160;
	Tue,  9 Apr 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzL+6kJa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EE28004E;
	Tue,  9 Apr 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662828; cv=none; b=lAonO4iXSemaQN6m2TPg+rwXNtNSGwPKfkHpHfUBgRsGFg2HmkEAaz7KlCAE/AQX2X2MZgqm9nWj6dpU1Yh1cvSjvBNljA+keTRnqUMirMKOg2IR9ZJX/pGtYGYdqY3OJBLzOUB07E/gmquh9+p4mbJpaH54mOjqs8UACtF8Iao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662828; c=relaxed/simple;
	bh=MDm0KRglBzo5PbbZbHHd+NCNNsHxXViVQ+IbGUpzics=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b36M2QwJ3sk8R15F2whzObFWhJ3awy3nN7xDvz8xT4fLVTEWRStmMnMTzMFhu3t412bN5fbU+x5afJjBN9RqiBPQc+ROG2NizWoZVs+FnuZMIlspLW2RhdRSrYI232Q6pyQuaFduSfjVIc7SwLVwBBiEkhlRAVbytNlHJmYYnbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzL+6kJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 859F1C433C7;
	Tue,  9 Apr 2024 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712662827;
	bh=MDm0KRglBzo5PbbZbHHd+NCNNsHxXViVQ+IbGUpzics=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pzL+6kJaDdYmTmRlcOvJ2z5VrVEFabYiYR/bxbdw6mPCztSRaxTjlVXSELOVjzSuF
	 h3Ui2P3fLh2PL3460wQDcaEKnZNHS64gKULMQ/ywho9MwUqniWuDm/s4VIdiNDudi5
	 RK47zeRtn45sYzkLQxJzUvFCsehKRdkBf0m4b4hk/0tlSqhnMXWRt++b8nypQwXGvv
	 e/ecFRCO606xd8j/7j2rxNpoWpyHVOx1wLQ2rHH5Gdd7f+E/lJmt26F5VAgEYOPggM
	 s5y3MOuf9E+8Wm5Cm8zwvqIEtTr2MDOqKxuQv12El8ExSf+A8tcExN6leXFEefb53h
	 X02ogHi+iqlJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73C10C395F6;
	Tue,  9 Apr 2024 11:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: net: rockchip-dwmac: use rgmii-id in example
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171266282747.30909.11983889718535172879.git-patchwork-notify@kernel.org>
Date: Tue, 09 Apr 2024 11:40:27 +0000
References: <20240408-rockchip-dwmac-rgmii-id-binding-v1-1-3886d1a8bd54@pengutronix.de>
In-Reply-To: <20240408-rockchip-dwmac-rgmii-id-binding-v1-1-3886d1a8bd54@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, heiko@sntech.de, david.wu@rock-chips.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 08 Apr 2024 08:44:10 +0200 you wrote:
> The dwmac supports specifying the RGMII clock delays, but it is
> recommended to use rgmii-id and to specify the delays in the phy node
> instead [1].
> 
> Change the example accordingly to no longer promote this undesired
> setting.
> 
> [...]

Here is the summary with links:
  - dt-bindings: net: rockchip-dwmac: use rgmii-id in example
    https://git.kernel.org/netdev/net-next/c/220d63f249ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



