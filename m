Return-Path: <linux-kernel+bounces-103227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D664487BCA0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CD31C214CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12366F534;
	Thu, 14 Mar 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmPq3F5F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105526F060;
	Thu, 14 Mar 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710418830; cv=none; b=DhGVyDf9YtcvaI2FShba/GqNR+x1t73mR2su3WO5uyYKKukdaCyoHwjFr8CI1pWxuSwUxYlt6yvFehPQJ5GUA1NUV11Yx1bGZG29xzEaN1J85T7AUWkspnQ8fhym0paB0ym5ywtld+tk61UUP66uW2XsqppDSRUaDHFbXeESJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710418830; c=relaxed/simple;
	bh=Vlz7xDdbc5gXzzXqPkBq0Ykx9/cXCPwF5Rhr46XvbQ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VD/unxAwdkmet5IseF0QrZM3c6OFZznslyMNdZai0wHTN7Gw7hMDfxxxhYQw80f4z+aS5PscxsddhITw4LvtwpFoC8fy4hagwiF3sQQQ/VEdHcqunVtopxdO8RKAzoIz8IF28J2+TG7v77rzky1V/quQjmF4EQXMR+4kxMiYgys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmPq3F5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B693C43390;
	Thu, 14 Mar 2024 12:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710418829;
	bh=Vlz7xDdbc5gXzzXqPkBq0Ykx9/cXCPwF5Rhr46XvbQ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AmPq3F5FlHynKgxYrxNfDn3vRvAAzE7wBYlV8LNLFPgWD6ph8F2gv3hdzBUvpUbii
	 lPItlmbTKSYp+BMd4BqELI7WixWg6PqME7UjWFz5006QuiBxijR8n25Z4tdQes0DQp
	 q4SpQ7Xl/qtXqRMzvlAXm85VBsQBFtG9h6Uf3TbA6/I6ivJKAwDuWsulMYID0uR0aG
	 4hHzobHv+LZz792YR+6fy08fo5l5Tnrld5Kjy6yy6imkFcbIOUBPE0siJSJ2rNX34t
	 Pnvl3y0Q/PAylcUKOZBhRFrR0xoYtv3b6oQRw8PYxJp3Dm5G1wZ/A1uxkw+E9NIapM
	 D8SJJKuNE4HhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86633D95055;
	Thu, 14 Mar 2024 12:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] rxrpc: Fixes for AF_RXRPC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171041882954.20850.6365451829795236564.git-patchwork-notify@kernel.org>
Date: Thu, 14 Mar 2024 12:20:29 +0000
References: <20240312233723.2984928-1-dhowells@redhat.com>
In-Reply-To: <20240312233723.2984928-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, linyunsheng@huawei.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 12 Mar 2024 23:37:16 +0000 you wrote:
> Here are a couple of fixes for the AF_RXRPC changes[1] in net-next.
> 
>  (1) Fix a runtime warning introduced by a patch that changed how
>      page_frag_alloc_align() works.
> 
>  (2) Fix an is-NULL vs IS_ERR error handling bug.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] rxrpc: Fix use of changed alignment param to page_frag_alloc_align()
    https://git.kernel.org/netdev/net/c/6b2536462fd4
  - [net-next,2/2] rxrpc: Fix error check on ->alloc_txbuf()
    https://git.kernel.org/netdev/net/c/89e4354110ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



