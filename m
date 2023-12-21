Return-Path: <linux-kernel+bounces-7958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFAB81AFB0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577EA28832A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B38117748;
	Thu, 21 Dec 2023 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2S5WYQV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8A156CB;
	Thu, 21 Dec 2023 07:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 688BDC433C7;
	Thu, 21 Dec 2023 07:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703144423;
	bh=oPCPg3Yq/bJZ51N/NJP3XHeREjgOGUpAA3IBR2Tegmo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n2S5WYQVP+STasWR/xRCW1x4E/jG1aIe5qVmDndRCpl90+xl0JkhljqP23CcsiREH
	 wJyT4ERSFQbHROM8mzUOyUK03QtjOXS2FiXqYY31O7vQ4M26WnPlduJ3UflCiHI6MN
	 e3Y0TxICQM75gwcArqZGpLnyJy4aLOmO5D4xJ6Fqm/qxR5AnKEeK6fBLkXL4MGA8KV
	 IvIo3RRO8x3OOp6sSiPEQdbk/aG8QwCtwrUw5z8/9b4qev/kRX8kq4eTDMzNzJFYA1
	 HYcAOPBvJaweWDfpwDYdu2UTEQcJmyRc9tcYKVdB9n5K99hXtTaICzesKlyoYFzLvx
	 QfQwKExrhinOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A04ED8C988;
	Thu, 21 Dec 2023 07:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: avoid build bug in skb extension length calculation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170314442329.7814.1959861244056655649.git-patchwork-notify@kernel.org>
Date: Thu, 21 Dec 2023 07:40:23 +0000
References: <20231218-net-skbuff-build-bug-v1-1-eefc2fb0a7d3@weissschuh.net>
In-Reply-To: <20231218-net-skbuff-build-bug-v1-1-eefc2fb0a7d3@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lkp@intel.com, arnd@arndb.de,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 Dec 2023 18:06:54 +0100 you wrote:
> GCC seems to incorrectly fail to evaluate skb_ext_total_length() at
> compile time under certain conditions.
> 
> The issue even occurs if all values in skb_ext_type_len[] are "0",
> ruling out the possibility of an actual overflow.
> 
> As the patch has been in mainline since v6.6 without triggering the
> problem it seems to be a very uncommon occurrence.
> 
> [...]

Here is the summary with links:
  - net: avoid build bug in skb extension length calculation
    https://git.kernel.org/netdev/net/c/d6e5794b06c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



