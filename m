Return-Path: <linux-kernel+bounces-77703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6CD86093A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B081C21E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1C4111A4;
	Fri, 23 Feb 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8Ht98pZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A17DDB1;
	Fri, 23 Feb 2024 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657827; cv=none; b=mSkBr0cAwNoFS9T2nGrTcKGmuaVw0hwA2s/tO7ViUMitWw3nazKKDqA3PATXATZoiPAESIjj9JH9hnm8UYW1zzpVtM7rd9gi6o77e6kdmhS/rWWlfAN7ELZ6sjgB89qv026Nc9jR5MHA6eBExtaQqPc0SWAGesH9R9cwSJhDEcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657827; c=relaxed/simple;
	bh=Ultwqvcq0n9E64Qm0Fs/sVhHWX2pgxkPlYGksBDhg5Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hbsLGJFTNBmEwmoZqemkZeM77ERO4vMh3ITYTCnp9pOSihRgbDs9wMqariab6iGk4TPyvEs4NUSYzNf/iHOI2YORK2MsVRkfQganhWSDnavlB93GdlPW4gxANnPJHDxMYi7pvpfoRuSjgqKqhkkLugKNFmCuntPgIn3KaUXmpo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8Ht98pZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 162E2C43142;
	Fri, 23 Feb 2024 03:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708657827;
	bh=Ultwqvcq0n9E64Qm0Fs/sVhHWX2pgxkPlYGksBDhg5Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W8Ht98pZdGZBEStFd3TvJw8bIaLW7h87cqmaJAhKMtwzhen+a/8hTJ+YN2jTGGYpU
	 tVaZ0x/oEb1amGLndOKXpe+YxdOHrVof0s1+lgcWhP7Rqra+6SsFOAMo+9IdPSSmcB
	 qyspMcnogSosz9BzLula8aKB3Vlhs2kgJX4EQSiecmfyvg0yCQFH/FtOsZUEiskOoR
	 fImZnEKwaj0j+oKYuP1PIeBOIhXojYKO0l8OtCmvwVdLv7y3fURktZ/peJSf4avfGs
	 e0TIrEWq+GzgnKjt42zRNKHJ7KDzy+Im4Hn7oLn4egCWjZ52ZMm5A6JGuwhh1weWdO
	 HuG2v07nV53EQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC457D84BC0;
	Fri, 23 Feb 2024 03:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [net-next] octeon_ep_vf: Improve help text grammar
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170865782696.16544.7241037943109179618.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 03:10:26 +0000
References: <b3b97462c3d9eba2ec03dd6d597e63bf49a7365a.1708512706.git.geert+renesas@glider.be>
In-Reply-To: <b3b97462c3d9eba2ec03dd6d597e63bf49a7365a.1708512706.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: vburru@marvell.com, sedara@marvell.com, srasheed@marvell.com,
 sburla@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Feb 2024 11:52:41 +0100 you wrote:
> Add missing articles.
> Fix plural vs. singular.
> Fix present vs. future.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/net/ethernet/marvell/octeon_ep_vf/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] octeon_ep_vf: Improve help text grammar
    https://git.kernel.org/netdev/net-next/c/bcc115760ff3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



