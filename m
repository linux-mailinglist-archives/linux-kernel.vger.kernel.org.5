Return-Path: <linux-kernel+bounces-88119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8793786DD8A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364E928498C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5855D6A8B6;
	Fri,  1 Mar 2024 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPcavvos"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACAA6A034;
	Fri,  1 Mar 2024 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283031; cv=none; b=fnZoQIvKawQ2VHFiGybMuQdnfa3OFNnw+iZqz9pvURdm/pP5rw/aC4I28fNgtrUfHbUvXcyN2pGIWKcmYUmyyuDHrdtY9q5Z7GV/5IfopEGKEAANefM/PFfk2eIqK/0DieR5y3q4qoRFdRQp3NQefUOW7mx+dsK/WsxKA32zwCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283031; c=relaxed/simple;
	bh=W+ElAkxps07YiXLORB5OqpZCpe09DVJd0YWymfLyQzc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F4+2qbFi7dagR2vH00E/r01Y1l5gwm1bakkJQmTouepEOBESHz0numemt//OETtKECYdU8GxWsA8G7ZBPkEneOGHmNig5UuXK1HuloB9ecmz+6Qk2YjEXddUzKAcEKEcKwspv+u77QSyNmPWj9YgKTltbN6pIMB/+UfOLcvxiNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPcavvos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B2C0C433B1;
	Fri,  1 Mar 2024 08:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709283031;
	bh=W+ElAkxps07YiXLORB5OqpZCpe09DVJd0YWymfLyQzc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hPcavvoslxa/n5DIPawhU8r7qc8G7nQ9Xd77D0w+/5EBPDLN5U8hUJjmAmq1FwW1o
	 ZeScvaq3crg/ZIYKYfwHhXbmgfC9OdXMa0LbWuhfpDAt6eLxnxIV0ZdM/TX9zGs3A0
	 575HL2wv3TZsT0n7Oc9IYxqFO/VUkgOcksN5ypNTLXWdAm43cEBIEHDDi1kXkAMzck
	 jTUrhG8BxylMXKM74HSbem+y9Ev8zgpgEpJPfQTkTe5XlJT2w+BZlSSsK12KME8I6d
	 VrmJaz4U/2CN5js9va0t9vpbe9W3pxHyOAMnY+XwJajFotqZHw1B1lolbhMCrdXiT4
	 fySRDJhCGa2fw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7E2AD990B0;
	Fri,  1 Mar 2024 08:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Simplify net_dbg_ratelimited() dummy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170928303094.20263.16511055444255974157.git-patchwork-notify@kernel.org>
Date: Fri, 01 Mar 2024 08:50:30 +0000
References: <5d75ce122b5cbfe62b018a7719960e34cfcbb1f2.1709128975.git.geert+renesas@glider.be>
In-Reply-To: <5d75ce122b5cbfe62b018a7719960e34cfcbb1f2.1709128975.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 28 Feb 2024 15:05:29 +0100 you wrote:
> There is no need to wrap calls to the no_printk() helper inside an
> always-false check, as no_printk() already does that internally.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/linux/net.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] Simplify net_dbg_ratelimited() dummy
    https://git.kernel.org/netdev/net-next/c/f29f9199c2d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



