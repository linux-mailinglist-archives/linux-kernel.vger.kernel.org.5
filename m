Return-Path: <linux-kernel+bounces-147795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C6A8A79C8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742BE1C2246F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79486FB9;
	Wed, 17 Apr 2024 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQvSDFab"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65ACA40;
	Wed, 17 Apr 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313233; cv=none; b=lwRh9/h7uHOZNyqS6mTOTRKoqqFimS3LMab1esvmrdJdDmmv1yxWJ9RfO/myfq3N9Ql0daG6pqvLbbfvxWDmiomXBmdxqcOJu+zQgk8Mogq4t5X74ipHLFSE2Ko0I9vE3s5NdaTZqcIDkPAi47Ozv/KfrOcayD6wf0UaduUtKTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313233; c=relaxed/simple;
	bh=/i9bdPohR3Hwnz6elKCfzDTvkDD/UZyPKPtJnBQFJGI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H8bv4VkAT8Id6SE6aRUfbcvRDhwERgOYdJle13nnOorcXkO2k+JPclIwY6CXNnylJ5cJbCuHxP09HQZPFvlhQ3lZmcvxUZY8yromS5VOccWR+D0aO10PiGI0y8VJMwLyxW7cj1au2lIwG2zrkY9H5kF75QKg77K42Wv2GaiwSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQvSDFab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9803C32783;
	Wed, 17 Apr 2024 00:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713313232;
	bh=/i9bdPohR3Hwnz6elKCfzDTvkDD/UZyPKPtJnBQFJGI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BQvSDFab91ZIIYmGF5PiICYqxDJLf/nYC3+gI3Rguyo/8VrqJPD+4OBgKeZ/NZRuA
	 uJ413Vtf7hMTI7SkhFba7vsPvFynhQcwNwX7z5lRD++UhyIFAi4DswZklO35viMS4f
	 fCFXCFwlNNZNAOZdU5Mag8/Dbdr8OAewLXlqo3rPe0GLYz+ClYpbV0wu4kHJJHLUYF
	 a+TtKQ/N/HW6vMn1BL7mdFUSG/hr0/dkkeKMnOs18h20LqrhYTRPVUdo8hr00armhw
	 QeyK2kf2HksegKU87b4QA2zMs3CTTricUHJwhKJqVWpVkVnUrh4mw6lEL5CdeRgJhn
	 kx3Q1Y5FSDOfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABF1DD4F15D;
	Wed, 17 Apr 2024 00:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: microchip: drop unneeded MODULE_ALIAS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171331323270.29224.2660598885504020651.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 00:20:32 +0000
References: <20240414154929.127045-1-krzk@kernel.org>
In-Reply-To: <20240414154929.127045-1-krzk@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 14 Apr 2024 17:49:29 +0200 you wrote:
> The ID table already has respective entry and MODULE_DEVICE_TABLE and
> creates proper alias for SPI driver.  Having another MODULE_ALIAS causes
> the alias to be duplicated.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/net/dsa/microchip/ksz_spi.c | 7 -------
>  1 file changed, 7 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: microchip: drop unneeded MODULE_ALIAS
    https://git.kernel.org/netdev/net-next/c/9b07508845f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



