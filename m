Return-Path: <linux-kernel+bounces-52624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D5A849A94
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA962B21E0B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B081BDC8;
	Mon,  5 Feb 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czPCzekn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFABB1CA84;
	Mon,  5 Feb 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136829; cv=none; b=uroZA35RtVnlXYzLGUiIj2iW+pGTpRFFd+gICYysXuqq7MjilZ8xwlcAGwKWmtuk0RNNfhSAs8J9Ng5oXm2lhg5S+5v+tIGzVPWI6Sr0Nkh/qehe0XP83DL6FNhX32g9ioj0/5NAC2EMvCm4wOJ9kaMOKMdp9QSFPlUghEZVmrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136829; c=relaxed/simple;
	bh=vPyXYPpBmJ/7vHEzsQgUk9odanwPM0KlMhSo9ImXqsg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uv8Szsrkf86YYAIz7TdVsjT2Zs5TTYg+HCWhaSONjUVOCo2WGkcgDRCaoF18NRFfaGs5HlA9jPx5JLPF2Aqa2N/RYKoiXZjPPGP92pb+prd/YQPp0fWal4wgc2joTbaTi3W2G6DiugtHH+ugh/e190qdrqZ6Gb4xRryis2gHSEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czPCzekn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D0CFC433C7;
	Mon,  5 Feb 2024 12:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707136829;
	bh=vPyXYPpBmJ/7vHEzsQgUk9odanwPM0KlMhSo9ImXqsg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=czPCzeknTOoPaxx9WjYozUIAQUc8S7PIrVS8WgsHDpk40ME40m14lMFtptja/7T3S
	 S5mAGWBbot6qjqqwmpuBh9Zq9XfaWueGUQyPalagSlH8a3qONYFkMZCB1p68fh6Y8g
	 nDgaokt5Joui5qlaYYiL6Q9AXsWqGBJRHpovHns20MKEayEU/GO0Em0VLaywhVFc4P
	 0aoalzPIewtFVTdnGlRJ5eKDiQkNhDfAu+59lzzm98/kwObQG9PnEbdVmZwWNLimq0
	 b+khWne2XKUlJbMJhA5LI5hg/uXqXlG7AvWbHVCCu7UXVsDsc8yXMhkwYODfEqLWTM
	 k2m8u5IujoWrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15C2FE2F2F2;
	Mon,  5 Feb 2024 12:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] rxrpc: Miscellaneous fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170713682908.8022.12488201316715935767.git-patchwork-notify@kernel.org>
Date: Mon, 05 Feb 2024 12:40:29 +0000
References: <20240202151920.2760446-1-dhowells@redhat.com>
In-Reply-To: <20240202151920.2760446-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  2 Feb 2024 15:19:12 +0000 you wrote:
> Here some miscellaneous fixes for AF_RXRPC:
> 
>  (1) The zero serial number has a special meaning in an ACK packet serial
>      reference, so skip it when assigning serial numbers to transmitted
>      packets.
> 
>  (2) Don't set the reference serial number in a delayed ACK as the ACK
>      cannot be used for RTT calculation.
> 
> [...]

Here is the summary with links:
  - [net,1/4] rxrpc: Fix generation of serial numbers to skip zero
    https://git.kernel.org/netdev/net/c/f31041417bf7
  - [net,2/4] rxrpc: Fix delayed ACKs to not set the reference serial number
    https://git.kernel.org/netdev/net/c/e7870cf13d20
  - [net,3/4] rxrpc: Fix response to PING RESPONSE ACKs to a dead call
    https://git.kernel.org/netdev/net/c/6f769f22822a
  - [net,4/4] rxrpc: Fix counting of new acks and nacks
    https://git.kernel.org/netdev/net/c/41b7fa157ea1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



