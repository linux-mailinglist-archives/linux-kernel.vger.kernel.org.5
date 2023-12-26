Return-Path: <linux-kernel+bounces-11709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF7F81EA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 23:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB511C220B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 22:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EFBF4E4;
	Tue, 26 Dec 2023 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7bHMgG2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A385240;
	Tue, 26 Dec 2023 22:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F25DDC433C7;
	Tue, 26 Dec 2023 22:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703630424;
	bh=ryDm7pOT+r31LU4XL/GCtTXYbzQxJsxoJjvSmPDjus4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t7bHMgG2lLbyUuF+1Yc3xWuncheq6o8G9xI8krL5UUno3uc6BjaSPKS/WOXYMitiR
	 YMYwz7cNoS+X7ZGHfOZPi8g7lvhCYm8v/nPpx1VbpvEPd4cSXgDcEAqtSy8KyqUOGN
	 kS1E8VjhHHaKBTgMe9ZnQhNOBzXNP4sdYBalxN1X32EEGbg8/xTUgYmlMuklg1XD2k
	 GoyiW1DOD7voZxyQKn9H/BcWquLHXrY7Ab9XqpgI/xTkaD7wUjqzcW7Uo6A+SUenLn
	 xyYkZoccbY9B3XwFQabnwUkpNcNmFAkkgBOieZSKBNUQU0OsQr8ET5gNTWMkzKrIef
	 M1BOrkS31HZlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6880E333DA;
	Tue, 26 Dec 2023 22:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] bridge: cfm: fix enum typo in br_cc_ccm_tx_parse
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170363042387.9770.16551926898239856386.git-patchwork-notify@kernel.org>
Date: Tue, 26 Dec 2023 22:40:23 +0000
References: <20231220163451.2720130-1-linma@zju.edu.cn>
In-Reply-To: <20231220163451.2720130-1-linma@zju.edu.cn>
To: Lin Ma <linma@zju.edu.cn>
Cc: roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horatiu.vultur@microchip.com, henrik.bjoernlund@microchip.com,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Dec 2023 00:34:51 +0800 you wrote:
> It appears that there is a typo in the code where the nlattr array is
> being parsed with policy br_cfm_cc_ccm_tx_policy, but the instance is
> being accessed via IFLA_BRIDGE_CFM_CC_RDI_INSTANCE, which is associated
> with the policy br_cfm_cc_rdi_policy.
> 
> This problem was introduced by commit 2be665c3940d ("bridge: cfm: Netlink
> SET configuration Interface.").
> 
> [...]

Here is the summary with links:
  - [net-next,v2] bridge: cfm: fix enum typo in br_cc_ccm_tx_parse
    https://git.kernel.org/netdev/net-next/c/c2b2ee36250d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



