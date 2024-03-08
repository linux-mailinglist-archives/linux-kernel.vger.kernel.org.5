Return-Path: <linux-kernel+bounces-96520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353B0875D73
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DE0283256
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD8E36139;
	Fri,  8 Mar 2024 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0X7bSyg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7433E2E65B;
	Fri,  8 Mar 2024 05:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709874641; cv=none; b=TWoqOZXqcT2x2zRsWOsatXdDEM6MX56ffRaVt+Umm21Bd6mWO+06Dh1BvusC9BTCl2rp7RqI2Ym6hFcPQMiwIhlOYkl7TKqREtSFL83/IjM8Vy2RPK3MFoGffYos1cPdqfiCgJN0KMmwOq1/gUOxcXwSdpa0WFbMAmxuwvklYIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709874641; c=relaxed/simple;
	bh=HztKOIg4+66lGu7czS+0k1V+1CxY0EBqO13dTWTKoBQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I9T5vU+P8QUtxNhvwHWjWuCqwXQ2qM7zO0dzEt5cE1YbNFtUPh3H1jkE76ImZF5jSbdVBivDznxMRUcUZkr62kmw4I+Ap4VYWjgKMmRdqCJH6McbUE9vutZbiWdfedSSxmpWxDLara78FgXdwiIGaob1I8A3Va7hecIcl0pA0DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0X7bSyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDABAC43390;
	Fri,  8 Mar 2024 05:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709874641;
	bh=HztKOIg4+66lGu7czS+0k1V+1CxY0EBqO13dTWTKoBQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m0X7bSygxms7Saliz5w6r+X1fdN5mTyVR8IszbQvetGR5fdl9DNihlDV1QTZO9Z3M
	 m8gbbBzbwSCYtNKAnieS18N6hJZLbe/inag3MG+2RtcKYnR0oxPbi4fYR+t7eMPIpP
	 z3//AglzOt+grvT1UYRH87qHvUjIgJXz8rgLlqaLHKlrZaS2xmKq2/7V7GkCGe653Q
	 xcDkmfxzkuQjhXfx2en/vvBFDdCRmAW22JVRKZRalEEdYNaAx0QYsf90B0+WfAT7da
	 iTc9B3xesi16KHeQPrCMdiJTEjO3Knv4+GPpJtrSntsOmRoUFX3OKgORiwAwJdbWrI
	 xZo8xFPnHhF7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D34E4D84BBF;
	Fri,  8 Mar 2024 05:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/21] rxrpc: Miscellaneous changes and make use
 of MSG_SPLICE_PAGES
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170987464085.14945.491149931271263670.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 05:10:40 +0000
References: <20240306000655.1100294-1-dhowells@redhat.com>
In-Reply-To: <20240306000655.1100294-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, horms@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David Howells <dhowells@redhat.com>:

On Wed,  6 Mar 2024 00:06:30 +0000 you wrote:
> Here are some changes to AF_RXRPC:
> 
>  (1) Cache the transmission serial number of ACK and DATA packets in the
>      rxrpc_txbuf struct and log this in the retransmit tracepoint.
> 
>  (2) Don't use atomics on rxrpc_txbuf::flags[*] and cache the intended wire
>      header flags there too to avoid duplication.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/21] rxrpc: Record the Tx serial in the rxrpc_txbuf and retransmit trace
    https://git.kernel.org/netdev/net-next/c/ba132d841d56
  - [net-next,v3,02/21] rxrpc: Convert rxrpc_txbuf::flags into a mask and don't use atomics
    https://git.kernel.org/netdev/net-next/c/12bdff73a147
  - [net-next,v3,03/21] rxrpc: Note cksum in txbuf
    https://git.kernel.org/netdev/net-next/c/41b8debba79c
  - [net-next,v3,04/21] rxrpc: Fix the names of the fields in the ACK trailer struct
    https://git.kernel.org/netdev/net-next/c/17469ae0582a
  - [net-next,v3,05/21] rxrpc: Strip barriers and atomics off of timer tracking
    https://git.kernel.org/netdev/net-next/c/d73f3a748875
  - [net-next,v3,06/21] rxrpc: Remove atomic handling on some fields only used in I/O thread
    https://git.kernel.org/netdev/net-next/c/693f9c13ec89
  - [net-next,v3,07/21] rxrpc: Do lazy DF flag resetting
    https://git.kernel.org/netdev/net-next/c/d32636982ce9
  - [net-next,v3,08/21] rxrpc: Merge together DF/non-DF branches of data Tx function
    https://git.kernel.org/netdev/net-next/c/1ac6a8536c2c
  - [net-next,v3,09/21] rxrpc: Add a kvec[] to the rxrpc_txbuf struct
    https://git.kernel.org/netdev/net-next/c/ff342bdc59f4
  - [net-next,v3,10/21] rxrpc: Split up the DATA packet transmission function
    https://git.kernel.org/netdev/net-next/c/44125d5aadda
  - [net-next,v3,11/21] rxrpc: Don't pick values out of the wire header when setting up security
    https://git.kernel.org/netdev/net-next/c/a1c9af4d4467
  - [net-next,v3,12/21] rxrpc: Move rxrpc_send_ACK() to output.c with rxrpc_send_ack_packet()
    https://git.kernel.org/netdev/net-next/c/99afb28c676c
  - [net-next,v3,13/21] rxrpc: Use rxrpc_txbuf::kvec[0] instead of rxrpc_txbuf::wire
    https://git.kernel.org/netdev/net-next/c/8985f2b09b33
  - [net-next,v3,14/21] rxrpc: Do zerocopy using MSG_SPLICE_PAGES and page frags
    https://git.kernel.org/netdev/net-next/c/49489bb03a50
  - [net-next,v3,15/21] rxrpc: Parse received packets before dealing with timeouts
    https://git.kernel.org/netdev/net-next/c/3e0b83ee535d
  - [net-next,v3,16/21] rxrpc: Don't permit resending after all Tx packets acked
    https://git.kernel.org/netdev/net-next/c/a711d976e1cd
  - [net-next,v3,17/21] rxrpc: Differentiate PING ACK transmission traces.
    https://git.kernel.org/netdev/net-next/c/12a66e77c499
  - [net-next,v3,18/21] rxrpc: Use ktimes for call timeout tracking and set the timer lazily
    https://git.kernel.org/netdev/net-next/c/153f90a066dd
  - [net-next,v3,19/21] rxrpc: Record probes after transmission and reduce number of time-gets
    https://git.kernel.org/netdev/net-next/c/4d267ad6fd56
  - [net-next,v3,20/21] rxrpc: Clean up the resend algorithm
    https://git.kernel.org/netdev/net-next/c/37473e416234
  - [net-next,v3,21/21] rxrpc: Extract useful fields from a received ACK to skb priv data
    https://git.kernel.org/netdev/net-next/c/4b68137a20bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



