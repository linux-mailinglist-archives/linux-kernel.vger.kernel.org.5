Return-Path: <linux-kernel+bounces-61312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D231C8510E1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9C11C22020
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD14D24B2F;
	Mon, 12 Feb 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9aVtuRR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7A318E01;
	Mon, 12 Feb 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733827; cv=none; b=bvu0CdhDPQIAnYm5WSMF2k4wGxQVIMS8YDT9yxm3N6tSZaE25M1vdcLubWhfVS01FrjPyrwZU8uw0xXIgS0D4X/otv605JE2z9fvlidooAfmZLx+yFxnU6Bstsdk5sTn9gSB3VYNRLeYMTIgQb2JeJjLxwEN4Yq9b77eDBbmfic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733827; c=relaxed/simple;
	bh=mdLN9Mi0jBOEC7J635BO3YYQtUbzRw+yuJA/UGXvjgo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BX7mUGfG7XEcyLqDLlaq6GyBCpJ0LF7hghBjEqOpyOvVIRjBTHXXjsgsMNi1jXQLqFTan2Fplc/E7VDDNwVbza5jtgScwJyavtR5eU+WbdZ6JTJQ2iker+aotepLsiW9qEhSgMaO2N1uC6Y2wIxXvv76KNUONfBNop6uzxgPxB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9aVtuRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 827E8C433F1;
	Mon, 12 Feb 2024 10:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707733826;
	bh=mdLN9Mi0jBOEC7J635BO3YYQtUbzRw+yuJA/UGXvjgo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t9aVtuRR0a0TBp4xR3gWY2JNWvBFEPf6a1e9Hxup7PNiU62kxaMhHI7RZP9C+0mX/
	 uOd9BVQszU0WONCEVh2W2bitnRC+WRrNdmRMqt/rkqc+hRi8pPkz4XEQ+qsFdSABH7
	 BNCxxMYwUOKN1NLLFexIT+Jost3iPqqwhhavUJaXnIoTnKvhfwa1k1oWwajGD42Kvb
	 uTBkgW1iIxFT5W8FKvC9SR1ovNf41PcMDUdd9XX3CBYy9ZOiJCuEDH6JdovOYedFgM
	 QHNtYg4FIBrArbHy4bjOb0kAXnytrGumAMYG0ADtpEqdvN17KpsuQkXsO6iW1QMkFv
	 uH3/9JRK7XSjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63CABD84BC3;
	Mon, 12 Feb 2024 10:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: stmmac: dwmac-qcom-ethqos: Enable TBS on all
 queues but 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170773382640.15535.14931143276870991018.git-patchwork-notify@kernel.org>
Date: Mon, 12 Feb 2024 10:30:26 +0000
References: <20240208231145.2732931-1-quic_abchauha@quicinc.com>
In-Reply-To: <20240208231145.2732931-1-quic_abchauha@quicinc.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ahalaney@redhat.com, quic_jjohnson@quicinc.com, kernel@quicinc.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  8 Feb 2024 15:11:45 -0800 you wrote:
> TSO and TBS cannot co-exist. TBS requires special descriptor to be
> allocated at bootup. Initialising Tx queues at probe to support
> TSO and TBS can help in allocating those resources at bootup.
> 
> TX queues with TBS can support etf qdisc hw offload.
> 
> This is similar to the patch raised by NXP
> commit 3b12ec8f618e ("net: stmmac: dwmac-imx: set TSO/TBS TX queues default settings")
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: stmmac: dwmac-qcom-ethqos: Enable TBS on all queues but 0
    https://git.kernel.org/netdev/net-next/c/0918c1dcd55c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



