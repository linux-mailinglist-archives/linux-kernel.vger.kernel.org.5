Return-Path: <linux-kernel+bounces-41069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FBF83EB34
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 06:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F48286404
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 05:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B7617BAF;
	Sat, 27 Jan 2024 05:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb+MyNje"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED6E13FE7;
	Sat, 27 Jan 2024 05:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706332230; cv=none; b=FI3YGhH/1K0ROKaQTILM/Xz0V+MDzrOjt/kMiFTz2zLVZn3I/hOPuHhzqfGkkdxQCEfK47qeTenY35mJtvy75v5i7c0rOA6j/f/yAuGUwa6gcuiCphMhP9LAOkIXe7TDm/v44Jk1BGueOKo/4Ba4qoL5CWVhSP4GHeWhxxHSIq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706332230; c=relaxed/simple;
	bh=5j7c9OaIp+03FfKkYS4vICqk3KUP5hKpHsHO6ntv9wo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h3A5Ne02GNMwWPUnQppH4GpCk0VXeodWmOxWoKsC/REhccsMir1iN+dVohBXYrB/nXsJLxx84qU3MiHOXEs6cx5DxjVCllziBWn4igpHtj3p1HyNd7il94TY0U5nv27zuXPxAJxrIpq/yVbYh4gBzybtlLX5xN9CTyY5f34jqO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb+MyNje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F742C43390;
	Sat, 27 Jan 2024 05:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706332229;
	bh=5j7c9OaIp+03FfKkYS4vICqk3KUP5hKpHsHO6ntv9wo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zb+MyNjekpdoArtUyTBf6dt3H7fIOZEIrPrmuq6uinpc5fUHv/JXnUTlS0CvlC8eE
	 GPZpMaz/Iz8mphPkILP/jWEsTjvSQ0OFYIQQhcePuEpf0aYpfrRpp7IuQrmbOSaZVt
	 xvdxrdTD2JFmr2W4OugM/PI22iVhAl/YhYWDIvugQgSplB5UfRJnoAERNybK15aRSm
	 x5/us7qCyIcB1jYo2oGuxnUX1WIzrhXrmCMcLKKpdWxoDq5oBD47YQZGPxsF+8MEcI
	 obNNj9oGs5zPHcdBEz8pV9KrWlWvcEvWyvfQj5r/fd4mOTr5o/0eYb71gWmBWBJ4zN
	 DYbf4tkD/mi6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7546ED8C962;
	Sat, 27 Jan 2024 05:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bnx2x: Fix firmware version string character counts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170633222947.22327.17115220484623160383.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jan 2024 05:10:29 +0000
References: <20240126041044.work.220-kees@kernel.org>
In-Reply-To: <20240126041044.work.220-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: aelior@marvell.com, lkp@intel.com, skalluru@marvell.com,
 manishc@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jan 2024 20:10:48 -0800 you wrote:
> A potential string truncation was reported in bnx2x_fill_fw_str(),
> when a long bp->fw_ver and a long phy_fw_ver might coexist, but seems
> unlikely with real-world hardware.
> 
> Use scnprintf() to indicate the intent that truncations are tolerated.
> 
> While reading this code, I found a collection of various buffer size
> counting issues. None looked like they might lead to a buffer overflow
> with current code (the small buffers are 20 bytes and might only ever
> consume 10 bytes twice with a trailing %NUL). However, early truncation
> (due to a %NUL in the middle of the string) might be happening under
> likely rare conditions. Regardless fix the formatters and related
> functions:
> 
> [...]

Here is the summary with links:
  - bnx2x: Fix firmware version string character counts
    https://git.kernel.org/netdev/net-next/c/5642c82b9463

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



