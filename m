Return-Path: <linux-kernel+bounces-740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBE9814562
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3306B235A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B371199D5;
	Fri, 15 Dec 2023 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIWR5YM7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77FF2D04C;
	Fri, 15 Dec 2023 10:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B85AC433C9;
	Fri, 15 Dec 2023 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702635625;
	bh=iv9oElJngzHo42q0fWfQK3rxr/N5YI9kxO5ONzKzkDM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DIWR5YM7veGVFw7NlnXvzJpV9BgBo+/TGJCJCNPiwi7BM4/+q86/TYUEf2A2IjGUN
	 Gmnr/tx7xA7TrLMUo9sMP4HL7WpVgglA0iYnraSKpf6cUGC64nCVlArlmtLlBP7y5s
	 OS/xh5jEDk+TqQ5hXGJY2tgGqyLQPszbMIsee8mAu204wqf9uuITc/gxFm7XGNyzH2
	 K4Ek5LSXi0QBJ539BzP9YqBmiHIEzpv6xM1NJI8gxtIdYKTUp6w5jtKA5q2jZSPKvg
	 /3nnrik35IFuUnBWEHDS+Hc1lKs8WdX4OtheyxB+qJNPyN/OL+4FTjAIhtA68HIauv
	 FkOO0XBlTTZqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21EF3DD4EFD;
	Fri, 15 Dec 2023 10:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v2] octeontx2-af: Fix multicast/mirror group
 lock/unlock issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170263562513.24113.452405729165126729.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 10:20:25 +0000
References: <20231213095349.69895-1-sumang@marvell.com>
In-Reply-To: <20231213095349.69895-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sgoutham@marvell.com, sbhatta@marvell.com,
 jerinj@marvell.com, gakula@marvell.com, hkelam@marvell.com,
 lcherian@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org, wojciech.drewek@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Dec 2023 15:23:49 +0530 you wrote:
> As per the existing implementation, there exists a race between finding
> a multicast/mirror group entry and deleting that entry. The group lock
> was taken and released independently by rvu_nix_mcast_find_grp_elem()
> function. Which is incorrect and group lock should be taken during the
> entire operation of group updation/deletion. This patch fixes the same.
> 
> Fixes: 51b2804c19cd ("octeontx2-af: Add new mbox to support multicast/mirror offload")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] octeontx2-af: Fix multicast/mirror group lock/unlock issue
    https://git.kernel.org/netdev/net-next/c/10b7572d1787

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



