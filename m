Return-Path: <linux-kernel+bounces-54680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B9284B263
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7017228C70E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D19412E1E5;
	Tue,  6 Feb 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiNLNKR0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF53D12D777;
	Tue,  6 Feb 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214833; cv=none; b=qkVpURDQ41UhkO1KJA3jQUn2erl+r4eVT3XI9qluaQ1JTpQzM+HtI+YNWMdLVFNDC7vf0R6d0EZ7wj4GP6/37dI2TrCmTMWSozS8j1cwKyyQ80dCWVJOg26kLe5ZLdQmLT4tPUybG2hSYeW9BFvsaFTTxhZENPifPMMoKHALtjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214833; c=relaxed/simple;
	bh=Fjg4am9IQzHVyiyUiJW4bVseISNNzm8i3XEiwSZ6iQ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u1TqfQKIHU+LSQ0nSCAv3C1cYqvucLi6VyE6xPVajWASi0Q7HBO0k/08wSs0vjQ2D7IDOVo8I1q4unfccUO/3q80f1WWvzq0j4jvv81UBGpf6uZw5Ra/auvwh66b8c+sdwCP5mCGR5KkaESFCjB3TmUGvj/fYn5nyd9cdEUpPlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiNLNKR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48063C43390;
	Tue,  6 Feb 2024 10:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707214832;
	bh=Fjg4am9IQzHVyiyUiJW4bVseISNNzm8i3XEiwSZ6iQ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XiNLNKR0qAHMEkw+WJtv0zjrpwpoYKL7jqrvtD/MNamOLYj1D+ZumOrg+y5sHRzKr
	 l4ORzwUaS/VdAiYQyMdGjZP5Y8sb+tujPcMnvs1dDzAzsIvXl71C8YO8A+3Je7XzFU
	 NJCogyd6Ms+7FfJy4fzWl+cCGLJ/3YRn/5aZFKJQpt0wLpRGcm64RD/YqOl9jpKmpM
	 allltjkGKFJDaamYULRC6DB/x01GzCjG8IXPYs1vasfqhXg7n6DmAqWoVM/crpM1yR
	 lpCCJbiVgbWbiJ1WLb0Boukegk58txiu6+1VX8mAkTnR57NGf/pNRg+SqZPSxQqv0o
	 zd1gIgJTkfZpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A830D8C97E;
	Tue,  6 Feb 2024 10:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 00/15] net: ravb: Prepare for suspend to RAM and
 runtime PM support (part 1)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170721483217.7972.7667176225745984934.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 10:20:32 +0000
References: <20240202084136.3426492-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240202084136.3426492-1-claudiu.beznea.uj@bp.renesas.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 p.zabel@pengutronix.de, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 claudiu.beznea.uj@bp.renesas.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  2 Feb 2024 10:41:21 +0200 you wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> This series prepares ravb driver for runtime PM support and adjust the
> already existing suspend to RAM code to work for RZ/G3S (R9A08G045) SoC.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,01/15] net: ravb: Let IP-specific receive function to interrogate descriptors
    https://git.kernel.org/netdev/net-next/c/2b993bfdb47b
  - [net-next,v6,02/15] net: ravb: Rely on PM domain to enable gptp_clk
    https://git.kernel.org/netdev/net-next/c/e1da043f2b2d
  - [net-next,v6,03/15] net: ravb: Make reset controller support mandatory
    https://git.kernel.org/netdev/net-next/c/b1768e3dc477
  - [net-next,v6,04/15] net: ravb: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
    https://git.kernel.org/netdev/net-next/c/6ccc22a5afcb
  - [net-next,v6,05/15] net: ravb: Use tabs instead of spaces
    https://git.kernel.org/netdev/net-next/c/7493bb4c400c
  - [net-next,v6,06/15] net: ravb: Assert/de-assert reset on suspend/resume
    https://git.kernel.org/netdev/net-next/c/c5c0714e2950
  - [net-next,v6,07/15] net: ravb: Move reference clock enable/disable on runtime PM APIs
    https://git.kernel.org/netdev/net-next/c/a654f6e875b7
  - [net-next,v6,08/15] net: ravb: Move getting/requesting IRQs in the probe() method
    https://git.kernel.org/netdev/net-next/c/32f012b8c01c
  - [net-next,v6,09/15] net: ravb: Split GTI computation and set operations
    https://git.kernel.org/netdev/net-next/c/f384ab481cab
  - [net-next,v6,10/15] net: ravb: Move delay mode set in the driver's ndo_open API
    https://git.kernel.org/netdev/net-next/c/23698a9abb62
  - [net-next,v6,11/15] net: ravb: Move DBAT configuration to the driver's ndo_open API
    https://git.kernel.org/netdev/net-next/c/cd1fb46e02de
  - [net-next,v6,12/15] net: ravb: Move PTP initialization in the driver's ndo_open API for ccc_gac platorms
    https://git.kernel.org/netdev/net-next/c/a6a85ba36fd0
  - [net-next,v6,13/15] net: ravb: Set config mode in ndo_open and reset mode in ndo_close
    https://git.kernel.org/netdev/net-next/c/76fd52c10077
  - [net-next,v6,14/15] net: ravb: Simplify ravb_suspend()
    https://git.kernel.org/netdev/net-next/c/b07bc55cbb1c
  - [net-next,v6,15/15] net: ravb: Simplify ravb_resume()
    https://git.kernel.org/netdev/net-next/c/e95273fe4d02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



