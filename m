Return-Path: <linux-kernel+bounces-49223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 054B784675E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2087D1C21B10
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D645D168BD;
	Fri,  2 Feb 2024 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qgz9kIbb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B333168B1;
	Fri,  2 Feb 2024 05:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706850029; cv=none; b=dBxpWtahsflRQHsuPd7b21CI+q2uQOMFekzdIdl81MN8G2EjYw3DaC8YpzjX/ByADkEGyae/jOeiEqwpyvdgPsYb/d8lIjFHN+kgzbVLkemAAxA8TgniDv1K8sJOgv55E1+YC6xhQ3hWkNzVQ0PimRJRVpjcCUkZqyiY18Acqho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706850029; c=relaxed/simple;
	bh=U0LzKhd1g2ziJuw01cyz9vzzbqAe66DMK2KOff1bl/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SrSOzWAzNY08CfgK/eMhtEwyVfcZPpsCVMlmgjX4K6nPgK3auX5aN2G3kxzQF0h9xENq+dZPJWeumRHi9YolIhV3H4Bf71Oj5WGofSRYZNlb+DxsVcrUKysMBdeguE65En03jxR389g4sFzVPgOq5dCdz+4RNBvQY74Sbm3OLIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qgz9kIbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 725C4C433C7;
	Fri,  2 Feb 2024 05:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706850028;
	bh=U0LzKhd1g2ziJuw01cyz9vzzbqAe66DMK2KOff1bl/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qgz9kIbbrUIk68TQAiQqNqUPnT0lGDlUNO0BoVPQaYewTYT8kRT5w+cLwEtUcNZuu
	 7XIa8VSlxzOCLnQ1CpFlPAbu8Yi2Vaj9d5gbuUdFLKNYEb+uPM/qooRDJcwDEav2WG
	 2yuwD1djS+zXfzmUqMh42FNJD1MniieIJqBuycX1b80Z1Bdf52by5ntIbkKzH/fuFu
	 lLsDTl0sRujjegxRKLQ+51q8mTe9meHUML3cQvtRBwjYfMohWNYTvLVZYkXDjegB9N
	 wiFEiPlAl2dBnDs9JOajWqNWdIQqTk7N4btyFzccX4YeZhDhdajhZwDD4Njm8hjm4G
	 kyQB3PwxChphA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58351C04E32;
	Fri,  2 Feb 2024 05:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] net: ipa: simplify TX power handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170685002835.2674.5013367139260704418.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 05:00:28 +0000
References: <20240130192305.250915-1-elder@linaro.org>
In-Reply-To: <20240130192305.250915-1-elder@linaro.org>
To: Alex Elder <elder@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mka@chromium.org, andersson@kernel.org,
 quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
 quic_jponduru@quicinc.com, quic_subashab@quicinc.com, elder@kernel.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jan 2024 13:22:57 -0600 you wrote:
> In order to deliver a packet to the IPA hardware, we must ensure
> it is powered.  We request power by calling pm_runtime_get(), and
> its return value tells us the power state.  We can't block in
> ipa_start_xmit(), so if power isn't enabled we prevent further
> transmit attempts by calling netif_stop_queue().  Power will
> eventually become enabled, at which point we call netif_wake_queue()
> to allow the transmit to be retried.  When it does, the power should
> be enabled, so the packet delivery can proceed.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] net: ipa: stash modem TX and RX endpoints
    https://git.kernel.org/netdev/net-next/c/102c28b83ddf
  - [net-next,2/7] net: ipa: begin simplifying TX queue stop
    https://git.kernel.org/netdev/net-next/c/844ecc4aa78e
  - [net-next,3/7] net: ipa: kill the STARTED IPA power flag
    https://git.kernel.org/netdev/net-next/c/688de12f080f
  - [net-next,4/7] net: ipa: kill the IPA power STOPPED flag
    https://git.kernel.org/netdev/net-next/c/86c9a4929258
  - [net-next,5/7] net: ipa: kill ipa_power_modem_queue_stop()
    https://git.kernel.org/netdev/net-next/c/30cdaea23600
  - [net-next,6/7] net: ipa: kill ipa_power_modem_queue_active()
    https://git.kernel.org/netdev/net-next/c/2acf5fc8daba
  - [net-next,7/7] net: ipa: kill ipa_power_modem_queue_wake()
    https://git.kernel.org/netdev/net-next/c/e01bbdc9f851

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



