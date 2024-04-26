Return-Path: <linux-kernel+bounces-159450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603FB8B2EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A98E2827BD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7532749C;
	Fri, 26 Apr 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVcse5PH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15839EDC;
	Fri, 26 Apr 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714099229; cv=none; b=NXo81JCSPE/vabwuiJ46J9v7Vb9LAiA3iHF/69pI4m9m6C6g+gLGANZfaAigGLD0GhNdpzMY3h1Hh32N+ge4V96mM16LgxpUdu+ixBV5g42dndIG5Du4jnv4hmlcbvgkRBi9xYjMRBmz8TMnqnaYk+n5orm4fhORDxw/lv6k9qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714099229; c=relaxed/simple;
	bh=MvPasSymwqkOFwVFDn3svyEW2JPPhT92aF/PDKHQVQg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JIrJK68J7metnffVBx+HwGVtPS2cnl3jEncC9DWnZDgtQK8yR9pPzJ7sSmHB5KnsbHq800U2wLbMEdMFUl80jf8koz2a4tWbszj1TGNasIz274+Sd2EeV5MYgkb0B7uQpjX5I78dsrJS6POzByIrUaKI4FjvSHXd+PwdQ3fsZOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVcse5PH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95C11C2BBFC;
	Fri, 26 Apr 2024 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714099228;
	bh=MvPasSymwqkOFwVFDn3svyEW2JPPhT92aF/PDKHQVQg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XVcse5PHjXRImCPmNxDky7cPAaHsHvWJZ18l2gN+pXEExZzOZfd1oEanlDEZTbCTX
	 S/3vtAl0lbP57RBNF5Q9qNVfrF8vFKy6G83t888dPJX2vwrqdJ0W4p1+ZfDzmM/L2j
	 wdtJDg8ZAbZBJKj61/0x5655FZwG7n/PaCGWN836u5n4cZ/1nQwpsejNupSZ72j0Nh
	 Nbw7zJJ6aHoRTIY81l4ew4TZtaBpz+R/l7rb/db0QXpXPBxaJJeq83jOmp+YwHHFgi
	 sMikKvCpEtLa6cgvl0kBKqWbGKFeEvosdtzgOoeqpx3ofa/trr3+Q1QaD5AbnOi97J
	 aWx7l8igfP4rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82337C595CE;
	Fri, 26 Apr 2024 02:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net: sparx5: flower: validate control flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171409922852.17911.17168640790224969782.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 02:40:28 +0000
References: <20240424121632.459022-1-ast@fiberby.net>
In-Reply-To: <20240424121632.459022-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, Steen.Hegelund@microchip.com,
 lars.povlsen@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 jiri@resnulli.us, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Apr 2024 12:16:21 +0000 you wrote:
> This series adds flower control flags validation to the
> sparx5 driver, and changes it from assuming that it handles
> all control flags, to instead reject rules if they have
> masked any unknown/unsupported control flags.
> 
> ---
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: sparx5: flower: only do lookup if fragment flags are set
    https://git.kernel.org/netdev/net-next/c/bcf303c62c98
  - [net-next,v2,2/4] net: sparx5: flower: add extack to sparx5_tc_flower_handler_control_usage()
    https://git.kernel.org/netdev/net-next/c/8cd1b6c0bf31
  - [net-next,v2,3/4] net: sparx5: flower: remove goto in sparx5_tc_flower_handler_control_usage()
    https://git.kernel.org/netdev/net-next/c/b92eb1ac13f0
  - [net-next,v2,4/4] net: sparx5: flower: check for unsupported control flags
    https://git.kernel.org/netdev/net-next/c/8ef631e9c995

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



