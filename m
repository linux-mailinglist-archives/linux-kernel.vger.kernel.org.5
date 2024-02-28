Return-Path: <linux-kernel+bounces-84673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0323386A9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F60DB26C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF232C860;
	Wed, 28 Feb 2024 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjU7/iKE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA391F164;
	Wed, 28 Feb 2024 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109033; cv=none; b=TERIn9rbDp5KjVwJR0SIMUg25JrHpPBpwbBpeaHHQMC3Yj2MplMLD9OLhqHB08jihyxIbRzuctfqe+/j008gq23fHYAIZ/ftB5Q5xLC2VkVOQG8FOhV0dU4uCFbee9t96prR80anWoOkuBoSFZtW7JbSxtLl92sDJ7FhXLZ9OTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109033; c=relaxed/simple;
	bh=8Vydkbv+kfRAUshdZNxTGlKy4jifm0a/luMTbD/eFhY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VKih3OMBlxCzwHbCTXfk6ZeO04nYEyF9w2cJ+Vl7fSqEhM2qv0Hg6cLvL+yxR0cmTtbrJivCH+4tj+kyvoZTOIMuneJ+hqcB5W55npyfxBnpBEa51iwBmWxdzHnqa7MB1W01TQiDpqQks7Q3LRpVlOxg0PMhaABlkwCJE8LnnKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjU7/iKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20FA6C43390;
	Wed, 28 Feb 2024 08:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709109033;
	bh=8Vydkbv+kfRAUshdZNxTGlKy4jifm0a/luMTbD/eFhY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JjU7/iKEmgBrDwSJlFxSSCDFPALFnIFXHWyNkdbmhe+jRGo65bO0+ebvAm2SrUGNc
	 Sz4twvg3gAV1u5Zqx5RsPTShGHgHslEoIm7f+rirmxCAzkufGyVNLjY/+066jgZCGd
	 AowFz0odrbYPGlq+17BCjC4mJ/OtfCCWa/IIPxWvIrefAm4hUds0WzXqNbjXXxjzSj
	 8n6L9MrS/GbOY4D5S6TDzo7RDTJ+r/QL4g3Ey5vDAZbD6QICyXAezwQ3m5Op9GGf+E
	 O9ByRToMohVV119moDeDWUvw7pkIijJ23o+flDzrvqENMb1iI8hmKa7feUtRcFW07w
	 Y5mV4Fd8ErUhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 046C6D990A5;
	Wed, 28 Feb 2024 08:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/3] net: dsa: realtek: support reset
 controller and update docs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170910903301.16278.18422198402730438279.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 08:30:33 +0000
References: <20240225-realtek-reset-v5-0-5a4dc0879dfb@gmail.com>
In-Reply-To: <20240225-realtek-reset-v5-0-5a4dc0879dfb@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, arinc.unal@arinc9.com, robh@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 25 Feb 2024 13:29:52 -0300 you wrote:
> The driver previously supported reset pins using GPIO, but it lacked
> support for reset controllers. Although a reset method is generally not
> required, the driver fails to detect the switch if the reset was kept
> asserted by a previous driver.
> 
> This series adds support to reset a Realtek switch using a reset
> controller. It also updates the binding documentation to remove the
> requirement of a reset method and to add the new reset controller
> property.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/3] dt-bindings: net: dsa: realtek: reset-gpios is not required
    https://git.kernel.org/netdev/net-next/c/28001bb1955f
  - [net-next,v5,2/3] dt-bindings: net: dsa: realtek: add reset controller
    https://git.kernel.org/netdev/net-next/c/5fc2d68fc818
  - [net-next,v5,3/3] net: dsa: realtek: support reset controller
    https://git.kernel.org/netdev/net-next/c/56998aa6b7f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



