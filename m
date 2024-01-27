Return-Path: <linux-kernel+bounces-41074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4A883EB53
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 06:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DB37B249DF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 05:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89A114A93;
	Sat, 27 Jan 2024 05:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCiAbR+t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166227F;
	Sat, 27 Jan 2024 05:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706334028; cv=none; b=nEzqt0WocrFMo2+B4JfR6kGefbEaTUGHtzILD1sVdLC8NNle6QGIHXAYCwi/NBBxvr2/AwW4xCVipMHbZMwZx6BHHv5pJV8V4l8k2vvOcPbshDJ64xJP4HVzIFmDLkJODaGr/ODuaMoYX0o/DqX8epFg/jvPbHS5d0Qnf8FWMws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706334028; c=relaxed/simple;
	bh=9ZTfUtMn1a338N0HPReMh7C0UyVheHoUSbQsZXZyiG8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NPpf5VKJXwzjqQ1k1JrF164+nOtXRgOACh418bJi1ampDmMU8cmtbGTq+ArVU/l7BXSA9tGPEOBxfUsy3F6oqmjn9Xp1mq+5yhZoQf+IiSkb+YSTa1/ji7fa1NUbpssvY8z1tcyUBbptzSyAxFS+vAhF+X04EBUoWEKdfaesuqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCiAbR+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 699E0C43390;
	Sat, 27 Jan 2024 05:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706334027;
	bh=9ZTfUtMn1a338N0HPReMh7C0UyVheHoUSbQsZXZyiG8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sCiAbR+thSAuApUEJKyoQCHu1r9hIzgVvJGE4EF0434TCeco2LtGfIbx2476vPudE
	 NNu/2sD8/CTsQSTHNGmpJOFLF9xU7tsQ+W1r+dpm8O5N3pg0LPhreE7F0l2ksHWZI1
	 qeWVSKYf4T38wwqo6HJ5jwx2pnS0lXvcVKA8k6lzDMlSW7p5geybMhWRIYDVnBm6V9
	 eSBBF2gbhWpY+/AhnPMIbU7D9fGxQBFdvg8gH5xa4FNmK5jWRMwegCayKSrf1kPuJA
	 nyksAWWNQ5KGxiNsJuza2cwSxkOk4lIxy0Q6WLgJDFeTz+RfLDT/iDwqlPft0nPjmQ
	 kaopvDt+Qlp2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F132DFF762;
	Sat, 27 Jan 2024 05:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] net: dsa: microchip: implement PHY loopback 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170633402732.3753.3039393822972314797.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jan 2024 05:40:27 +0000
References: <20240124123314.734815-1-o.rempel@pengutronix.de>
In-Reply-To: <20240124123314.734815-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, san@skov.dk

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jan 2024 13:33:11 +0100 you wrote:
> changes v4:
> - add Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com> to patch 3
> - add Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com> to patch 3
> 
> changes v3:
> - add Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com> to first 2
>   patches
> - move ksz879x specific loopback handling to separate functions
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] net: dsa: microchip: ksz8: move BMCR specific code to separate function
    https://git.kernel.org/netdev/net-next/c/0c657f860e67
  - [net-next,v4,2/3] net: dsa: microchip: Remove redundant optimization in ksz8_w_phy_bmcr
    https://git.kernel.org/netdev/net-next/c/d1b7d0d85d59
  - [net-next,v4,3/3] net: dsa: microchip: implement PHY loopback configuration for KSZ8794 and KSZ8873
    https://git.kernel.org/netdev/net-next/c/9e62bed6e105

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



