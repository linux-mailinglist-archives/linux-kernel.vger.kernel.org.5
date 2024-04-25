Return-Path: <linux-kernel+bounces-158392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF0D8B1F30
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2371C23F87
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198E51DDCE;
	Thu, 25 Apr 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9L6hE0p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B036D;
	Thu, 25 Apr 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041029; cv=none; b=ZcwCMwIBiOdtGh0/thnZJkniiFd3AACQ7Ky99cJJ/fCc/v33+27WU4ArSwsTQEQkUjFpREDpYkuiXB/XOBaVT1JUMIizj4geT8Ziry7XRFAll60rSN4CX+Hy0SAyxuWVHQRfT1yMvn0O9gimfLaskldXiQhQGy0BmOi8+1UkN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041029; c=relaxed/simple;
	bh=aSnk4tl0PCA0sPVmmyPb/wJFTj+/FjtqDBcLndI6hl8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IKfwJILi/ZZVWbLKQuYoKgJSy86NMgxaJWiQSFb2rkO9Xm/jhiMbnpjqoshXLCqvOjrS1BJMO7h6kpLvy43uDWaZIzfWx+m7KoZ5oziLnQW0Xhe468i4nKcukg2d8j1c5EYwYhEqhiAOFgm5L9gdO3O90WKR1xueIVY8uOa3j3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9L6hE0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4A95C2BBFC;
	Thu, 25 Apr 2024 10:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714041028;
	bh=aSnk4tl0PCA0sPVmmyPb/wJFTj+/FjtqDBcLndI6hl8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u9L6hE0pYWKliO5ohk+06svUmSV8CT+xaBOUS9f7QFBz7XGpoaWejbNjBh6xtcDsl
	 rMyCMJndBv1TiAJCw3hd83051Kvfcx+jdAh4zVS4Jt62Qgba5dExpNbX/sdhrHxqWl
	 fBPLbEOnfjQTVaiQrIfRlbuM9uX2Qh01fv8xKTHsC/9EgRsWA34i2x/Dz/BQ0ZZKfP
	 gRITIn1DRPECkFefCEChkbppLw7N8luR97KTCTWUanLWqZgmWHaewjK71XBgo6hiGy
	 cZs25MWlB7FGk7QbXCTZVnkrKTVMfKDqc6vVl7gH/4rpqmgUMYHGaTU5W9drpT6KDM
	 v+HwGSw27xYYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F19AC43140;
	Thu, 25 Apr 2024 10:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: dp83869: Fix MII mode failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171404102864.28185.819517729147949329.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 10:30:28 +0000
References: <20240423084828.1309294-1-danishanwar@ti.com>
In-Reply-To: <20240423084828.1309294-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: s-vadapalli@ti.com, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, linux@armlinux.org.uk,
 hkallweit1@gmail.com, andrew@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, srk@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com,
 rogerq@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 23 Apr 2024 14:18:28 +0530 you wrote:
> The DP83869 driver sets the MII bit (needed for PHY to work in MII mode)
> only if the op-mode is either DP83869_100M_MEDIA_CONVERT or
> DP83869_RGMII_100_BASE.
> 
> Some drivers i.e. ICSSG support MII mode with op-mode as
> DP83869_RGMII_COPPER_ETHERNET for which the MII bit is not set in dp83869
> driver. As a result MII mode on ICSSG doesn't work and below log is seen.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: dp83869: Fix MII mode failure
    https://git.kernel.org/netdev/net/c/6c9cd59dbcb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



