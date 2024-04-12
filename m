Return-Path: <linux-kernel+bounces-141821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D528A23E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30835B23337
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B1F179BE;
	Fri, 12 Apr 2024 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLWzub48"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF31134CE;
	Fri, 12 Apr 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890231; cv=none; b=G//B/Gc3BoWKQnygu+H8Am/gtlN4VCQ+u4NcQ4ls5BxhSgqF8nTJfIdCfw5HHiVzwVxfLOUXrc4ua8FLQiW9RgzSoDxzX/dB7/ZIyWwxP7htWnLakpwmytYmR/yZ5cVcVWG1I9kNNBZO9jlRtPMXVMZIeX1hrvqUuHf8/YhyhIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890231; c=relaxed/simple;
	bh=zuHFbeFEeS204l/YqzpMFcRAaDus9Cr4Z1+LOMuO/Kc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uDmwhyAelIH0V8xiXZp09FWn63CJ4oi26aQi8MPcz0pqOET2k6HZ8xHpCXGVYejFpKxqomr7CeGwTUvfGk9IM93DEJ4hfuTizd5BIbpLhExOpu4EY2aM/x7UfwyYwDgHaAkAAf1G8IbZ4ietGi0KLq0NJWmDc2nd/2lOB3TnZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLWzub48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE5CBC32786;
	Fri, 12 Apr 2024 02:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712890231;
	bh=zuHFbeFEeS204l/YqzpMFcRAaDus9Cr4Z1+LOMuO/Kc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rLWzub48BYy3SV9Bxg2cpH+T8AnWWqZK1WTsQi/vNSehXIe78z2aNPClPZtk0ms1J
	 u30ntN5t+k1WOzd82z1u7OW18JaHS2KttpOOJ2exThBdUIxE8lTMjRgle7AcIqNJiF
	 yxp9cvsZqdIW+ayr9ABdiuT/PvPGEm/pRsKfr1njQyi9JdiDSIUOM6284uHtob/Ggj
	 /9BQJFF+BzBRn878E0SZst31juVZtKdX6XEGN6aKXwJ/m+oyzTwYrmhqCHxwkJ8EkT
	 1ClJTY7s0c8/guWHCal+kewFg2hGawMsSnC4Zq/u+QhJn+5BbwQhHuxlDCKqeMV2Ok
	 OuXBgoQiwQ9OA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCBD3C43440;
	Fri, 12 Apr 2024 02:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] flow_offload: fix flow_offload_has_one_action() kdoc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171289023089.15367.17253750888058630494.git-patchwork-notify@kernel.org>
Date: Fri, 12 Apr 2024 02:50:30 +0000
References: <20240410114718.15145-1-ast@fiberby.net>
In-Reply-To: <20240410114718.15145-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 pieter.jansenvanvuuren@netronome.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Apr 2024 11:47:17 +0000 you wrote:
> include/net/flow_offload.h:351: warning:
>   No description found for return value of 'flow_offload_has_one_action'
> 
> Fixes: ab79af32b0a5 ("mlxsw: use intermediate representation for matchall offload")
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>  include/net/flow_offload.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] flow_offload: fix flow_offload_has_one_action() kdoc
    https://git.kernel.org/netdev/net-next/c/e1eb10f8ef10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



