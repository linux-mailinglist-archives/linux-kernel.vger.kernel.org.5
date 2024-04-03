Return-Path: <linux-kernel+bounces-128912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748E88961CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FFF1F2264A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B689818638;
	Wed,  3 Apr 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezHaY0Js"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F099911198;
	Wed,  3 Apr 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712106628; cv=none; b=lFSm2DhHkIlibwloOSh134sIPFaJy+NvvK9fMNza90bT4XXKhUKjXrpCBYvXI+Ws2mYZ6n4CfwGGjJ33GE0PROqou71vTqlXIf21DeOtLoGiAQt3IuqYxh1v973gqlCu+Y72MWOqnM/AByRRFCtVyWDHjyneLgbVQQuYbkgJZ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712106628; c=relaxed/simple;
	bh=d0RR8BQ2ZkqRT7pPf+veQBwijEC2P3qhpNxH6jjB9k0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fYD0TGjAYtu6kcYZXzApL4ecPISfA7hNIFhjnpwkEkMEB1eA2ES84VUp1sARP1chjGaNjRLykCKg1BG7TSzQajS96w24mpxd93L6z6QGEsB484vPL2cyya/V7vymHQ6GoIcxKSSxVKhaUZRGjvouj06ld/NSam0hwuc2u2IIGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezHaY0Js; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2323C43609;
	Wed,  3 Apr 2024 01:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712106627;
	bh=d0RR8BQ2ZkqRT7pPf+veQBwijEC2P3qhpNxH6jjB9k0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ezHaY0JsPHvLQR4rAf846SOCDmYmq4o79WMbaA9mxTLwZ+RUVwS1i+ixb7hjHgDml
	 +OeRc+K0Wn0TUJriEyT06Om2Lz6zFmsISsKu0xtIqQhze4PFmgQZtTu6WARpJRCTzu
	 wmE8wdmhR8OR+Vtexu4u1SekL4tv5grVpm3jW8bVPnIzdeqEGSQx/MEpyhR/kURk1A
	 8DiExBE6zX2J1S59v0iowM3NfA96LM3UwTl47ytu5eRcXZS+VXU5Efe32TWxm+8GiR
	 l985kUdgkCSP1RxGLLjQpoR4yt69veOnjKwLmRiXqYt5HTTMEcq12D/Fnvfi2Q0YlP
	 7xbliR/I3Oo3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7FBBD9A14F;
	Wed,  3 Apr 2024 01:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: aquantia: add support for AQR114C PHY
 ID
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171210662768.30217.15740978858781535025.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 01:10:27 +0000
References: <20240401145114.1699451-1-frut3k7@gmail.com>
In-Reply-To: <20240401145114.1699451-1-frut3k7@gmail.com>
To: =?utf-8?q?Pawe=C5=82_Owoc_=3Cfrut3k7=40gmail=2Ecom=3E?=@codeaurora.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ansuelsmth@gmail.com, robimarko@gmail.com, rmk+kernel@armlinux.org.uk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Apr 2024 16:51:06 +0200 you wrote:
> Add support for AQR114C PHY ID. This PHY advertise 10G speed:
> SPEED(0x04): 0x6031
>   capabilities: -400g +5g +2.5g -200g -25g -10g-xr -100g -40g -10g/1g -10
>                 +100 +1000 -10-ts -2-tl +10g
> EXTABLE(0x0B): 0x40fc
>   capabilities: -10g-cx4 -10g-lrm +10g-t +10g-kx4 +10g-kr +1000-t +1000-kx
>                 +100-tx -10-t -p2mp -40g/100g -1000/100-t1 -25g -200g/400g
>                 +2.5g/5g -1000-h
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: aquantia: add support for AQR114C PHY ID
    https://git.kernel.org/netdev/net-next/c/c278ec644377

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



