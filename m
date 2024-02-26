Return-Path: <linux-kernel+bounces-81294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAA4867398
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813981C25166
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F7E339BF;
	Mon, 26 Feb 2024 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/xjhlNX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9192557F;
	Mon, 26 Feb 2024 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947632; cv=none; b=NSCykPwrKPd/SG2wdYNlg1KGJSCspR/jLJQAcF6dQ1+yqgRxVkazUT4qofOHJk/W0U53UxhjIdBOnU1mv2yq4PLd6YeX7aUT1jHeJip33I1pQoYq3JpGSN4kCM/lqxLhBwUlESAzj+5JFrUeOaMnT0tUwYoA/BDrD4eA/6QOm/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947632; c=relaxed/simple;
	bh=zmYoQSAAJBlRXeHR52mQWL2C4tPRmHijjrJ32Dly2QY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bbdDrvZ42h9RqVAFaIWlxXZyBGmzWtVfU2FndwbBAmxaFW9zL0TcaQeVzPr25MCFP5X7dTRUgr2UJIM6cUCENIWHx6MD5lJLJytBtUHLlnzDRWj7MizaBEDtV+OE95wWAiZywVvBaai0c0ZWIOmhlsoqLqtp0CnC+WZSgt/9TfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/xjhlNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F467C433C7;
	Mon, 26 Feb 2024 11:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708947632;
	bh=zmYoQSAAJBlRXeHR52mQWL2C4tPRmHijjrJ32Dly2QY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B/xjhlNXIhha2w1LNFsnfpTcA5bdHhn+bf1G09Ob30Tfm/xuz27SAGxBQF8ObdqBp
	 jSwl7s2EWhghB5lNuUFZ1pH5WvmUgVB5fryTdmBId4oV+22tGI+GmlYIJyP6Gad4PA
	 2WZ9q3JZFHQu/4eq1buDkCXJ8lx+/yDJMrwPwtcGOGkLSkeIZjYqBrnb1VMM4E472h
	 48v/ReFBnzDUPCTmJJMpjAxq/q9MpMznAYLDgM5ll3l/OqQcWtwYFJThN5/kRDC2kL
	 15IBNvmSpiuwBpLqjTg7Nf0dMckAgIJOFf5HRDz6sn+8XqhH4PK5CHjx81wMO/hGVu
	 mHzNDzhmguFmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10550D88FB6;
	Mon, 26 Feb 2024 11:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/1] net: dsa: microchip: Add support for bridge
 port isolation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170894763206.4235.9816052153130545658.git-patchwork-notify@kernel.org>
Date: Mon, 26 Feb 2024 11:40:32 +0000
References: <20240222075113.2564540-1-o.rempel@pengutronix.de>
In-Reply-To: <20240222075113.2564540-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 22 Feb 2024 08:51:13 +0100 you wrote:
> Implement bridge port isolation for KSZ switches. Enabling the isolation
> of switch ports from each other while maintaining connectivity with the
> CPU and other forwarding ports. For instance, to isolate swp1 and swp2
> from each other, use the following commands:
> - bridge link set dev swp1 isolated on
> - bridge link set dev swp2 isolated on
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/1] net: dsa: microchip: Add support for bridge port isolation
    https://git.kernel.org/netdev/net-next/c/a7f08029e2e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



