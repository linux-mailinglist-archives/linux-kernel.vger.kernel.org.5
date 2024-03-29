Return-Path: <linux-kernel+bounces-124404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4773B891713
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA97F1F2354B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0636A025;
	Fri, 29 Mar 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYWjPCpF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC2B657CD;
	Fri, 29 Mar 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709429; cv=none; b=Xf9ll7QTLV5rfDEdwfPhhLLn14+ZMc/UqQuDLA5q/eQQ5M9QPjTuYwr414MZOQfz4Q8OoJvDllfC2Dpw3u4eG/DXR4PhFAyYlbHApB2o5lKwUpDbvkzEWTk6fVPTO60Z/ixtXrjiwDIWxchEGgmKpSi3JjIVtJ+O7PB2xDbLt08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709429; c=relaxed/simple;
	bh=cZb9yUcynYs3EY1tC0nL7B6G+FJShK1jMRJ0DcQTewA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UzIpcP94J+UHys5fO+7vWBq9yV251BadHelGdFKT9bBqX05QDwKOj4CWqrpMiJpuYaJSQFBaOvvYHTlscyPn5oxq7AWZdzp/SupogcxHCTQRIwa5EuJcCDx0nQFsmPvDBEWnCpTltJTbapdXYb3xEL35EZ3GfVk5ZkCInna+rmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYWjPCpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A13CC433C7;
	Fri, 29 Mar 2024 10:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711709428;
	bh=cZb9yUcynYs3EY1tC0nL7B6G+FJShK1jMRJ0DcQTewA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bYWjPCpFjiUqESOadfBHRupATXSlQHLWFX5V9/BvMSK6LHApUi/qHvax6Ot+r/IKZ
	 lKS4di1gqEH5TUwfe2sBvqfkCUZayUjk1HsUQ/bpNd2nawG8HZcJEjihuJUCcKo5Ba
	 05yc+LZ3qo56qUddYmUAmg4dG1dt88P4dWJnjkCBZpJ1oXwo1oOlsEjCiEax6nWNC9
	 UWGbwW1QwLYO70jIS8x6xRes5D8bGUOUAV8Xvochbi/ujqfZ2MRi68tboaRFjC7nt0
	 rdLk9gTBe65fU33ELlEhEEq3UD0re5c6rPmprfNuTgW5VbyHVXMwOUlaZMQTJ73d+U
	 mnEg23E6zzZCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72CE7D84BBA;
	Fri, 29 Mar 2024 10:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 RESEND] net: hsr: Use full string description when opening
 HSR network device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171170942846.27059.6312977801783703742.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 10:50:28 +0000
References: <20240326085649.3259424-1-lukma@denx.de>
In-Reply-To: <20240326085649.3259424-1-lukma@denx.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, edumazet@google.com,
 olteanv@gmail.com, davem@davemloft.net, kuba@kernel.org,
 o.rempel@pengutronix.de, Tristram.Ha@microchip.com, bigeasy@linutronix.de,
 pabeni@redhat.com, r-gunasekaran@ti.com, horms@kernel.org,
 n.zhandarovich@fintech.ru, m-karicheri2@ti.com, ricardo@marliere.net,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 26 Mar 2024 09:56:49 +0100 you wrote:
> Up till now only single character ('A' or 'B') was used to provide
> information of HSR slave network device status.
> 
> As it is also possible and valid, that Interlink network device may
> be supported as well, the description must be more verbose. As a result
> the full string description is now used.
> 
> [...]

Here is the summary with links:
  - [v2,RESEND] net: hsr: Use full string description when opening HSR network device
    https://git.kernel.org/netdev/net/c/10e52ad5ced2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



