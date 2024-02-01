Return-Path: <linux-kernel+bounces-47406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862D2844D88
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204691F269DA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B642C1B3;
	Thu,  1 Feb 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8/pQahr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B5A259C;
	Thu,  1 Feb 2024 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706745630; cv=none; b=GOz1MUDdeXQ67A876PGfQ53AJWlTexBUvwXxQGFOdOpxbjpNTOI0UWGsuJd+F4j8pypcmIu4+79RkWIjDgsnqS60vd1eApgjGQlE7c5tEOU4NDRV7Sabkc+v5h33UZVa+StPV29AdPwmTnFcILuub2aguMuzjrnmcaPD+o3hTqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706745630; c=relaxed/simple;
	bh=VQ1dvamFDSryW11vpmGv5L78MWAe9bKmnX4ruK5uSbs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ovB4JaHcby+n93uLLY4WIfmfhrQHfp+SPZBoyq139eU3IIzIsTS8AYrq2A99Jh9CEMkfzkNWKrApWy41HHEnbEplnWoDRoOsetnpoyHU1QkY7nIdKNuUYGNIeJQ/Cn4e9Xkh7MJXB/NDcloz1E/UP7zvJ4Jlj9j3JuRaOTjJW0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8/pQahr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A141C43394;
	Thu,  1 Feb 2024 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706745629;
	bh=VQ1dvamFDSryW11vpmGv5L78MWAe9bKmnX4ruK5uSbs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N8/pQahrcMr8fQlcWeBYDBb/MeX8DcaueRP9x84V8xYsa4Kg1hRbTkfwdrT9Ohw8f
	 YFlREoniVhxmlc7JjhGtiKMa9R/I8VTOyn4uHzx3MfR4avlQjXH0P5E7HYzeQoSlG1
	 n1W9ay7LPAIch4Ia3ZjcBHapWrB41hLPF87pWWMx79/gnUSHeCG1KYTM9HnDMcr+7U
	 g5vYZXb2hSCTULnqdtNAZdlJmTh/cm78zqRr8s/HFx5rQQRyYB+pGyneevU4LSnF6X
	 3pHfPTFCSXiwWJDKdW+ecg6CDN9gIo4AcMWV0msXAAnV4Va5wp7tndoOcjCFUUJYXf
	 QtC2xi+vokbmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D1D2DC99E8;
	Thu,  1 Feb 2024 00:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Drop unreachable reviewer for Qualcomm ETHQOS
 ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170674562937.31899.1767619419103104462.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 00:00:29 +0000
References: <20240129-remove-dwmac-qcom-ethqos-reviewer-v1-1-2645eab61451@redhat.com>
In-Reply-To: <20240129-remove-dwmac-qcom-ethqos-reviewer-v1-1-2645eab61451@redhat.com>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: vkoul@kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jan 2024 11:12:11 -0600 you wrote:
> Bhupesh's email responds indicating they've changed employers and with
> no new contact information. Let's drop the line from MAINTAINERS to
> avoid getting the same response over and over.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> If anyone knows how to contact Bhupesh / if they're willing to continue
> being a reviewer feel free to suggest an alternative, but for the moment
> this is better than nothing.
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Drop unreachable reviewer for Qualcomm ETHQOS ethernet driver
    https://git.kernel.org/netdev/net/c/e028243003ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



