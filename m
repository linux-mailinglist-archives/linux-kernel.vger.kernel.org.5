Return-Path: <linux-kernel+bounces-81293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D06867397
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A29281D28
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FA22EAE6;
	Mon, 26 Feb 2024 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IciREwrv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF8224219;
	Mon, 26 Feb 2024 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947632; cv=none; b=ld8f6Bvhp0pU1XhYK7gzBEhzzCPaq8qdKAsRHSRYSlOX3ABM6PK+yryzgugPUpy8Wk3LGvZndkFBgCx6GqMIal8TrxRx/cNkK08AwVCTZoz+W8p/OL3v19X09mppouBOJRgvacMKTi95mdohuQDHpVJvTr+8Rj3FCgkVnFxfCGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947632; c=relaxed/simple;
	bh=AGMvW8EzegrzngxDywguUoFCHmieih2v3vNs74/+sig=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DMdC6a66w/Xfyinb1RJZBej1ojcaOCZpEyIhC+bcwJVYzPj8i7li6TX9QTJhB1i8as0T8e/0XeOfQgJ2WOmuf2D4XkK0UOv+kKdfdbR8GXP5KF730T62kaqiNMutQ0pdNCeiWwgOiJK89eiUGTUYICVYlwgAQo71xKaW2O0zel8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IciREwrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 198F2C43390;
	Mon, 26 Feb 2024 11:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708947632;
	bh=AGMvW8EzegrzngxDywguUoFCHmieih2v3vNs74/+sig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IciREwrvQsqlzZpOHwerFS7IMRIVdUuF8hT/60pVNBTe5UJzfIAhOJKep8i3kNq8a
	 9YsaAyZI29ql9+uAqLYJUYETMKOQ+epr78TphVNb/jWax8v4u6AaEdsxrhfktmO8VY
	 HwDYc5aaI4xuQYQk9O1MoASw/24x9gXJRv85Gkynv9WwdhWXvIwGpk+MkD6izUDA8N
	 d5W1LSKQcdozx7PFxDqkQlPaowzsZjrWN0HheCQt0Z4cFNIBkNrJIY/0wPgI1LXPl7
	 pb8SCY9h1M5rwr+ORTlgCrag09eFeBnRwx1PuD3MFIMeQMLyrH5gM4zWHjnzh3UpXS
	 9GamgmH8h/U7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04DEDD88FB0;
	Mon, 26 Feb 2024 11:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] Add support for TI DP83826 configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170894763201.4235.16287009126578340303.git-patchwork-notify@kernel.org>
Date: Mon, 26 Feb 2024 11:40:32 +0000
References: <20240222103117.526955-1-jeremie.dautheribes@bootlin.com>
In-Reply-To: <20240222103117.526955-1-jeremie.dautheribes@bootlin.com>
To: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=3Cjeremie=2Edautheribes=40bootlin?=@codeaurora.org,
	=?utf-8?q?=2Ecom=3E?=@codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, afd@ti.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
 yen-mei.goh@keysight.com, maxime.chevallier@bootlin.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 22 Feb 2024 11:31:14 +0100 you wrote:
> Hi everyone,
> 
> This short patch series introduces the possibility of overriding
> some parameters which are latched by default by hardware straps on the
> TI DP83826 PHY.
> 
> The settings that can be overridden include:
>   - Configuring the PHY in either MII mode or RMII mode.
>   - When in RMII mode, configuring the PHY in RMII slave mode or RMII
>   master mode.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] dt-bindings: net: dp83822: support configuring RMII master/slave mode
    https://git.kernel.org/netdev/net-next/c/95f4fa1f459a
  - [net-next,2/3] net: phy: dp83826: Add support for phy-mode configuration
    https://git.kernel.org/netdev/net-next/c/d2ed0774b633
  - [net-next,3/3] net: phy: dp83826: support configuring RMII master/slave operation mode
    https://git.kernel.org/netdev/net-next/c/2844a0d7cffe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



