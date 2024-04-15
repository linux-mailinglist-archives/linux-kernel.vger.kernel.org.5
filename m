Return-Path: <linux-kernel+bounces-144847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E02988A4BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787951F22EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F1F4CB23;
	Mon, 15 Apr 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flRFcoxI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E40B42047;
	Mon, 15 Apr 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174029; cv=none; b=g4ZvKz0bV+HRTF2+74QO6rQLTBbI8M6h4xbDxAw/JjaSjJLO5Syfqar5hWPNzMQcMuqCGAEwy3ndThUm8qIMhAgG2P+DOzoNDuQl60tQWRjfjaRVnr87gGib87plbYL4bEbDtwco5JcjGxYi0uVVxOkkTldOXDEAqabGG+uhLlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174029; c=relaxed/simple;
	bh=9Mnn6qyJVMs37l9u8VTN36rF0wfvTVLYBRGBvMamy+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DygAySM4/dNKZCAKnriE3BfbsKUFD6CtYxr7hPHiJoZQBLZF/van/2sL5besem+pMgw0uNuUcyvpkag5KZjw/aBKtJAwORlq2TLmlgqzWCQ69lKuRFtgziJXfDUlRY5ArnAQQ8T1qnWjAItCS8RtkrE41X4U564sm22iQRXuZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flRFcoxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7798C4AF0A;
	Mon, 15 Apr 2024 09:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713174028;
	bh=9Mnn6qyJVMs37l9u8VTN36rF0wfvTVLYBRGBvMamy+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=flRFcoxIV91g34Pq4akuS25YB5DW7Lb3U7zD+QF4lv9YQXp+EEpONqdbFvA1T6XEe
	 QmuHQ3K8lBN12+9AatdPcO54w8A4uq+ggiXBh+lKNXKnRjZbw+d8QPbcLKc7B2jsLP
	 XU1Y3pM/AEmvEPPIQPoCJcIz0bydGNvQ71+Ldqaup0j8BvnQkUFH2y/ZkC4i/f0O+v
	 uA66jLSVSgMqMaO4rxBsrZBpuqr5O3KhVpmlwA/2v72m1tZBqGdFWFZKwivPwUa2wy
	 jAmdc8JHiqCHYBPdnaGUsTKkKTUHCsNsgcc1+EYurajkDs3kWcEdgWS4cWWM8VUgXP
	 /Can4b4sjP8Aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93B36C54BB3;
	Mon, 15 Apr 2024 09:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 12] gve: Correctly report software timestamping
 capabilities
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171317402860.10544.14389784477150957793.git-patchwork-notify@kernel.org>
Date: Mon, 15 Apr 2024 09:40:28 +0000
References: <20240412053245.3328123-1-jfraker@google.com>
In-Reply-To: <20240412053245.3328123-1-jfraker@google.com>
To: John Fraker <jfraker@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, shailend@google.com,
 willemb@google.com, davem@davemloft.net, jeroendb@google.com,
 kuba@kernel.org, junfeng.guo@intel.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 11 Apr 2024 22:32:29 -0700 you wrote:
> gve has supported software timestamp generation since its inception,
> but has not advertised that support via ethtool. This patch correctly
> advertises that support.
> 
> Signed-off-by: John Fraker <jfraker@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next,12] gve: Correctly report software timestamping capabilities
    https://git.kernel.org/netdev/net-next/c/4ca78e61ec70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



