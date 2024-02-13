Return-Path: <linux-kernel+bounces-63715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D403385338F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CDF1C27D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB7F5D91C;
	Tue, 13 Feb 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWr4XY3c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3860758107;
	Tue, 13 Feb 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835829; cv=none; b=q9/Qe3l4CX2NUJpTdhwSoP+VnaTRuf2amSuwOqhX769lkT2czbEvAsjjqG12gEGYeE4R+4lfWcd2zbq/1dJDXCI8Pcg61qv96jv2qHHYv1cU+DyRgdZqyojMkL19w10HG/SPWdCTgy57rv+ugW3t+Coo4TZ+5AQTfpHcWRVZ+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835829; c=relaxed/simple;
	bh=JE9++Xijhmm1+mSvtLh33sMJJ6bqD9bFiZRF2MoVYOY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c/mdkbhA905Ck7nEv1Kbv/hJ63mNrqiD/xPdFVsEyBW+g3UUgnKBRTFxOsbHBHX8rz5o5ffUQMwwl/SJ+6oxyRUcJEZQO+35791UH8FTPM4Oz+QoVjK0PmJUfnwLE+MGrS6PQFDYgY/61qhWvw1kmDT2m0Z1MmG9Pkj56PhXlW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWr4XY3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD16DC433F1;
	Tue, 13 Feb 2024 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707835828;
	bh=JE9++Xijhmm1+mSvtLh33sMJJ6bqD9bFiZRF2MoVYOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jWr4XY3coR3amQkHQNNTK4XY5Te3Uifr5SbWhrCdU5Ua+7UoIPosDcn/hK9sFq/bS
	 CZxm3VSHghO5tpaGmgRHtBqhv8cWrgmSZhVOBuwYetDEwOa4LpGbrdYWNG7jmpuzVA
	 KuaoMfY7A3p3Dxf7Y5NEwnHvh2JLLhGsiB89H3XYKlWBYfEjqnzdATq/Ks0OUFd9FY
	 MwuIEGRJIHwDEAaJH34HnHn6yaVnL7JliX5foWAIgiLBsjTGjFHB6PHXTQ8xU+IHka
	 4xGIa+ZRzh4dHiSBp+2tUSO8xlboVxF1ZZ0d5yVTHhaz72BNOLLkfT/GCaSlHakGEp
	 UQOjC6XF/WI1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A214BD84BC6;
	Tue, 13 Feb 2024 14:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: aquantia: clear PMD Global Transmit
 Disable bit during init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170783582866.26385.2877189864647698276.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 14:50:28 +0000
References: <20240211181732.646311-1-robimarko@gmail.com>
In-Reply-To: <20240211181732.646311-1-robimarko@gmail.com>
To: Robert Marko <robimarko@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ansuelsmth@gmail.com, rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 11 Feb 2024 19:16:41 +0100 you wrote:
> PMD Global Transmit Disable bit should be cleared for normal operation.
> This should be HW default, however I found that on Asus RT-AX89X that uses
> AQR113C PHY and firmware 5.4 this bit is set by default.
> 
> With this bit set the AQR cannot achieve a link with its link-partner and
> it took me multiple hours of digging through the vendor GPL source to find
> this out, so lets always clear this bit during .config_init() to avoid a
> situation like this in the future.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: aquantia: clear PMD Global Transmit Disable bit during init
    https://git.kernel.org/netdev/net-next/c/bed90b06b681

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



