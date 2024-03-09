Return-Path: <linux-kernel+bounces-97780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9886B876F53
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 06:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDC29B21412
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31C234545;
	Sat,  9 Mar 2024 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spuYolso"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB831DFEB;
	Sat,  9 Mar 2024 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709962228; cv=none; b=gFzTINCdv7A9un5mOdkKhAZp2hM5OC1+Tec6ytXv4QfBgDDlmrU0GB79YKNIddcYWJ9mZG5wTLSinEJT4RNvCevrWJXVnz1L/NqfLjvdtKKAEx0tFBEkwP1fTnNrzx92csQbxqAe3TRCDzxXUKeGVKpgRufkaQLC+MhJMFhXkEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709962228; c=relaxed/simple;
	bh=TG/vDqNImmnnG9h3xrNoUytTfmm0zjE67EU2lnlIOPk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UnWbC3lQ/ayUYkXVTRe7bsUj2xjyIgLRGdEx5euZBlrpeDvUT479sK8CJ5FO8BnGVNtbps2rOQOODQiyWdMKpkqGMq8tjjwM8Gp+9pH2RKNVlWFMU81t6pv+eq36AlqL4hEIXBzOWdjO9SytWCWTvn01K8WqKyucChKNG9nIcjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spuYolso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF6D3C43390;
	Sat,  9 Mar 2024 05:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709962227;
	bh=TG/vDqNImmnnG9h3xrNoUytTfmm0zjE67EU2lnlIOPk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=spuYolsoNMT6xDV9nsgIGK0NYV1xKr0uWD53dkqi3xfbiP5SCXdEu/oeCtLWbLrkt
	 Of0ltUXAbsR+yygynPP/wwNL6vNdTgd/f9USZY1be+wN5BL9n8x0maQzJZ/a9u4dwq
	 QEzmtzooIV459YnIi94mw6ijbAiiGIKxsO8ee6FnLddpDi6LtsE3BpeJW/6i+jgZq1
	 8Oe3jqjAzJzF/6V8u6GybVuX3rjc6XbsAbFybr39rBMdJkJ05NabvR/mjARk/q9dGP
	 gaoJYnBED7BarQ/THuT8gTRCzB9uqO4AIIySmGiaQ/u65qGWL7ACHpk6SOKQoSgSHO
	 E+XBogyiDG5ZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8BAAD84BBF;
	Sat,  9 Mar 2024 05:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: phy: dp83822: Fix RGMII TX delay
 configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170996222775.25117.16446625649338127389.git-patchwork-notify@kernel.org>
Date: Sat, 09 Mar 2024 05:30:27 +0000
References: <20240305110608.104072-1-tp@osasysteme.de>
In-Reply-To: <20240305110608.104072-1-tp@osasysteme.de>
To: Tim Pambor <tp@osasysteme.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dmurphy@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Mar 2024 12:06:08 +0100 you wrote:
> The logic for enabling the TX clock shift is inverse of enabling the RX
> clock shift. The TX clock shift is disabled when DP83822_TX_CLK_SHIFT is
> set. Correct the current behavior and always write the delay configuration
> to ensure consistent delay settings regardless of bootloader configuration.
> 
> Reference: https://www.ti.com/lit/ds/symlink/dp83822i.pdf p. 69
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: phy: dp83822: Fix RGMII TX delay configuration
    https://git.kernel.org/netdev/net/c/c8a5c731fd12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



