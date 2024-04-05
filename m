Return-Path: <linux-kernel+bounces-132332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F182489933F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A614C1F2249B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3591117BDC;
	Fri,  5 Apr 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4KOQAZO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755DC142;
	Fri,  5 Apr 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712284830; cv=none; b=kXmu2I+cd3xiTTIUlFQDNG6rUiblxFHJQHgQ3lMQcGKO7fzqXsrDTXC5N8B6gOJDtqwIau/WTn0m5hbT6OWcT9vHiXZhZR8Totqzp3MmTsiUpRt7Is4F4kCEN1M34FL8XjeCJMohMojQiEAE4vzvXrmMH5HSjf+hjDapUxMKJp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712284830; c=relaxed/simple;
	bh=Axh9FcoK3VYcCgrbRb02lLAG5Sv0+YQdR5I1p+8CItQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YSe9r/nG5YU904CdXPISmyTR5XMZ5Op9QxueLNEDLcsZC+ig8VNwsrPqgvlg2LDvbDTS+DJ+NnZLISUumCUUpy1xCFsh5lboQ1RF4MDAVz0pL7i6juodFdQnBiqyO1aESFRUcofz0bO6h6NeA98EobxUMqgrAfsZrDUZiBBdIXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4KOQAZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3780AC43399;
	Fri,  5 Apr 2024 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712284830;
	bh=Axh9FcoK3VYcCgrbRb02lLAG5Sv0+YQdR5I1p+8CItQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T4KOQAZOhSgZNcQ1dJiyeze9QmmAuEhT9hafKGlnPvNPyhSXznSPVYm41/n2QzEpt
	 Mwhe2Zx3fRvqTZ54Ovqt9ABBHHL82/6mCB011Gqip2IIaqp0ejh+aUNpn0S0amQT67
	 L4JmLyhZPVFmaMllQbIegnJ2j1/ALjb9pEN+vstN5uS5o+hFB8hQRJDQ4nzAwr7wyk
	 fgCEkdwMODxmfDnQtXCGEsgQqKEgPs2Z8/j5V4dG8NThJ5/QPibxt3c7fGCiFB6G/t
	 uujN2vHeENtb4/sLWaHqCgC4WU17EtADBKgOf46hh4yUjIMZ14cridMY1R6R9NNCLX
	 32uq2aqKlcPRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18928D84BAE;
	Fri,  5 Apr 2024 02:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/1] Add StarFive JH8100 dwmac support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171228483009.11871.14072192832057973325.git-patchwork-notify@kernel.org>
Date: Fri, 05 Apr 2024 02:40:30 +0000
References: <20240403100549.78719-1-chunhau.tan@starfivetech.com>
In-Reply-To: <20240403100549.78719-1-chunhau.tan@starfivetech.com>
To: ChunHau Tan <chunhau.tan@starfivetech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, kernel@esmil.dk, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, horms@kernel.org,
 bartosz.golaszewski@linaro.org, ahalaney@redhat.com, jszhang@kernel.org,
 u.kleine-koenig@pengutronix.de, rmk+kernel@armlinux.org.uk,
 leyfoon.tan@starfivetech.com, jeeheng.sia@starfivetech.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Apr 2024 03:05:48 -0700 you wrote:
> Add StarFive JH8100 dwmac support.
> The JH8100 dwmac shares the same driver code as the JH7110 dwmac
> and has only one reset signal.
> 
> Please refer to below:
> 
>   JH8100: reset-names = "stmmaceth";
>   JH7110: reset-names = "stmmaceth", "ahb";
>   JH7100: reset-names = "ahb";
> 
> [...]

Here is the summary with links:
  - [v6,1/1] dt-bindings: net: starfive,jh7110-dwmac: Add StarFive JH8100 support
    https://git.kernel.org/netdev/net-next/c/1a9de5646559

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



