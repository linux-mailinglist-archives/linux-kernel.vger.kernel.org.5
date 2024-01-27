Return-Path: <linux-kernel+bounces-41070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD33083EB35
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 06:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3211F247EC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 05:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB05E18E07;
	Sat, 27 Jan 2024 05:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3zx9WhK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECFC13AF9;
	Sat, 27 Jan 2024 05:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706332230; cv=none; b=XBuWWT2H8Rl/Wm6GB8SkcIUaq3D1mErCDGk+HvUCF7OYjAP9cyG7yHCwHKrNW6V8y0PUe5KFD2kxi8jOcsIbFcxoPK4TMODebvztX+I6k+XV5ku9IEkSQCupwS0agmKjN2gm5k2V1MhJTJeF/U2XCFz9v1+EfzTb22g1auDD9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706332230; c=relaxed/simple;
	bh=wUmUAKvbwlQsmbXWrLM1GAtgXCgeiPGESIUk3Gb490s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L+KpCrnkdNzFB1P7E+/+bVY0wgT6U7CYVOTJ2pliKhi8hJaKLjpMjzTHsxtmX/99j1W+pBtN2r7JFE4n+qKzpKyEtqXbmgZduXQBZ13CuW0GPmCdXqX2PNbmLqoFhkaq9KNqdiDzEsnpiRjQZXFUjNlxPANFQki2LB1fqSOruLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3zx9WhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA0E6C43394;
	Sat, 27 Jan 2024 05:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706332229;
	bh=wUmUAKvbwlQsmbXWrLM1GAtgXCgeiPGESIUk3Gb490s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s3zx9WhKs34Tvi7pZjHVF05k5goKTZuVJpH+1ZZ05yBuBsrn3ZuBKc5KkFwg7wXUE
	 BHDUTilhbpHzSGrGfspjF5wiQDh9OV3ut6gkSk/cAmKshWfXZvM5AXkKYDBt8MOfvB
	 iPRlgIUDVwDbrMTTuYiRT4ATrKnE34A8yuuLCfI3kQiVALqn7W6VCSFPkrzaNln/tO
	 F88qBWkIXfIACaG7Ws7hk7VJHJH0mWjD+fyReIZYJiJQt1r2uhK3xcczxNnmnFWM3P
	 ZBXxzul8hjbwKJqIRrGhxxY+s7yAn9Y+cvnk2W83vDgs33znTg65TfFeAxUiNEG0BD
	 qCPtZGxhRqXcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 890FAD8C9C3;
	Sat, 27 Jan 2024 05:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v10 0/5] net: phy: generic polarity + LED support for
 qca808x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170633222955.22327.17810717334139226034.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jan 2024 05:10:29 +0000
References: <20240125203702.4552-1-ansuelsmth@gmail.com>
In-Reply-To: <20240125203702.4552-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 william.zhang@broadcom.com, anand.gore@broadcom.com,
 kursad.oney@broadcom.com, florian.fainelli@broadcom.com, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, jacek.anaszewski@gmail.com,
 noltari@gmail.com, sven.schwermer@disruptive-technologies.com,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jan 2024 21:36:56 +0100 you wrote:
> This small series add LEDs support for qca808x.
> 
> QCA808x apply on PHY reset a strange polarity settings and require
> some tweak to apply a more common configuration found on devices.
> On adding support for it, it was pointed out that a similar
> feature is also being implemented for a marvell PHY where
> LED polarity is set per LED (and not global) and also have
> a special mode where the LED is tristated.
> 
> [...]

Here is the summary with links:
  - [net-next,v10,1/5] dt-bindings: net: phy: Make LED active-low property common
    https://git.kernel.org/netdev/net-next/c/c94d1783136e
  - [net-next,v10,2/5] dt-bindings: net: phy: Document LED inactive high impedance mode
    https://git.kernel.org/netdev/net-next/c/355c6dc37efa
  - [net-next,v10,3/5] net: phy: add support for PHY LEDs polarity modes
    https://git.kernel.org/netdev/net-next/c/7ae215ee7bb8
  - [net-next,v10,4/5] dt-bindings: net: Document QCA808x PHYs
    https://git.kernel.org/netdev/net-next/c/91e893b43d1c
  - [net-next,v10,5/5] net: phy: at803x: add LED support for qca808x
    https://git.kernel.org/netdev/net-next/c/7196062b64ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



