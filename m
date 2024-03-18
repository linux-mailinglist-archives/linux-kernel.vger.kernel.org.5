Return-Path: <linux-kernel+bounces-106125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5444587E97A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A9B1F23295
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A8536B11;
	Mon, 18 Mar 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Enfm3adz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543321E49B;
	Mon, 18 Mar 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765628; cv=none; b=rS721cYsBY03NaY+hbKt7qquARqic54Q39NuXZekNAkxq/Y4auxLJEffF/YVhyVMBpsc8lnzRItEJ6ffGVFQo5Dapphlfph/hLetCmAd/excwoJgt6X2bSBvmnzYNNG//VETbb8/TRnsNA4uz4zqvPuQUy0caIUxMEQoPpDfh00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765628; c=relaxed/simple;
	bh=5XX7xe2v9TVwMD/Q7kw64MatCriscLje9aNzRQpdmKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pCcxxMAFXO4V7nehnEvYijYcvs3Abl7+UEp8I6N9q60XG+kP+dBcseO/RvQJirdkNG6eIJaKt9egvU2/2f8xt1rxf5T5OqpwINQCMvxtzjlq1wUEG1OTb44hPwpuqkBvXR6STIsuFFDKEBzh7fKr/1LkGjMy5wgwHrLwqM7JYq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Enfm3adz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFAABC433C7;
	Mon, 18 Mar 2024 12:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710765627;
	bh=5XX7xe2v9TVwMD/Q7kw64MatCriscLje9aNzRQpdmKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Enfm3adzTkG0gOHfGHXsJ5kFUygBBIvLr+lkMdhyabmfyuaWwsV5/rCe4XEMFygX+
	 mW8iQI3G8JD4MG+8MN+jFegzCzHS0XAGRSkgyvWvDFr9ZQRicq/pS2Dz+Z81zPFO0N
	 P5k6DQ19TpSrasIR8D2yWc3XofRHun3HhUkwmGOei3ByPM7z18I8cjSgUq03rIlNFS
	 d/YJD1vmALAFtGy2x7gSmkozlvtxM2YCPklEeW59/OCAFTse1mw8w+NuO8zOkHHE8n
	 2U1SDa1N8zj4VFMS8Mha4zaKjxdhj79vGJzohko/r/biwcFJZdHpbLl2C+LPrcpt/V
	 iqKX1o43ZK8YA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0061D95053;
	Mon, 18 Mar 2024 12:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] Revert "net: Re-use and set mono_delivery_time
 bit for userspace tstamp packets"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171076562784.6189.6426367474212497766.git-patchwork-notify@kernel.org>
Date: Mon, 18 Mar 2024 12:40:27 +0000
References: <20240314192404.1867189-1-quic_abchauha@quicinc.com>
In-Reply-To: <20240314192404.1867189-1-quic_abchauha@quicinc.com>
To: Abhishek Chauhan (ABC) <quic_abchauha@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ahalaney@redhat.com, willemdebruijn.kernel@gmail.com, martin.lau@kernel.org,
 martin.lau@linux.dev, daniel@iogearbox.net, kernel@quicinc.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Mar 2024 12:24:04 -0700 you wrote:
> This reverts commit 885c36e59f46375c138de18ff1692f18eff67b7f.
> 
> The patch currently broke the bpf selftest test_tc_dtime because
> uapi field __sk_buff->tstamp_type depends on skb->mono_delivery_time which
> does not necessarily mean mono with the original fix as the bit was re-used
> for userspace timestamp as well to avoid tstamp reset in the forwarding
> path. To solve this we need to keep mono_delivery_time as is and
> introduce another bit called user_delivery_time and fall back to the
> initial proposal of setting the user_delivery_time bit based on
> sk_clockid set from userspace.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] Revert "net: Re-use and set mono_delivery_time bit for userspace tstamp packets"
    https://git.kernel.org/netdev/net/c/35c3e2791756

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



