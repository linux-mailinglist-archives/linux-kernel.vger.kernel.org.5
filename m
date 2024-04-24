Return-Path: <linux-kernel+bounces-156779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864B78B080A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B830A1C21F88
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E44C15A494;
	Wed, 24 Apr 2024 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVAGBNaM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2DC13DDD9;
	Wed, 24 Apr 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957027; cv=none; b=LCxHOaftmUEMIDrjwUJSDqp4hvYtX+6n7hHt75PtIlCKEwRHkv/EA3aLwO8apF9L1TbNEeKKvs98GXw3CBVeZs8THtMGWr1tN+7RiB/CDdy5DIMxHUWD4VQsslNZlJ6Ut/ISy04jKrBRa1ZytNLKCwhsNQxCzV6iyZCM3TJpsa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957027; c=relaxed/simple;
	bh=Ckxhz825vmza6vvWz/TLutSmlDWafm3SUwU+g4hqtAQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A71NK1CgqxgdJFEx51u1hEQwRZMh/B5fPAbC8i+AHoP1BCPj71c/rYvQBZam0gBOyrCdur5EKV9BUTL20NmROHDplRZSTdD3AdUnZp/RWYWWBP3VO9f3G3AcxxGaJ4EdMbRUf9mcuPWBatpFLb2hoFJZsrJ9LRlCbYcGfIcbNaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVAGBNaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E210BC32781;
	Wed, 24 Apr 2024 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713957026;
	bh=Ckxhz825vmza6vvWz/TLutSmlDWafm3SUwU+g4hqtAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bVAGBNaM7DF00r6IsRzTLUj8CSJoy9XYR8ymyWFycWjZFrAU5SQq81tGhcuF2U/PC
	 eUKTwL0QBd9POnCBbt8hJ9uLWdFYiP30TmXHtXKwCdUOYyidMwCqxJn/IRevcBVjOU
	 55o+uv9QjLsMcdxJ/cKynz16F9GJPeYzm+bZKDqKWbKnMDOkg2MoiLb3Lh5yY73Tjc
	 lQTG3EplQ3d9F44iTDCFeGVwg71NNMOA7/oSg33U0qPK9uxkOwu0YOVMwl1a2NnGj6
	 SwbiUdScEGocf1tJ4IL3p7Tn947X9d5nZH7VEodftC4Br2fDlxnbbOPhn8qFxLFUKP
	 ImdVKMeFRUnJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF635C43614;
	Wed, 24 Apr 2024 11:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: mediatek-ge-soc: follow netdev LED trigger
 semantics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171395702684.12181.223647631542261480.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 11:10:26 +0000
References: <4983a6b197ed999808c5690d01ec1ffb4f6407b7.1713656093.git.daniel@makrotopia.org>
In-Reply-To: <4983a6b197ed999808c5690d01ec1ffb4f6407b7.1713656093.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: dqfext@gmail.com, SkyLake.Huang@mediatek.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 21 Apr 2024 01:08:31 +0100 you wrote:
> Only blink if the link is up on a LED which is programmed to also
> indicate link-status.
> 
> Otherwise, if both LEDs are in use to indicate different speeds, the
> resulting blinking being inverted on LEDs which aren't switched on at
> a specific speed is quite counter-intuitive.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: mediatek-ge-soc: follow netdev LED trigger semantics
    https://git.kernel.org/netdev/net/c/5b5f724b05c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



