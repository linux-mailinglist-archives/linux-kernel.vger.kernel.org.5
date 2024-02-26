Return-Path: <linux-kernel+bounces-81449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB25786761A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8775728DBDA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AE880C05;
	Mon, 26 Feb 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iM4EEFJF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BD780042;
	Mon, 26 Feb 2024 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953030; cv=none; b=ASPdp5lqlZ7xH8VAtWzbmiPv7lphkPI2Sr2eUvIZ3S7zrWvDyQxA+QGup4Zl/x4LsJC2o41on2rgG4liXOCDGoVHEO1YZqlgRz9qndf2Lr1siEux7AsOEsey7ZKo6pvxAnIPrwSyFqF1wMJl+eXS2Kmiv+01Fjmk6IgYgy0021o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953030; c=relaxed/simple;
	bh=2ZRKSz20uf5qtYVZ+ImiTNm8ZkqunWH4zizwS91rpTk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hVePZvnRzn3s4610UXqbR1PDcLx0CIoWxzeTbz0RUvT/JcHDXayq3tcerk0oo2epBwmLTwMg6iuyeqfaDg7ktvJUmnU/DpyjPy7EbflH85hZUpnpRP/1Q8HGOnTgimHtPhcGbspkIL/csBOBAwa6KJxIxP7TacfVaKCZ+fQHPXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iM4EEFJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80DA3C43394;
	Mon, 26 Feb 2024 13:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708953030;
	bh=2ZRKSz20uf5qtYVZ+ImiTNm8ZkqunWH4zizwS91rpTk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iM4EEFJFBV8tLm5uGeIlPbUxkriGewZWbytfqsS5w2OMj2oj3gBp5vBXXfFsmFw4y
	 Ku6j1BLjTv/6dwHPPy1aeefoEwKmG7CLATltXDpFqlTzeNnkEjk0+K92b7cUuUrri/
	 sviGVz3mgFieH/Ubpjr14nueN/mjQHJ9sz4YjOa7dvuYR/vp58skgRiTnCDpODGxmg
	 ySMkAzJ+IEfOsLz1xsLuc0h/k6PpGMCZnS67yuD4TsrL/PrIcEPvTWUAb14vkpRxXI
	 D9hrhJIK/NrZp7G1Q3Vg7btNajKM7mvfHTYqImxN3UIkmj399xul6y1N4KbTql4qpS
	 ZEQZvs1sp4PrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 617DFD88FB4;
	Mon, 26 Feb 2024 13:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net: pcs: xpcs: Cleanups before adding MMIO
 dev support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170895303039.847.5849181262053799577.git-patchwork-notify@kernel.org>
Date: Mon, 26 Feb 2024 13:10:30 +0000
References: <20240222175843.26919-1-fancer.lancer@gmail.com>
In-Reply-To: <20240222175843.26919-1-fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: joabreu@synopsys.com, Jose.Abreu@synopsys.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, kuba@kernel.org,
 olteanv@gmail.com, maxime.chevallier@bootlin.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mengyuanlou@net-swift.com,
 tmaimon77@gmail.com, jiawenwu@trustnetic.com, alexandre.torgue@foss.st.com,
 openbmc@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 22 Feb 2024 20:58:19 +0300 you wrote:
> As stated in the subject this series is a short prequel before submitting
> the main patches adding the memory-mapped DW XPCS support to the DW XPCS
> and DW *MAC (STMMAC) drivers. Originally it was a part of the bigger
> patchset (see the changelog v2 link below) but was detached to a
> preparation set to shrink down the main series thus simplifying it'
> review.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: pcs: xpcs: Drop sentinel entry from 2500basex ifaces list
    https://git.kernel.org/netdev/net-next/c/0ffc3292c02b
  - [net-next,v2,2/4] net: pcs: xpcs: Drop redundant workqueue.h include directive
    https://git.kernel.org/netdev/net-next/c/e26802ebd295
  - [net-next,v2,3/4] net: pcs: xpcs: Return EINVAL in the internal methods
    https://git.kernel.org/netdev/net-next/c/f5151005d379
  - [net-next,v2,4/4] net: pcs: xpcs: Explicitly return error on caps validation
    https://git.kernel.org/netdev/net-next/c/361dd531a11b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



