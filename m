Return-Path: <linux-kernel+bounces-150874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF39B8AA61B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5421C21A68
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0445E2905;
	Fri, 19 Apr 2024 00:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OowmgT+p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6B19F;
	Fri, 19 Apr 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713485429; cv=none; b=oL3EHdE8hZJ9/VVhPrAhvznBBgUIhXOumva2pTAhtKVn5+S1OcZZ/W6Mh9C1YNMUf4yWaEzlYr38fToFR52PQxogE6s8e+5lSU80UV+yUpWKtZSYjQT/XMu615xAq39EZtfRax00iBcq6mzxbhZ5IY0G+seQgAb5u07snSqlVIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713485429; c=relaxed/simple;
	bh=au9e2DXEXg0r+PdKUgdCR2iRtWETwh9UVFavY181u6Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dZhMOSUX46XtpmW4YczNWJg3F4bR3gZ5mfEHpEl+4axJOy1pezhPefIgFNq0qKRDMbR15F+fpLkLtbNKuWnzXkg+ka58xS/1IcZUjyE/S883Y4efdrfiP0Rzm6juc2u395CyA2Z/ec5+xLTghQtxpuOI5EtiovuVqRw/bmd4VmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OowmgT+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7DF3C3277B;
	Fri, 19 Apr 2024 00:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713485428;
	bh=au9e2DXEXg0r+PdKUgdCR2iRtWETwh9UVFavY181u6Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OowmgT+pThPC7KGeV2tqiqxpafRbYZ6MAm2s1TzkjtK4m3KFYinbz9BpyGcfrcy0O
	 AEBrSVPDkO86BhpCSIr0FsRUyF9/loK26RFgWPdD4InYE+kopnwW9zoXmH/Epxm2Ng
	 heowytnAgSGrqFpvudHWSrvdlzhYCBB/wKoJYW97744R7gEl0TNUaObDJ1Ovury8e9
	 0LrApY+Yi236azAPzqACVCgNNVocNuTjz9OTKMHxG/OVpYOjaz8GlNxcL3HVCY3L08
	 fjCQTqqtHreDZPfvEUJyMKaPRs3svn/YLJuGrpquQD7/aG7v0ynqA6yZrNeqHMy5vL
	 jz/Kj1CZwtZqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A313BC395C5;
	Fri, 19 Apr 2024 00:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: sja1105: flower: validate control flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171348542865.28734.9680138028938575168.git-patchwork-notify@kernel.org>
Date: Fri, 19 Apr 2024 00:10:28 +0000
References: <20240417144413.104257-1-ast@fiberby.net>
In-Reply-To: <20240417144413.104257-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vladimir.oltean@nxp.com, andrew@lunn.ch, f.fainelli@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Apr 2024 14:44:12 +0000 you wrote:
> This driver currently doesn't support any control flags.
> 
> Use flow_rule_match_has_control_flags() to check for control flags,
> such as can be set through `tc flower ... ip_flags frag`.
> 
> In case any control flags are masked, flow_rule_match_has_control_flags()
> sets a NL extended error message, and we return -EOPNOTSUPP.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: sja1105: flower: validate control flags
    https://git.kernel.org/netdev/net-next/c/4b762fee325b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



