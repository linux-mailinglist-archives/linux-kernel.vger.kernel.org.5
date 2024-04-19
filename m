Return-Path: <linux-kernel+bounces-150915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDB18AA6AD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF3D1F2230C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B0853A1;
	Fri, 19 Apr 2024 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFqF7q82"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662027E1;
	Fri, 19 Apr 2024 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713491430; cv=none; b=N35gplS+NTAIFoE4NJyGhvv23CgvT9o2Fca8Z4HCw+bRarSSRx9JovUOfc1sm/ZJU1Y2/0wYMokTwk0uKrkcp+U3+vtCKY/I16L7yTA96NMFw2H7H8PyOumtmU9/j6XjkQRkkl4+IJXbGf2pzW4VUcBdcg22BhByHqeK5nHw+Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713491430; c=relaxed/simple;
	bh=P7QyU/lVlQX9RVc4B3xTSbRhqvl7Ll7dDC/jXXZ3nUY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AX0IT+rmNXuKJ97ZdIIk7zGwyvufRDeQCoB26KFiVteBa2+iRay9xs1NKfRToc8ii/f9ZGI8aRg0HlaCTrjNLfmPf9g/qY7Q9KyazwO8eTrSh3TYtr3dNX5GYdA1msNZ2v5WXQ3lCG5xQesHabvTFOynh5BOQIBn9hiL8iReUP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFqF7q82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06AE9C113CE;
	Fri, 19 Apr 2024 01:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713491430;
	bh=P7QyU/lVlQX9RVc4B3xTSbRhqvl7Ll7dDC/jXXZ3nUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HFqF7q82XO9yqLoY2842VZ0KZ1HZE3Lkmew0QsWU/QCNg+yYj3NVXn5cql4xxFj3p
	 Dc9PvPSTnNEv9Z6cnI0q/uMMcrk+JQs8dSf1CzJJg5RfuPGLXbIfnsM3n7GNaF8shO
	 Lju1YIWeiqq6oU1FkYoWvl79f6Ap7BoF5zYkqJfkbiukfnzt0eQW3gVNNlDACrwQHm
	 Btvw3TDJzqUKfPCxbahKM/IHGmTWY+aSXerDW6oSin6f7ePoTgAlxh3+eDskM6FMS9
	 Ge2AoNhdHebeqKpkJBFN02i7GK3D6LqbLbHhz31Wd5zx5Rqum79FplJA5sPAZGAUy+
	 2N77BxKBk+MFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E38B9C43619;
	Fri, 19 Apr 2024 01:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] gve: Remove qpl_cfg struct since qpl_ids map with
 queues respectively
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171349142992.11062.2278804601434624598.git-patchwork-notify@kernel.org>
Date: Fri, 19 Apr 2024 01:50:29 +0000
References: <20240417205757.778551-1-ziweixiao@google.com>
In-Reply-To: <20240417205757.778551-1-ziweixiao@google.com>
To: Ziwei Xiao <ziweixiao@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com,
 pkaligineedi@google.com, shailend@google.com, willemb@google.com,
 hramamurthy@google.com, rushilg@google.com, jfraker@google.com,
 junfeng.guo@intel.com, Julia.Lawall@inria.fr, horms@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Apr 2024 20:57:57 +0000 you wrote:
> The qpl_cfg struct was used to make sure that no two different queues
> are using QPL with the same qpl_id. We can remove that qpl_cfg struct
> since now the qpl_ids map with the queues respectively as follows:
> For tx queues: qpl_id = tx_qid
> For rx queues: qpl_id = max_tx_queues + rx_qid
> 
> And when XDP is used, it will need the user to reduce the tx queues to
> be at most half of the max_tx_queues. Then it will use the same number
> of tx queues starting from the end of existing tx queues for XDP. So the
> XDP queues will not exceed the max_tx_queues range and will not overlap
> with the rx queues, where the qpl_ids will not have overlapping too.
> 
> [...]

Here is the summary with links:
  - [net-next] gve: Remove qpl_cfg struct since qpl_ids map with queues respectively
    https://git.kernel.org/netdev/net-next/c/fdf412374379

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



