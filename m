Return-Path: <linux-kernel+bounces-77702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCCB860939
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A5C1F25326
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EF211197;
	Fri, 23 Feb 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJD3OGCm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F95DD510;
	Fri, 23 Feb 2024 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657827; cv=none; b=WmKuWWDrwES7H4NZLlj1s8bYH+2N6Wq1UypGaMkAaliXb0O+6wN9XzMJGvmzr0Y/k9j1E9TkP+6bq91w5GI68miErHs4cwm0pkZ3FObl30bSxRpgz8Y1P5EqJrUKh1s9igKtVw6/7KtDwThpvIz80oEO3Rb2vW7Du8bR//zLmHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657827; c=relaxed/simple;
	bh=faycilTshPbB6YjAlC7Ll0g1SDl1TVKUCVVTQuh3x0Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FqRDrjMxZYIRpVgQNPatmgbK2vBNuUEAa3qCgQQxsFZPEJXvSv9h08duUJ4SJnjZiHBGJMjv1Q6aiJ8AJnw2Gq/vlex5NaTnMj72pILLuxyM/ME48ItYNRLojrJPnP9p8pAHKfTBtxoyaet5wx2hWRoNvBaONSw94561c4SF6gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJD3OGCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02835C43394;
	Fri, 23 Feb 2024 03:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708657827;
	bh=faycilTshPbB6YjAlC7Ll0g1SDl1TVKUCVVTQuh3x0Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PJD3OGCmS8EIuILXngOLqxPnHjmX5Rz25Ep2lhnpDV2QchEF8v167ABRC4aXh/6O1
	 1e/1vLITk1YUTd4NKXBd9CwTNbmegFPlAydg8snzS9lEloyywsUUzXLwD/skDiyQZJ
	 iraFt+/h1Nfaq9xXss/sBOBBR3ToQlReOiUQmNzqc11h3+RplJx9jWln4jcXpchNm3
	 xZe2+mlNYjHSeLRDZh0TpJIk17tMnz7+620G2sy2lSkn0xILQ9691bVo9ijMByd5DD
	 dZ4wsvE8MuW+6gUQVP1KnCL8syPTZafFy3XT0QPdMaZhAg0w5yvHPZLhyXNxn9WSXv
	 HWpHYNE0bmJ5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4CE5C04E32;
	Fri, 23 Feb 2024 03:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: microchip: lan743x: Fix spelling mistake "erro" ->
 "error"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170865782693.16544.30761697624612779.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 03:10:26 +0000
References: <20240220091737.2676984-1-colin.i.king@gmail.com>
In-Reply-To: <20240220091737.2676984-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Feb 2024 09:17:37 +0000 you wrote:
> There is a spelling mistake in a netif_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] net: microchip: lan743x: Fix spelling mistake "erro" -> "error"
    https://git.kernel.org/netdev/net-next/c/cbe30f99431d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



