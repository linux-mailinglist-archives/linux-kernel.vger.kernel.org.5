Return-Path: <linux-kernel+bounces-18865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDCF826427
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 14:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935581C21331
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 13:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760E4134B3;
	Sun,  7 Jan 2024 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0Ldolpc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACE212B9F;
	Sun,  7 Jan 2024 13:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 310DBC433C9;
	Sun,  7 Jan 2024 13:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704633023;
	bh=D0XfO/g3q7ahcqj6C5B4bjONoZE77XKY1fDsb6zfyq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g0Ldolpc0zN14qjZqvf87CA61OD6GpNLbjLw9k/3U2MRh69/8ZtDBMTjOUWBS/gEh
	 ekvMEj3FG6aF9ll6k/61FjCcc1g4mu3L3rwtvwOHkQ6VheFlgn217+LXRu7KxRKsJu
	 It4IYTc3lpp5zdPzlAsl0o7DKjgZTVbSTKwv6X6fQZ1iCwMD8uWGwZPpnIhdTB2f9J
	 2uqHZ1kPSOpAYP17ti95J548nL1dTSYY8GscDo9FvIwnPQfuQH1R7FymQj1/BHQFEn
	 qcDiLWdudtzkZfqRsm6B1LIED69i7Mj9Hi65NAWSqYvRs+vNP2YcOOG6QHpIMjJyRz
	 hTt78KFhBh6Iw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1922AC4167E;
	Sun,  7 Jan 2024 13:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] nfp: flower: Remove usage of the deprecated
 ida_simple_xx() API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170463302309.18403.10179345946425795042.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jan 2024 13:10:23 +0000
References: <de9e2b0be80f92dead2c8c66584bb34b9c95aab0.1704445716.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <de9e2b0be80f92dead2c8c66584bb34b9c95aab0.1704445716.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: louis.peens@corigine.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, alexis.lothore@bootlin.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 oss-drivers@corigine.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  5 Jan 2024 10:10:37 +0100 you wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Note that the upper bound of ida_alloc_range() is inclusive while the one
> of ida_simple_get() was exclusive.
> So NFP_FL_LAG_GROUP_MAX has been decreased by 1. It now better watch the
> comment stating that "1 to 31 are valid".
> 
> [...]

Here is the summary with links:
  - [net-next] nfp: flower: Remove usage of the deprecated ida_simple_xx() API
    https://git.kernel.org/netdev/net-next/c/363096a27f90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



