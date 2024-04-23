Return-Path: <linux-kernel+bounces-154869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA5E8AE239
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E400E1F25CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD8F64CCC;
	Tue, 23 Apr 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoVuOjsN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A75E17BAB;
	Tue, 23 Apr 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868231; cv=none; b=jUoZeZq7XHtX3fMvs4p7ODuccPvMVwV07zgJzqbUhZ8jErxchH/fBuWIqFim0nzK9b5VYuWK6fFBZFG/esnxYSfaCwHyZCo8UMUfaGl9hGYzDWZzsxNbxA8oyRoZgI3zPRtjS9dXxfliByE7aRQD9a5JK5xDlv9sZTUPEbKZuuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868231; c=relaxed/simple;
	bh=ZpvsKpOC8n9lQ6MW2xPW24HPfDqjR7WKOozGXE0/mVo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n64Hazr3q5qbDbp2PwoFEie/Hf+iNufNNV0vWUHZYOIOYFvFTPVy7gBhGFfQHooKiG/JImM1I4XURqPocEkZXjzWUVeLao8n4JbPF3UgrL6Php5S/sRFRHl5ykr5kHFgCPIb+WF8drBGGddMph44tpT1L5hjHDTbLm0m6bKBf2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoVuOjsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38AB2C2BD11;
	Tue, 23 Apr 2024 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713868231;
	bh=ZpvsKpOC8n9lQ6MW2xPW24HPfDqjR7WKOozGXE0/mVo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AoVuOjsNcliEIpxWNQj6IHjFI37/OUpM+eoLolH5cxgGPRtcnNQqibE52JJ8IPdx9
	 K0cehgY2l/osstWOyTI6ZAtVk/Q9AUbTqyFcqKV76v/UhZt3asNBNm3HlstChknUPh
	 yf7E9A2tt0r5W5RyJs4prIwUjKbQZqd5z1MUzLX63wWuFcy/JpOFA4wepJpBsKlA2x
	 h7cZ/xAEQ80etxPybKFaWEmK9ILe4SHOvjy1JvQ8liosRrdzrULhcXg7BDScTaBiaY
	 j434owkYIJK2aH8HRI/DdMruFQwcdE4KHdgbY4HVHMgA2uFnxpQ5zlvFWuf67GGWNx
	 Ks3T9IuVC5TJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 222FBC00448;
	Tue, 23 Apr 2024 10:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next v3 0/2] net: stmmac: Fix MAC-capabilities
 procedure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171386823113.5282.15525637149577989440.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 10:30:31 +0000
References: <20240419090357.5547-1-fancer.lancer@gmail.com>
In-Reply-To: <20240419090357.5547-1-fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, siyanteng@loongson.cn, romain.gantois@bootlin.com,
 mcoquelin.stm32@gmail.com, horms@kernel.org, chenhuacai@kernel.org,
 wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 19 Apr 2024 12:03:04 +0300 you wrote:
> The series got born as a result of the discussions around the recent
> Yanteng' series adding the Loongson LS7A1000, LS2K1000, LS7A2000, LS2K2000
> MACs support:
> Link: https://lore.kernel.org/netdev/fu3f6uoakylnb6eijllakeu5i4okcyqq7sfafhp5efaocbsrwe@w74xe7gb6x7p
> 
> In particular the Yanteng' patchset needed to implement the Loongson
> MAC-specific constraints applied to the link speed and link duplex mode.
> As a result of the discussion with Russel the next preliminary patch was
> born:
> Link: https://lore.kernel.org/netdev/df31e8bcf74b3b4ddb7ddf5a1c371390f16a2ad5.1712917541.git.siyanteng@loongson.cn
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next,v3,1/2] net: stmmac: Rename phylink_get_caps() callback to update_caps()
    https://git.kernel.org/netdev/net-next/c/dc144baeb4fb
  - [RESEND,net-next,v3,2/2] net: stmmac: Move MAC caps init to phylink MAC caps getter
    https://git.kernel.org/netdev/net-next/c/f951a64922a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



