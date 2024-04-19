Return-Path: <linux-kernel+bounces-150872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427028AA61A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CAC1C21A24
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B4215CB;
	Fri, 19 Apr 2024 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyQ6Moi2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE97F;
	Fri, 19 Apr 2024 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713485429; cv=none; b=OTDWF43iHdBlRMAcbU1EWqXLWEmRmdQ2S2AIjduOvQjyAM2XFS33dYDqmpbKvUYrHFdap8Pm3cBcfVuoGMIEQTDDSPhPFZgyFMgOGc3Jp0m13P6/nt2xcewKQMZ58pSrL7ex+X9Zr9kkJ6+vjJbd0YzSZk2ITUlVUCrvY5O70hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713485429; c=relaxed/simple;
	bh=Kv2epKjxPjosi8KgOFBLf1qfFcEbu7a+0EyqYvYeqE4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UIbMDzHXV6NUlgs8Vk9DzZOO8OACD/1Mgfc0MLBt7RJWud4IbViZ6HuUikj4eiDzvTVnspDUoNp0bmZxoibIeKqwiczyk2hlLrrl1p10hsVn98Ti2DOv3X8X7MJObkYDqeXayMrH7DDpVjFD0Xsj9folzjADrmR+UGlfQwcNNb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyQ6Moi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFB74C32782;
	Fri, 19 Apr 2024 00:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713485428;
	bh=Kv2epKjxPjosi8KgOFBLf1qfFcEbu7a+0EyqYvYeqE4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jyQ6Moi2DJupQUUR7lECua4fQ8XBU3DBk9K2TOTKri06HHRIhp7zt81T8hrENLFoI
	 5R30FrVTwU8KTrRYzMZeUi5iSXNQlq1kL+PJCPl7ENfxxFns+fOz8uDMrrBS5yCd8m
	 YLHIu2OLKmwFPR9TJMs12B3lSpC/hmT6K9T6WWdAbGlentd32t5bP9Hft1R5rD4mdO
	 XSzZPmgUQ/YnuioCqFMMAm26t/BqOOWhu/1zwFmE9cETRFlFI2SgFlIogPJYPsB06F
	 z6GPKZ7YZwwgq+3EX1Pel38On7ziM588qzrTy9BhzWXdGkAsV8tU4+i2WeQgCgKjJg
	 xFxcchpzXMXDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABE04C4361A;
	Fri, 19 Apr 2024 00:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] sfc: use flow_rule_is_supp_control_flags()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171348542870.28734.11802305757567903100.git-patchwork-notify@kernel.org>
Date: Fri, 19 Apr 2024 00:10:28 +0000
References: <20240417140712.100905-1-ast@fiberby.net>
In-Reply-To: <20240417140712.100905-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com, linux-net-drivers@amd.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Apr 2024 14:07:10 +0000 you wrote:
> Change the check for unsupported control flags, to use the new helper
> flow_rule_is_supp_control_flags().
> 
> Since the helper was based on sfc, then nothing really changes.
> 
> Compile-tested, and compiled objects are identical.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] sfc: use flow_rule_is_supp_control_flags()
    https://git.kernel.org/netdev/net-next/c/bb534830a74f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



