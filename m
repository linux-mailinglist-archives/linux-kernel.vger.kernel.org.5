Return-Path: <linux-kernel+bounces-5070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B404818639
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715381C23BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0BA154B6;
	Tue, 19 Dec 2023 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePkWVA4r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98D616405;
	Tue, 19 Dec 2023 11:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 212FCC433C8;
	Tue, 19 Dec 2023 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702984825;
	bh=FxNtzFmTDXIECr6vy5RnaSZ24/wTDFdWrO+Iou4nKMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ePkWVA4rEdxmflF5Xc8zD/EpGQUyEGK7o5ZE7tWqn4pH7K+CdrI6VUYMYYFovuML1
	 7CeO1Gdtyl1PBZ0ILW3CzrETRb6j0FrAtiohbdl/mq1e18RXvhhAVhuur00nkoAy9K
	 6CW5Gt2pREFVCv77M6+hmD+oXnlkPcrfWWQhq2RjN6SOt2zldqDMdecjv5+JlCDUZb
	 R7aSko7xB/6mI0txwQaIDm8g3270FVQEbWfJxfQrUxWc2wXEHr/0zTUEoAeh9+j8Yi
	 cW7wc2E9VvAv6r1nJrDhd6vT3AJG5JyrLIoEI3UxiZlMQ4UEl6w56EtzVAYp0zAFKu
	 NPXo4Wt9cG4zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 069A6C561EE;
	Tue, 19 Dec 2023 11:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/4] add PF-VF mailbox support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170298482502.31697.94316863464466171.git-patchwork-notify@kernel.org>
Date: Tue, 19 Dec 2023 11:20:25 +0000
References: <20231215181425.2681426-1-srasheed@marvell.com>
In-Reply-To: <20231215181425.2681426-1-srasheed@marvell.com>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
 vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
 pabeni@redhat.com, horms@kernel.org, kuba@kernel.org, davem@davemloft.net,
 wizhao@redhat.com, kheib@redhat.com, konguyen@redhat.com,
 shenjian15@huawei.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 15 Dec 2023 10:14:21 -0800 you wrote:
> This patchset aims to add PF-VF mailbox support, its related
> version support, and relevant control net support for immediate
> functionalities such as firmware notifications to VF.
> 
> Changes:
> V6:
>   - Fixed 1/4 patch to apply to top of net-next merged with net fixes
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/4] octeon_ep: add PF-VF mailbox communication
    https://git.kernel.org/netdev/net-next/c/cde29af9e68e
  - [net-next,v6,2/4] octeon_ep: PF-VF mailbox version support
    https://git.kernel.org/netdev/net-next/c/c130e589d50b
  - [net-next,v6,3/4] octeon_ep: control net framework to support VF offloads
    https://git.kernel.org/netdev/net-next/c/e28db8cbeba3
  - [net-next,v6,4/4] octeon_ep: support firmware notifications for VFs
    https://git.kernel.org/netdev/net-next/c/4ebb86a97ceb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



