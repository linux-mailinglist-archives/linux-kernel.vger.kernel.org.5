Return-Path: <linux-kernel+bounces-131304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9578985EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE815B2382A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A850F82D7A;
	Thu,  4 Apr 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKl5MP0f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF3C81AB5;
	Thu,  4 Apr 2024 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229627; cv=none; b=GR+E/oLl5PIejgaYasmdz8fewe+52XD7qGis4oMOnjtawwFpTtEJs+vj9rBp7RqWvxRlngQrtNqq2IZP4QYayer27HtF0Ta1CwjtTdiHJLWlyOlHWQzbdlmeaDsFgBTmmom0O+0LuXoj5ir2CY0cWGqFOTy7SfJ9XfUlyhgFQn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229627; c=relaxed/simple;
	bh=uizeStKHDGOmVR+J1SVYeTPjm6UGUaB7epfBeytqslU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NVJ5VcufjgSO0LqG2suCFpEKRd4/6jFIjOlgWK7jkp3vsiFodUhjLZo7fHQsAtWSwoNy5TUZYpeaTyM6JXkvONqvdtjOPZHIvIK6/s0HetTq3H86w3KKQ9hw1qcn3U7oz11lRO1Ke3S7QXUPvlst2xlQMYCkK3L1+Uj6Z6QvQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKl5MP0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69B8FC433F1;
	Thu,  4 Apr 2024 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712229626;
	bh=uizeStKHDGOmVR+J1SVYeTPjm6UGUaB7epfBeytqslU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GKl5MP0fHKQKB0R5/++mmpl+ryHhVzzwDTSOC8jL3Jgsu7ZKNZ0Yi/TcPLhsn9zB0
	 2XIrWmgNrzpjh2YSy1C/JwVohzaCGcwYN52Aj9hZ96Aumj1VEL+bKpgwx19X82HnHH
	 lziyoYE2jaFILJ4KeKbP9ppCbSl6YgKPnIEw0hFeZos3STx/+U7PcdDzx+n59/7BOv
	 rd07a1A1rq2ryxqRsjGAVjrObAxzuaLgXI8cHWiEpIM937aBvHmK4L4wltDO4SGmsA
	 F6TyPbnhIHPdJmLIEkIuccoS3VIRevKqbAy4LoJd+ZUIrQNYbNlOVILE8M2MFVw+Oj
	 rsMuCTu5dH9Gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 548FFD84BA4;
	Thu,  4 Apr 2024 11:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: sja1105: Fix parameters order in
 sja1110_pcs_mdio_write_c45()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171222962634.8594.16340816459676269808.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 11:20:26 +0000
References: <ff2a5af67361988b3581831f7bd1eddebfb4c48f.1712082763.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <ff2a5af67361988b3581831f7bd1eddebfb4c48f.1712082763.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: olteanv@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michael@walle.cc, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  2 Apr 2024 20:33:56 +0200 you wrote:
> The definition and declaration of sja1110_pcs_mdio_write_c45() don't have
> parameters in the same order.
> 
> Knowing that sja1110_pcs_mdio_write_c45() is used as a function pointer
> in 'sja1105_info' structure with .pcs_mdio_write_c45, and that we have:
> 
>    int (*pcs_mdio_write_c45)(struct mii_bus *bus, int phy, int mmd,
> 				  int reg, u16 val);
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: sja1105: Fix parameters order in sja1110_pcs_mdio_write_c45()
    https://git.kernel.org/netdev/net/c/c120209bce34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



