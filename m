Return-Path: <linux-kernel+bounces-44585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEC7842489
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BAE1F274CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC406A016;
	Tue, 30 Jan 2024 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHvQcBtT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCD767A1F;
	Tue, 30 Jan 2024 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616626; cv=none; b=bPgl3ktDuRSSVvuOPsKV2SI2M6htAsw2oH+VJQRa9G0srimibSb9fGrdWPV47qjN96i3yMSz5XXDrMFcsakmUv9EGS0TgLeEcn9alyjwmMo5hrxCscv5wxl1R67LWqc/C2IibFTt84YSc4CUxjfg1NjlgDMDVrLOtqGKbzA/XTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616626; c=relaxed/simple;
	bh=ZWN9I22FnsH58CTQa5pd4CXfCR+OhSYKRggqL9Rt5Gg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iRFxqe3aghPJel5PCWwL0wMTFOkcL/37iBDaYCQXkE3J51kl4I6sBo3l8GJRmMjZHFdV+4VIE56kot+sIXPiWQp3iYbRHw/0phET65n/v/pZwhfrsVm2O7bcA54nZ8AO/jjVoexYKedWTBrExmWsVnApZTOOo/Ncxq/lWl4VzII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHvQcBtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25058C43394;
	Tue, 30 Jan 2024 12:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706616626;
	bh=ZWN9I22FnsH58CTQa5pd4CXfCR+OhSYKRggqL9Rt5Gg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GHvQcBtT0D+CRZV3GeXl7jiKSdGS9wcN/Mdbc1b93f4Ej49kP7UZsKHmiyUK/FnBk
	 foZMC5RTikbC0vpeGtQSeYt2Kw7vFfufSjWLuPFiGRX6BIIQoTVTlV8yCSaFV2j9+G
	 qBLUximMUOPToY3L9+KwaZwzqL5jNE9wHHVywHepDcNpEdp4eaC84Uk8MvsPUfUPL1
	 WTy9KTtKfJGzp5QLIr79OzCK/qHyCe1HOu9ZKgyniqb83WL5N0KXe4BCLeSwMUF/vy
	 WmEZtC3oTmEhDyM+ppDu9fiPwuc/3E86Amot6cNBa1QWIuY7/uwssRE3J8Q7uNQpMG
	 86PIu7jSARyoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A2E7E3237E;
	Tue, 30 Jan 2024 12:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] net: stmmac: dwmac-imx: Time Based Scheduling support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170661662603.28218.1318230641182920988.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 12:10:26 +0000
References: <cover.1706256158.git.esben@geanix.com>
In-Reply-To: <cover.1706256158.git.esben@geanix.com>
To: Esben Haabendal <esben@geanix.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, linux-imx@nxp.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 rohan.g.thomas@intel.com, quic_abchauha@quicinc.com,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 26 Jan 2024 10:10:40 +0100 you wrote:
> This small patch series allows using TBS support of the i.MX Ethernet QOS
> controller for etf qdisc offload.
> It achieves this in a similar manner that it is done in dwmac-intel.c,
> dwmac-mediatek.c and stmmac_pci.c.
> 
> Changes since v1:
> 
> [...]

Here is the summary with links:
  - [v2,1/2] net: stmmac: do not clear TBS enable bit on link up/down
    https://git.kernel.org/netdev/net/c/4896bb7c0b31
  - [v2,2/2] net: stmmac: dwmac-imx: set TSO/TBS TX queues default settings
    https://git.kernel.org/netdev/net/c/3b12ec8f618e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



