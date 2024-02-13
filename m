Return-Path: <linux-kernel+bounces-63518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4E28530AC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B0E1B24515
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B826405D8;
	Tue, 13 Feb 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQnejl48"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6761043ADC;
	Tue, 13 Feb 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828029; cv=none; b=It9/WqmEQqTJ6Fq0fqf9EsSjSe75Bu+YHPUapTnd9S0T/ocrhX6LfapnO4iOLmmmiE6cYN6mlp8HPt+fFnJTd8AONomMzvmOQMHhidEymVh1xdlMi9NhitEzE778c8auHpLltFm9jSQoTzGZQ1UAfPTDi2bIspIkX5xLr1qRWY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828029; c=relaxed/simple;
	bh=GA7RMWsqv1O0/MvrjqEvXE8vnean2zl18KUUMmaqY94=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K4s3oMfe1JCEPXRAYo+neyT39A9rLhrcXqS+YaronRLAlBoz75rif4f08nkXihxEs8O84UvumeangfoQNeu5Z0mY0Kmh0RWYpextko8Ct7TAHnNhVqo1ZLoldl1CVvB1FNG6nh2p7gZTyp0TQ5sa/VUwqCdcMRgRC8pRo2gVTVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQnejl48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6690C43390;
	Tue, 13 Feb 2024 12:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707828029;
	bh=GA7RMWsqv1O0/MvrjqEvXE8vnean2zl18KUUMmaqY94=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GQnejl48DuAomr5Lrdz/0ClwU3w1nLyaD5d6m9j/WLmQmIQh8Ny+JUmXtCpMfibem
	 wTEY0AHSlXCLsCqgrHKwkOIk/leqVIxkqRm1u0ZR03BCGky+tpEl35+l0OLrkpTbhE
	 HnmxqvDOp4pTBTiHL+9QCBidTaa1fWtcUXRQoV5q5YA9Y4vJ8sIlXP3h0OUxc4n20m
	 QhCPOvXsUYZs6FjlL1SeuBvtW7XcIkQ86TPp0HduwVXWc5QylDq6ld4VhnBc67hhjb
	 qvMEOzP08sDd8KRjF6zdmrHfbipRQlOe0E7IfhspGhr8kTvueYcTrKkAYGCzicF8Wv
	 ZMhtlBq5v+chQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9624C1614E;
	Tue, 13 Feb 2024 12:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ti: icssg-prueth: add dependency for PTP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170782802882.10603.17662061919205446405.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 12:40:28 +0000
References: <20240211061152.14696-1-rdunlap@infradead.org>
In-Reply-To: <20240211061152.14696-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, rogerq@ti.com, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 10 Feb 2024 22:11:52 -0800 you wrote:
> When CONFIG_PTP_1588_CLOCK=m and CONFIG_TI_ICSSG_PRUETH=y, there are
> kconfig dependency warnings and build errors referencing PTP functions.
> 
> Fix these by making TI_ICSSG_PRUETH depend on PTP_1588_CLOCK_OPTIONAL.
> 
> Fixes these build errors and warnings:
> 
> [...]

Here is the summary with links:
  - net: ti: icssg-prueth: add dependency for PTP
    https://git.kernel.org/netdev/net/c/e083dd032eeb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



