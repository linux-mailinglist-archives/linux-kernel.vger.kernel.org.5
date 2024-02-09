Return-Path: <linux-kernel+bounces-58965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E5C84EF44
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290C0B25B48
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21DBE574;
	Fri,  9 Feb 2024 03:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixgVlk4p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175EE5227;
	Fri,  9 Feb 2024 03:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448269; cv=none; b=ik7S2gKX0e5dgxPS/71biQfHQfilmfBjvutzn+YAedwieQNMBn00a34x8BoPlWNqiuPoY5xd3tjpmM2M08/gkWgop65Xw8KBhb9otv1bIYAZ/cSRfDj8q665KFjtSowshjFdADZqyGNwmg9i2MU6OdyDW2vzNj+jPCwUFcISevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448269; c=relaxed/simple;
	bh=MImnYCullCb2OJJMdGIL1zNVsFYJtY2dXlgKHUn3xOU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F3ZMQ/QlslgDZ/AqIAs/cfSWsrVUtQoWwxAupiJUqg1KfmIBgyYVk9ntoIFjZmBkXByejit/nLKKb2bM/ssv4s3kicT50J8LetYETrmmBKxwlqTeMMhb2niJhlxEQ0thVn/aQlvhBqrusJGm0VIumBu3TM7azYWfUj38d8aEAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixgVlk4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C397C4167E;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707448268;
	bh=MImnYCullCb2OJJMdGIL1zNVsFYJtY2dXlgKHUn3xOU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ixgVlk4pB7dXF0Sso2D2+1H1xMARajI0aoLoEus3pECf7eoFk6a0xnE/0PXm4qKc2
	 PcIZhioO0K2dM9vB+IjiaCcNK2E8VEluxnw3WcK17AQaF4J+45zq6gZ87B5ydaKEcT
	 NdxsCyreM06oFYooEW0IRdChmbG+CmZ6WxNwU9RgIv7SbMAhh0099eL1PuercoK14l
	 WN/aUOc9B/cHyntco9u9LwbLNMZxdK3TWqWDTK4bQRN2MBhEX0iGrlSiXnbq+YjsbG
	 7ubSGyrgle8PEtXLUJiNTMuTYd0FITvANn5BifI2JP0qGjLaKa9G11cs1Mys9npdzJ
	 A1Xhzeiqx0Irw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A1D0E2F312;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6] ptp: ocp: add Adva timecard support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170744826849.23533.2455688708391144333.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 03:11:08 +0000
References: <20240205153046.3642-1-maimon.sagi@gmail.com>
In-Reply-To: <20240205153046.3642-1-maimon.sagi@gmail.com>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: richardcochran@gmail.com, jonathan.lemon@gmail.com, vadfed@fb.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Feb 2024 17:30:46 +0200 you wrote:
> Adding support for the Adva timecard.
> The card uses different drivers to provide access to the
> firmware SPI flash (Altera based).
> Other parts of the code are the same and could be reused.
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v6] ptp: ocp: add Adva timecard support
    https://git.kernel.org/netdev/net-next/c/ef61f5528fca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



