Return-Path: <linux-kernel+bounces-88118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D05886DD84
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232F01F29919
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D0A6A345;
	Fri,  1 Mar 2024 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnU4eYRn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E85B1E2;
	Fri,  1 Mar 2024 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283028; cv=none; b=pPdmcDQnHT+IqJ6Fje3pioX74SxaYFkR4/8FWwr7Xm/GfTRkbULCk4dW2pcWK608kKNljP9IkrPe/nHnpKrq726IXM5DY4bvr75On2IywJvpZKQD3K+g380xtuFeWmIhjYj1Hh8M3j4pcz6nifnZOINMZffqRpkhYaexDYQ7oIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283028; c=relaxed/simple;
	bh=jRwlwLaY8DvhUJ5vZvOY0zwbcM9tnxbvoCb2hzIH5KY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=byIHur+nT9njkvOlBHzmd9z6qLPhDIqwfksW6N8IXPspmNLJYXBp7Qjk0xXZHQKkuBrB2o8WBu1yAQqXO+j+E3W0Coj7HGycVk2ey4Fc0bB5nQyMiUvYLncoBkRrsBbfM3QqAz22DMGVXHDb5WRRSX+I7QcMZPrhn0sD0DzdfKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnU4eYRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D5A4C43394;
	Fri,  1 Mar 2024 08:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709283027;
	bh=jRwlwLaY8DvhUJ5vZvOY0zwbcM9tnxbvoCb2hzIH5KY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CnU4eYRnnjuRUQGulZk7J5iCtt/iedtbbzStswrDzf71YwH+ENxLUUeOei91KLT4m
	 oNtejIgWR9wueOQASwKRr+jJQvvcNgtrkzRJRVnrZQ9t04m9HL8KBA0NXpj0SDhdkn
	 zifyRkMSYAnDOKJnQ2CUupAkOLYXfB1YXYLKo9zO1jOvDmhd1V77XaTcghyltCPflI
	 LdmnbNL42vVi46Nfc8ZSwuYseOIAWVF+Kqje3X02EX66DV+GMgTCOCAMhxjuxjZHGZ
	 1N/sKWPjxkuBpSyVQ+JKslceJ/O1yQ4u4PCGRdoC8/v7SNH7VjPiygQRPmLQrefK+t
	 s/X7ql0v3JDrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 565C8C595C4;
	Fri,  1 Mar 2024 08:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v2] net: bql: fix building with BQL disabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170928302735.20263.761844776141762847.git-patchwork-notify@kernel.org>
Date: Fri, 01 Mar 2024 08:50:27 +0000
References: <20240228160732.1662287-1-arnd@kernel.org>
In-Reply-To: <20240228160732.1662287-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, leitao@debian.org, arnd@arndb.de, s-vadapalli@ti.com,
 rogerq@kernel.org, grygorii.strashko@ti.com, dan.carpenter@linaro.org,
 horms@kernel.org, daniel@iogearbox.net, ansuelsmth@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 28 Feb 2024 17:06:56 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> It is now possible to disable BQL, but that causes the cpsw driver to break:
> 
> drivers/net/ethernet/ti/am65-cpsw-nuss.c:297:28: error: no member named 'dql' in 'struct netdev_queue'
>   297 |                    dql_avail(&netif_txq->dql),
> 
> [...]

Here is the summary with links:
  - [v2] net: bql: fix building with BQL disabled
    https://git.kernel.org/netdev/net/c/eb2c11b27c58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



