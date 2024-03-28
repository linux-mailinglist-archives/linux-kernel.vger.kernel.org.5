Return-Path: <linux-kernel+bounces-122807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C75088FDA0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574831C2A7BB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7767E0FC;
	Thu, 28 Mar 2024 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEFHdQXS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5270E2B9C4;
	Thu, 28 Mar 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623629; cv=none; b=hbE/an0bZcvcEqHXjfQVa/ltcPW2VKRHJdonM2bf33tL/sstqqvJsW6TAQwNtyRY2bLkohp30C/AS5IQhuIu00x6HIbnW7OqMsrxCVeqLg5ftF1EwcGr9x48/dw6+F5T1KOAI6zj89mnYHeZH86OuAwE3p7G/7Y4Cg3ny+9Sh7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623629; c=relaxed/simple;
	bh=0lxXx362Dut5xedsJ1jHvviSrwVWwdV1VnDSTkexTe0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jLXGZYoZVAJ8Q2KJ1ThCfg76P93hJ7nee3E2TtQmdWLNPoIsXDJyxpN5L22HaNRbf9ZvMRaJoq0yl5GKex1UeGsgm1/2N9SvUawdXi3ymVtEnit4Vo+mS3LyQwT5GvoP6jRJyNqr3dQEn6KY/KCKsu3n3ZadU0ClFWlmAbknbwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEFHdQXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D096DC43390;
	Thu, 28 Mar 2024 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711623628;
	bh=0lxXx362Dut5xedsJ1jHvviSrwVWwdV1VnDSTkexTe0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hEFHdQXSH4d+JFaPP5z0Xg4cg79BTl2xtrsoiNphqZ8IewRhkaVzNqwD85wfSWBUU
	 ER4LlV/4kVFgh9OTMxfiY1BCVun/xXer8PqFIhGFJ/uVSjN6B8ir3Sgt4geCiCYyLZ
	 nfB5I/x9fj2BibNNXErSXRYyWg0mShriyCpLqF/w0H7ExiEQI/WNCnGFX7+i9EATKa
	 tijgBPQJ+JjG4flqsFJRKW/VO5DDHl9KPSiqcdnCLeHcyb+TYaCAAJE4OW1B2w++N+
	 ZcRCcukpS2Mt3M2K4CPvSleoWIYOXedpSUxHA+LytG+DBh2exFAJ6QKcDOw7YLs7ai
	 m2kewna5G7GaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF4CDD8C965;
	Thu, 28 Mar 2024 11:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2] net: lan743x: Add set RFE read fifo threshold for
 PCI1x1x chips
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171162362877.25241.2855018810326891961.git-patchwork-notify@kernel.org>
Date: Thu, 28 Mar 2024 11:00:28 +0000
References: <20240326065805.686128-1-Raju.Lakkaraju@microchip.com>
In-Reply-To: <20240326065805.686128-1-Raju.Lakkaraju@microchip.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, linux-kernel@vger.kernel.org,
 bryan.whitehead@microchip.com, horms@kernel.org, UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 26 Mar 2024 12:28:05 +0530 you wrote:
> PCI11x1x Rev B0 devices might drop packets when receiving back to back frames
> at 2.5G link speed. Change the B0 Rev device's Receive filtering Engine FIFO
> threshold parameter from its hardware default of 4 to 3 dwords to prevent the
> problem. Rev C0 and later hardware already defaults to 3 dwords.
> 
> Fixes: bb4f6bffe33c ("net: lan743x: Add PCI11010 / PCI11414 device IDs")
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net,V2] net: lan743x: Add set RFE read fifo threshold for PCI1x1x chips
    https://git.kernel.org/netdev/net/c/e4a58989f5c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



