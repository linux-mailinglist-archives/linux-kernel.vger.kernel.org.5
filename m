Return-Path: <linux-kernel+bounces-131838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AAC898C5E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB97528B1F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8962127B5C;
	Thu,  4 Apr 2024 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKLxKWaX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FDE1862F;
	Thu,  4 Apr 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248831; cv=none; b=romiO2weP2/j95tXaNA69XYswfJi50pogK6crRKceovu1lAzE4k8zHV4lJJgTtY0e9J8uuZfQQzXm/0vWJCjSVBmgNuuJJ7G3ZQeEcPKbTSZzuogXSmIo2r7zGEC4AxMt1qfd3WbhzZ3NKkeQGLJ4I8gtRQjIla6TXG9El/qVP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248831; c=relaxed/simple;
	bh=NDcTO6ryp12wsBd5oIpZdw/H8fCBPwWYXGzE2tqxxKY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oMuReSzieOzlB0et3VqGeSPJjV7uFjrjX8eWeNa693pf4azAdtn6E4460uisfO1OCGQjbzp7KLrEQZZsJQS6hRTjhd0F34QSkaeNPqVUrP/VNi6Gmw+l/18b4tvw6KAgb2nenMbxTbAK0c0tFK9g9Cg/FBIfLKz7Z9ztvLtVnVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKLxKWaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A58D9C43394;
	Thu,  4 Apr 2024 16:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712248830;
	bh=NDcTO6ryp12wsBd5oIpZdw/H8fCBPwWYXGzE2tqxxKY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WKLxKWaXvC/da1X4T1YzNj/Sf8tuEo4IosuZssveerUwuwdlgIfynCX0A+8gX/koC
	 ChnaFk9SYl667aFTjq0JtoLQV02haVv6wLXKpKlso+p8sVRT068j/24GU/qojbZQPw
	 pFyuBeuB+fh23sZjYyxAtrTYLWt0gHMMn33v0T4A4bQ9HpzT74oFRbjPmdQANviBLq
	 n4Dx0xc08IXabJXvUiEPn439wfPpWHRpyi8n/ZsRJETdKtfHwYweIw4GCNed6I81LQ
	 qiORyGPHUK7nK/aQaSa+s3Bp3NjA+NlJ42uXCPvIgrNaRA1z70m0o9ddPb/0dsaUCP
	 U/k1E8hVVE6oQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94697D9A155;
	Thu,  4 Apr 2024 16:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: usb: ax88179_178a: avoid the interface always
 configured as random address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171224883060.6883.2513876662318355261.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 16:40:30 +0000
References: <20240403132158.344838-1-jtornosm@redhat.com>
In-Reply-To: <20240403132158.344838-1-jtornosm@redhat.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: kuba@kernel.org, dave.stevenson@raspberrypi.com, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Apr 2024 15:21:58 +0200 you wrote:
> After the commit d2689b6a86b9 ("net: usb: ax88179_178a: avoid two
> consecutive device resets"), reset is not executed from bind operation and
> mac address is not read from the device registers or the devicetree at that
> moment. Since the check to configure if the assigned mac address is random
> or not for the interface, happens after the bind operation from
> usbnet_probe, the interface keeps configured as random address, although the
> address is correctly read and set during open operation (the only reset
> now).
> 
> [...]

Here is the summary with links:
  - [net,v4] net: usb: ax88179_178a: avoid the interface always configured as random address
    https://git.kernel.org/netdev/net/c/2e91bb99b9d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



