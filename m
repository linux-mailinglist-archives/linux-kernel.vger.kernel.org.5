Return-Path: <linux-kernel+bounces-56849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D4784D034
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 498F4B23DB9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC47D54645;
	Wed,  7 Feb 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxEDhHHm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61E182D73;
	Wed,  7 Feb 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328233; cv=none; b=t2jr4XJzbPMwpWxrqXw2zPM4xnvTzddAURGRHjRUUBvptxSlb/ZqWgYtGvasnIIybNyaTl0UcgSMob/Ufh22h/T7cn5O7uI/BZbdQxzwIZpCqFsMdShCDbqGOflkXI0SPI1Ca9B5CAWqPbow/rP7D4R65BrHSRUYmNCAxqCCZ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328233; c=relaxed/simple;
	bh=OFVjgX+skhzLMEQtXnI4Ir8Wwpvt73NhyXm9sT76BRo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YEyZiSE+WrhtuOQX98xZDX+EbWeXD8T3tJCv7fX4aTLmFM7of+3n3QFlsnwPXDKb+lXpePxLYwbyDHpSqDQMEF3EMl0eglkdKl4nUaW1MVVk26m743k9lzMABzfD1131zjzqXMzD0sEAjfbO4CeuHRZ2och1CKbzdRIecTSOyUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxEDhHHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7232DC433A6;
	Wed,  7 Feb 2024 17:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707328232;
	bh=OFVjgX+skhzLMEQtXnI4Ir8Wwpvt73NhyXm9sT76BRo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jxEDhHHm1YCIhsWTR/4bpYdCpnGfN864F7SKg+2VjaIaCfpquhjQbZZyojdVtkjiN
	 gVLe9PJThbBLDrlo42F4VNf/DSsR2cbzE0UXhDaYGje6cGE0p8awtBbrF9NAUdIfJi
	 1awBvEWN0gD1j04idc3dyht807ySmd6uXYrnE0QfBCzayGFwmwsksBBqOzgG/z1YLR
	 2h0hXhuX+5HddCa1ps8RzD/iYrxYF+6dfgmsNk1F6DcPehHuyX/9Rh9OTdmK2gDjhG
	 Euqr/Wjqofy9uM8Hy/C95xdXtztnuRSg9nXtMVsTDLNTWDf7uwA3NHUg+QyRiQDRhF
	 MAVqkp4g9gNEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D82CD8C96F;
	Wed,  7 Feb 2024 17:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Do not return value from init_dummy_netdev()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170732823237.3503.3883222852584962770.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 17:50:32 +0000
References: <20240205103022.440946-1-amcohen@nvidia.com>
In-Reply-To: <20240205103022.440946-1-amcohen@nvidia.com>
To: Amit Cohen <amcohen@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@iogearbox.net, mlxsw@nvidia.com, idosch@nvidia.com, jiri@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 5 Feb 2024 12:30:22 +0200 you wrote:
> init_dummy_netdev() always returns zero and all the callers do not check
> the returned value. Set the function to not return value, as it is not
> really used today.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: Do not return value from init_dummy_netdev()
    https://git.kernel.org/netdev/net-next/c/d160c66cda0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



