Return-Path: <linux-kernel+bounces-157947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8328B1921
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C1FB24DED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9EA1E884;
	Thu, 25 Apr 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dipPpSYn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63428171C2;
	Thu, 25 Apr 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014029; cv=none; b=C1pI1dXvTHI2ETAD3P6mwFtFeT20l/KQx57x7Z/N4BBY03i7ECL0stkPLAMLZkCMU95yha0UniYiRDpQmuOQervHYVSN2+u2oKLT1r8kUj2jrXqzyqAZSnqRNkirJMRMhQsNC+foJo8Kyz/xP2WUYpWd2EPVZSlkGgmp3wX2pnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014029; c=relaxed/simple;
	bh=+KHfR5qU8qns/p6rp8kt6AgDQsgke9l+phmlaKIzh0k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UPfrGNtZ1uBThiTtVVEm7dPisZgMNVFrkNZccPe68WdqjggwMzW89UZA/kr9MK2+Na1EqtwmexBnfu0wf4cduDAfMWkauKyNQsC+G4fz8L22BhMChy/72XtRBi8QtmR8kbbKkWXrw/X3zGT2K5x/bteS1syfgfF6wPcKFLCee2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dipPpSYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1854BC2BD10;
	Thu, 25 Apr 2024 03:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714014029;
	bh=+KHfR5qU8qns/p6rp8kt6AgDQsgke9l+phmlaKIzh0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dipPpSYnXPwzjxbVJDLu4SJcVZHl8FS+kgv6vX0732HHBP/nP2l9Jqr7yvjCFNfv4
	 Neqx1nS9EZxhcQ+VTK/4rxBVnvuDTt896DiX5uvYL0L3eYi1apYkvfe6yf8bycmRyp
	 uc3ziqJR82vdXMnvPYvQIOUg2ElwjxVa8mOHOnLhfgVw5TPrEUtjTNgKbjCbVDhR9f
	 +3qc6wj5Bnl/AJHG2x1aKLK5mDQ7/KI1LOUW2Yd/s0mqPSRxIrr0ua3+wMTui4SkSs
	 nBAIigOerFCdY+xvUi7I9hRy91LKF0Gzo2EQz191uzsHe4X63IQISZIXcer5iIr4sD
	 /lpuzJC8TCYFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 089D4CF21C0;
	Thu, 25 Apr 2024 03:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bnxt_en: flower: validate control flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171401402903.32160.16501907185348537103.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 03:00:29 +0000
References: <20240422152626.175569-1-ast@fiberby.net>
In-Reply-To: <20240422152626.175569-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michael.chan@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Apr 2024 15:26:23 +0000 you wrote:
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
  - [net-next] bnxt_en: flower: validate control flags
    https://git.kernel.org/netdev/net-next/c/3833e4834d70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



