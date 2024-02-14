Return-Path: <linux-kernel+bounces-64989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FB7854646
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB08284BED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FACC13AD8;
	Wed, 14 Feb 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfE9hlrx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E4279C0;
	Wed, 14 Feb 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903627; cv=none; b=L5jQmvs2ObHggG1naN+w3yt53IpCeJnrJbcBpcSmpCWqcBLjKD5KjZGpBiuY/6B1z/jGNe+9yPfiVo10fxOEgP4D9FXwuomfbkHnl+zTkHbEVH9jX0gwKp7Gw8zw+0I3X3kBh4H93KgGo0mDWUdEnK1jkcMYr2nXMumBwk49RIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903627; c=relaxed/simple;
	bh=vWTvUiuKtN0jgQdcjInK2WPJO03oUyX7nKQGUB7qGMo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VbWHUktui8Ynl7Gb2m0x1ewpUysfxAOr8l5Tb0lSzbqzNIfH7vFlkd7PwoDZAI2W8nDlFDNhQ/raxdk3Fat3CyFNoF0cOyXX1UgecRbWibTC9PpExfeOOekKlCYpdSKGukY3OKAuXb5i4dDeKvyMA7PkI4Kw4bzM3f3DwImAIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfE9hlrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28FE2C433A6;
	Wed, 14 Feb 2024 09:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707903627;
	bh=vWTvUiuKtN0jgQdcjInK2WPJO03oUyX7nKQGUB7qGMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cfE9hlrxIFiTORgHHxAvSqs1WerT4My5QhD9qN0pv0Wpv8Uv+Ck1XucQ/rubw6OYt
	 c2QPSs5yiXslNs+WCEmmGlrHwmcmbR3TZYEIbzMStsDEqQZPixgx/zPpcoNY79bI4D
	 rigMVXUzPRRmfHb0Bu2Y/OfJ7jv2/iP8+HAHCqfYLHllGP7bkEZOfk9asxmPNqjQH6
	 gKju1GhJC7/YbxMS/PilJvUYqwsaB8iknfKXgfQIcGDEjM/2CChSEYNadkqbQxaHNA
	 LGNCVwBsMqkahnAa2nsSP3124aA4xj4qpns/g3UArPeI1VqIvDC1n49ax3y1WoNMFS
	 i4svfb7t3VBDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D5E0D84BCE;
	Wed, 14 Feb 2024 09:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: Remove the PF_FUNC validation for NPC
 transmit rules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170790362705.30474.13042133604652078072.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 09:40:27 +0000
References: <1707678038-13062-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1707678038-13062-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, naveenm@marvell.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 12 Feb 2024 00:30:38 +0530 you wrote:
> NPC transmit side mcam rules can use the pcifunc (in packet metadata
> added by hardware) of transmitting device for mcam lookup similar to
> the channel of receiving device at receive side.
> The commit 18603683d766 ("octeontx2-af: Remove channel verification
> while installing MCAM rules") removed the receive side channel
> verification to save hardware MCAM filters while switching packets
> across interfaces but missed removing transmit side checks.
> This patch removes transmit side rules validation.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Remove the PF_FUNC validation for NPC transmit rules
    https://git.kernel.org/netdev/net/c/858b31133dbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



