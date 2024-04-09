Return-Path: <linux-kernel+bounces-137040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F4F89DB79
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3525EB228F2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D04E12F59E;
	Tue,  9 Apr 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfSgojQT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD1C12F585;
	Tue,  9 Apr 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671228; cv=none; b=Gr484KpJKutTnUp5xdq+amyKTZMpNqUQgye9ZrC0JAOZLYvq8PdF3adsSVgWwaGPmDz5HASaMVm/Pc+lgWVWDmrjEn/ue4zaJQqlj4LT/7ZvwzPXYW/QMN9UkiUnqqLvnjlmW9PBz0ltvZuoRp08VonKRETdLI33nmrVFdJlMYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671228; c=relaxed/simple;
	bh=3imqkCaF0cUyufJVCbO+U0FzUIq5rDIjHYANKbEr5gQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TX9QbhhJhbpHhuDY4gUKE/LkndTkVkjsnoN4zWccS656ueuOumswwHBEE5FVu/jhMeMUh85/1wwKnGK0IhmwFx7uHxOgZuj2fW8l2sNF5fi61qpMo9+XMm8s6da08yzUqMQwl1rvy1TaCxsMsu4/+s5mMkpbsMacyzENUb5KBuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfSgojQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E9B0C43394;
	Tue,  9 Apr 2024 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712671228;
	bh=3imqkCaF0cUyufJVCbO+U0FzUIq5rDIjHYANKbEr5gQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kfSgojQToREe1AnpRsrJ9xZqHeOdDGf1PsYfQpKiv5S03fwMOMTYSokV9KgAAMQad
	 /CoEuaPwgQK02Tzxnr3IKF2BomxcydkhdTlAeMRZAb+jSTOuwqMtURUd/qK023VEO5
	 8+CB37LJtbbs3jgIkO5wWMZviOTYyk2cNvop6V4AeOFtBZtkonngwZ2/ZMz6vz3Pkx
	 aHMykdf0vGsFw0HPu6Wi1wWPL99gjLStOQFylfZiqgkmOI1G0rYLtkfMhc9+CQRkZ4
	 pjaZtbhgslJr6ixOSTHU91cikQ0ueAmX+Akrmx6wNWbLSHwNjAJDxQNQstLS/GXkk6
	 07+Oxm795KdvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C961C395F6;
	Tue,  9 Apr 2024 14:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] ipv6: fib: hide unused 'pn' variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171267122804.20541.9875437937830919479.git-patchwork-notify@kernel.org>
Date: Tue, 09 Apr 2024 14:00:28 +0000
References: <20240408074219.3030256-1-arnd@kernel.org>
In-Reply-To: <20240408074219.3030256-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, arnd@arndb.de, leitao@debian.org,
 thinker.li@gmail.com, chentao@kylinos.cn, kuniyu@amazon.com,
 vnuorval@tcs.hut.fi, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  8 Apr 2024 09:42:02 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_IPV6_SUBTREES is disabled, the only user is hidden, causing
> a 'make W=1' warning:
> 
> net/ipv6/ip6_fib.c: In function 'fib6_add':
> net/ipv6/ip6_fib.c:1388:32: error: variable 'pn' set but not used [-Werror=unused-but-set-variable]
> 
> [...]

Here is the summary with links:
  - [1/2] ipv6: fib: hide unused 'pn' variable
    https://git.kernel.org/netdev/net/c/74043489fcb5
  - [2/2] ipv4/route: avoid unused-but-set-variable warning
    https://git.kernel.org/netdev/net/c/cf1b7201df59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



