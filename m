Return-Path: <linux-kernel+bounces-94974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B09E487476D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47599281C5F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCB72421A;
	Thu,  7 Mar 2024 04:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2Th6j+B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62AE1BC56;
	Thu,  7 Mar 2024 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709786431; cv=none; b=QfT5mGgzlVGh4Fm+NohN3NcDpQ2UoRL8eiSFi/yE0NhKVmwzKzFOdV1ikp2kCN0x0rG1YAqctm3dO7eGpLk2zNe4o53YXF1+vr+I+nU5cE1nP++oRNV7jH9mD3is/t+qql+Vm1LZuvp6L6FSSZyvN/UMnllwYysgH136oeqcor4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709786431; c=relaxed/simple;
	bh=oWQ8k864w4vkTmNo/1e1A064OVjilSU6x9OOmcthMuY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JLWT8pPvFVGErY1VCNwUCrZaI5++h1WluUXS19ZUW5ly1uonib47SlFiOgt+YkWHKoJmVe4Xd/Cc2ZskqC1rVliTCg7+CAKsxdtiCuzgL3mQANKkplm/BjFbpLXClZmWadZQNijXwF0gwZSwZ2tqwam11vVckqatozmWKoW2x9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2Th6j+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B73DC41606;
	Thu,  7 Mar 2024 04:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709786431;
	bh=oWQ8k864w4vkTmNo/1e1A064OVjilSU6x9OOmcthMuY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n2Th6j+BGGCGrFm7Zi7vNUbTWrWuWjzILTLUC+1KTW01BP9KHNhVW1c6Bz8eePbVE
	 c0zh/KsI4EJLHABIOCLgLEkrvqySve7YSQcQG9ujskKG4UEexiCj5cbxP3+Arujgo2
	 hYY/CxGkMK5l2KO8UiMi2EcmNCanuN5VSIHSL7Y0ULpA+CNB44VlZYOdTrD1RJT38M
	 ECCOCh+kWwD7oGuhwyAm8f0QR85+0fE0IWJQrOCO7qQxaj1+6/ojNY+a6pqJGMxnOa
	 yFAk9mVzX7fl9TseTdJZm8IaPSsK8jVOV/McATqnj2+q7TfczFRN6a5H5BDP8oaKL7
	 lBuVezuxpgP0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 014A8D88F81;
	Thu,  7 Mar 2024 04:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] mptcp: some clean-up patches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170978643100.7855.15154832484312373588.git-patchwork-notify@kernel.org>
Date: Thu, 07 Mar 2024 04:40:31 +0000
References: <20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-0-c436ba5e569b@kernel.org>
In-Reply-To: <20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-0-c436ba5e569b@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 tanggeliang@kylinos.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 05 Mar 2024 12:04:29 +0100 you wrote:
> Here are some clean-up patches for MPTCP:
> 
> - Patch 1 drops duplicated header inclusions.
> 
> - Patch 2 updates PM 'set_flags' interface, to make it more similar to
>   others.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] mptcp: drop duplicate header inclusions
    https://git.kernel.org/netdev/net-next/c/d5dfbfa2f88e
  - [net-next,2/4] mptcp: update set_flags interfaces
    https://git.kernel.org/netdev/net-next/c/6a42477fe449
  - [net-next,3/4] mptcp: set error messages for set_flags
    https://git.kernel.org/netdev/net-next/c/a4d68b160240
  - [net-next,4/4] mptcp: drop lookup_by_id in lookup_addr
    https://git.kernel.org/netdev/net-next/c/af250c27ea1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



