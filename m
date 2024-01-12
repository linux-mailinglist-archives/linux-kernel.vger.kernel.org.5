Return-Path: <linux-kernel+bounces-24603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBAF82BEF9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B95C1C23E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927C66351E;
	Fri, 12 Jan 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcU9n2XI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E4F634F8;
	Fri, 12 Jan 2024 11:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FFE7C43390;
	Fri, 12 Jan 2024 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705057826;
	bh=ENF/dO9gAomIOEvQaS8M4ij6ATRkJ5A5aK4s+0X+rD4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KcU9n2XIuY2mgpbqZ9mpU/euyJzJcuDOH3RaKN7ny4hdoxrwxZM/rwOnJh6OXFAaH
	 Y7bWV5AoEavtM0+hbml2yKJ6LI3LCDANB4hejbaHPEaRu8ZjTVI4AvFzS5dn19fGYQ
	 df97XZxbJQQadTL18OoGKHXlxmwqQNhqVFpwqX5Eugo/XTTl84qRd+G4oWXbB201nY
	 A5kE8IxVjHt7A8aZoNlx3Z9+nGKBrjy1e1zCq2195i6xztDyTh3JmXW02kZEjwyK0x
	 K3DWTRiFMelnawnm6BOSfywWERAdFMh4YsPDnddtDBIaEcea8c540QIEGtHfMW7yQS
	 OhNRoSWKpg8tA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4520FD8C984;
	Fri, 12 Jan 2024 11:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: micrel: Fix PTP frame parsing for lan8841
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170505782627.23132.8127636448769245123.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 11:10:26 +0000
References: <20240110113730.3704712-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240110113730.3704712-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 10 Jan 2024 12:37:30 +0100 you wrote:
> The HW has the capability to check each frame if it is a PTP frame,
> which domain it is, which ptp frame type it is, different ip address in
> the frame. And if one of these checks fail then the frame is not
> timestamp. Most of these checks were disabled except checking the field
> minorVersionPTP inside the PTP header. Meaning that once a partner sends
> a frame compliant to 8021AS which has minorVersionPTP set to 1, then the
> frame was not timestamp because the HW expected by default a value of 0
> in minorVersionPTP.
> Fix this issue by removing this check so the userspace can decide on this.
> 
> [...]

Here is the summary with links:
  - [net] net: micrel: Fix PTP frame parsing for lan8841
    https://git.kernel.org/netdev/net/c/acd66c2126eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



