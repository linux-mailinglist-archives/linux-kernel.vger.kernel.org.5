Return-Path: <linux-kernel+bounces-154369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 524428ADB53
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D02528214E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559411B7E9;
	Tue, 23 Apr 2024 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcpVjxR8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C64168B8;
	Tue, 23 Apr 2024 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713833593; cv=none; b=n4FWjn/sMTI3MYJfULF0ZwGC29wp5FQQOjb4crEkUerBzSsboh+SsBqS6PW4A/1TyV/pnJMWZgfPuCgc8z04Ct/gL6ky2hLcqUM60SAmCQgfHJ2MAvKFUK6ULYizCX/UPSD6NQQWPGjtTGcE5ufpiQoTy3bfD8LAEcK3oSjeVX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713833593; c=relaxed/simple;
	bh=/b+EQeQgjOThGXQ91wTEx8RDS06LwJVQyIGHLf9kxxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=emMBpjpqHrLPsTOLkn4QNfto1QeykLh69KEri1HXt47EhPrBGiHnzqgEmxXR1pjF5KaRQPaH012hHrQqVtQ9nV+aZBQvojZRAQ2ZLibeRSWO4Ojo0qjzBNJmKtP/5F8+QY/LuBdoFVh0z3VuWdrgc92AasfPRZiiw6Cpzsd29uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcpVjxR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67272C4AF0D;
	Tue, 23 Apr 2024 00:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713833593;
	bh=/b+EQeQgjOThGXQ91wTEx8RDS06LwJVQyIGHLf9kxxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GcpVjxR8PDqm/KbwbOEjuecwfeRHQ463cF75dIXMmj09c8bmxzt7O7KYTuiy2IIux
	 j61hjWUpNQ0hTkOl68C1+XA/DICdrfcbTPl/JkfYJwbG+jqL+u5bRoW+IQ3qGQGR1U
	 mtglrbGTQside7rGCJ6LqT8czQiwbEr/dB8D+f1cvirMgagELqHD3XqH9gu5+apFdx
	 ugoOgshMNd+e+HlOySrLmPhx3+oXTVqyPLsRSga3xaMb/IWCWyt4/XT0lZlSVncl43
	 wJsgC0hTHWZLD2Bclj5V6amZtONof3dn+l0g94PN/AVY6j19C8dsq6bLXSm+faFFS6
	 ImKa36zcHfuDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57503C4339F;
	Tue, 23 Apr 2024 00:53:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dpaa2-switch: flower: validate control flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171383359333.888.17584728773628518508.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 00:53:13 +0000
References: <20240418161802.189247-1-ast@fiberby.net>
In-Reply-To: <20240418161802.189247-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ioana.ciornei@nxp.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Apr 2024 16:18:01 +0000 you wrote:
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
  - [net-next] dpaa2-switch: flower: validate control flags
    https://git.kernel.org/netdev/net-next/c/af7dfa94c2f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



