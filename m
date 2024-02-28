Return-Path: <linux-kernel+bounces-85291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD5C86B38E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DBD288696
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E53115D5D5;
	Wed, 28 Feb 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikqppHLC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6731A15B99D;
	Wed, 28 Feb 2024 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135053; cv=none; b=htNl3Hd2P7lB9gjfqLB9ZLnqhCeXnbKTvFXlegta+1q0H17AtfE30M93YwOLVKvaDfsOp934KpGDMctAs03W8nbUYdxaamPizCN5guPqTnblYFJ4CyzhVzumQTUz4qpF/OaY5ZhUqAZCHHkR8x/FsQWP0Zln8M5UAR6hzMtB2KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135053; c=relaxed/simple;
	bh=wCq0/G0U3G5jLX6uSW1H6YvVIcliYO/6CdNqJSK4uRU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=owbYPjfdfG4dRLt4qhDAb2qPwobVIeZD6I620WQCLTHbPlHyAKtt2zBHyxJvy+74d6Y1tBqvzTsmmYB+7X6CBacipfI6lnTHHKJzjU1wipRai59H6K+Of4nSYjxg66u33L8WgZBDu5XJJ8wiazNGtlbN9M8BVphQQ57Lp3IoFgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikqppHLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDCB7C43399;
	Wed, 28 Feb 2024 15:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709135053;
	bh=wCq0/G0U3G5jLX6uSW1H6YvVIcliYO/6CdNqJSK4uRU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ikqppHLC0brjC/lu/68aUWysFEdkRmeDneSFe+MSx6xLDSa32wQHXZfQfgFjLb49k
	 NIE/3Xcvt+aFNBd997xeCZwtHuChJy+JNWN/yfCwg+O+TOXpYvLhHDIiabBB+lEebx
	 VbKSn28i6oS4nV9/D51lNtTmbuIfgqcbP/jYNbHiRgsWKAdax1ScfKf4TOYPQtn9Bn
	 Z5ZGdmd6dBLFVmd9CdW9AnouTYguFt+O0MfmQcTup66HXMrMz1HNTttZwN59y4NtLe
	 DKE+nlFO+ZLrIXxVK2zpZI3KV4CtLsl8kjHolbVBFaYU41O8eI4fpbq7CVTD6EcjKf
	 R3tOFOPUidJqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BAED7C595D2;
	Wed, 28 Feb 2024 15:44:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 4/9] net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170913505276.28471.11477968638938529738.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 15:44:12 +0000
References: <20240208164244.3818498-5-leitao@debian.org>
In-Reply-To: <20240208164244.3818498-5-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, alex.aring@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org, andrew@lunn.ch,
 f.fainelli@gmail.com, jhs@mojatatu.com, aahringo@redhat.com,
 linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Feb 2024 08:42:39 -0800 you wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to IPv6 over Low power Wireless Personal Area Network.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: Alexander Aring <aahringo@redhat.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v3,4/9] net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
    https://git.kernel.org/bluetooth/bluetooth-next/c/2898f3075e6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



