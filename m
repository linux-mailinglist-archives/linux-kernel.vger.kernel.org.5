Return-Path: <linux-kernel+bounces-159448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217448B2EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D4C1F230CE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A4F79D8;
	Fri, 26 Apr 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PL1uaM3y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137E0EBE;
	Fri, 26 Apr 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714099229; cv=none; b=d0gB0Na8eL0NSXm38AOmAiYEmuQLTEvB1GXsPpNApb+p+f8ie6686Jt5yG4pZh+6IiMu0XtvaavW0CJ1FdDoiFcEtmD8Uogp2fKzhFAwySku8udSsrjQkZyosuxhysDNBNIDe0Cq9+jfwpf0A411E21FjBTps6n0ryIv4utlr5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714099229; c=relaxed/simple;
	bh=IigEBOZrzWP8+N4pDGPBdcSxPqUXH9S2u5G+mGyIzAE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TNA+qkbmorg89vBONqaaBf3TbKTksXQqxy17RUuavNJ+OojUTzu4H04CA2FATPIwbR8XoaPAsfpcFiVjX4MXlYcQNw8IGYWk7WMkkFWYf7E4GW+uD6dgDiyUfPSLjsugmwZ7XkWOGF8+nGN6CtJt4ljYr3TKdz/5nUCrhzO4Ljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PL1uaM3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0EFEC3277B;
	Fri, 26 Apr 2024 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714099228;
	bh=IigEBOZrzWP8+N4pDGPBdcSxPqUXH9S2u5G+mGyIzAE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PL1uaM3y5B9GgPi7XyGvyLStxYDWd4qVgTETgIhdIrbroN6McdyAJU/DJGKWdqb9Q
	 ImF+XUeXcFgOJrTEJ/4hUIwllYnv8Uapv1i6UqEmCm0I7C5p3ktACfV52NB7MSBesN
	 nvco0mESwF/K3FPOpskDUAbmWMhRzrnyA1HixJwLcqkU9c844t1oiboLI/aMNuHrhb
	 f3FHiWi8B1gH9avoi4Ys8R49kGj7/89h43VEdq6Ch/QkTqEb9LQzAP/T0a8zUPGcWq
	 CI4YyZnSHcuu7YsllxxErn+y5LM9phSEkFvWKxKmriUqSV/wKqQw0yiqnB/NuVbChE
	 //3uN6c33xAHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C831C43140;
	Fri, 26 Apr 2024 02:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: lan966x: flower: validate control flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171409922857.17911.8111493422367965592.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 02:40:28 +0000
References: <20240424125347.461995-1-ast@fiberby.net>
In-Reply-To: <20240424125347.461995-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, horatiu.vultur@microchip.com,
 UNGLinuxDriver@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 jiri@resnulli.us, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Apr 2024 12:53:37 +0000 you wrote:
> This series adds flower control flags validation to the
> lan966x driver, and changes it from assuming that it handles
> all control flags, to instead reject rules if they have
> masked any unknown/unsupported control flags.
> 
> ---
> Changelog:
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: lan966x: flower: add extack to lan966x_tc_flower_handler_control_usage()
    https://git.kernel.org/netdev/net-next/c/505ccf890c21
  - [net-next,v2,2/3] net: lan966x: flower: rename goto in lan966x_tc_flower_handler_control_usage()
    https://git.kernel.org/netdev/net-next/c/12b8e129c409
  - [net-next,v2,3/3] net: lan966x: flower: check for unsupported control flags
    https://git.kernel.org/netdev/net-next/c/8c65e27b42fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



