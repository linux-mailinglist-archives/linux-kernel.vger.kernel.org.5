Return-Path: <linux-kernel+bounces-159032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1A18B2875
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A4528160D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3679114EC58;
	Thu, 25 Apr 2024 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qztlQEUz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792062135A;
	Thu, 25 Apr 2024 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071034; cv=none; b=IZWlU84ycwboG4dZXcaDhT8kvftbUqRXiouq3m0e1VujSznS47YojwylBY92KT5YT/nCCSUS1I+E/bnccefidGVn27CzYW7Pc7Spv5y0jy9cn7FnA+mmxb2n/hUmkgA6ug6mXgCRHrKzFiI52mo0p65QvWBBD2IPqN+Lsq3S/mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071034; c=relaxed/simple;
	bh=kt8WoX1FzFxbm3s2wti1UEz7nEy1w2bo9zkTOhlslRg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DI+oMgfgzz46v+11PEIS2vt09W38aStH4JbtbrtW3WozRpPKrTM6Lpb6qXUaCGK/WmhQ544y3naqAcPazKOCxUckj8T5ISPDIgD3MzeBwOU3eY9G4hdWPbeDd5xdcxUJlHyCsineC7kRg9ipOukj58vOGACRMF8H2p59yBpNxIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qztlQEUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC6E9C2BD10;
	Thu, 25 Apr 2024 18:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714071034;
	bh=kt8WoX1FzFxbm3s2wti1UEz7nEy1w2bo9zkTOhlslRg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qztlQEUzIcGecgUOLaJcIw+pwInH4URPwrWfroNrxpprZeKywT1h4/UO1oEPpx2a5
	 37W5fm8Au5hBjwYAwNCRARExfoqYIqqA1aRu8+yOwHG9/ukbKl3CrKioXVzsn0ugpy
	 AMWB2mPIwPkb/Ls/tTYW2wC6TS/domdxkwvF1hQPBFAj7AgtYNXcTLqk/6LUINk71q
	 Q/i8wmdAxPSLx+8INMISQTICl7Nm8YGX+UX4xVs9GSIgO5mXaCuGQL3U9/ZZeAjhzL
	 PUeyTZcjypSZefDIgKsaIMutWBlsbJWvwyi4cqYm2UwCSYPzixAR4B+gOkTEUtJuTB
	 CTrVS1zjGmqiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF640C43140;
	Thu, 25 Apr 2024 18:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] net: dsa: b53: Remove adjust_link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171407103390.26281.405270567595119985.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 18:50:33 +0000
References: <20240423183339.1368511-1-florian.fainelli@broadcom.com>
In-Reply-To: <20240423183339.1368511-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Apr 2024 11:33:31 -0700 you wrote:
> b53 is now the only remaining driver that uses both PHYLIB's adjust_link
> and PHYLINK's mac_ops callbacks, convert entirely to PHYLINK.
> 
> Florian Fainelli (8):
>   net: dsa: b53: Stop exporting b53_phylink_* routines
>   net: dsa: b53: Introduce b53_adjust_531x5_rgmii()
>   net: dsa: b53: Introduce b53_adjust_5325_mii()
>   net: dsa: b53: Force flow control for BCM5301X CPU port(s)
>   net: dsa: b53: Configure RGMII for 531x5 and MII for 5325
>   net: dsa: b53: Call b53_eee_init() from b53_mac_link_up()
>   net: dsa: b53: Remove b53_adjust_link()
>   net: dsa: b53: provide own phylink MAC operations
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] net: dsa: b53: Stop exporting b53_phylink_* routines
    https://git.kernel.org/netdev/net-next/c/65245197ecec
  - [net-next,2/8] net: dsa: b53: Introduce b53_adjust_531x5_rgmii()
    https://git.kernel.org/netdev/net-next/c/b3d06dc3707f
  - [net-next,3/8] net: dsa: b53: Introduce b53_adjust_5325_mii()
    https://git.kernel.org/netdev/net-next/c/0d18dea4cde6
  - [net-next,4/8] net: dsa: b53: Force flow control for BCM5301X CPU port(s)
    https://git.kernel.org/netdev/net-next/c/93a2579ed08c
  - [net-next,5/8] net: dsa: b53: Configure RGMII for 531x5 and MII for 5325
    https://git.kernel.org/netdev/net-next/c/536e5b2ecbae
  - [net-next,6/8] net: dsa: b53: Call b53_eee_init() from b53_mac_link_up()
    https://git.kernel.org/netdev/net-next/c/888128f360e1
  - [net-next,7/8] net: dsa: b53: Remove b53_adjust_link()
    https://git.kernel.org/netdev/net-next/c/600354352cf2
  - [net-next,8/8] net: dsa: b53: provide own phylink MAC operations
    https://git.kernel.org/netdev/net-next/c/d0a35d2948ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



