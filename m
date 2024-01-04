Return-Path: <linux-kernel+bounces-16168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FD5823A07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A800A1C20D61
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE491107B6;
	Thu,  4 Jan 2024 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gdm4hyZd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136774A35;
	Thu,  4 Jan 2024 01:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D40C6C433CD;
	Thu,  4 Jan 2024 01:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704330035;
	bh=QbJKo2yVuzbyRefmO7HcXD3siDsdSRGa7mK0sXUrkas=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gdm4hyZd5gBTQpTj8jC0QMOhQ3OdhtEIHQKhmnfBzhDv+BfQSqHMZ3MD2A/6Gpfl2
	 Asa3GI9+meLHyQvKJ48137ndmr2YSk/YWF9791kn5Ud4p9dcD8hgCT5Gzf+HMLWMxV
	 EZwxCHsbGOstAv1B585vJf6ojZ064Ssei0DhyWU6dFvnTKxrOsCvKid8w+4IW2MIYK
	 MSAyxjRkOOUNfHVNbLzADv9yQaVKIOP5srFspS/VZ+hj4XfXMuK+7CxH/KGLQXupZX
	 poJH5lj4iPpTu4nzeLvqNmIDSlUHIcaGHmv3uk1sBhPv9TEXT+WgbLqkphmN3qUzIS
	 bqoi0GSwuqqfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF511DCB6FF;
	Thu,  4 Jan 2024 01:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] net: mdio: mux-bcm-iproc: Use alignment helpers and SZ_4K
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170433003577.5757.14037935796410160204.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 01:00:35 +0000
References: <20231229145232.6163-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20231229145232.6163-1-ilpo.jarvinen@linux.intel.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen_=3Cilpo=2Ejarvinen=40linux=2Eintel=2Ecom=3E?=@codeaurora.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rjui@broadcom.com, sbranden@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Dec 2023 16:52:32 +0200 you wrote:
> Instead of open coding, use IS_ALIGNED() and ALIGN_DOWN() when dealing
> with alignment. Replace also literals with SZ_4K.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/net/mdio/mdio-mux-bcm-iproc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [1/1] net: mdio: mux-bcm-iproc: Use alignment helpers and SZ_4K
    https://git.kernel.org/netdev/net-next/c/73b2e2e3fe26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



