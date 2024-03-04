Return-Path: <linux-kernel+bounces-90366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6128986FE37
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0223B220EA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8C522611;
	Mon,  4 Mar 2024 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhgmQDaW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB7D224EE;
	Mon,  4 Mar 2024 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546427; cv=none; b=ntT5YIZiCc8bx9Xk+sCHOOVgy1EjHCjQRjhHtg6mDjmb68ILecyciUD0Qkr5OBFwk3z3k58nQXdZQVFfoPUVLMMjP3ulWxFfw/Ok/vv4tCYdD/92kybXvBkUCqw66wj9RGwjvvDognsyAyWkcM3Hyyl9sF1J3vr69dYLZ7ROdGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546427; c=relaxed/simple;
	bh=SLyJ9jpZGtOXavO2oR1SCQeOLk04pqT/HIrfnN2FiKk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X8cxZaFjgMz/jenV4srBrtfK4tSkxvp0hKP+IhIjo+XqMGax5BnPbPWnHLv3Bj/b4Sj1rc0p1I6WQCdWZF8gaUE30dd2Oo6DJ7s2pKF4SxuQne8/REP1yApoDTFzpWIVRKchbZuYuwX5KKj8s4Tma6UYrlQ0PJK1C9BqehNwLE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhgmQDaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5549C43330;
	Mon,  4 Mar 2024 10:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709546426;
	bh=SLyJ9jpZGtOXavO2oR1SCQeOLk04pqT/HIrfnN2FiKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RhgmQDaWDHNseF+UtD1FWf6GafR38sMs5UGPSDMD4NTPnONmEGC1Bl0XDq7hWnHxl
	 xJp00nYalFFKMdSpruDbPxpf8LvxIADqmCfCMOFnBcpwOKcQw/61E5wTl7CzDvR/NK
	 ZhviPzwKGP+8HiGYHEVQXRhZEOHPyddApGVRXq7fhLgbBNOBjSCnMnCpQrep7mv52L
	 qV238/nikgIDRwhTJAyC4lDJt2webOxeGp9Npgbl3RU93+qbPfX9h6dBHGgGBoBiV9
	 /mupYZqUuO/TNnNUBIXFG8amt1Qhq0WyqUhaaHQf+Fa6o/urt7cpm4/SGoUZ7YrhPg
	 v0si3BMKwRxUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3A9DD9A4B9;
	Mon,  4 Mar 2024 10:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ip6_tunnel: Leverage core stats allocator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170954642679.21816.8952625755887609113.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 10:00:26 +0000
References: <20240228180318.1650988-1-leitao@debian.org>
In-Reply-To: <20240228180318.1650988-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 28 Feb 2024 10:03:17 -0800 you wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ip6_tunnel: Leverage core stats allocator
    https://git.kernel.org/netdev/net-next/c/6752fb18dc57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



