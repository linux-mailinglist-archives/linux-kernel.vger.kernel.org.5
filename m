Return-Path: <linux-kernel+bounces-51675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24897848E27
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC23F1F225F5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9506B2261A;
	Sun,  4 Feb 2024 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oihRNg4B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C155C224E0;
	Sun,  4 Feb 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707054026; cv=none; b=KJ+lXN3F+TNRO3oAXfuOS6ciIaASzXxOdHY2VHTFYPSuin+Ev3StiN8ajzKOdS3sv9DXMTKY/Jl1id3FMAaAXocVoOY6h6apNYgR84tG5soLkAJquIoRG2e1jdINSx0/Xomu+zaRW261Vmy329xXyxjdbW+xcYxWgiAZDPota+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707054026; c=relaxed/simple;
	bh=BMAQS7+vqkNKpPINrsTI6Gle5RLZn3L2OWtrc8K77iA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZjepmGqYkk+VO3w39kLk/SV3uSEKXu7VUq3yHRwtV9fMekqdhzDZjS7Vako6gJfxzd029oBWE0mjh68qlsZLxeX4ICwnHnNGCXC+iGkm+RPi1WfMv9m3IJ4I1OSbhmtW97S/uSQL0IztF8n5atvK2oYEwxxv3NkCL7BOfBZMLb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oihRNg4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DD9FC43390;
	Sun,  4 Feb 2024 13:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707054026;
	bh=BMAQS7+vqkNKpPINrsTI6Gle5RLZn3L2OWtrc8K77iA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oihRNg4BCPc6Fsr3tUvkYmcpW/QFQYMe8r2EzNqKaezOinghFfKrRLIKL+Ad464Pu
	 N7yHRlIF/hSgKLXobNpxb3SBylVC7/+Xz079luScNrDW5msDIA/gUyrLib4MDdsosL
	 WINXNHZ7gwEFFvn2dZTAetzm2Qh4JOGsu/l9tJfi93nMygFxrTRAaXR3RAydozbkzW
	 YTL4unwV+ofC496EjyDACGGZfhfhcx7SSYNgD9Imbl7mehYaagEAw9C6/Xfs4EPyTw
	 T0DJvbqN0o48MEGszgRDByuRKh0zDVrgSvEdYOJyOSjf3gxba6e08V0dtlkd66vdHI
	 DmKE4fJEd/Arg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3941BE2F2EC;
	Sun,  4 Feb 2024 13:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: micrel: Fix the frequency adjustments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170705402623.16095.16131459625270724303.git-patchwork-notify@kernel.org>
Date: Sun, 04 Feb 2024 13:40:26 +0000
References: <20240201204203.2691424-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240201204203.2691424-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 1 Feb 2024 21:42:03 +0100 you wrote:
> By default lan8841's 1588 clock frequency is 125MHz. But when adjusting
> the frequency, it is using the 1PPM format of the lan8814. Which is the
> wrong format as lan8814 has a 1588 clock frequency of 250MHz. So then
> for each 1PPM adjustment would adjust less than expected.
> Therefore fix this by using the correct 1PPM format for lan8841.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: micrel: Fix the frequency adjustments
    https://git.kernel.org/netdev/net-next/c/7d7bf30f031b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



