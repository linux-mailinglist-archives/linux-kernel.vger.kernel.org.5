Return-Path: <linux-kernel+bounces-49644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B455846D65
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4F44B22287
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AC87A70D;
	Fri,  2 Feb 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StfPeYjR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D40077652;
	Fri,  2 Feb 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868628; cv=none; b=VYvKfu6WXUlHMjjICOSd5/A0W1ghhGKK3w15uVSkz7DzILzYOg/A9rqOj/DeCmvcfKxVH3wiQmJauGov+vKT/kLEbJyDuhWbBisRPynExexKQNXoz44RAUaADOHk4ZQJcDsyVhRD61gy0Kx9Gd+7AsJfmdFmS50N4QDIZxCA3Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868628; c=relaxed/simple;
	bh=/u55Rx+IiTBdg/DacgDPZdGpm9UlGyfFcxW+Iw8dSsQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u0VpnWIMoVb1X65YMVDrUXY5xhTzWoN7CkTko8DTJMib4P90D9UYAkhiJyh9jkoWp+TVl4o5DlXu8KTtZlkkneP7WLrvqAtIRvZLYmHYDd9wXEcVkS4sKgbTHT7gjJDKDMr5V0tVwcOR1hdCnheZ+18M+vzq7bjlJlD1zPMMRw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StfPeYjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5364C433C7;
	Fri,  2 Feb 2024 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706868627;
	bh=/u55Rx+IiTBdg/DacgDPZdGpm9UlGyfFcxW+Iw8dSsQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=StfPeYjRBqYjb120rx6pvww20hdGJ6GoZniIp7gLR0uSFsVufmorTJBKVZmTGPete
	 Q27wbZ0dY0QN5k2BE0noMJxZAEnlfdtJuemGMVXcknA1x0frc7zxzsfv6AonWpGy+5
	 p0w5zubveGe427y8RyIUlSXu/enWOxlK1tfwh8AeMJr8M+L0viXiuFTJ2aTPd1hExr
	 CNgVzUzxh7uokaQT+EPHDDvnLOsXgxfuBHHuMVd6WmcLXx+lSg5jX9h0sQfv5tT603
	 M3lTXQP7OdjMDfujfaFcT2pVnQxw8a5jFBZVNAiSCqTvoLBOvt0NusOAn9OjGxAyDk
	 M4GDHrvxtPdlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7B18D8C970;
	Fri,  2 Feb 2024 10:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v3 0/2] net: mdio-ipq4019: fix wrong default MDC rate
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170686862773.17682.10435156329986246682.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 10:10:27 +0000
References: <20240131022606.1532-1-ansuelsmth@gmail.com>
In-Reply-To: <20240131022606.1532-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 robert.marko@sartura.hr, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 31 Jan 2024 03:26:02 +0100 you wrote:
> This was a long journey to arrive and discover this problem.
> 
> To not waste too much char, there is a race problem with PHY and driver
> probe. This was observed with Aquantia PHY firmware loading.
> 
> With some hacks the race problem was workarounded but an interesting
> thing was notice. It took more than a minute for the firmware to load
> via MDIO.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] dt-bindings: net: ipq4019-mdio: document now supported clock-frequency
    https://git.kernel.org/netdev/net-next/c/9484b9555de0
  - [net-next,v3,2/2] net: mdio: ipq4019: add support for clock-frequency property
    https://git.kernel.org/netdev/net-next/c/bdce82e960d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



