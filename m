Return-Path: <linux-kernel+bounces-71914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2FF85AC7B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE85285DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48004535C4;
	Mon, 19 Feb 2024 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkwQ6gfd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6863352F65;
	Mon, 19 Feb 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372227; cv=none; b=p6Tj8wMSCPK3QOYfyIY83bVfbd3RJIUqHEaojBplrxtK1C5Mm9xwNKIrmKL7M+S4j0DZeqZ90Q8MCir2HTdlZXl3mTAiDO71Z9TYvVx4M1YwFeTgxMLQ0wUETmDkjPiPZg4W7DG/kmfCFnMfkmrK00B0qpd3icWD+WOce3kpmm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372227; c=relaxed/simple;
	bh=DKv0x0Lj1BGsY8NfdmRdd4z8+XPtICz9fcfzMgX3ysA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mMuKruGJuyGQCDSV8OEkilhCVjng5uukydvL50WULG7rMH4vORGXR59PCpo+9T/gLzORhcc4D1jdTM4u4smq5nKQxSgCVTQKhgg5aZmOOqZABjzWCLXz0x3OhP3z25EfIXFmxbbj5E25NMlqDSdQXRQeGFNC74CgQcrGps3114I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkwQ6gfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD54FC43394;
	Mon, 19 Feb 2024 19:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708372226;
	bh=DKv0x0Lj1BGsY8NfdmRdd4z8+XPtICz9fcfzMgX3ysA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tkwQ6gfdXf302AG8Vt0ZCKB/gcKJUUHWkSkDO4mwVLBj50tARRukUVcjXPwWeKdFW
	 cqYhc1/rNAlAUW/aQYbs6gkDF1K/Nuintv1VKnHbGRTm671OeqCzM/AJRo49wGb8DT
	 tWpExqOK0lJJsCK1GyaqEncLLmnTD1EnsSKDOUlMnur3HkaqGcO9sJeFWOg0fhc7YY
	 8ocs9CO+eQiE9kNolqraDlQqvsbOyWLl+YkL7pX8LBBvVY8nB/5qo2wlzJ0YOrxTKD
	 2UNmvOqq1CzCXfl1gLklImAN6xDf1u1kYrRYXrLMCH1IYVQbNet07UCXBXQCRDMDrG
	 EfCsuyyCOwpnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C256FD990CD;
	Mon, 19 Feb 2024 19:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/4] Add 8qm SMMU information
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170837222679.28614.9914346623954739776.git-patchwork-notify@kernel.org>
Date: Mon, 19 Feb 2024 19:50:26 +0000
References: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
In-Reply-To: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, wei.fang@nxp.com, shenwei.wang@nxp.com,
 xiaoning.wang@nxp.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, imx@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 01 Feb 2024 15:22:40 -0500 you wrote:
> Change at v2
> - Remove iM95 for fec.
> 
> To: Ulf Hansson <ulf.hansson@linaro.org>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Shawn Guo <shawnguo@kernel.org>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: NXP Linux Team <linux-imx@nxp.com>
> To: Wei Fang <wei.fang@nxp.com>
> To: Shenwei Wang <shenwei.wang@nxp.com>
> To: Clark Wang <xiaoning.wang@nxp.com>
> To: David S. Miller <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: imx@lists.linux.dev
> 
> [...]

Here is the summary with links:
  - [v2,1/4] dt-bindings: mmc: fsl-imx-esdhc: add iommus property
    (no matching commit)
  - [v2,2/4] dt-bindings: net: fec: add iommus property
    https://git.kernel.org/netdev/net-next/c/5983e5df8630
  - [v2,3/4] arm64: dts: imx8qm: add smmu node
    (no matching commit)
  - [v2,4/4] arm64: dts: imx8qm: add smmu stream id information
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



