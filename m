Return-Path: <linux-kernel+bounces-157949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AC18B1922
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 373B8B24DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCD120317;
	Thu, 25 Apr 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwwFxeLF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751C817565;
	Thu, 25 Apr 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014029; cv=none; b=stiJDwXGU+A5cfgEVXdoOdE/3iqQiX8EmIxmwXc8gdtnACTfIRboW1jXmV2fdYUHEmiM0z8WXgfA7sbGF2pSECSEVNcctE1rkXQtTAtF3y85ftufLd0qbrZoYnN05tCjNRWCD3/pf3EoSERq+7AiMklU1MOlrg7SWUnx0t4XDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014029; c=relaxed/simple;
	bh=A0rIwBpNr1Tffk9rgj4BHfMAJbxiw7CRQm0bR+Krz0o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dx24BgYsvmri7qo+OPNWhuBzl+hT4ouXinnGNlbzZQA3NVDwvOGsRNKfY6QRV9D+Yzw7PvnT0ydHeL661qpYo6tK7MNh4WU4Vd2PxE0JhwFzXwA0IK5F4dqMLj1c/BiNJxtGC5NnKBrxq79LR+W0T7QTikL58n+YvixPMN5Z8/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwwFxeLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 241F0C32782;
	Thu, 25 Apr 2024 03:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714014029;
	bh=A0rIwBpNr1Tffk9rgj4BHfMAJbxiw7CRQm0bR+Krz0o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IwwFxeLFTrJ/TUnAc2Ytq1aMS0uraGRg0x+nfssJ0TKIJWnzRMAxtDN2ov8Lesghx
	 Bv1dRbQzP8tYHyOOpzw8eT84jVWjo4EeWVgFgY1huTd6oUSBRS1uZzwqAXJxSDhlP5
	 FkRjyWidnRMuC3JjTwPYiRPh/lMG/M6E+xIjtgXKQsSKaLafNg86D2o281WDBq/TSl
	 2syfClflyCZncm7UCw7UtN5QFlM5rTIZPUwoKtWay6fSfpV4x43oAjkaQ3uf9ItDzb
	 q5uOzdCJAIJaUofCaEHN+rZiB3AWcTLESpnM10TvVILjPGk9jJvhtc5MJSfh4AxQTn
	 s3570IPvzPd/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15CA9CF21C3;
	Thu, 25 Apr 2024 03:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: flower: validate
 control flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171401402908.32160.13284699758535313028.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 03:00:29 +0000
References: <20240422152643.175592-1-ast@fiberby.net>
In-Reply-To: <20240422152643.175592-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 grygorii.strashko@ti.com, vladimir.oltean@nxp.com, rogerq@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Apr 2024 15:26:42 +0000 you wrote:
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
  - [net-next] net: ethernet: ti: am65-cpsw: flower: validate control flags
    https://git.kernel.org/netdev/net-next/c/8ae124f1897f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



