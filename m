Return-Path: <linux-kernel+bounces-51758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7CB848F00
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5231C21D44
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB332374B;
	Sun,  4 Feb 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtPB0x2K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3474F224FB;
	Sun,  4 Feb 2024 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707061827; cv=none; b=Syb+Nd+0z43OuxNSmue+ay//c43l0QqDpU8+fVye1laf/tmkyfI2YywO2LFQf3lrgjgC/fKGMoZoxVwhml3y/3z6cE4vWNMih8fkTnXlIKuFfSWFoihMVK9CLp73vvQPm8uVYDQoZO3U6867bqFeOEWU43ORR74tNlxlNTjh+X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707061827; c=relaxed/simple;
	bh=K/l4XAhKUoqj0Gf4/fuP2lXIRj4zvUX24qlOR/OzA/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eqpaIHdRpHqYlCXH4el0+XLAHN46eoyCsUoPQk1VDjRCWV816rS/c43jxE5uViYQ+Hj+YIwDOeGzqOaslvmThfzYct2E5ZsGFdDCFnTFNYixSSX8bheuNnKLtcSWR0KW1kTMXESS+6vtbdgMsl1g75nqElj1PFMZbSpmmGoI3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtPB0x2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68293C433C7;
	Sun,  4 Feb 2024 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707061826;
	bh=K/l4XAhKUoqj0Gf4/fuP2lXIRj4zvUX24qlOR/OzA/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NtPB0x2K/E20X26/5ARyHjievHQZfX9Rx0lxHbQ1zJATMxe1h5WiJ0++iqpMg+Hbh
	 B9wVp0av2t5GVBYhHKOGX61jZgKuVY243bPbFTcdA7/VtIEEZkaIeemjZ2YpOhFl1K
	 JzaNC0H1S0zqOC2VVSERq9pxds8ErCNeXkyFQZw0xFDBL+sR+/xWzvw5+JwB2SqVUP
	 0QZ8W7LkrIIB/J/Sz0ykObuvdIBAGz8KrcCdz5/IWPdcGiXH42LhvSyipSI0GiyxuW
	 qsomEejQeufRL+IT8L5AKFY8KE0IjM/LDuhcuyWteDQFskqGI2/g6s+J6Kvsi6L7Ag
	 O8rL1O0I1YDbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DE35E2F2EC;
	Sun,  4 Feb 2024 15:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] tun: Fix code style issues in <linux/if_tun.h>
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170706182631.14059.17998041446894205076.git-patchwork-notify@kernel.org>
Date: Sun, 04 Feb 2024 15:50:26 +0000
References: <1706858755-47204-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1706858755-47204-1-git-send-email-wangyunjian@huawei.com>
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xudingke@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 2 Feb 2024 15:25:55 +0800 you wrote:
> This fixes the following code style problem:
> - WARNING: please, no spaces at the start of a line
> - CHECK: Please use a blank line after
>          function/struct/union/enum declarations
> 
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] tun: Fix code style issues in <linux/if_tun.h>
    https://git.kernel.org/netdev/net-next/c/bd8a8d5ec504

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



