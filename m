Return-Path: <linux-kernel+bounces-94969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00793874766
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EA81C22444
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9181C6AE;
	Thu,  7 Mar 2024 04:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUclku5i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F05227;
	Thu,  7 Mar 2024 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709786431; cv=none; b=crIzk2BrY7jAw0wE8ET6M8u6CmDujK0+6Wpds8qcfR70tbRDEYJt0Bz30joVivEQIRdAAKeMPO0pU+lDYBVYkR9i3gXdwqq3c3kiMbXbkTAzyewTfVDzjNFDO06wjZ7R2ZFhY56BM/Xjd9+r2js6IpT+8LoX8QwXP8uD/OzGX1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709786431; c=relaxed/simple;
	bh=RP4hy+R35jLPZPDVIpeZNpzZRzY9gWkWN21185TXQ9M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RaqFA6G3RaKdH0mUpo8GhHXMVPk8Y6VCMijaUUYvS18JbaJ92NZW4NbTniuBJgkp7IID8aptfJNM7S1xoatT9P7DWvj9C7Fcu4fD9hf8RhzGn/DpCG5Zuzl2pNF+nQ5g2YTgk4eSFHKWIYX8hB1GsafQfqAx/Pj/Uir6OUZPGws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUclku5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE46DC43330;
	Thu,  7 Mar 2024 04:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709786431;
	bh=RP4hy+R35jLPZPDVIpeZNpzZRzY9gWkWN21185TXQ9M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MUclku5inUZbx0b9kXs3PcEGBifb3QEaZfvxz16YmxjaW694i9VzBCBEzBdZmlj+j
	 dcSD0urZHFXm3ekmv762VD6YFPlX8wt/FiYuvpYtbIac8+LBWuGwELMekPKjZLRd9S
	 QkBlVgsWwS98NAw8T7YAQCEP/DSkmmX0k4xJc116xmPghWli/cZ2WtkR9qmwlCdwhF
	 qOQ25KU8oKvA1KP5mly8an3ALQ8fyY1FCVN+zTnQRFt4l2VK8TLfSA2Vdlu9FX4A4t
	 3icGb934mKJiwrFQEdaV45oWh9zoO56DPjU1VJZcdR6Q1xYSD5s0s0FHWFAjfrDfnN
	 1EeWeGCvW9DSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7B0DD88F80;
	Thu,  7 Mar 2024 04:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/3] net: gtp: Leverage core stats allocator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170978643088.7855.4668701544499499077.git-patchwork-notify@kernel.org>
Date: Thu, 07 Mar 2024 04:40:30 +0000
References: <20240305121524.2254533-1-leitao@debian.org>
In-Reply-To: <20240305121524.2254533-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: pablo@netfilter.org, laforge@gnumonks.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org, osmocom-net-gprs@lists.osmocom.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Mar 2024 04:15:21 -0800 you wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: gtp: Leverage core stats allocator
    https://git.kernel.org/netdev/net-next/c/660e5aaea11d
  - [net-next,2/3] net: gtp: Remove generic .ndo_get_stats64
    https://git.kernel.org/netdev/net-next/c/13957a0b0708
  - [net-next,3/3] net: gtp: Move net_device assigned in setup
    https://git.kernel.org/netdev/net-next/c/81154bb83c44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



