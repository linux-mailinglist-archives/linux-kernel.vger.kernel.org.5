Return-Path: <linux-kernel+bounces-96832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5ED8761FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCE51C20323
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D4455C08;
	Fri,  8 Mar 2024 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qG53Um5m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AF51E48E;
	Fri,  8 Mar 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893834; cv=none; b=TuvRCZQICnSHDBnCu1kEgXtWcswyZtTw9srXNSMoVQDKR2/0imhY5q3l5ZlYzJMD90dgqsgnPmS3Xx93+8PaUVvcHiHIq9UjGQwQrAlj7+WQPLMTVzzjDXH06vCH5FWGX4Fjgb555xAHrNCSje1fw5unolA3DvDw6yOB9QXWPjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893834; c=relaxed/simple;
	bh=DBJyvUiFYHBmEE5Rw8Tzk8KpqQceFdTVRr7W62ft2DU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EKpj8YvAs46RrGlMQay+SUmgeFyKkj2BpBgihM/s/pt+XsakjXuwZS4xaLnA7srKk5IP9sykLJ55pUYYythpqo/Hpnd0Q+i1i1H8NCbvLU8iw2Lij3yZyIzO5zuEjuyusAZcvUXDIlzwebIlHiINQd8Wr45V7OQoo7xPZF39shs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qG53Um5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 363BBC433A6;
	Fri,  8 Mar 2024 10:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709893834;
	bh=DBJyvUiFYHBmEE5Rw8Tzk8KpqQceFdTVRr7W62ft2DU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qG53Um5mAWgMveKQoLnosEWx8G31xr4T853Bc+Hxzr0zReHgFufMJInKHrgQZRWGd
	 y1/g/93stjS7tEs3Ah1LPe3/YgWjnnz7T9uMTxMi9wsWHmAeO/cHdBwUhgbGaR+KYN
	 9MQT0jnhKGMWTyIufzoeLKCxTzWcntlXOWwMLfzdoBHIupiArRloxzdEiJOvBlPmB6
	 Ih25sCNLi3PeBBlOr9NVd+3+ryUMJH+LJB1CHc8aWOzJv4CsXe+8le4ILefkCA0aDN
	 8JcCeNMm6zOEnJcnCXqbY274AWaLgMgYtpJAUJZOOuVMfYLkW5Xf7AvncX4og3mQgg
	 GCoCgyulNJg1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12C99D84BDC;
	Fri,  8 Mar 2024 10:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-pf: Add TC flower offload support for TCP
 flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170989383407.12583.3109784089553687997.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 10:30:34 +0000
References: <20240305181606.244208-1-saikrishnag@marvell.com>
In-Reply-To: <20240305181606.244208-1-saikrishnag@marvell.com>
To: Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 5 Mar 2024 23:46:06 +0530 you wrote:
> This patch adds TC offload support for matching TCP flags
> from TCP header.
> 
> Example usage:
> tc qdisc add dev eth0 ingress
> 
> TC rule to drop the TCP SYN packets:
> tc filter add dev eth0 ingress protocol ip flower ip_proto tcp tcp_flags
> 0x02/0x3f skip_sw action drop
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-pf: Add TC flower offload support for TCP flags
    https://git.kernel.org/netdev/net-next/c/3b43f19d065d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



