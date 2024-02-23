Return-Path: <linux-kernel+bounces-77709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A62386094D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AA91B23ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D734FBF4;
	Fri, 23 Feb 2024 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTSjaRSl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C6FC2DA;
	Fri, 23 Feb 2024 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658428; cv=none; b=K/G8DIBfWzSEaliL1w0NsHuP4uwqlBvfO5kRtbJLCFeInh4J31cIhb2AuG5HCn5hbzYHkyh/9mnylF/G7LGtmvUPXmY8+5FBlhlXz3+7U5zK6gw2pmcp2EB4VIKZrRIPc0mfqNkym5bdFl0A0z38SWQ2cgaE6HlxcIyWgp0DZqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658428; c=relaxed/simple;
	bh=V6JZhkP+8HnvC5KUFcuNeGRzMN+4OV+7JlW6tufRPAY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tH2ELEmaKfVpr1QXviJsJijsVN/p/gNM+McC3anpx/TnKZDvycGXwJxwSOL+88Mr589/eLdZ+LXejJQ2+OJRIsWMQkpZ0N3UQ2U1Zef2g4cXotR3R1dZIcPKmhxb0vYvP4j0+mZ1fJxPYpq5M2bItzx2MSfu9XyE1Rff41Ku3rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTSjaRSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC550C433F1;
	Fri, 23 Feb 2024 03:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708658427;
	bh=V6JZhkP+8HnvC5KUFcuNeGRzMN+4OV+7JlW6tufRPAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YTSjaRSlRiBgTO02P0GIbHviTnos/EqofPnJgeMSy3XfCmfP9p5l7+32rO150QVQK
	 Ih9eOGV8gmUQMPj0YbnGuiSZHNBII6oI6THCBre2hI8LQM9y8jCSKT68iplZbOkQje
	 lnt01vuQc6r6NyNeyREVYmiK6TlVzua9qqmocIRGOEAuTI/Ff1OEObTRpaLREi+Mfn
	 SHgAXhvp2nIqHH6yoperab5tJ1pnMlu2sbMBVGb2MU2qxrZeAwfd87GckpOMJEX017
	 gzTGwcpZ07cZC0e9WIaG5XV1GsJxK1R78T8F9vVxtW1NdQ8+cHTElv25+MiumcAmbr
	 ASYxMTrAwif7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD9BBC04E32;
	Fri, 23 Feb 2024 03:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: smsc95xx: add support for SYS TEC
 USB-SPEmodule1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170865842770.21611.18090294447425361465.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 03:20:27 +0000
References: <20240219053413.4732-1-andre.werner@systec-electronic.com>
In-Reply-To: <20240219053413.4732-1-andre.werner@systec-electronic.com>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: steve.glendinning@shawell.net, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel.krueger@systec-electronic.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Feb 2024 06:33:32 +0100 you wrote:
> This patch adds support for the SYS TEC USB-SPEmodule1 10Base-T1L
> ethernet device to the existing smsc95xx driver by adding the new
> USB VID/PID pair.
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> ---
> v2:
> - Sort new USB_DEVICE entry by VID and swap with previous entry.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: smsc95xx: add support for SYS TEC USB-SPEmodule1
    https://git.kernel.org/netdev/net/c/45532b21dc2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



