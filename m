Return-Path: <linux-kernel+bounces-83039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADAF868D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53551F22B11
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2132A1386C9;
	Tue, 27 Feb 2024 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXviboW/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541751EA7E;
	Tue, 27 Feb 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029832; cv=none; b=NqrMvndBdSl5PQxWhvNOOq0EB4uchPv40EGi3gN+n+lZJAleFZuJuuLSP3RM0Tna0l3ZC92+OXZbkAv1AtnAFYBk4WR8jdupnw5n3o07ft/Gpm/4eFPEylDlcf+smw5W11ZDGUkI37yipGaDBDZEKKAHMDTl4y04V/GLmkxZ8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029832; c=relaxed/simple;
	bh=E3jGskvNBf3e+YK2sKmw8RMH03ctQ0Demwu4aoHl4hE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V00RKJAq121BsYbebxtBJ7AFhn2k0mDCuBBs9MrOx9/2K9E4qZCKBk1Ek8Q1YCCDPT6RIE6NfF9rj6rQPvYTthA2EAGvgUtcG8BOxNVPpF7XY3BRendlpiRZvSJTSWcup1vTEIbRANyTGLGdkvTQ+yHAy0WHvLkN/uIZtEbGnJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXviboW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 154BAC43394;
	Tue, 27 Feb 2024 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709029831;
	bh=E3jGskvNBf3e+YK2sKmw8RMH03ctQ0Demwu4aoHl4hE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iXviboW/OW+qWp1NdKgkWfp9ter75hCoXqZ1DQt/UtiNR4i5s+iMCvHUV5MesJSDP
	 Tt30vKK33dcIVSWoCvg4W17YxmjmBXoAauJ+SC4cQlv/NQfl7QI6uKcWa1AHAEdej/
	 N4iV1HY4RqHtp7ZDHZhbqWN4GXkNPRb5h4He4yHgc51FyDB9XSjcrQjw2RidaZyf1B
	 Al3avRdcZulBXv/hDQR9pInkJY5iWNWlYRO6JrWm1eOAQe6xJ5RaYWCS0ndXjilN+v
	 4HGbFqLR9YLSRtPFp8PaIU77ol886pfQdOMJn6wQZn0wtRxgeXHXZ0D0/LsT5MAnQ4
	 NisDR04Cf+zrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F012AD88FB0;
	Tue, 27 Feb 2024 10:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v2] net: ethernet: adi: adin1110: Reduce the MDIO_TRDONE
 poll interval
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170902983098.8915.14921560374432662804.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 10:30:30 +0000
References: <20240223162129.154114-1-ciprian.regus@analog.com>
In-Reply-To: <20240223162129.154114-1-ciprian.regus@analog.com>
To: Ciprian Regus <ciprian.regus@analog.com>
Cc: linux-kernel@vger.kernel.org, nuno.sa@analog.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 michal.simek@amd.com, broonie@kernel.org, yangyingliang@huawei.com,
 amit.kumar-mahapatra@amd.com, dell.jin.code@outlook.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 23 Feb 2024 18:21:27 +0200 you wrote:
> In order to do a clause 22 access to the PHY registers of the ADIN1110,
> we have to write the MDIO frame to the ADIN1110_MDIOACC register, and
> then poll the MDIO_TRDONE bit (for a 1) in the same register. The
> device will set this bit to 1 once the internal MDIO transaction is
> done. In practice, this bit takes ~50 - 60 us to be set.
> 
> The first attempt to poll the bit is right after the ADIN1110_MDIOACC
> register is written, so it will always be read as 0. The next check will
> only be done after 10 ms, which will result in the MDIO transactions
> taking a long time to complete. Reduce this polling interval to 100 us.
> Since this interval is short enough, switch the poll function to
> readx_poll_timeout_atomic() instead.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ethernet: adi: adin1110: Reduce the MDIO_TRDONE poll interval
    https://git.kernel.org/netdev/net-next/c/2322467a0f5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



