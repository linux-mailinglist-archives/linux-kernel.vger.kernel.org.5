Return-Path: <linux-kernel+bounces-66891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793B9856333
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9A41C23290
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FB412D751;
	Thu, 15 Feb 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwKuH8eH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED61A18EA2;
	Thu, 15 Feb 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000229; cv=none; b=dq59fPKyPJIvmoKw/BG6j5dqhy2XP5iiGCxPV6xPto5VY3V+8aDol/ClkJkX0YzR0zEKraGHP2MuA2A0EyLKcbeM2Xxrs2btRbZla0xU/w9rENuAoupuMoxFr9Gb6LOr3CNVQpcixbKjflZ64eac3eeffTsmrd3s7p8P4oeGS/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000229; c=relaxed/simple;
	bh=B+YQ99SF1f7s20FoqQoRtIlLxfE6ABfVDyypZUEl59s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SBJzQ0DLtL3UPDiFhTNNzXeYZSPGl63tkpoND5kI28yLY+HU+T/ugd6zocW0JgENjoTvVT8j9MGhFCMlQKgFWfrce9Joc/LRwJEMMvEltmO/OeYMTvSuraBFqJd75pPFvIiLdw/RnNP3S4MkdQ6HfDgwZLJFk+Aw/hGK4/xru0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwKuH8eH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9273FC433F1;
	Thu, 15 Feb 2024 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708000228;
	bh=B+YQ99SF1f7s20FoqQoRtIlLxfE6ABfVDyypZUEl59s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SwKuH8eHPHALSIqEi+4NxYhO1VIiTrZfh3RyAmIWri/MTTsUHUYVP+KDNt+2imBWN
	 hlU2RwmOFAoctbl0rjF/mRTwtqXt56asy7szP3cmj19mibHcgbaU4DVSWvz+cYho2D
	 qE/IdakVfaoPup8bCSZ0Uq/xzRbJGh3UOKhZYvIknezoLi8ofCqRM/bOIm7yTiiu6j
	 h3N8vZyXzczQnQ7XrHyyy+TtoLhu/NLoxyY6nW0sB5Bc7S11rBoD7ws5vcGngnKPo8
	 xVoZdO2pn6vhwD7MonXxO32zP8d+hoCtDal9XxTuEh0M9FnDH+0FCioVa0gOf+Fujv
	 HOXKTnF1ezjlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73525D8C978;
	Thu, 15 Feb 2024 12:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mdio_bus: make mdio_bus_type const
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170800022846.10978.18400205281341107095.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 12:30:28 +0000
References: <20240213-bus_cleanup-mdio-v1-1-f9e799da7fda@marliere.net>
In-Reply-To: <20240213-bus_cleanup-mdio-v1-1-f9e799da7fda@marliere.net>
To: Ricardo B. Marliere <ricardo@marliere.net>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Feb 2024 11:48:00 -0300 you wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the mdio_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> [...]

Here is the summary with links:
  - net: mdio_bus: make mdio_bus_type const
    https://git.kernel.org/netdev/net-next/c/81800aef0eba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



