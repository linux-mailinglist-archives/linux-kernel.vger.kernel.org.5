Return-Path: <linux-kernel+bounces-83038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A2D868D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F27284F50
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213881386CA;
	Tue, 27 Feb 2024 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfvCUwI4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B32A8C1;
	Tue, 27 Feb 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029832; cv=none; b=BSJ9fIeGiRSbfNaP2k9VRS/kGivSCaUPWOsCc9IX3AaGKWw/i1ubHt9mhbljAgPopNXRco00lpEGd7i78ge8AkYMagfNKrdi9Zk34Ci96A1d20HiMgOwSQsOWnUiFyQmlB+lJbGTjZCKjbjqkcSJTSjL7I7dbXz8NP2FmMJUCG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029832; c=relaxed/simple;
	bh=b+TmIZM1BbzBrs8DPklmaQytiyICHGa9Tx0B0KH98gs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VSveGgxwYQ8PB9ECV6maG7yxddVI57VJT9Zql/gT57DClz/dOzaLZfdORbFvmE8MLVYMd0mSsQPdeXBhFwsbjOYQ5Y8H0BsuYEajiWPg5055ywTvKAQKRTo/fJON/ZGyJ2KpDny7m1PF8Tya5vsQjRVCpZ21alS4/DQeMZV5dPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfvCUwI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FA02C43390;
	Tue, 27 Feb 2024 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709029831;
	bh=b+TmIZM1BbzBrs8DPklmaQytiyICHGa9Tx0B0KH98gs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YfvCUwI4tvPaW9gmzzc/9luJe2CCvi77NHfMBnrR9KbKUi7UQp0XND5fbAU8FDL2f
	 4m0IW4qTGP/pLECfqC7GE8s0urYua2Sgp8CYnYXAWqkiLXZd8dHIZRUUpCYjRtgQUI
	 nL1VgSSugvKLl7qctMTJEVjiF8e5S2YaF3Y8y2awb3vZaEHQnB1s9+cIb3HcCIghKA
	 +Z0Zaz3RUkIp1Rkw7boGBTFAL2+cSpZAWXEBSSozXPL2s1fXe5DWc95YzifMvgFJqz
	 dq9PC9GpU1vle625tJ/N0hefzWyuwFUHgzdzQ7GT1/YZ0qmDZsA2P8+F/+EDwj2QMe
	 Imr//gcJaiPRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7957D88FB6;
	Tue, 27 Feb 2024 10:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] net: ipa: don't abort system suspend
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170902983094.8915.2318266650538047473.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 10:30:30 +0000
References: <20240223133930.582041-1-elder@linaro.org>
In-Reply-To: <20240223133930.582041-1-elder@linaro.org>
To: Alex Elder <elder@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mka@chromium.org, andersson@kernel.org,
 quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
 quic_jponduru@quicinc.com, quic_subashab@quicinc.com, elder@kernel.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 23 Feb 2024 07:39:24 -0600 you wrote:
> Currently the IPA code aborts an in-progress system suspend if an
> IPA interrupt arrives before the suspend completes.  There is no
> need to do that though, because the IPA driver handles a forced
> suspend correctly, quiescing any hardware activity before finally
> turning off clocks and interconnects.
> 
> This series drops the call to pm_wakeup_dev_event() if an IPA
> SUSPEND interrupt arrives during system suspend.  Doing this
> makes the two remaining IPA power flags unnecessary, and allows
> some additional code to be cleaned up--and best of all, removed.
> The result is much simpler (and I'm really glad not to be using
> these flags any more).
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] net: ipa: don't bother aborting system resume
    https://git.kernel.org/netdev/net-next/c/4b2274d3811a
  - [net-next,2/6] net: ipa: kill IPA_POWER_FLAG_SYSTEM
    https://git.kernel.org/netdev/net-next/c/54f19ff7676f
  - [net-next,3/6] net: ipa: kill the IPA_POWER_FLAG_RESUMED flag
    https://git.kernel.org/netdev/net-next/c/dae5d6e8f0ec
  - [net-next,4/6] net: ipa: move ipa_interrupt_suspend_clear_all() up
    https://git.kernel.org/netdev/net-next/c/ef63ca78da2e
  - [net-next,5/6] net: ipa: kill ipa_power_suspend_handler()
    https://git.kernel.org/netdev/net-next/c/423df2e09d3b
  - [net-next,6/6] net: ipa: don't bother zeroing an already zero register
    https://git.kernel.org/netdev/net-next/c/f9345952e74a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



