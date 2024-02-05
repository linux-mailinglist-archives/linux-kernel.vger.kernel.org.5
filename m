Return-Path: <linux-kernel+bounces-52475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F096D8498AE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F41E1C22571
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F8F18E27;
	Mon,  5 Feb 2024 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8WLBJe4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45AC18AF6;
	Mon,  5 Feb 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132029; cv=none; b=VmeEVMDwGw7MgVHBi55Lq0Tshq6zkzfVsVNkE44UnSKyUG/5/mOV97luuwTC7LOlvnlbi7WQd1ka6O9lY5OBdkFegdFklY/TMqik7gdYr9utp2GpdqpoukPifguWuQZKW54UX/cPDAW+35fJpRh2//9DkXzE70i62dxfHRQ08M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132029; c=relaxed/simple;
	bh=c7Fj/wPtiOUubtTF3wjdUAiVTE4AOhMVnaoeCU913dE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DSqOSzs0ySPR0p8FLaG1cyiHzKERZEY4Ic65fDa7937KuK9RRoCMsLsS46RcT1ZHXHPjOAwSc27JemCnmcPE9owtcAiBznSBNHGnRBM5ukxCxw80wqAvPpviXYuZCvKiwmT7XSTOdw5+e5OB1zWqy00b++DdQexkF6VHWl5k/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8WLBJe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 454D5C43399;
	Mon,  5 Feb 2024 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707132029;
	bh=c7Fj/wPtiOUubtTF3wjdUAiVTE4AOhMVnaoeCU913dE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R8WLBJe4UHRafytugFoYiqA/o3spzg9R4i70/j3gU36jMNwkjQSdPfERjiX3Wwmqy
	 FYnAW6KZ6zVckqPA/1+LNlq7+yaV0ouaBj8UE0DX5+HLSS6gk8kTzN9e9xDA/XFeXP
	 ZB2uYZs2ERuQ/xPmV9xRD2bk1MjUl+A8AFU0XNdrOhxDIz5+JxzL8wdd3uIe+0phGc
	 8mosYsB+BpLBqt8RNrUNy86VosEna++048gEqH2BRg966S33RwzQ+cYK916pkKa65s
	 EbbmoDSBfHbGZYMoNac6iN2M3ss4GgV6sGo6zsEwzEB6eQEtltyV2nuAc1W0nqO6wf
	 5ETH66XFaliqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32448E2F2F2;
	Mon,  5 Feb 2024 11:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] mptcp: annotate lockless access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170713202920.23951.439284843602275473.git-patchwork-notify@kernel.org>
Date: Mon, 05 Feb 2024 11:20:29 +0000
References: <20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-v1-0-031d6680afdc@kernel.org>
In-Reply-To: <20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-v1-0-031d6680afdc@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang.tang@linux.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 02 Feb 2024 12:40:06 +0100 you wrote:
> This is a series of 5 patches from Paolo to annotate lockless access.
> 
> The MPTCP locking schema is already quite complex. We need to clarify it
> and make the lockless access already there consistent, or later changes
> will be even harder to follow and understand.
> 
> This series goes through all the msk fields accessed in the RX and TX
> path and makes the lockless annotation consistent with the in-use
> locking schema.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] mptcp: annotate access for msk keys
    https://git.kernel.org/netdev/net-next/c/1c09d7cbb57a
  - [net-next,2/5] mptcp: annotate lockless access for the tx path
    https://git.kernel.org/netdev/net-next/c/d440a4e27acd
  - [net-next,3/5] mptcp: annotate lockless access for RX path fields
    https://git.kernel.org/netdev/net-next/c/9426ce476a70
  - [net-next,4/5] mptcp: annotate lockless access for token
    https://git.kernel.org/netdev/net-next/c/b9f4554356f6
  - [net-next,5/5] mptcp: annotate lockless accesses around read-mostly fields
    https://git.kernel.org/netdev/net-next/c/28e5c1380506

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



