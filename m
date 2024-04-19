Return-Path: <linux-kernel+bounces-150873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D658F8AA61C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C331C21AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0834029AF;
	Fri, 19 Apr 2024 00:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZXFbKoW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F3219E;
	Fri, 19 Apr 2024 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713485429; cv=none; b=btFB2VklRbRwTDTn7wDPG6oebcVO472lmexXLKeiavicoqCPVxYEoBD35RjJ+ZoM0p5Ngf/1/7Q+ZrJnNOGM/h/4Ro0qPo22NJZtXFsIe/4hP1w0LHdCL6rHZ/c46GxYF1AliMREQihEMqAJ9tkVOnaGIWdlkTkkZxTn10r9Cas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713485429; c=relaxed/simple;
	bh=RwyQafOy5bEPSex5mtWQhumKrv9v0SO+tyTcFaB6hLo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OHhOi2zUZL0FDdExwOVmWS6aahvRkCkCR+MpUdh8UIPA/BAklCdERVtgBpjsNY/L3mm2WdL7/5kP2qQv87GAlHbSVoj59aDMmV4HrN7hN9cboOWsEmkG+m/kGInIwW+YaR1xBRa9SorraVs64CKIZx/BULUPhuKgNJBIkjTsNLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZXFbKoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D21ECC32783;
	Fri, 19 Apr 2024 00:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713485428;
	bh=RwyQafOy5bEPSex5mtWQhumKrv9v0SO+tyTcFaB6hLo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gZXFbKoWMLtQDUwVPJw+cpaCHSV5i/Nxoh6vqR8prFhXoWvZdn9ylo3A7vhHvB3ET
	 /huY1Q/2MSq+y+E9vMhXy+SmiXfRHULOVHFSutw6dqNE08xgbxTu56jJ50ddx6K4E9
	 mSJlhn1Z11oCPR51Yiz6wzICMkKQA0BkgBetSTxB0wBCcsFYjiGE8rNdMBfGizbrdQ
	 WRiK19ISA5XfGOa2wTraHEuV62BC8GXSNETFLh6XVw8lSeeqOzbyog7SPE2teSz7AR
	 S8ajSV3SG+Ah1+AGU0po4TrpaexY+SBuOlrcWNeL9PN813gZFLSN9MLxStXGECBUYl
	 FC9JGxzNoCprA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B99E7D5B3C0;
	Fri, 19 Apr 2024 00:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mscc: ocelot: flower: validate control flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171348542875.28734.4407750750845103149.git-patchwork-notify@kernel.org>
Date: Fri, 19 Apr 2024 00:10:28 +0000
References: <20240417144359.104225-1-ast@fiberby.net>
In-Reply-To: <20240417144359.104225-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Apr 2024 14:43:58 +0000 you wrote:
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
  - [net-next] net: mscc: ocelot: flower: validate control flags
    https://git.kernel.org/netdev/net-next/c/435f9fcc0e44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



