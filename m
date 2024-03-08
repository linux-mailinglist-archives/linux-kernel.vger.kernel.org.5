Return-Path: <linux-kernel+bounces-96830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EBB8761FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292EC1F21F59
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BA355C01;
	Fri,  8 Mar 2024 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBedlyFj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AC114A82;
	Fri,  8 Mar 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893834; cv=none; b=XlVLDF/REpLPknQ8ge+Eg928CHIcitb08L9zWwXgImeayr6JzHNUxa+pTaGu/SC3+KbycyIGL+5bmwkeSuM3QIpkWJ95BMiKWEV+IilN4IK+gnW/yF3/EFEmpvb0OMh6XtkpVwYrzLmb/FXNlW625X6umJ3wkxLeiZBOksOQjGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893834; c=relaxed/simple;
	bh=j5uI7aSimtgzTLs49rbKceY9hxo7Y46tdvilI1JCt08=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AJZs8ANX/OknsrDYheJUV3CjkpVXlntOY+eozGXrRLVLSpV8c/5JHF764X+KeClTI5+4g7f3pb1yZyF/Fy2u4ZfVB9dm9A8DF19XkzG+Hy2Qq54rI7dOHv1O8KFz1unjHmLYmS2GXAxbJAP4v4MgAeo9SZXIkrXHOv0E/SOsa3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBedlyFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18824C433C7;
	Fri,  8 Mar 2024 10:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709893834;
	bh=j5uI7aSimtgzTLs49rbKceY9hxo7Y46tdvilI1JCt08=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TBedlyFjbR6LYj82pqMlUgdnZnRR8Z+zPH4lljli9qVPUiQ8QRg/6agPW86sDIx8c
	 vFhOH6cVaqbLDp1pZuQhO+uws4GN8kwPj2+zqGn6HhEQtBO3W4cJ0K1k80/9JrB2Pd
	 kbiLLlyKStvGtZszqFwg1EgHy2Q3LCk6qrsy+ZsOmjacEDAXWV5EcJN1Dq7PoRGkFN
	 tvtuMSKRjDglX4fFPeMaQoVwFF1ZxWZ4BjckhNT7MgDFcs4zDW0svfnd5oiUYjkzBV
	 dMojfu9Ow3hG9AUSnapGIfrKxfP+xEoDMNUA7Tbl5SHVay6jYdcl8+dM1Eg2agI1qB
	 BuGwKRbb1cYEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7C10D84BBF;
	Fri,  8 Mar 2024 10:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] tcp: Add skb addr and sock addr to arguments of
 tracepoint tcp_probe.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170989383394.12583.17811930111770070930.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 10:30:33 +0000
References: <20240305030358.GA13138@didi-ThinkCentre-M920t-N000>
In-Reply-To: <20240305030358.GA13138@didi-ThinkCentre-M920t-N000>
To: fuyuanli <fuyuanli@didiglobal.com>
Cc: edumazet@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 5 Mar 2024 11:04:17 +0800 you wrote:
> It is useful to expose skb addr and sock addr to user in tracepoint
> tcp_probe, so that we can get more information while monitoring
> receiving of tcp data, by ebpf or other ways.
> 
> For example, we need to identify a packet by seq and end_seq when
> calculate transmit latency between layer 2 and layer 4 by ebpf, but which is
> not available in tcp_probe, so we can only use kprobe hooking
> tcp_rcv_established to get them. But we can use tcp_probe directly if skb
> addr and sock addr are available, which is more efficient.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] tcp: Add skb addr and sock addr to arguments of tracepoint tcp_probe.
    https://git.kernel.org/netdev/net-next/c/caabd859c41b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



