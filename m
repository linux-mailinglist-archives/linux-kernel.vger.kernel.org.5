Return-Path: <linux-kernel+bounces-135206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FB189BCB9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C532820C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4119053E32;
	Mon,  8 Apr 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn/QozvW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7540E5338A;
	Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571027; cv=none; b=Db4L6yOe9tFUK3BOE+LeXYjrNWbBMde4BUaAYuaDn1U1SYiJxKEh7Clu+CzJBL33dUYhjMw9qGB9PDQgqRkApeAmOwKUT1vuE8cLFPyAnDiPIyNbgILdDJJATfr1MYxRLfbuF2rzsuk/b9TFDeNvdgp2d2eQ3TVBYqV9s5nlBpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571027; c=relaxed/simple;
	bh=eJLmUUbE/dFCVEAt0gU+7oGilcRZHF2S7tBGba+61X0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pAQ/F6yqOorSYbxBENrSz64hrXWUbt7XBwQ5pKi5f/6s36fPbjXo1NmouhZ2NFBv972ozZOhhfFeDvKppQ5Q34a2/AG6M2kO4lVHVx1G5HBg5Y2EUxBM4a6H/8sJzTG9eUxC/5Qb+QbefTDoNXodC926rNfA2koYOI5uAgUd0Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn/QozvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22963C43601;
	Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712571027;
	bh=eJLmUUbE/dFCVEAt0gU+7oGilcRZHF2S7tBGba+61X0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mn/QozvW/fEHg0cJ1/x5GJX71M4zdLeUIiFBo6bJC7KR77vKukYSKHCgGkqnasK4B
	 ya6iImHSozLtbgr8DwgszW8EcM5PbhbE/5Lbf66JPaL9pqRVRqD5g751htCATvSp5V
	 O8lidxQjIbgfk8vwoGlKEWgqZvHrV04pdHROXjDvVUYN8F089ShvQ0cyu1WY/m5FBU
	 Cr1mMkA2ZvPIvFEKQGbe85sbTssAk7M+Ktkv8Acn/f9O8T8M+t8skrlHUF4khO7SfL
	 aZbErjw+adFEXcSjc2AfaynprlhtfPmUnfiKh2DLBVWTTPiW6NR6PpwIDlNQV+939b
	 Y0LQNVw0rNQoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13036C54BD7;
	Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: mdio-gpio: Use device_is_compatible()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171257102707.30740.13866298012357932747.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 10:10:27 +0000
References: <20240404175557.2470008-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240404175557.2470008-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  4 Apr 2024 20:55:57 +0300 you wrote:
> Replace open coded variant of device_is_compatible().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/mdio/mdio-gpio.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [net-next,v1,1/1] net: mdio-gpio: Use device_is_compatible()
    https://git.kernel.org/netdev/net-next/c/9d56c248e503

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



