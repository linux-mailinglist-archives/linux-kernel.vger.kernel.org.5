Return-Path: <linux-kernel+bounces-124450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C7589182F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4F8286CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8966AFB9;
	Fri, 29 Mar 2024 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcV5zTKP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CE954737;
	Fri, 29 Mar 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711713028; cv=none; b=tbHEmoM8Z8nuti+nDUYtJW28BwB7oYLQbeY/j5PbLixO3X+TFaP0hNzbnKWbT5m1j7S5N+hp3NS5as1aA8FNPz+hNzXHNPYNz8iWXextxUq7X7Sp9IQRGHPfub55D6arDwYKou9+u5c7KocSpfApAttbQYRTFuEk/q+tN4tcxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711713028; c=relaxed/simple;
	bh=sf+asqxprd7GPK8qQVfc44quhQ5MK4xF5ACJAjA1v5A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fh3zm4IBLMet0e7GaSG5+OfwYeKruzv03k0b4cmUfg1HTyfR9RNR15OYKtZe2rSOWFJ9B3fLNJUkvGNpbXXPwteTg2BNW0q2NEcRU2Aq1TScywqoCvx2n9dtWtoIacBCABOUrup9VkBHEjZESkEbcfT6HrT2V6z/4NHfZReerk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcV5zTKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E43DC433C7;
	Fri, 29 Mar 2024 11:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711713028;
	bh=sf+asqxprd7GPK8qQVfc44quhQ5MK4xF5ACJAjA1v5A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BcV5zTKP4t9eHMaxpEyO5SalY7u5yMDQqd9EhRnjPWBveEJrueutgooAgVkMAvQ8r
	 TFiaAM2hKOhH+r7PAWz7tCGGt/I6aAW5ulIjMFmJW/0iPM60jGerHjsPPjnZtm5v8d
	 wxMICdN5Hn9PRO0anA3K2LI10X+3XEcoQInMetM4Kk33MASqBT8XNCjxMK4u0ZG090
	 +P1RUXmPLtzVtwLrESNeXsNdT5AVa9EgoyFQsr3o23lEWbIhseElGSd9oyj3+72t0m
	 mvlG1fqeDviZrWgCPianyATh6bS7CHVxiRyDHznGCP+i7uRd/9xYbyGH2OvusvDfLX
	 51Ac7lNZ6Hu5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CFE2D84BBA;
	Fri, 29 Mar 2024 11:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net Patch] octeontx2-af: Fix issue with loading coalesced KPU
 profiles
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171171302804.30113.8957090574149995586.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 11:50:28 +0000
References: <20240326122149.4377-1-hkelam@marvell.com>
In-Reply-To: <20240326122149.4377-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
 naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 26 Mar 2024 17:51:49 +0530 you wrote:
> The current implementation for loading coalesced KPU profiles has
> a limitation.  The "offset" field, which is used to locate profiles
> within the profile is restricted to a u16.
> 
> This restricts the number of profiles that can be loaded. This patch
> addresses this limitation by increasing the size of the "offset" field.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix issue with loading coalesced KPU profiles
    https://git.kernel.org/netdev/net/c/0ba80d965856

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



