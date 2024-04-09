Return-Path: <linux-kernel+bounces-136505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FD689D4E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B418B21A0B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48AE7E78E;
	Tue,  9 Apr 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ae0wXjoV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F7182DA;
	Tue,  9 Apr 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652630; cv=none; b=GyDqvlc+DXI7osV5aRrol/apIMZw/yCbSDDGD8ZL9OK6qZVYw8VrvS35M9y4UL4qn2sOymYivdXwqC6GK52eYX4oaN8yD4iwtgozr6PDl0zRCPuyf+8DPnbzq6lSM3uXOcADe7Sdm2C5t5tT0c9mDluf16Jbct2VDEH+212VFBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652630; c=relaxed/simple;
	bh=O25aYkHWrsu7zBiCOqklwkMToywUQR66Sk3iIgRw3vc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ARdR/VKCzhxK2cOIkSYeMQxDPjdnyC6D/eQ0CpWjIko4ayuOp8Eg454XwPQEaPv8KDI10Hzi9O12/hQUQnECagjgeByrji0i2tahkYdRj9+pWvyJQRsIzuHzEkGzz65cxrEJqAcjljLZuZy7jKJB9rA1hcvTC29CeKySAhLfrWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ae0wXjoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90C6BC43399;
	Tue,  9 Apr 2024 08:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712652629;
	bh=O25aYkHWrsu7zBiCOqklwkMToywUQR66Sk3iIgRw3vc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ae0wXjoVDKUFxDplqKjl7fOho3gK4aiVLkNMwtOqOVjG6Cdq/YNa9gvAMV3aMVwd7
	 cIWj5Az/QJxQyUw2rzyYuif9NS6AwI3yf7vWSDELvlpao+oF8rpO9ReBSZlP9Rm5ns
	 M1oovSBY7p6i2dftu4UAepKHFZVYl9PXLBO+1cwFn0q9maTM65hsVuH0ZORKGP7vzi
	 9jcYF4WgL1hfJhEyeTHQujWb6WKluvoqz9i/a5p1ZA9+JjIvwX7W73qHPWcVgVR0uB
	 JhaNUYo9HjU0gXkCN9McS83WbSuNnOc7MgFXHUfGHcMiGvJxjR/Ydm1n+0gckU3bye
	 lxTIjYZ4/y35w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D990C395F6;
	Tue,  9 Apr 2024 08:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Add support for flower actions mirred and
 redirect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171265262951.12361.3435746641851146490.git-patchwork-notify@kernel.org>
Date: Tue, 09 Apr 2024 08:50:29 +0000
References: <20240405-mirror-redirect-actions-v2-0-875d4c1927c8@microchip.com>
In-Reply-To: <20240405-mirror-redirect-actions-v2-0-875d4c1927c8@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rkannoth@marvell.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 5 Apr 2024 09:44:48 +0200 you wrote:
> ================================================================================
> Add support for tc flower actions mirred and redirect.
> ================================================================================
> 
> This series adds support for the two tc flower actions mirred and
> redirect. Both actions are implemented by means of a port mask and a
> mask mode. The mask mode controls how the mask is applied, and together
> they are used by the switch to make a forwarding decision. Both actions
> are configurable via the IS0 or IS2 VCAP's (ingress stage 0 and 2,
> respectively).
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: sparx5: add support for tc flower mirred action.
    https://git.kernel.org/netdev/net-next/c/48ba00da2eb4
  - [net-next,v2,2/2] net: sparx5: add support for tc flower redirect action
    https://git.kernel.org/netdev/net-next/c/1164b8e0b108

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



