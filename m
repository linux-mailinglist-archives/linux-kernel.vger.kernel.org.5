Return-Path: <linux-kernel+bounces-154048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B32C18AD68E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7BE1C2186A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5835A1DFF8;
	Mon, 22 Apr 2024 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tm1b9YqI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961591CAB9;
	Mon, 22 Apr 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821429; cv=none; b=Q7bRPxh8yEwYIVECJ13bnQDMFS4cs5PvEnpJF+lv/AZ0N1hAZcaLgElxx9/VEDqPa688HhytXq7PesZL2fnR4+HSMpI40eJ+2QxPdZMswfgqpKzezGU2c+MnFGvWqM1Du0XNREiBvSo8nezqP7mVwNK7C46x9o7b0U6oK5hd3a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821429; c=relaxed/simple;
	bh=+MWDh4eam1mec7YkpjYmojj0wm6twFqAbTY7wxEKGxg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EMxK2clQ7f3ZsfDDuDPZKD2oliKh3C77GrYr95VaV9+G5Codb1WwpJALFjm9tumyYcDSqOIdQL9imZ2sApoV234truk78Yijzl65siWisZSxhSetJFimTiC5zFKgL012TUB8R2dzgolLUnEoD3Cr84SDHNAT6yxAb6VRPl5hdI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tm1b9YqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30031C2BD11;
	Mon, 22 Apr 2024 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713821429;
	bh=+MWDh4eam1mec7YkpjYmojj0wm6twFqAbTY7wxEKGxg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tm1b9YqI/m5bnQY6lWhSzYJqnahgKyXaRTYJAdahs40lAMMcmZhgH775gKe+DIguq
	 Go2jiXbEF0DkDQvOq2qRaMORMMN9XjNw628K02fygYwi3e8gXMyT0Bw6/WfWoAEjpJ
	 UbyL50WZBtmqCr2Hoc3cYEEQn5AzaR+7qlcIosuPstYVvkl17sLxD5pDoUcUZ3+SeS
	 ud5KhudroduD/fuzsDJxOgfxxUa0ECrfoCMA9MxR3J2a5gJkJK+MJbIXxpPunbbMWB
	 oYoL1tgszcTV+se6YkvV/SaDch6DtaEdtNT4XCn3CYbnZGA0Tv++aKAyTsJ4Rf1Z9P
	 bVIRODx5CrgvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1319CC43443;
	Mon, 22 Apr 2024 21:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] net: dsa: vsc73xx: convert to PHYLINK and do
 some cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171382142907.1995.10883580544289239545.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 21:30:29 +0000
References: <20240417205048.3542839-1-paweldembicki@gmail.com>
In-Reply-To: <20240417205048.3542839-1-paweldembicki@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Apr 2024 22:50:43 +0200 you wrote:
> This patch series is a result of splitting a larger patch series [0],
> where some parts needed to be refactored.
> 
> The first patch switches from a poll loop to read_poll_timeout.
> 
> The second patch is a simple conversion to phylink because adjust_link
> won't work anymore.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: dsa: vsc73xx: use read_poll_timeout instead delay loop
    https://git.kernel.org/netdev/net-next/c/eb7e33d01db3
  - [net-next,v2,2/5] net: dsa: vsc73xx: convert to PHYLINK
    https://git.kernel.org/netdev/net-next/c/21fc3416ea11
  - [net-next,v2,3/5] net: dsa: vsc73xx: use macros for rgmii recognition
    https://git.kernel.org/netdev/net-next/c/12af94b2955f
  - [net-next,v2,4/5] net: dsa: vsc73xx: Add define for max num of ports
    https://git.kernel.org/netdev/net-next/c/6cc5280a0889
  - [net-next,v2,5/5] net: dsa: vsc73xx: add structure descriptions
    https://git.kernel.org/netdev/net-next/c/96944aafaaa6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



