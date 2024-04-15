Return-Path: <linux-kernel+bounces-145722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E198A5A05
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8411F2163F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1166155736;
	Mon, 15 Apr 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWLCh0LP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E240E41C66;
	Mon, 15 Apr 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206429; cv=none; b=H0FLcMtpdys3qMzigjaiZolXOD6ApbtOH+HzJQEe0n4tZdQpKI69JwcAi7rI/4tZQm35UlQLZiSTqKaU9j2Uw0PpaOPErdVGiPAZs5AMGK4S+T73j6aOiM4LKzVtgpZEyQBFdgUq/PZPVExZUuAQMBLeKw8vnwlLvyeCuouvPxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206429; c=relaxed/simple;
	bh=kgowzD5fH9d5m5BdHrdoSAm9Nv8Ny5qyh36nwbqfVJU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kBVbwGzHZS2VtTolcmYpv/mUtxVGD0D3NlzAcNZF3IZ/2MdKUFjvfEv/1QZNYvug5a0YQ93FZVQuLvlVZK6k7uFweRTXYS9JQ6eenL6VaFGwM8z5i2fyo7FC8Q7Ul1r7U7SLlns+j0M+9iuLI02G9oxyZ+iCDQychTAw4eRCfpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWLCh0LP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AF4AC32781;
	Mon, 15 Apr 2024 18:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713206428;
	bh=kgowzD5fH9d5m5BdHrdoSAm9Nv8Ny5qyh36nwbqfVJU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hWLCh0LPmuKPaERfjBv0puRjxeizWuCM4pfy2PtEWKbpolywviYo7FmIyvqL4uJqQ
	 AJoFgBe30f2dE+O8SCA1BKsa4woQj2QGAx7EcZhOymwDh3NnVnZz3/qLMhO8uo1Fkf
	 8EdEkNCu/n4tuKPUdDTIlRoHSzt7+IHMifwcKdBk2OhFBWXL994ufpLUY5HsozuLpx
	 MZvxk7zs+LYPFDVPp1ZC96Gyj96g9IN9ZgaJkwS4ytoXEa3/u0zazdshmezGrzrcAe
	 5eyQKmNu8OuwnUb1k4uJQ/aulAlWM8lUns4e+d4dtudtRaY/sEh4j0t/Dtc6uorJ1a
	 SAUaASD3waicQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D8BCC395FE;
	Mon, 15 Apr 2024 18:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] net: dqs: optimize if stall threshold is not
 set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171320642837.24301.3642985390319068381.git-patchwork-notify@kernel.org>
Date: Mon, 15 Apr 2024 18:40:28 +0000
References: <20240411192241.2498631-1-leitao@debian.org>
In-Reply-To: <20240411192241.2498631-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Apr 2024 12:22:28 -0700 you wrote:
> Here are four patches aimed at enhancing the Dynamic Queue Limit (DQL)
> subsystem within the networking stack.
> 
> The first two commits involve code refactoring, while the third patch
> introduces the actual change. The fourth patch just improves the cache
> locality.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] net: dql: Avoid calling BUG() when WARN() is enough
    https://git.kernel.org/netdev/net-next/c/4854b463c4b2
  - [net-next,v3,2/4] net: dql: Separate queue function responsibilities
    https://git.kernel.org/netdev/net-next/c/cbe481a1b741
  - [net-next,v3,3/4] net: dql: Optimize stall information population
    https://git.kernel.org/netdev/net-next/c/721f076b62cb
  - [net-next,v3,4/4] net: dqs: make struct dql more cache efficient
    https://git.kernel.org/netdev/net-next/c/4ba67ef3a1fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



