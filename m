Return-Path: <linux-kernel+bounces-154868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4452F8AE238
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003E92833A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDA66311D;
	Tue, 23 Apr 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwluyx6i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7951EB56;
	Tue, 23 Apr 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868231; cv=none; b=gHrn5BDpBDvoL6x6io4hxOjOz78nVSRAG2JRpy4lWFWBB9LsXd+r1vbqffF/oOpA4o22Fq5Ynt0BKz42yvgaioFKo6c6HQhDk0c2t6e96Nvh1pnWywmzPixyne5kx4G27gjL9gHW0kuburPBU5BnvpgRN2YfD4RoofTrp4LBLWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868231; c=relaxed/simple;
	bh=SLELhq9s8Pwo4jEjjEa21DTEsxCcaygTfm0oUvjTWdI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JbaZsO3amaDAhsBSdlUHaDi11lrbcIkaJvNtdAc9ZS3Z3X/q5tMU3lMOr1vifCkcyqpX2/v7lMK5lQSVfWzMwvZIgq024oGxOUH3SO3ZODr/33ii6o6WcuGPZQ9AfjMXOleWOoENm4sRB47bU05uPbDtZk2D1n9DpcgVlDij2dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwluyx6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4055FC32782;
	Tue, 23 Apr 2024 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713868231;
	bh=SLELhq9s8Pwo4jEjjEa21DTEsxCcaygTfm0oUvjTWdI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rwluyx6i8nuipA7/zGA/szpoMpE3B944XnuEm1c7SYZauWVvKE8cQfKLxUxv22gKq
	 SUv8OtnFiGhCBHtM+788RZSQxOFYQ6MtMbFXVxzd6MZTYtdVZH20/FxPcldyxDOst9
	 9GcFheT89OExr9CfeKAiZ1bRgSqADPXoFCw3qd6IbCZFmo1OVFnWiwv2bpvQv+IiTE
	 yTQH/adUBSkVOXtICQDE4lDQ3bxMylwnLz34PVyBY3E3KJYRXWM0+bbc3+8YctoNPZ
	 glKBbxVVjfUtBOYYoBJvmsUFfLHD28+GKrkSE4Twh9xu/2thj136x3QIwRLc+nY5qq
	 sqXy7JvJ8Yj4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D495C595D2;
	Tue, 23 Apr 2024 10:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/2] Enable RX HW timestamp for PTP packets using
 CPTS FIFO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171386823117.5282.12691029337739979479.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 10:30:31 +0000
References: <20240419082626.57225-1-c-vankar@ti.com>
In-Reply-To: <20240419082626.57225-1-c-vankar@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
Cc: jpanis@baylibre.com, arnd@arndb.de, dan.carpenter@linaro.org,
 hkallweit1@gmail.com, vladimir.oltean@nxp.com, andrew@lunn.ch,
 rogerq@kernel.org, richardcochran@gmail.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 s-vadapalli@ti.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 19 Apr 2024 13:56:24 +0530 you wrote:
> The CPSW offers two mechanisms for communicating packet ingress timestamp
> information to the host.
> 
> The first mechanism is via the CPTS Event FIFO which records timestamp
> when triggered by certain events. One such event is the reception of an
> Ethernet packet with a specified EtherType field. This is used to capture
> ingress timestamps for PTP packets. With this mechanism the host must
> read the timestamp (from the CPTS FIFO) separately from the packet payload
> which is delivered via DMA.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/2] net: ethernet: ti: am65-cpts: Enable RX HW timestamp for PTP packets using CPTS FIFO
    https://git.kernel.org/netdev/net-next/c/c459f606f66d
  - [net-next,v8,2/2] net: ethernet: ti: am65-cpsw/ethtool: Enable RX HW timestamp only for PTP packets
    https://git.kernel.org/netdev/net-next/c/c03a6fd39826

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



