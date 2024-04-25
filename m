Return-Path: <linux-kernel+bounces-157950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3328B1924
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16311F21F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F572231C;
	Thu, 25 Apr 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/w2EzJb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1819179B7;
	Thu, 25 Apr 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014029; cv=none; b=uS6jQSVhMIFNYIDSXp783uEIaEW2IIOuvlnwjbmhFCUm4hUrY8lyuhc+StzyBvd2AmDhIDFXW8349z3K6luQ502dt33U6+nrAqD528oS8FNzHTv38I2HHmrgjBlhzdo+VpaelhXxKGx7NxaDvtTRLTmxUYx87tABM3C8wVUgpjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014029; c=relaxed/simple;
	bh=iMlUC33Nu90EzRIc2y/LB/9ZIZIxEjsdNc+qBGF0cKw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R3snzVP6EmJwNbI43oD6IxY76V6Iw4fa23MeuxSJlY+FyA/zOY6lRJK/viVBGghVBZYmKl1rjC07C9qzsR+ZQFsmvBUvfmnSZESN8Sk8Vl5bz38TL+5zSl4t8w8pffQctRCla0Jfu+3rF/DPpaqIQWNYj4/w3dq6OFValiDS9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/w2EzJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 261B6C32786;
	Thu, 25 Apr 2024 03:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714014029;
	bh=iMlUC33Nu90EzRIc2y/LB/9ZIZIxEjsdNc+qBGF0cKw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k/w2EzJbRRNS5/bS7ArVPsITZoNjrYkMbep41yvrTapxkE6LbARGqkgqKF3VwGr3/
	 Ps3hk3yGlQTd2cbvtRx26isC6O1qpjJed4d3qjzNMswSFiPlyZUeEuNddNqEbAedk/
	 /FZ+rj8eQrt1kK4WUpDElh3XuBjN1/XhE3h4+QFcAe7N4zuyHZ2mYnhZbWOlQRItnH
	 VCr4JYkxH2ZB2DiRTK28JstSW79ZtBuX0xP7R0S13gPI4oEwzK9QrP+iuTxp4kVzgC
	 GaJ/I9zlHHj/l9tXvGiPJADbBBGCart36fF2hxt3/pysiaY6BVeHVpqiQGANQs1EFE
	 VueA9iWX9NtAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F131C595D2;
	Thu, 25 Apr 2024 03:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: flower: validate control
 flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171401402905.32160.3489921688576506312.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 03:00:29 +0000
References: <20240422152656.175627-1-ast@fiberby.net>
In-Reply-To: <20240422152656.175627-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, s-vadapalli@ti.com,
 r-gunasekaran@ti.com, rogerq@kernel.org, linux-omap@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Apr 2024 15:26:55 +0000 you wrote:
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
  - [net-next] net: ethernet: ti: cpsw: flower: validate control flags
    https://git.kernel.org/netdev/net-next/c/f97e0a5eac15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



