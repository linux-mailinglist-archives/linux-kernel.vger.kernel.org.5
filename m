Return-Path: <linux-kernel+bounces-85289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2C886B38A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07CB1C2548B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A3A15D5C3;
	Wed, 28 Feb 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRS4mCRX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBB715AADD;
	Wed, 28 Feb 2024 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135053; cv=none; b=NyiHgWSQ9buALNI6iHHIFxlD0mEEZ+qyThu+NA11UQ1IIHyac9zSk3/AtfkZPXbZhbm/8vBmt5LVhhZO6aiC3p7oNUWo4fn3AdQ/xcmDtqNWZfdGxmmIGbz/l2LYN7mvhKC7IzNa6p43if9jBkoLBtmntcUQdJywmCQgsfMMoJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135053; c=relaxed/simple;
	bh=SkZ2A+DXkGoZ1uPkmNROV+iPI9094CkcRNXpeb7Payw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oC6VlH8MTAnCqgHPfk4pSnjPmy68daNXD9lhaO3dC7dra7dOyWLIWYjNPHAeaexwMiKSinaurduvhyFdg37lomXr8RAklFCfImOBLjGoah6MbVtPo8YiUkUPor/P7tqUvTUpFRbofHwK1zwKPm1CWOc9gtphmCEKZeg3uH5YcX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRS4mCRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE34EC43394;
	Wed, 28 Feb 2024 15:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709135052;
	bh=SkZ2A+DXkGoZ1uPkmNROV+iPI9094CkcRNXpeb7Payw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bRS4mCRX9DNd5pW4c5zoQsf2ptuVuCSoBsdXPGvPosyCb/+cZOAi/E6mERTxP/117
	 zqAuIVMPVBUDd1dzfamd4dw2nz2YlahO2drhPXTKCzFbmQ37lQBeECYzGOPsKZiZTU
	 Xj6Xk63A5jJkKFxwHuleEc6rHuvcsZJh6u8I/GtUY8VvnfuNMDmTDd7S3jCrOlsZdI
	 snjfaiIfp06gA845jGkJSQ/H+g8cD0VnD/iq0xmcQ5CXl0KQ+MykpOZRNTKEN/P69z
	 yMPRcdH36OppuYFNoZSiRzyWO1UaT1WtPkbEHHtGDsv/SIuX66gI6A4XJeJ8KcN2lf
	 gWwAs1Vy/QQYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B31DCD84BC5;
	Wed, 28 Feb 2024 15:44:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 4/9] net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170913505272.28471.5112906084108672664.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 15:44:12 +0000
References: <20240207101929.484681-5-leitao@debian.org>
In-Reply-To: <20240207101929.484681-5-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, alex.aring@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org, andrew@lunn.ch,
 linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Feb 2024 02:19:23 -0800 you wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to IPv6 over Low power Wireless Personal Area Network.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/6lowpan/core.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net,v2,4/9] net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
    https://git.kernel.org/bluetooth/bluetooth-next/c/2898f3075e6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



