Return-Path: <linux-kernel+bounces-154372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335D08ADB56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4F81C21127
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10BD1C695;
	Tue, 23 Apr 2024 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKC/8SGX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E348617BD2;
	Tue, 23 Apr 2024 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713833594; cv=none; b=SjagxEEqrlgZqYCrDI/bJGMwwG4PAshQQS4SWCqRr/9xbzc6gIY6rM8fvSJ2mUpS6T24hzgospvweLZVZ00UWAk+gLTMfpMNPQ2mR5/54q90DdxO3CWn9yekbaDB4u59mmRuX/cAYDcTzWVxMD9KwQoM56alEeUpRU9vMQKNbZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713833594; c=relaxed/simple;
	bh=jI5bL7iZTCWlIquhb1JFeBrYufSIIQmIzkACqSOqk3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H1mp8bCFPZS/E8DsrogqJamhogLlOVkyk9eXVURnMQFP5C83MluXK8IVSui3K9sFZwfabirDwfAXpa+UY2u1lDmxun6qqmcvqA0GdL4TfM50HxfdqH+cVm0hh67rQ6E5eI4DcHifSqFnIn76fffcMlrhD6N4onLLHzRqiWcHmS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKC/8SGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70167C4AF0C;
	Tue, 23 Apr 2024 00:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713833593;
	bh=jI5bL7iZTCWlIquhb1JFeBrYufSIIQmIzkACqSOqk3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kKC/8SGXiXH6YG7PY8wqzHNvQ2VlI8LbPh3rBkNSbBzBW1gt9awlTtolMAuWMgws7
	 8LovJu0pIgxs4KPf/0Yheg/e4FUcRuVkm7TDYfmOaCtUN5lvJWPdiz4J+YOqGsogkY
	 G5qzSopCd2r99GwidgEVc2BLwaA7bsYyvBhU1KEuT6uU3aowI6gGpDlGGYAz0PkSnh
	 +nEU1Or5lhAh5lFxDLLrTBZ6wAo8WVGO4rEAM1I60suCx25oa4FU0MCBPh5pGXLGqi
	 FD6WHPZyzSkPSUQRqx0mTXnXeULC7j9NomgLQgE4kyK6x26E6J9L3E96Fa9sG3mlzq
	 Xy+mF5IOwmtiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64B2CC433A2;
	Tue, 23 Apr 2024 00:53:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] cxgb4: flower: validate control flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171383359340.888.1780504229391004957.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 00:53:13 +0000
References: <20240418161751.189226-1-ast@fiberby.net>
In-Reply-To: <20240418161751.189226-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, rajur@chelsio.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Apr 2024 16:17:49 +0000 you wrote:
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
  - [net-next] cxgb4: flower: validate control flags
    https://git.kernel.org/netdev/net-next/c/93a8540aac72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



