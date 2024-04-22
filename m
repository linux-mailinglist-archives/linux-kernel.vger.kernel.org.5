Return-Path: <linux-kernel+bounces-153083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEDC8AC8C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1CA81F218DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AF513DDBF;
	Mon, 22 Apr 2024 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvSEagxl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6080B13D62B;
	Mon, 22 Apr 2024 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777627; cv=none; b=Vu5jnyBGgPtAjP3Z1UAa5mK5V/4vJispzU2n9wiVSI2nSWM/FgMDGNSbZDAScEG4yg8lXUplV0GhWurLz8Bsnn6EBHfSbxziUU4zan0ltuFxp/9BK4hYBeHWXMMhr/YN5dA0SVViDcvUkDipeYNgBISGsE+dVZn6WvAn6DAGKX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777627; c=relaxed/simple;
	bh=UmuAIDX0d6WavQjMlvxXSE1qRDZVx10f8/lRg63pIpw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bXFPI3eOIelIdL+MOiG2d8fvilnsZwfzEhGFPiaAT0Dd/c/kXyugQQIc2R9FB70i3Jm62KnWKmvbZ8YY70cpw1uC6XyYVM1WcManTEHXGDMwXINoepOokPYBdCiudCrTIKIGVdWJr8zevF6oTQOfCbq5ssW5NZ95Gohr5y5yuuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvSEagxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3ED2C32786;
	Mon, 22 Apr 2024 09:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713777627;
	bh=UmuAIDX0d6WavQjMlvxXSE1qRDZVx10f8/lRg63pIpw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LvSEagxlzaeeP8MBfVxl1R5NncafmIBG+R84qxZiazcb8Jr/CZ9MWS2B5o/K9Y3VD
	 QARn9h6PkcpNyJR20u5IT01l2FkgeSqK+KNYj7w8x3OHxbih/61ItaqBGP34My8tC/
	 U761/60ZdarDjJG/4T0PF6N5lZ3VDqX51zl8qPJ2tUuryB9N2juDv06Hng8N0LjMR5
	 rr9umqvPkI3LcRKAWBS/3VaLY7JWF8gQ0fRnxs3bkWwtqb2fGNSz41df3KXRpcMDS8
	 2q5u9+hCxYJ2AAWCUbUZpVqp/+MOsR8lVpmA9Kt8A2CD4dmaAmPvHp4uYSPEo6Pf8N
	 1o7ra8A7dr96Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D26A0C43440;
	Mon, 22 Apr 2024 09:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v3] octeontx2-pf: Add support for offload tc with
 skbedit mark action
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171377762685.9875.10684047694830185564.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 09:20:26 +0000
References: <20240420093505.31044-1-gakula@marvell.com>
In-Reply-To: <20240420093505.31044-1-gakula@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 20 Apr 2024 15:05:05 +0530 you wrote:
> Support offloading of skbedit mark action.
> 
> For example, to mark with 0x0008, with dest ip 60.60.60.2 on eth2
> interface:
> 
>  # tc qdisc add dev eth2 ingress
>  # tc filter add dev eth2 ingress protocol ip flower \
>       dst_ip 60.60.60.2 action skbedit mark 0x0008 skip_sw
> 
> [...]

Here is the summary with links:
  - [net-next,v3] octeontx2-pf: Add support for offload tc with skbedit mark action
    https://git.kernel.org/netdev/net-next/c/6a57f091622a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



