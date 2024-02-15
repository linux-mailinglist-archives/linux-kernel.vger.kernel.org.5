Return-Path: <linux-kernel+bounces-66715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD818856091
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C70F1C242F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB78D12BEA7;
	Thu, 15 Feb 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKKGdMo9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04B012D755;
	Thu, 15 Feb 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994228; cv=none; b=ca5S/syr/rc09lH1NUUHkAiHNCM5n8k9BBY5smEM0AA+qp/JAzpz5mlp88b3+fSxVFkrXwMHLNzGvz1LCNe42UuDyKyWPXyEBoEFKGf/mj3+M7/NfpejDfhIXGWhYdTyU6Gandu2xiz85+gg8FR7RIg+CRo13vEDb44/0udwD6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994228; c=relaxed/simple;
	bh=mPkAl0B5FPIBBKPul56eqRHQGADbH4mMnMRWdtErg+w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bfSB3aSQw7HToM9G9TjWzOrn64l7mIHfobgp7eD5EYIRTdGe5pyys4VJ49jBmFwxmEP893Kcp1B7UgQu11oW0ztNccY1cMKcyCX547sd1RdIVdZFA3AzLs3xfs/8ITS7C4nCJgm6ZF3KGT/QG4ZlVIrWqx0jsuzoe8qkhJbdVKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKKGdMo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6263C43394;
	Thu, 15 Feb 2024 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707994227;
	bh=mPkAl0B5FPIBBKPul56eqRHQGADbH4mMnMRWdtErg+w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iKKGdMo97+gMGlXF3RKyljSDVdfnPV4jamidEMBm4y9otufE+I+yBIbCyjdaZGQH4
	 JzH3IizJJl9Wcb6z9pd4OhUym6xY0YuRUsZLh5Ycnyf+cy/CDV1EqwnAOK+FhQAL5m
	 3oQ6VcWIQ2hzsMZbodKEQxOonUNEFFMCmqvDNm4fjyVtxpFmp4CloNNq0sVwQ/9xhj
	 NeYy66odtJbGxCb4YgYZ6MFLTLA8KyBanrkL68M8P42oke1ZEBhAXykFDTnaxg/OTs
	 nBDnfxlwSvIyJpaPFBCd+mBoSRBew8m15cSIvEmjpAcqdbvtL+MyQ9D5UMbRi0aa5K
	 E+sfiUDhzuKpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B5A8D8C97D;
	Thu, 15 Feb 2024 10:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: qca807x: move interface mode check to
 .config_init_once
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170799422763.15473.1497115981711263607.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 10:50:27 +0000
References: <20240212115043.1725918-1-robimarko@gmail.com>
In-Reply-To: <20240212115043.1725918-1-robimarko@gmail.com>
To: Robert Marko <robimarko@gmail.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ansuelsmth@gmail.com, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 12 Feb 2024 12:49:34 +0100 you wrote:
> Currently, we are checking whether the PHY package mode matches the
> individual PHY interface modes at PHY package probe time, but at that time
> we only know the PHY package mode and not the individual PHY interface
> modes as of_get_phy_mode() that populates it will only get called once the
> netdev to which PHY-s are attached to is being probed and thus this check
> will always fail and return -EINVAL.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: qca807x: move interface mode check to .config_init_once
    https://git.kernel.org/netdev/net-next/c/3be0d950b628

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



