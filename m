Return-Path: <linux-kernel+bounces-96821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3018761DF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B642B22D55
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAA755762;
	Fri,  8 Mar 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQ0ZkX/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8958053E1A;
	Fri,  8 Mar 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893231; cv=none; b=Z1RUqnKbfMcwErq+oQApa+FvPOBg1uoXE30K4mMM2TEvWnpyE/7syfN+LhuTZiRnp4cktm2CLt21d3H8eC4hNm85bnztcsM+tUUjvV877VDFxsD6is36R9K2/YF/cF6qRahQVxnDX/kMchLbRsamxPcWhBQ9FneeSuh7xHLqGrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893231; c=relaxed/simple;
	bh=YqlPywJD3XMNMCdoVOYKpvfNURY2E+g3zmeAf8v9w6c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J/6yUEljrP9mm8ECeYx0MjG/DI/nkAPAsTylvJbxvFtEDhba0UFXfDmthfxmHRsLS7uuRV6vCJ4Ce9CeedKkZ3/uyUR3+GxOKoh7+7O8/VtlwQHN09xLB24x30ftTbkayzHUShfJRVYG9RjShOK500z5bjlVNBV+A6bvAHB+HNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQ0ZkX/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C49BC43394;
	Fri,  8 Mar 2024 10:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709893231;
	bh=YqlPywJD3XMNMCdoVOYKpvfNURY2E+g3zmeAf8v9w6c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uQ0ZkX/PKS2gNK1UG2EranIWLS0/DdWwqEbIoqD4pqbXEKc1dgJ5IDuwS9UCjnqMx
	 miqxbiuk0kNWUE4hViS+Kk2B3wXY8QlP1wtWAgFk1B8u8YY4bQCblR7bfIBbz3Fh3Y
	 0n6LRp3IA6+TEHHW6cq2NVt+HHOAFfl5lQHLPgpc7qI2wNbnNp3pR6kCwO7kZjDA4P
	 yvvsQv+XfWQ3pAK1OXEekYkfu6hNJ4yT7zuv4DpxbgtycgtfqeD2Om7YGL/naZJ3NT
	 nsrXD2nS9sFifj6rWuKdSOFGT73YSKh0HXt2hjDnJzvm/NHpWszP0ODb0YPgTmE6N3
	 4AOkxZeS3YDJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12758D84BDB;
	Fri,  8 Mar 2024 10:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-af: Fix devlink params
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170989323107.6327.11751670957207804135.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 10:20:31 +0000
References: <20240307105623.474757-1-saikrishnag@marvell.com>
In-Reply-To: <20240307105623.474757-1-saikrishnag@marvell.com>
To: Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
 gakula@marvell.com, hkelam@marvell.com, sbhatta@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 7 Mar 2024 16:26:23 +0530 you wrote:
> From: Sunil Goutham <sgoutham@marvell.com>
> 
> Devlink param for adjusting NPC MCAM high zone
> area is in wrong param list and is not getting
> activated on CN10KA silicon.
> That patch fixes this issue.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix devlink params
    https://git.kernel.org/netdev/net/c/fc1b2901e0fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



