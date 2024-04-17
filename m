Return-Path: <linux-kernel+bounces-147796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE298A79CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09554B216AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D1F7462;
	Wed, 17 Apr 2024 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFaELdQ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB2010E9;
	Wed, 17 Apr 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313233; cv=none; b=bGbZ2l4GLfYfl3NDPuVcH9aV7PKwLkd4bZ9ZDftT+pr+xb6375aLP4N2Mrt6UiqwE+/WtgpkZNnU8FU84qZW+h07lLwnmwDzh5ASHRTKxCaOowCY4QVLTISBi9FTGKo3AnuspdGyQPG3Van5JGf5T8kw5aItdLsCd7rbA79fNTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313233; c=relaxed/simple;
	bh=lpocv/z70qCxQnRbXQyLix+hr4YPw2aKx/Neh7cyi8w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FR2Ew6VUVc+w4k9wbNEFKjgLsWq1/iENLsG/mnfW2FSxd0IkYzUgdzERnqd9jUJuakRfe8Ru5PunqZXKlCu7L+FLEAfLjyHVKw5T/sW7fBeTji1x56ra0wX2meK6hDL9nWKVZKoAYAWmV2kevvwiC+Wyuh9nFoSQnERdWrXhaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFaELdQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A11ECC2BD10;
	Wed, 17 Apr 2024 00:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713313232;
	bh=lpocv/z70qCxQnRbXQyLix+hr4YPw2aKx/Neh7cyi8w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pFaELdQ6DNSlIIuV6DbafKIDSFH0d6Ai4d9dtZy2Nm8sSCpg/G9QeWCxXnNelPUF3
	 3xf3caf+NDku2zk1hRDcScBTRpC2jNtM6GOVIiDQbtOQsTWTcg+XEvi3ZsAHJL/cUO
	 RQ0LiA7Nz4pLdhOFQpDSNzYHdK64RblOANG9voEWVwUoA7C/bumDDo0dCeRN1ZB2bu
	 VNzESRsY/VkuidAZA3Wi6F5blYXCcmuYzajWix4BdJrzSXfcCmOQTnxQ9Y2toQpJGQ
	 anbP3ZcoH6c9k6u6b76+WVf7hFBlP+wT9zu0OjN62Obh6i7yYhi1ynD1pSRsWY57CR
	 caMhw8zJmHUcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9568AD4F15F;
	Wed, 17 Apr 2024 00:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ipa: Remove unnecessary print function dev_err()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171331323260.29224.8750365048469013468.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 00:20:32 +0000
References: <20240415031456.10805-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240415031456.10805-1-jiapeng.chong@linux.alibaba.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: elder@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, abaci@linux.alibaba.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Apr 2024 11:14:56 +0800 you wrote:
> The print function dev_err() is redundant because
> platform_get_irq_byname() already prints an error.
> 
> ./drivers/net/ipa/ipa_interrupt.c:300:2-9: line 300 is redundant because platform_get_irq() already prints an error.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8756
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 
> [...]

Here is the summary with links:
  - net: ipa: Remove unnecessary print function dev_err()
    https://git.kernel.org/netdev/net-next/c/19ad0f3a16d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



