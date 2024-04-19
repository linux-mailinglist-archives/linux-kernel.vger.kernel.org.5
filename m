Return-Path: <linux-kernel+bounces-150875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E03408AA61D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AEEA1F225C7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082D929A2;
	Fri, 19 Apr 2024 00:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bflkVu3W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F93372;
	Fri, 19 Apr 2024 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713485429; cv=none; b=WNNqE6VYWnE+EZoc6imbTg//cIlXSCn8cBQcqU47wP4GGxVHKy3/DGTlOTt/pt8oTQBxftzKn8C+8/jiyV5GE0OyBl6GKUsvmgWMUI5+HbEwL41I9oZgnG+dpM53UFeb+DG1guM9WlbXx+jbPGzN71TcGWoMa7Anie54zrfDESc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713485429; c=relaxed/simple;
	bh=/qEzgsJYKOmnWCtaOGAJq9R6BXcWIzgJ9dRWwDWhlIA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=guIoWuLSGHy/4GKq121RAGTUjXmXFdKqTEqrQTLuAf071hTDeuuFOFudILnG4IZHCQixxnDxR/CmaAbPRBcSxRMi0waEOBoneZJN7Hj/wx+4oiAl8rwuO1gm3cVfGj9+yBeQZ87ezSAfTZk6h5OGW2JUuZW1eUJuF2Be1QVywI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bflkVu3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4CCBC32781;
	Fri, 19 Apr 2024 00:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713485428;
	bh=/qEzgsJYKOmnWCtaOGAJq9R6BXcWIzgJ9dRWwDWhlIA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bflkVu3WgupgQuniRmFg4aQoPC97a4DvibViHqI9mmxmkMbhY6WcRMMXooANCxoL4
	 UxDHV29ipY3j9guU8y3PBmmKYJ0bZqCtIcaiRbfjEhum34lpwmu87F1MaMl4e2V2RF
	 5ZcUYuZYZ/W/kUV8GaUEbOU5y7RvqFTMMy5PTkWbBtQ7nh3GYN6P8X5fwk2ZlwIx+h
	 HHqaRvPLLq1xwVmEDEikPtNu9hMNM6E1jwMJ4n+5qfXFg9pzBC48U7Y/1ZcnYUdvCa
	 nw0zQ9qN+9Bse0VYtA58gzc91oKyDiQZ+Hv4Td4W9NfwK+pTah1AUOWQCaFFQdD2N2
	 WLGvrBYVNMq7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2B88D5B3C1;
	Fri, 19 Apr 2024 00:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mlxsw: spectrum_flower: validate control flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171348542872.28734.11022107997483572046.git-patchwork-notify@kernel.org>
Date: Fri, 19 Apr 2024 00:10:28 +0000
References: <20240417135131.99921-1-ast@fiberby.net>
In-Reply-To: <20240417135131.99921-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com,
 petrm@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Apr 2024 13:51:20 +0000 you wrote:
> This driver currently doesn't support any control flags.
> 
> Use flow_rule_has_control_flags() to check for control flags,
> such as can be set through `tc flower ... ip_flags frag`.
> 
> In case any control flags are masked, flow_rule_has_control_flags()
> sets a NL extended error message, and we return -EOPNOTSUPP.
> 
> [...]

Here is the summary with links:
  - [net-next] mlxsw: spectrum_flower: validate control flags
    https://git.kernel.org/netdev/net-next/c/4713744d9f6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



