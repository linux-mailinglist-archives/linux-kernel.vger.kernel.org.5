Return-Path: <linux-kernel+bounces-107702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29198880073
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE25CB20FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D7B657AC;
	Tue, 19 Mar 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg9pCQWt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F462818;
	Tue, 19 Mar 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710861628; cv=none; b=DehY8O5f5Iph0JJM6RL+THZo2V9qfrZcHgu5P+0wWVxZ5M1uZVRC+6SSIOUfCz4PSdToFTz8L+ppZNfJdD4Ic0k015xfdvVNnff62cz43magN3jN3hRGyAN2mS5rLwBAthih2nJrvp4oSA/mazZCCruLlsoEgDAyeSQyPXbhhnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710861628; c=relaxed/simple;
	bh=nNmQMr4qsJJT45KeaczDshMR3IsjHUY1Z8kaEgKlOGE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qKCoONy5eYLfp7eSWLpdB6o/N0v6aRNz04r2fWGMbMsLALTiXYBzF7WxnZZE6BjUdFG1iPlkhANOAwfRn+pZ+eSYscwLl1y4RDyNIVEPSJzYifOXZdAUv5LbjcXLQgJdAsLgPeF5xL/zMSpvgvXA7/Cwbhnka1OeUdM8Tj2Qa0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg9pCQWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D232C433F1;
	Tue, 19 Mar 2024 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710861628;
	bh=nNmQMr4qsJJT45KeaczDshMR3IsjHUY1Z8kaEgKlOGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jg9pCQWtVVM3NDofDz8skdPZLZ5oaNmO8n1Pr67BbeqKVjfuD50HS0VC9099bCYhi
	 n3BFOps6wT55TCy0wSChdmlgPzsEG64I2iVGHCtfpULVi1Z234Z90oY41zFW0iSnxQ
	 l/iHv5bT0+tkUrZEEsnekjId0fGdbHIXlqyjyGPnUpyR8cYuv5LJ872tzs8ZnHpJ7v
	 vuqEz6LpUDqUCO4OlgbpRHf5eDKvF3bLZ6YfrEnVEFo3hwTBF/mnnUeExPUtHJVNfW
	 FAuWEKVfWUVQD8u1oF0NNaiBWyeGTn6oCHxwefWEeRmT46RNu0RDmrCXKQs2K2buby
	 oa/ZIvBywYYbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 057AFD84BB3;
	Tue, 19 Mar 2024 15:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: fix phy_read_poll_timeout argument type in
 genphy_loopback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171086162801.23936.5209926422558321847.git-patchwork-notify@kernel.org>
Date: Tue, 19 Mar 2024 15:20:28 +0000
References: <20240315175052.8049-1-kiryushin@ancud.ru>
In-Reply-To: <20240315175052.8049-1-kiryushin@ancud.ru>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 o.rempel@pengutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 15 Mar 2024 20:50:52 +0300 you wrote:
> read_poll_timeout inside phy_read_poll_timeout can set val negative
> in some cases (for example, __mdiobus_read inside phy_read can return
> -EOPNOTSUPP).
> 
> Supposedly, commit 4ec732951702 ("net: phylib: fix phy_read*_poll_timeout()")
> should fix problems with wrong-signed vals, but I do not see how
> as val is sent to phy_read as is and __val = phy_read (not val)
> is checked for sign.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: fix phy_read_poll_timeout argument type in genphy_loopback
    https://git.kernel.org/netdev/net/c/32fa4366cc4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



