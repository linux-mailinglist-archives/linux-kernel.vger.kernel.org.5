Return-Path: <linux-kernel+bounces-150876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBDC8AA61E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E561F2257E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C552F5A;
	Fri, 19 Apr 2024 00:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q04YH+Ab"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B51C37C;
	Fri, 19 Apr 2024 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713485429; cv=none; b=DsT+tbv5xI+3v6pRph+TLlAftoiJeWEemqu7FoCNuvgQehLc/h2atajuCrORWiNJqPc5HU1xItdRe2Wd+C7SMSWKUGrBFHs5WSahW+RnaShda4/ZisKVRyNwTeGS11Poo5wQK3IOd9lBgeyGHVsO6SSIgRVUbpuohCUUWeDxodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713485429; c=relaxed/simple;
	bh=AJ20xfofJ8LHkU/pX2d4maXulEd3If4fKQRVvYL9jcU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L2GunUuG6Cr3D6L4LA5P8R+Dlf3aCxJmwEGrxqz/mUd/9s/55366KuW1upb1jw472D6ucQHl9idrjMM/ysr52v/BnGysPIJTbr1JUyELr7Q50OKAzup+Bubpa1ck/k+2xQRtR8ryYmZlpqHO5hKUdxoid6Pof8q01xrWiL8fIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q04YH+Ab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D808BC4AF08;
	Fri, 19 Apr 2024 00:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713485428;
	bh=AJ20xfofJ8LHkU/pX2d4maXulEd3If4fKQRVvYL9jcU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q04YH+AbqR59dCKMbmXm1M+zooSCkDPAmMlMeGz+9duZQ1hpRY674bDIxS1jxCAyx
	 HV5MHYgcbfzxCIBEOkbpK4LeLwFwkEI/AwzEAah/8UoFEDlitjNF7tDKstL6siW1t1
	 c1PQ/AFpPS1r93REJW1GrCpHlzRLh3YLZ4LBVklTR7+amTnIkoYsWKPj/AbQlKIwDY
	 MgEv04Qyo08LrMWUIwDdrf2HhC0unhRGOBKEh95l0GhVgi3XzJ6aiW0vX6C+5Bfdib
	 LcnT4CWw7+EFjGrRSQhis+7T6ijn71nD6k5vQnZr3V9edxinI/fEP96lkuZFL5V2vt
	 iMdg48omtj3hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2538D5B3C5;
	Fri, 19 Apr 2024 00:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: felix: flower: validate control flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171348542878.28734.12858852515908004935.git-patchwork-notify@kernel.org>
Date: Fri, 19 Apr 2024 00:10:28 +0000
References: <20240417144407.104241-1-ast@fiberby.net>
In-Reply-To: <20240417144407.104241-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Apr 2024 14:44:06 +0000 you wrote:
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
  - [net-next] net: dsa: felix: flower: validate control flags
    https://git.kernel.org/netdev/net-next/c/b1bf8600572d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



