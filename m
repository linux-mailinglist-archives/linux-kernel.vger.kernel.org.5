Return-Path: <linux-kernel+bounces-105875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3EB87E5CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B3C4B2171A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A932E63B;
	Mon, 18 Mar 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7zOq/T+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2822E419;
	Mon, 18 Mar 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754228; cv=none; b=bpMauE+ncuQ4Jx7Vk+K4OAh/9vMSD2y7vaIQQGtJkIAvjAmi8vYVuXfZbh+2h8Lr3wc5+jpIsg+6arIPk40VyjR84KhEHNte1jOTGFFIx9ma8SdllhfQIkWjto07tscq5WzvqiUOe2Ggly/ycmVHj3gEa+1jbWwKhUWcsWCblqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754228; c=relaxed/simple;
	bh=wa8S5aQ0Fzi4i7GlEYIb73Ld/KafiFSLsqPj7Efjbi0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LBqF1ulIh5nhGjqPXtuaejzsK1WOqz4odRFrqkKSzocfi91Q7Ztr7MeWzHEIMRGG44oQC6CTEbg2Mo7+KxToRAL0oWd3/v8YPYePR00UBEBXV82LVaNQiVLd2qoi7cQrgxefQDGU4/S0uksCSKu/T3JV0SkniHK2xGE3MJtVyIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7zOq/T+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FFB3C43399;
	Mon, 18 Mar 2024 09:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710754227;
	bh=wa8S5aQ0Fzi4i7GlEYIb73Ld/KafiFSLsqPj7Efjbi0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u7zOq/T+2e0HggZ/WQdkDzR0G8QMpdeSemZfzugL74LUOQ02tAv/n6eS6Kx+vEldX
	 phqUbOvi1az5LXAWZAZuWZ5znyaVa2GZ6MgkzPXrPXbMj+TywfN3uhU0PwuucpbbxQ
	 5H0XnLfYoSbrLSY8nMABiUhzsGICcmvq8+yoKgUT3c8HNTbPdhDQis9qD5E4cz/Bf4
	 P37wHZCP8P1ZaGx+anM/Ascqzsa4c3Dmk7Kl1Y1PZGDjPzvj6H1908d9AuEKy+E/QQ
	 CBKq9e439vt4/OHOQObE/nHKcCatFeXWYDaShsMsRF3UQsetajPusOrYjOZsiTJ1ny
	 r+41iwwRFmNwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 504A1D84BB3;
	Mon, 18 Mar 2024 09:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wan: fsl_qmc_hdlc: Fix module compilation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171075422732.16862.15652727322358933272.git-patchwork-notify@kernel.org>
Date: Mon, 18 Mar 2024 09:30:27 +0000
References: <20240314123346.461350-1-herve.codina@bootlin.com>
In-Reply-To: <20240314123346.461350-1-herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: mpe@ellerman.id.au, vadim.fedorenko@linux.dev, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
 linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, andrew@lunn.ch,
 broonie@kernel.org, rkannoth@marvell.com, christophe.leroy@csgroup.eu,
 thomas.petazzoni@bootlin.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Mar 2024 13:33:46 +0100 you wrote:
> The fsl_qmc_driver does not compile as module:
>   error: ‘qmc_hdlc_driver’ undeclared here (not in a function);
>     405 | MODULE_DEVICE_TABLE(of, qmc_hdlc_driver);
>         |                         ^~~~~~~~~~~~~~~
> 
> Fix the typo.
> 
> [...]

Here is the summary with links:
  - net: wan: fsl_qmc_hdlc: Fix module compilation
    https://git.kernel.org/netdev/net/c/badc9e33c795

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



