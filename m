Return-Path: <linux-kernel+bounces-57953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DBB84DF74
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1998E1F24F05
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6816F50A;
	Thu,  8 Feb 2024 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLtWXJmu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380BF6DCFA;
	Thu,  8 Feb 2024 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390630; cv=none; b=I+Aj9iYee3SKMkgJ7hugkmA9zCS0jyJsIc4aUpFOkk6jsDkk1VGdnHMIqLSoxFnLz4owi7C85BIxWZXfINr1zl6Rf759V0/qsoDjY6L2zxgsCguU0HDqeI/ra0lZeoOJALZ6QCzj2PLLb4DUx34OcfLfmQ5OadbvOd0WOiWjgpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390630; c=relaxed/simple;
	bh=p+OUfWlrzA+M4vjTxp8+4tn9B0VIKOQSbkS2Ogl3CDs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qt19dfuEFGxzsXKmLogIMXWONUq03eg+kCgopeJYUWmwsGqtqJqEQmv+NnOh2yiV3jTywYZswQhmFVAzRXgENFjcH40bRIE5b6FeYQeeVND5SBIUJ2MqGqPgxfn5eOj0b9fesS/0ZzP82IXSrQJeJZg3rw56LMS/A6G2cxSEYfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLtWXJmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF9D0C43390;
	Thu,  8 Feb 2024 11:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707390629;
	bh=p+OUfWlrzA+M4vjTxp8+4tn9B0VIKOQSbkS2Ogl3CDs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tLtWXJmuOYFnp1AfFe/z/SZ58wkuAO3UJfZufjXnLwSsWCizUNW1Oh2sa/mSmDAsY
	 4cF5sjvcHSyphL6bi6D9qaUAfuAXeTEamih0p3pC+XJjB5Nne3uMSsGMk+3TQsYSdF
	 OCaYLwxfQ9yOQ2mCQ9uRvYYugiZ7Zf7CXwxBLDuiJEfNpqpWTBrLcTETPNQY2v5RUC
	 ACkTQSiDtA0bcq1LJmW+Wlzr+Lnt5sAp2zpMXqeAs/Pkx4TYmy7MgJDbjrBIuA6jDk
	 k0EjLZ4qKrPOXXlrCPoIvbXpis6b6eRoTOdOuGOU/O+eJwHkfLU+EXA+6NflJEUAUr
	 wWzZz1eVbM5vA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2E9FC395F1;
	Thu,  8 Feb 2024 11:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] octeontx2-af: Initialize maps.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170739062966.21022.12692038098590787305.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 11:10:29 +0000
References: <20240206024000.1070260-1-rkannoth@marvell.com>
In-Reply-To: <20240206024000.1070260-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, pabeni@redhat.com, bcreeley@amd.com,
 sbhatta@marvell.com, gakula@marvell.com, hkelam@marvell.com,
 sumang@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 6 Feb 2024 08:10:00 +0530 you wrote:
> kmalloc_array() without __GFP_ZERO flag does not initialize
> memory to zero. This causes issues. Use kcalloc() for maps and
> bitmap_zalloc() for bitmaps.
> 
> Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> Reviewed-by: Brett Creeley <bcreeley@amd.com>
> 
> [...]

Here is the summary with links:
  - [net,v4] octeontx2-af: Initialize maps.
    https://git.kernel.org/netdev/net/c/db010ff6700f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



