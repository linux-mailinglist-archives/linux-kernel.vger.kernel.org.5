Return-Path: <linux-kernel+bounces-144848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146208A4BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5550285F74
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27244CB37;
	Mon, 15 Apr 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkO1gVdE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4374436A;
	Mon, 15 Apr 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174029; cv=none; b=rkBgidS8exx6FG20EVnbX/hxM+1AWtX77v9NoRoxBXwg/nb1iRi+FY7yjF2BfR+KtleHhYWsiaATYD6HUjJRvBW0Qe0mLK4JDVukeRH3u1Y2mi68epjswVkFNZEoL88V1/ZQJEBKFXQyoNIxn4xhLoXTC3tFu5HaG7Gy/TyMEaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174029; c=relaxed/simple;
	bh=GG2kc0t91PzR/wlZyWCy6sMZqQDZhqAVjrWNR1GlAPc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gS98znlvyJh8KaLA43uqxDaygDtg2M0MhxUgYLAj5h8cYn3uBW27l9TjBJuQ29SYb64hhHH0SjH8tjl2QFjzie0/e/0iMGtA+JcAjdelDdf/s5KpYvx5O8Sr7MrYcfTKSdUZes/wPnDzMYVFHMVZLMXXvLENMZ8zO0CHnQA+FJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkO1gVdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90A6EC32786;
	Mon, 15 Apr 2024 09:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713174028;
	bh=GG2kc0t91PzR/wlZyWCy6sMZqQDZhqAVjrWNR1GlAPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JkO1gVdEdG+n0JD0dsipDM8mF3O0fT9W/aaKJnFQj4gXpLZZXajKxVZFRrUatE61M
	 Sa3gi4cFnpJRiQsfgpi7D30b/w7uaFLL5NbSWo74U7b5ITlYNDZ0YeP+2FSqdOucV1
	 H8ePnoS3mA93x4cVMcp+I89Xl2F/zZyz9Z9rxe19SCg5St8f2MzorqEM/rPKfoXLhS
	 QkuPN9WCvFttTFzx/G5pZ+4Pn45S0WrWuW5CsN/qAFLayG60xpbhbZOu+H936feyAz
	 d+3AmMx7BtE6ZWQLicrSTyprkWVPQjxGvAOv85OCoXGCVDzV3K1TiaY/i57SDjhS8c
	 j8q1RuWOaaCtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7BD1EC54BB1;
	Mon, 15 Apr 2024 09:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] flower: validate control flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171317402850.10544.12420137481628257630.git-patchwork-notify@kernel.org>
Date: Mon, 15 Apr 2024 09:40:28 +0000
References: <20240411105302.112091-1-ast@fiberby.net>
In-Reply-To: <20240411105302.112091-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 louis.peens@corigine.com, yanguo.li@corigine.com, oss-drivers@corigine.com,
 taras.chornyi@plvision.eu, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, ecree.xilinx@gmail.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 11 Apr 2024 10:52:53 +0000 you wrote:
> I have reviewed the flower control flags code.
> In all, but one (sfc), the flags field wasn't
> checked properly for unsupported flags.
> 
> In this series I have only included a single example
> user for each helper function. Once the helpers are in,
> I will submit patches for all other drivers implementing
> flower.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] flow_offload: add control flag checking helpers
    https://git.kernel.org/netdev/net-next/c/d11e63119432
  - [net-next,v3,2/4] nfp: flower: fix check for unsupported control flags
    https://git.kernel.org/netdev/net-next/c/e36245dacd2c
  - [net-next,v3,3/4] net: prestera: flower: validate control flags
    https://git.kernel.org/netdev/net-next/c/f8a5ea8c2a7f
  - [net-next,v3,4/4] net: dsa: microchip: ksz9477: flower: validate control flags
    https://git.kernel.org/netdev/net-next/c/d9a1249e715b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



