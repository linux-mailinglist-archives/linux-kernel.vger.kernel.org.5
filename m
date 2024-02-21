Return-Path: <linux-kernel+bounces-74605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D93385D6B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2CD1C22A92
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD51405F8;
	Wed, 21 Feb 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsLmS2tf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B0D3F9C9;
	Wed, 21 Feb 2024 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514427; cv=none; b=lnH4quAfNqUeYFDfkDQoQYGU+mIzb1B1yX/rtWjgvS8JB+MJ4JLfFq0//CsRBFy3MEU+ct4OV4urqDxdKjaQyiEmyYJMUob71c3LSIT6jGC18jBP/iJFdnK15cjMttvlkbri6DnXA8IanMdblg7OZ7CpBkBgI1Au+BhC2Q3nK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514427; c=relaxed/simple;
	bh=eQJjn+fyis4zmfVOr9+w1bUQCmIi1pyHsjNzhxVRHws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IETNqB0wsO9yq6dZqAanKFxqqJcwg8OA0/M8HRQreoSDlxqK8wL0usinFmeFfN7rzsvFJqP2BnQghV6ix4/deZMdhSo7dDi/uU1c54nC7sx3GMI38NZzjqDEgXMQe+/yxieyy5Ltm+qdyk3Q+934cORrZi0ADIoNKKjGQFR3OBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsLmS2tf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65309C43390;
	Wed, 21 Feb 2024 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708514426;
	bh=eQJjn+fyis4zmfVOr9+w1bUQCmIi1pyHsjNzhxVRHws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GsLmS2tfbwHxWhQ+pUHFHK7sIpRm2j9a0hX4RCzSk6ngnFHSjHYfGAbHBKyEUv2Gy
	 63T8plMEg61Ij7wh9Ay/q5JcSlplivX2fjL5oIAGdEYl67l5G/JnCKWkfEoZk66L/T
	 l14TWqEeFmutOmca1LhZwEl4ZBzkcp4Txoa5st6N5HwYzm4X/ZZMw79L59ffJ8YKQa
	 SPbUZnZqS2s8K2fzK941QiDVWtmzxsaH0qeoBxmc/DuJ6vo57+kc7GXDc6757aCvhh
	 Iog+vk8TBkylyb4WzAjX8+FDnPiJhK83VT33kREPvYU+anD0pg3nn8xQwN7f1uodpS
	 gfg6hJfRosb4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AAD3C00446;
	Wed, 21 Feb 2024 11:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: Consider the action set by PF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170851442630.9417.4575929978290134315.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 11:20:26 +0000
References: <1708347314-21624-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1708347314-21624-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, naveenm@marvell.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 19 Feb 2024 18:25:14 +0530 you wrote:
> AF reserves MCAM entries for each PF, VF present in the
> system and populates the entry with DMAC and action with
> default RSS so that basic packet I/O works. Since PF/VF is
> not aware of the RSS action installed by AF, AF only fixup
> the actions of the rules installed by PF/VF with corresponding
> default RSS action. This worked well for rules installed by
> PF/VF for features like RX VLAN offload and DMAC filters but
> rules involving action like drop/forward to queue are also
> getting modified by AF. Hence fix it by setting the default
> RSS action only if requested by PF/VF.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Consider the action set by PF
    https://git.kernel.org/netdev/net/c/3b1ae9b71c2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



