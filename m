Return-Path: <linux-kernel+bounces-47454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 075C0844E2D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12271F22905
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654D44417;
	Thu,  1 Feb 2024 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpD1jZdl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04191FDA;
	Thu,  1 Feb 2024 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748627; cv=none; b=O7MxkoDWOxO+1qAUcO72BKc0fhUjrBb/UqmmwqC1z3iIMZMxj2w1m1fDhGR4smJJJLz6dBWTID8Ao8OMlTyJi3/bnVOytb2AzeVn88HpZ/21glYIKeKqTlIYpNxNXyuHYE0LWNs001Rj+9gOG+ThEUZ4FxUfNtx38qBzA6tmz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748627; c=relaxed/simple;
	bh=8Yn7WZuUu+7N5PkWWTp/ZUOVig7abrr1Tg2VivYAKi8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xgcyx2CY+bY3PbpU4AvBAKsmSgBav4y5YN9C+/Ota5VpOjWItCKYMJVoVak/LW115w/KRpDztDapkfGHi+YZ4kmZm8dCfTEvqxWOMqiERANdiy/8gGnIUdJX4t6dtOKrBeHMO+HILxeOgwb5othJhgBXKxzIl++QhB3oM1HT/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpD1jZdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F976C433F1;
	Thu,  1 Feb 2024 00:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706748627;
	bh=8Yn7WZuUu+7N5PkWWTp/ZUOVig7abrr1Tg2VivYAKi8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tpD1jZdlJOCSbQjrtrLGr/hMr10uIywTyHgmSLZy7WvOCciOq/60PefDfkAIPc4w4
	 hcDHYbxp6JI/0cM3MhzGTCLVPWauspzVKCavbdUSMNZvcl8YCr9jVX9vPliEgMj1Ql
	 uaiVvsZetdarxleGT2VhwWGSmkiVcudpNKq+ZQ8pl0J4KuMjv1qMSf7yRqOPwL2FzI
	 bodwKNi+unOUv877jWxr4OSCxhiMxoJbHrB0p8uENbre6tamUBGg8y1wkrO2rX0GUg
	 aEo23zj3C2cB+1ATfJg7FPzjBwudfJ9fL7MbaHLtAKL0rvqLPFdN6s0eXtYM28zzPE
	 dVVnmvhrhnsEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14718DC99E6;
	Thu,  1 Feb 2024 00:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ipv4: Simplify the allocation of slab caches in
 inet_initpeers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170674862708.27305.5476784873293252924.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 00:50:27 +0000
References: <20240130092255.73078-1-chentao@kylinos.cn>
In-Reply-To: <20240130092255.73078-1-chentao@kylinos.cn>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jan 2024 17:22:55 +0800 you wrote:
> commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
> introduces a new macro.
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ipv4: Simplify the allocation of slab caches in inet_initpeers
    https://git.kernel.org/netdev/net-next/c/57f2c6350f2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



