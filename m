Return-Path: <linux-kernel+bounces-32913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6EB8361D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4C81F27C16
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9843D57B;
	Mon, 22 Jan 2024 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIARGBPZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCCB3AC2D;
	Mon, 22 Jan 2024 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922634; cv=none; b=i5vpZ2Rg2u3SfcquuS1Uyl5Ni8pcr1lbXofXY4TTzw0nEMck5T+Qyan0N/tLZ3W82EKyJEOKpgKo/ls8xSWf2uqhwLm/QTnIKkwBLmsJCH9heyH+uShUsTs1E4BeHLKOfV09CC+jc2SMkyU8hM0wAUmjVkFLXkmDWu0sPDyAUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922634; c=relaxed/simple;
	bh=bvA6HFw8nLUTA5cZn6JR721REIgJAxDXSqVZf5zaU6c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KmEwIB5uQFC09+JSvPt8amRsG/WYk9jGLGfoGlgZf+vtGyBLj4OMVsNBL4TerN8Mn6BlumQIAQTzIRWE/kOuvIVNL8VZoyFLaHWkTalLX2bOz9R3XEtLBSYWkfs8VD3CGSOaA94eQq6/SL+UFO9xKZyxiklW0TdYsUgJb1d1vNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIARGBPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B95BC43394;
	Mon, 22 Jan 2024 11:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705922634;
	bh=bvA6HFw8nLUTA5cZn6JR721REIgJAxDXSqVZf5zaU6c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LIARGBPZCqAJMnUQWgJYHXnTO9IZyj7Rl4U5lv/GUcRpR8kXc5AllrADgry2kfq0I
	 AIW3FIuF8pSXsKK3dXIETyb67awL0Jsw4Qq6SrSCI1uEWHrbNu5mrLtV05PbjPyTAO
	 G65TkWinjajIIBL45VuFbsP/Fee9Jd7N7zuMRk4FSb8wBz8+gi7WfmpzzpWB1k5uGT
	 FiQfr1qQ0YgVMJOY0EpX1fF5RCqqrr4ZupaB96WSz97JksEhq9YTwMs+rQq6VNZyzh
	 PbPBGrdaVpSrIms9wsAKSxn52FfZ6NsTUrIOswuUMW/WxNIczpzdqnkOY4Rht/b7Og
	 e0+IkeH+pYsyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 267ECDFC688;
	Mon, 22 Jan 2024 11:23:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: micrel: Fix PTP frame parsing for lan8814
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170592263415.5359.2361240787400007665.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jan 2024 11:23:54 +0000
References: <20240119104750.878119-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240119104750.878119-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, Divya.Koppera@microchip.com,
 maxime.chevallier@bootlin.com, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 divya.koppera@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 19 Jan 2024 11:47:50 +0100 you wrote:
> The HW has the capability to check each frame if it is a PTP frame,
> which domain it is, which ptp frame type it is, different ip address in
> the frame. And if one of these checks fail then the frame is not
> timestamp. Most of these checks were disabled except checking the field
> minorVersionPTP inside the PTP header. Meaning that once a partner sends
> a frame compliant to 8021AS which has minorVersionPTP set to 1, then the
> frame was not timestamp because the HW expected by default a value of 0
> in minorVersionPTP. This is exactly the same issue as on lan8841.
> Fix this issue by removing this check so the userspace can decide on this.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: micrel: Fix PTP frame parsing for lan8814
    https://git.kernel.org/netdev/net/c/aaf632f7ab6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



