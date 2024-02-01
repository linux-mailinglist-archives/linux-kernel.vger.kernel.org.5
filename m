Return-Path: <linux-kernel+bounces-47964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA402845558
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381FFB244EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF60515CD46;
	Thu,  1 Feb 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yoj5HyDo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF2D6DD0B;
	Thu,  1 Feb 2024 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783425; cv=none; b=dwxjdh70iORGG+0lagH+fCMoLgrmF040h4NoR6PIp+Y6XmwAYfHs4ZIv5BxwmATUWiAS8ppy44h8KBleS1An0G/WxJC41EtQRpvYF1jfdA3z2miOUkHPXb8H9FXoLKuxLYp/LdX/k+MavPcwpwVMO20CNRRC909oxtYYm3DRUfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783425; c=relaxed/simple;
	bh=kpRSNOV1qvBd7nRyNi+FOZQA1dXy0tQBvFmMZT/3dJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rBJP/Fojle1w1qFKuRHuH039MoZ3tGA+TqAHqSeRseDlrbKEqKUWizIxZFqUwckvy1jj0YcLUZhxrlndNDie01c66LhH8f1Ax8u52Gah4Y9aikv3dbKSwisFsZUz0hpQEhqBrjwFex4toe7VuJZnRrv7U/fL+FrrGFekXk5CHX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yoj5HyDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90F5EC43143;
	Thu,  1 Feb 2024 10:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706783424;
	bh=kpRSNOV1qvBd7nRyNi+FOZQA1dXy0tQBvFmMZT/3dJE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yoj5HyDox8bS3+CO489Mt5T+WHuJCTWSj6FmgvNsZ7jD0JfQuR0eLAsSG+n9TYFKL
	 9Q1JuZnw2DR6m5lDixJHbywvuUKA54Zdzkf2Ir36rex4Hla91aPP+25LGr+xT9JbQR
	 WJhcrd5f9x2fT6NMPkz+vKtGVL/Mo9mnfKDYFvEmgCzLLNGot76oqoHWyKqdPBv4ZD
	 fdj3ZSh/vCxaH+5NkMYsZ8qPUZ/rMzV6+8dYpp8t0MgPx4Ti0LqwvgHIpFFKKkAK99
	 oIkg7bIAjaiYM/WCh3sbByeVX6ZCgnxyiqBGt2Bd8lP+uQozS3cl2gJXfEodXC/6H7
	 lk2E6459/aH5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A7D7E3237E;
	Thu,  1 Feb 2024 10:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: dsa: Add KSZ8567 switch
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170678342449.6867.9597352434665263927.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 10:30:24 +0000
References: <20240130083419.135763-1-dev@pschenker.ch>
In-Reply-To: <20240130083419.135763-1-dev@pschenker.ch>
To: Philippe Schenker <dev@pschenker.ch>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 marex@denx.de, olteanv@gmail.com, woojung.huh@microchip.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 andrew@lunn.ch, UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
 davem@davemloft.net, f.fainelli@gmail.com, stefan.portmann@impulsing.ch,
 edumazet@google.com, kuba@kernel.org, philippe.schenker@impulsing.ch,
 conor.dooley@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jan 2024 09:34:18 +0100 you wrote:
> From: Philippe Schenker <philippe.schenker@impulsing.ch>
> 
> This commit adds the dt-binding for KSZ8567, a robust 7-port
> Ethernet switch. The KSZ8567 features two RGMII/MII/RMII interfaces,
> each capable of gigabit speeds, complemented by five 10/100 Mbps
> MAC/PHYs.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] dt-bindings: net: dsa: Add KSZ8567 switch support
    https://git.kernel.org/netdev/net-next/c/5f8066d45782
  - [net-next,v3,2/2] net: dsa: Add KSZ8567 switch support
    https://git.kernel.org/netdev/net-next/c/3723b56d6f73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



