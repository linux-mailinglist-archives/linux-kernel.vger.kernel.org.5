Return-Path: <linux-kernel+bounces-61446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2852B851278
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1911C21260
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F48E39AE4;
	Mon, 12 Feb 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+AGlfFP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C539ADD;
	Mon, 12 Feb 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738026; cv=none; b=lUWkqIoIwb1bQrWzCB4ddmR4EiUU4sMmI2INcgiwiT81TyVMR25wNY1KhLjcAfpbZ6WeRxeyBBvBogr7Psf6gV3+bOWcS8ojzjj1l10JIH1o4wPb/TqUlaIqZNazwjdhoGqytQ9dxiIKdsoCjFnDH1acn7LVsMeF0P8Y3VePYCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738026; c=relaxed/simple;
	bh=lzBgTEGIQJNtaXuo/iOt+XACv5fKcsFpX+j1R22SN5A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ePZ8K3Z4zQQ1w2H7EiV4is75aQzSePLwcdZV52kFLNsnKBwRMtJBAc6BBxLeS+v04ILl+0133dEx9cs3VxvKc026pMz8VFUmw8UgWHhIcsvRjIjwakCyar1SveoeMjMItrffH39RkKBd+28PeHJCHD1E8J36vfy5yn8Gy3bCI7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+AGlfFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35EABC433B1;
	Mon, 12 Feb 2024 11:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707738026;
	bh=lzBgTEGIQJNtaXuo/iOt+XACv5fKcsFpX+j1R22SN5A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A+AGlfFPYMjdAPkui+tWSm5Cs3u1nOwNJox21MeBgYasgspMcpDZbsiMyhW6cfCtj
	 ataCN5UJ7jG8Y7j8tzEZldL1O77am2UvULaQxS/bORhntK6KuRK7Pf5A0t6I6TNh1r
	 Ta8UpWzpt8dYEEuwZCcadwwYZXQwenqVPCmOaCuOwicBwbcg+LTOgMCdeRKpvEA8+B
	 S9gCEGmVZDETd/ImnqyHM4Paj6c79A+NsDzuak/Kb+okJIKXl79I36owDWLlN2CuRC
	 oBHirQhwElE5MiqyVfSLp3yR8C38iqtXudUsggzgC/ibfh6KGK+c/W7YnCg+IEZ0c7
	 RPWFjwW8NXVYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18742D84BCF;
	Mon, 12 Feb 2024 11:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next  v13 0/2] Ethernet common fault IRQ support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170773802609.23861.7253263581992379232.git-patchwork-notify@kernel.org>
Date: Mon, 12 Feb 2024 11:40:26 +0000
References: <cover.1707467850.git.quic_jsuraj@quicinc.com>
In-Reply-To: <cover.1707467850.git.quic_jsuraj@quicinc.com>
To: Suraj Jaiswal <quic_jsuraj@quicinc.com>
Cc: vkoul@kernel.org, bhupesh.sharma@linaro.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 psodagud@quicinc.com, ahalaney@redhat.com, robh@kernel.org,
 kernel@quicinc.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 9 Feb 2024 14:20:10 +0530 you wrote:
> Changes since v13:
> - Update correct sender email
> 
> Changes since v12:
> - Update correct sender email
> 
> Changes since v11:
> - Update debug message print
> 
> [...]

Here is the summary with links:
  - [net-next,v13,1/2] dt-bindings: net: qcom,ethqos: add binding doc for safety IRQ for sa8775p
    https://git.kernel.org/netdev/net-next/c/1963e65b3dfe
  - [net-next,v13,2/2] net: stmmac: Add driver support for common safety IRQ
    https://git.kernel.org/netdev/net-next/c/5c2215167d12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



