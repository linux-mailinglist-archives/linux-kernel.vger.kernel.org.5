Return-Path: <linux-kernel+bounces-70411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC0E859769
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F37281A81
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 14:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308F36BB41;
	Sun, 18 Feb 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQ6QLLSh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9E290F;
	Sun, 18 Feb 2024 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708266625; cv=none; b=Ydizr68TqWk+eacmX6O9gxrcuUqU2Yjed5LspzHrDl/NYSXHoQeI5WvIjCNDkEZgcSqsvQ/voL+q1H+zKnrY8wHVR71EqBlIUv1NImCFoDXtr+pQ6h8Gs65qrD+AkX6sF6h2rxebJnZGJycqAb1czH+4wr6Ob39vRlRrsTKzJ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708266625; c=relaxed/simple;
	bh=578ObU6iDAKq8fwBk1Q3SXmzlsnHqot8Ce8PnA7GUr0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nGgSv1raUYrl+8HpYc5Qb6aDjdq/xFKLOBM17cldVL2gIuxrfdGQHdyj/ZqruvRN9D3dWedN6OINd3J+IHdzFBMmI7qHr7T3WWDqR9a05K5x1N6mezNAzBQ3yRaAYddrp0WABFntBHy7UCNbep2A4L9farX3RuzV+60KZLfZE9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQ6QLLSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB477C43394;
	Sun, 18 Feb 2024 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708266624;
	bh=578ObU6iDAKq8fwBk1Q3SXmzlsnHqot8Ce8PnA7GUr0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bQ6QLLShDuJeCBzVfSUwrgSXgwK7/vvP7HKnl2l630jHHE7Sz79OyTYB8FlrkihHz
	 AxAajtmcgS8FOeoyVtDlKBgvokffrGaOlc9QHQkl5jZrNeYqxw8J3j0KvHgOsQyGb1
	 H8gIZch30Yjh/0PJlFEMGSoGYIVYzimJb5YT82V2QkMkAhnfckFYOiEha7U2oK1EsK
	 kzsv0bm9cuUo+Ddmsfedlfdta1RDYgG6RFUPlnoZfsyhSDGGjPG+iHTs+FPb2uvrOP
	 w7bWbO0yhgRbmogqfmj3SfGY64KZao/0lsGWJABn8VWNR0xux2s8oBWjrzXZUoyeT7
	 nSAN/Mg/FSL7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACE3AD8C968;
	Sun, 18 Feb 2024 14:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] net: phy: aquantia: add AQR813 PHY ID
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170826662470.32401.1327881086061594759.git-patchwork-notify@kernel.org>
Date: Sun, 18 Feb 2024 14:30:24 +0000
References: <20240215214331.18162-1-ansuelsmth@gmail.com>
In-Reply-To: <20240215214331.18162-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robimarko@gmail.com, rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 15 Feb 2024 22:43:30 +0100 you wrote:
> Aquantia AQR813 is the Octal Port variant of the AQR113. Add PHY ID for
> it to provide support for it.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> This is based on the AQR113 patch that has been already reviewed
> and accepted (still not in net-next as a rebase was needed)
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: aquantia: add AQR813 PHY ID
    https://git.kernel.org/netdev/net-next/c/6d47302a3f0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



