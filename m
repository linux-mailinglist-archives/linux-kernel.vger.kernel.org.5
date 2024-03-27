Return-Path: <linux-kernel+bounces-120667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E737088DB43
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E4A1C25F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868684F1FC;
	Wed, 27 Mar 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdUJk/6X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53994DA00;
	Wed, 27 Mar 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535429; cv=none; b=APSvtf8H4Ynq1stNYzLR/dO3Es6W9BcXudDMzMDBRgjT0iZNqfuMKCyiAwnMVzVRA77LEAt1vdYkM+MzEEvRZJP3FgJyYPwRF01qX2h8UdeFc81v+f8hXg6Q2WzMKueqx8p7mpm+tpPm1xr6fnmIy8aV97Oja0zSVbqRBj1aIKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535429; c=relaxed/simple;
	bh=bzSjKLAxq1T4vYKTzzoKb+f7Ma4B9HNjOz2UfsLO85k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K9xbojhY+B9IrD4b2H/8oXWLMQQtuRztHOB/uvXE6lfw34KUC2v+t0NQ4RlXux5YEhoKl9x/UaNMccCyL6PZRErKu2RRkYPl5D6EcjCIcLjOq8ytM1GhQgt8EAC6+zt5q0lqs6tInGt2uewb1qFrkurgraL95HcCYjQzPJzayGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdUJk/6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19C93C43390;
	Wed, 27 Mar 2024 10:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711535429;
	bh=bzSjKLAxq1T4vYKTzzoKb+f7Ma4B9HNjOz2UfsLO85k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sdUJk/6Xu+P3/aylX33dpTbS42FVBksPVx8qVuArBVcXtn+xfjzh9arFShRkyVqq8
	 /IwNTwcpnrpPx9FzsUue4BE4Q4MMAT6Oqlr0lDUeApDBuuPFD545w0MlHDT9EMp+gz
	 nd+8oZg0xMN+WDV4ReJpJpl9ic9I6bosWWIq5y9kgeBo7g518ZHsqrjNAj/Mc+nIXP
	 HB5i6RZfLeJ27r0dgckaZV/bc3Pt2XeIDxe25NhIESztAjEx3NvEi3xZZ3wpGreFzF
	 D49rtGnNUWM4viGV2r6G2E28D1KTAi3ewk9wr3qSSc/4g875R6vY9D3P4F7igtizx6
	 +Gogjeu5ZP65Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 089E4D2D0EE;
	Wed, 27 Mar 2024 10:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wan: framer: Add missing static inline qualifiers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171153542903.20945.16861388246431708832.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 10:30:29 +0000
References: <20240325082505.29385-1-herve.codina@bootlin.com>
In-Reply-To: <20240325082505.29385-1-herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linus.walleij@linaro.org, christophe.leroy@csgroup.eu,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 andriy.shevchenko@linux.intel.com, thomas.petazzoni@bootlin.com,
 lkp@intel.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 25 Mar 2024 09:25:05 +0100 you wrote:
> Compilation with CONFIG_GENERIC_FRAMER disabled lead to the following
> warnings:
>   framer.h:184:16: warning: no previous prototype for function 'framer_get' [-Wmissing-prototypes]
>   184 | struct framer *framer_get(struct device *dev, const char *con_id)
>   framer.h:184:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>   184 | struct framer *framer_get(struct device *dev, const char *con_id)
>   framer.h:189:6: warning: no previous prototype for function 'framer_put' [-Wmissing-prototypes]
>   189 | void framer_put(struct device *dev, struct framer *framer)
>   framer.h:189:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>   189 | void framer_put(struct device *dev, struct framer *framer)
> 
> [...]

Here is the summary with links:
  - net: wan: framer: Add missing static inline qualifiers
    https://git.kernel.org/netdev/net/c/ea2c09283b44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



