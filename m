Return-Path: <linux-kernel+bounces-124369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E513B891653
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2296E1C23F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D83651C5E;
	Fri, 29 Mar 2024 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQK5wIan"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD784EB5C;
	Fri, 29 Mar 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705831; cv=none; b=lFGibctv+W8xxyaNp5aVAyiYOgxJvGeQG6agY8XhWck9Me1b/BlLrH7JOjwFMR+9gf7w/zI4J2qylzxV2hwkdTPbs9nD8PRvv41au8pY2S2yf7SH/+h56yr0qWGHwR3rex7EjYlmhTJC8DFS7kDwk+0Xq2dF5kpaPw4c8uB3L5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705831; c=relaxed/simple;
	bh=eMTLoTHaMEdpuznPin6LB7cDg9T39PigSeGqe4vpejU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UEQPrPytrRJYmPCFoijIql/MFqTp1EeGrw8GqCGw5GAv6w31XzBlOlhTy7HOvpNCgzjpRPLiudDalG3Bn8m23Sutyg4svz3zgisagloUMIMbEhNnW8dUM1qIcO1agYLnyNL512IE20XQEpheLLAW2e8vpK9WQu7FMo3YHa9qCpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQK5wIan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A269C43390;
	Fri, 29 Mar 2024 09:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711705831;
	bh=eMTLoTHaMEdpuznPin6LB7cDg9T39PigSeGqe4vpejU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nQK5wIanCx2nLHoDH+Itou/s5izdW83nB/jIhIwQyHn4SLTvrx9nWGilnRH8Iy2b1
	 e6opLLE1bGzwQDWzyD2Xb0OVZHLQniYh5115ygKriz8qH8GoZWRqH3Lo1xiiORW3pm
	 ISl/YrDorj5KuIpXyDZcm3zTM0LlNVHQTFGxGOBVxSSmAIcxq9yD+5OJ7X2AtxEwi1
	 pvmhoxqF2l/CokkIqJ6ecTh/0YcdcPJ49YeALvsZQZqZMKqiXMF/4RtB9vJ8lh+FCa
	 QIMSMik8QV/eHk+hJ9Dhn3n62EFd1UDAfXwnFE2M7hHXPQdpLsOuFVlEdbUl/gU6ny
	 b4Gx3y1z76CcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1DCA1D84BBA;
	Fri, 29 Mar 2024 09:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] make skip_sw actually skip software
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171170583110.24694.10907029333516266808.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 09:50:31 +0000
References: <20240325204740.1393349-1-ast@fiberby.net>
In-Reply-To: <20240325204740.1393349-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, mleitner@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llu@fiberby.dk

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 25 Mar 2024 20:47:33 +0000 you wrote:
> Hi,
> 
> During development of flower-route[1], which I
> recently presented at FOSDEM[2], I noticed that
> CPU usage, would increase the more rules I installed
> into the hardware for IP forwarding offloading.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] net: sched: cls_api: add skip_sw counter
    https://git.kernel.org/netdev/net-next/c/f631ef39d819
  - [net-next,v4,2/3] net: sched: cls_api: add filter counter
    https://git.kernel.org/netdev/net-next/c/2081fd3445fe
  - [net-next,v4,3/3] net: sched: make skip_sw actually skip software
    https://git.kernel.org/netdev/net-next/c/047f340b36fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



