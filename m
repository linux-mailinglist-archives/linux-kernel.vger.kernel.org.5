Return-Path: <linux-kernel+bounces-74616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C46285D6F8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3681C22E47
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D557D47A6C;
	Wed, 21 Feb 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jje1ZbCr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD074655D;
	Wed, 21 Feb 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515027; cv=none; b=AvSipqEg4IHVwNYS9DMf01DU7q5fCnURMBn1gfHkAwhTJAEzaMXmwrRano5UBxdf3snrxXp6j2U829CAa9wzCKqxW2h3f7AIpnqPQt+Gk8tHwBWYNhp0lti8JHCQ0gHw31w/l8i6nrZFvSnwPosVkWD0UkWDhrykhws6urN2Kwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515027; c=relaxed/simple;
	bh=MeAvdc7WLmsLIrUeh9o85CTtaH7eG9dTI5T7CJBiAgM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N2n4f2IfPci7iTOqhz7vvvdLdofmzaY+ExBX9IF3NJuNz2JlKROO1U4Hft4BPFF1Pk3NvERJPh9B1Pz9fknX3adiRlj15FFtvVOt0b2+Y5idxEfaiht+t60MKGTZIIJc0KXtdOtgEHifH/j6Kbdb1Kao1AvxeClr9pX6SFboiIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jje1ZbCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8E99C433C7;
	Wed, 21 Feb 2024 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708515026;
	bh=MeAvdc7WLmsLIrUeh9o85CTtaH7eG9dTI5T7CJBiAgM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jje1ZbCrOvgQ3l5R8w/xDNzehmILLse7VCz3JSTBsIOoIXNbOSRUT2MxR3YdijPA/
	 vYyo0M4wpcV6kj6rb8lD5M4lMgFIJB6BQlwQgXNNqobzEKRKUXKdm2Dufl4i45nRJU
	 YaFC2z3GRn+o14LPcWQFPLibxsMeI2o1D8gl6HO5SMcTYP8nNNwWvjZW5WFsnvmoqv
	 KpsieZEc1LJyQZoqxP2pu5FzVAESc/8iZIynMDMCDQwEYZS36JFOhPzrkSe+Bi5Ynm
	 qymLaOcjiasLESqNzPiy416rJjW3TQ5BXJ4g5wv/F3BMihIkIvQNImwxKhVUe4VIZi
	 womGtJN5SmcCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8EE04D990D9;
	Wed, 21 Feb 2024 11:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ipa: don't overrun IPA suspend interrupt
 registers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170851502658.15341.1591741026086826951.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 11:30:26 +0000
References: <20240219144015.355462-1-elder@linaro.org>
In-Reply-To: <20240219144015.355462-1-elder@linaro.org>
To: Alex Elder <elder@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mka@chromium.org, andersson@kernel.org,
 quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
 quic_jponduru@quicinc.com, quic_subashab@quicinc.com, elder@kernel.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 19 Feb 2024 08:40:15 -0600 you wrote:
> In newer hardware, IPA supports more than 32 endpoints.  Some
> registers--such as IPA interrupt registers--represent endpoints
> as bits in a 4-byte register, and such registers are repeated as
> needed to represent endpoints beyond the first 32.
> 
> In ipa_interrupt_suspend_clear_all(), we clear all pending IPA
> suspend interrupts by reading all status register(s) and writing
> corresponding registers to clear interrupt conditions.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ipa: don't overrun IPA suspend interrupt registers
    https://git.kernel.org/netdev/net/c/d80f8e96d47d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



