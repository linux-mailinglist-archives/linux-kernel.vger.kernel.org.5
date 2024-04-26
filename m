Return-Path: <linux-kernel+bounces-159449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA9C8B2EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBADE282577
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CC4747F;
	Fri, 26 Apr 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcKuJ5PZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B07FB;
	Fri, 26 Apr 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714099229; cv=none; b=WPQ3iVkfhz7+M3fCK0H9seIH0mxmiZDKSIAZlVJY0Jc7Jm6Z6Co1H8nTX6tRYUEzJE374tKGNTIGbxXojNWu156WsQWMQU/SuawWCCSgcnuGWmoguZ+HELSZZFZ4t3mJVx0wa4f2bFAyf0uscSi314P7XvCuDQU+s38SxrgOHzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714099229; c=relaxed/simple;
	bh=hXgUyKan2+df5ybC4j1413HbrKM23fdfbk0h5LOhu24=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CzL3hTayGCCirAFTH77OzWCb+knTftZj2fOyx+K3wlTY8ZVl9Ze1bFnxqfusek10f8l90LqVAg8rpj+H2VoBnavApQD44JRQgG1fmWIKjzoTP0ZOKNht1u7v44niJekPOdDZCDtCnjjfmRgrWAxDPEjP4cfQWVa6+MV6APu697s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcKuJ5PZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B21BBC32781;
	Fri, 26 Apr 2024 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714099228;
	bh=hXgUyKan2+df5ybC4j1413HbrKM23fdfbk0h5LOhu24=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mcKuJ5PZDqt+3NkCXuoaZ94A8ZHOpiK+THXs7jJdOGKkO4FTE4ikU+q3ykpkiKTbD
	 wqDKsfgl7bQ34CAeMy4AI8DITIZ7eJjxowgcANNSkRKDUqRi+PucALUAk1Jqyb0h6w
	 MYX3BjXHPeilVPaCY1vj4LHdAt/d0EWzSajAGERzmEKXj8HjXqdDvmLl5bdAVqA1dZ
	 D4Ap+j9h4hNww0E5Hs9qGj3wGFS0t2vxgU2w1rb7NNGR4IuIY7DROJMYh890L8UqUt
	 96Ld2L/sE4TaBEF6JMDqL6CRZu8feiwdlwT1YG2AzYvpvw/tEBSf66+wozOjudo3cC
	 9MBjFKeNuYY0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9463ECF21C3;
	Fri, 26 Apr 2024 02:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: wwan: t7xx: Un-embed dummy device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171409922860.17911.13291258202636407955.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 02:40:28 +0000
References: <20240424161108.3397057-1-leitao@debian.org>
In-Reply-To: <20240424161108.3397057-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leit@meta.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Apr 2024 09:11:07 -0700 you wrote:
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from the private struct by converting it
> into a pointer. Then use the leverage the new alloc_netdev_dummy()
> helper to allocate and initialize dummy devices.
> 
> [...]

Here is the summary with links:
  - [net-next] net: wwan: t7xx: Un-embed dummy device
    https://git.kernel.org/netdev/net-next/c/c984f374aeec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



