Return-Path: <linux-kernel+bounces-125347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1C8892467
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63AD1F23468
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3724313B2BE;
	Fri, 29 Mar 2024 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrI+097s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1E213AD38;
	Fri, 29 Mar 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741233; cv=none; b=aF+b8/D2kJ4CmMiAbWn5pMamNm7zVxKXk6bd60EvWNE3r2LnDYYTMrJMYu6ZuKVwiwcAq3v5ybjO6yq7ogN4jLHTK9bRgOvmQKQ+vXHDNxJHaV4mEHdCUnU0npe4W8UQDgqEwrJkTsNq5dkJIRYN46+3H79Qx/R65qQq8Mr0muc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741233; c=relaxed/simple;
	bh=gGnJi8XEFB3O4myFpH6rYsRc7+0t11j655/w7tLh4U8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iI+o5EgWAhIcqLDZumtIwFn+iL8HTKETkZLCGnWvZp5qd29s59iQRUXFZJShStcd+J1scotDcmST4ECNX9mh/mjhyx6N22uezmKdBPhCXIQSc69b2z4zrJe45Cs3C0smKl85f2ktK9JNAt/19yBXNOEWUyVNyPEhfTgq9vv4RiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrI+097s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C108AC433B2;
	Fri, 29 Mar 2024 19:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711741230;
	bh=gGnJi8XEFB3O4myFpH6rYsRc7+0t11j655/w7tLh4U8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MrI+097sJ/rFgRAtSx6QrEBZF8KMYANoFGq8wdCTQOhqjQKsldqak7SUse7zBtwuc
	 Edk/NeEUMltD1On9lktYz2zsWTepB7wiLtb1z2r2Y4rwQ0/phy5VrGMDdhWLJ9OKJ/
	 GoaAb1Aa+Pg9/41gFeV9MjZfuq1fmKdpU9uel+jfxLGRiJZWdmHknSXj7METRZISGV
	 NcwsGqdl5QQrPQSq4WurNOR3olYGrwAszCn8FkLAEND3K6QGRUBmNPMvATOIQu3DS0
	 Y1la4H+4v9atvl8FlF7TVUCpxbdm3k+BPiOBWlj+gpdVzD2OdoIU+PitTL2e1/rvYm
	 SiYHwzy5CzSkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6210D84BAF;
	Fri, 29 Mar 2024 19:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/4] net: microchip: encx24j600: drop driver owner
 assignment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171174123074.26003.8118027754124064179.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 19:40:30 +0000
References: <20240327174810.519676-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240327174810.519676-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Mar 2024 18:48:07 +0100 you wrote:
> Core in spi_register_driver() already sets the .owner, so driver
> does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/net/ethernet/microchip/encx24j600.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next,1/4] net: microchip: encx24j600: drop driver owner assignment
    https://git.kernel.org/netdev/net-next/c/648bb2bf444f
  - [net-next,2/4] net: wwan: mhi: drop driver owner assignment
    https://git.kernel.org/netdev/net-next/c/343941206138
  - [net-next,3/4] nfc: mrvl: spi: drop driver owner assignment
    https://git.kernel.org/netdev/net-next/c/e3c95d56190c
  - [net-next,4/4] nfc: st95hf: drop driver owner assignment
    https://git.kernel.org/netdev/net-next/c/e93af7228605

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



