Return-Path: <linux-kernel+bounces-68553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94007857C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8EA28458D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BD378689;
	Fri, 16 Feb 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVPAAd7U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917BB54F9F;
	Fri, 16 Feb 2024 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084827; cv=none; b=qehRKPwW/UJhGDIIXD6UE0H3YSv5t0BRR/ehhdmTQjdVxSfd1bvXVNVkPCxKs7mnKMRU6VzEaljxui1ldwSHkaSlqvIfpA/z0MkCU1G1n3Qa8lJ9YTINSCu3Xf+9Omz0MWroiCJHTNmz0eKLOxBH8/2CcMhRe4CcL2ZbTi6eMvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084827; c=relaxed/simple;
	bh=67gMBEW7q8oBFF0wsQh1UGQcPSIpumcE7ZLCG2vgJeM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qmvd5EAFl07MJ15OK7xE4bamSd0l7wF84WmKMJb0G7U1/KaYh5xh9x7fa3RZ1RXcl4Zbd+C9lMT7l7mhRKdvF+FNtzLRLRa0Vhmfzaf+58NeaafobuqMPGpv/BTZaYUcEt2/u1CcUYEJrUsSXsY/0Xt5mHkq2W2PWe/Uauae7F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVPAAd7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29B26C433B1;
	Fri, 16 Feb 2024 12:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708084827;
	bh=67gMBEW7q8oBFF0wsQh1UGQcPSIpumcE7ZLCG2vgJeM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QVPAAd7UEtZUucagZYwOkAk43Ms1s1cvRuKHzMwM6vT54FVAZzSKFH0yPZs7Tmhha
	 oBVdcmiVA+2FPqJbfOg2D/RrTkB+AEP2UczBb3bQJeAQx7uTf+a2MAwYh629Tn/J0V
	 6vvjQLE9AR87KJ+uaqtfOYTKiNUdVRmfp5l7Bzh9cBgE7HCcgyh7ptpxx/xs2j6rHf
	 lwvA4P+xpOwVjgKqA7oRuSNflpCYUbmcy8FVhtHr+E7gKJ2j+8nZuRhsEIkRuvT3QL
	 x73044vwr5m4fquTfHA5/reefgo5xjprjfu3uyvlADaivO+vLYuLeIrWakWo2TNAFB
	 VJnJt4r1/XHOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09772DC99F1;
	Fri, 16 Feb 2024 12:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v2] net: phy: aquantia: add AQR113 PHY ID
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170808482703.6309.7552300533592846345.git-patchwork-notify@kernel.org>
Date: Fri, 16 Feb 2024 12:00:27 +0000
References: <20240215153010.2129-1-ansuelsmth@gmail.com>
In-Reply-To: <20240215153010.2129-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robimarko@gmail.com, rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 15 Feb 2024 16:30:05 +0100 you wrote:
> Add Aquantia AQR113 PHY ID. Aquantia AQR113 is just a chip size variant of
> the already supported AQR133C where the only difference is the PHY ID
> and the hw chip size.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: aquantia: add AQR113 PHY ID
    https://git.kernel.org/netdev/net-next/c/71b605d32017

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



