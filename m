Return-Path: <linux-kernel+bounces-72853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA1585B987
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FAE8B22035
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2343065BD7;
	Tue, 20 Feb 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYWLhnon"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A3236AF9;
	Tue, 20 Feb 2024 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426226; cv=none; b=p3ytY28ceY1qG5vxbwvi1gEI19xxbkGCsn9VcgHfoZFo0SjYxNDY6uM0yoYVio9HF3GmtHMOqrZuNJuIS3ZMeex27ETNgqRCPkaiCdziHmG2w2CimixQ9eEHUbMid7RxiHHhFLYlvOM6KTxXC+PeMJOtJMofivvkGcc48vZHaNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426226; c=relaxed/simple;
	bh=PF3C2v2bJ8nOZbjCxBoQV+JB9F2kpYzfYk9jt5xt52I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tm6NPfwGDnjTSXcmslWZXmTIZTnJSjqBComvGfo09MLUHUqyMmAUaszfvoA7zr8dr7f/Ra4XHH1gF9inrCj9Ajaag3+3NxQOC8RvCoCNXdyv52z2+TTMCzFp0bU1CUp/3fE3/iXZKjX2ogPzw8dqWi+1ixatD2t8EP1q46PdFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYWLhnon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34ACEC43394;
	Tue, 20 Feb 2024 10:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708426226;
	bh=PF3C2v2bJ8nOZbjCxBoQV+JB9F2kpYzfYk9jt5xt52I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QYWLhnonhFmbIT2D5/1l9kNRAy4/Gnnu8D0clpuOnNGm2meiyWNMMwx8MJCMWLB34
	 Ge9ILEn6bteGG/95raX58jfc/WFdQp8kTd8zbKkJLBPrtEDooEvMWZ1e3jvm2rrnik
	 HKtzEhsdwO6w8pePszLDHyEZT+l8xCpinvsKzNAdx+MMoiR55sNYBCDe2EjlqHnTYw
	 nZrKOVfIKsEfhDJclsjZbnO2U71zeRGTlL7OAO03wTm2qBz22rPNoh6hOY7J4XUY6s
	 8r5fZg/tk6QlFI2x1t9jlHJ2beTFVzwtwDeFe5Pm2FZV0P0mpDQZbp7RLUv53xsAKE
	 UfpUDSb5p3xnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19051C04E32;
	Tue, 20 Feb 2024 10:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: tcp: Remove redundant initialization of variable
 len
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170842622609.26465.2350331717695265318.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 10:50:26 +0000
References: <20240216125443.2107244-1-colin.i.king@gmail.com>
In-Reply-To: <20240216125443.2107244-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 16 Feb 2024 12:54:43 +0000 you wrote:
> The variable len being initialized with a value that is never read, an
> if statement is initializing it in both paths of the if statement.
> The initialization is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> net/ipv4/tcp_ao.c:512:11: warning: Value stored to 'len' during its
> initialization is never read [deadcode.DeadStores]
> 
> [...]

Here is the summary with links:
  - [next] net: tcp: Remove redundant initialization of variable len
    https://git.kernel.org/netdev/net-next/c/465c1abcb644

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



