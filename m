Return-Path: <linux-kernel+bounces-14439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56B7821D15
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AEC21F221BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170CD10958;
	Tue,  2 Jan 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OY7wRbpb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56598125D2;
	Tue,  2 Jan 2024 13:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3072C433C9;
	Tue,  2 Jan 2024 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704203431;
	bh=yF43n7Egk9nubHF5BP9kxh8uwESoIhtJ3XsgoBQXxGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OY7wRbpbc1JR79jpDs2h/nQEeutsw7qx7BDsppMZxXCwp7t6RKfi2rAzTMXmMxGXZ
	 B4Q3seqY6aXJQQanu0Ej2119/ftGD/ksx34oUNebkXdcVhdHVlKYUyehj593XTkwIQ
	 tSOv9LxZqjVbahfsv9Ev6HGq9mogHiwrk2dl6Ge2DbLct9ZkrOe5ZZ15qZlRNh0fGV
	 uIfi7oX9W047p3AhDktYqPyaPmkdveIMbMC7sr1mhJn4+HPtCsco7WE2Xn4CZ+GKhZ
	 rD3wrFkCPAykVXPyhttTs+Dzylq5qGoke9n5l/+BGJWfqgqixC6n0WOYV1zjSfuLHH
	 GgS/qRW2mI+ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2A75C395C5;
	Tue,  2 Jan 2024 13:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] mptcp: add CurrEstab MIB counter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170420343079.29739.4868758916667609941.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 13:50:30 +0000
References: <20231222-upstream-net-next-20231221-mptcp-currestab-v1-0-c1eb73d6b2b2@kernel.org>
In-Reply-To: <20231222-upstream-net-next-20231221-mptcp-currestab-v1-0-c1eb73d6b2b2@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 geliang.tang@linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 22 Dec 2023 13:47:21 +0100 you wrote:
> This MIB counter is similar to the one of TCP -- CurrEstab -- available
> in /proc/net/snmp. This is useful to quickly list the number of MPTCP
> connections without having to iterate over all of them.
> 
> Patch 1 prepares its support by adding new helper functions:
> 
>  - MPTCP_DEC_STATS(): similar to MPTCP_INC_STATS(), but this time to
>    decrement a counter.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] mptcp: add CurrEstab MIB counter support
    https://git.kernel.org/netdev/net-next/c/d9cd27b8cd19
  - [net-next,2/4] mptcp: use mptcp_set_state
    (no matching commit)
  - [net-next,3/4] selftests: mptcp: join: check CURRESTAB counters
    https://git.kernel.org/netdev/net-next/c/0bd962dd86b2
  - [net-next,4/4] selftests: mptcp: diag: check CURRESTAB counters
    https://git.kernel.org/netdev/net-next/c/81ab772819da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



