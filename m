Return-Path: <linux-kernel+bounces-96831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8246D8761FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B466B1C20F2C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C4C55C07;
	Fri,  8 Mar 2024 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxQYalDF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B2A54665;
	Fri,  8 Mar 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893834; cv=none; b=iFDp7e/qzRHQZc8CglGFKH4/53QWzv47GuzX2kpgtCgd8i5Is3/JcxfmwT3PV58ggKu1qpYp8YhO6xNMVYbKKwOeB/M05V3HczlnFCRCwoPC613UiAxexeE8k7x7A7/B1jrZoeBr6tB6ZE6Z1/h4uZH4sIe+MhXqlGAk3qEQnKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893834; c=relaxed/simple;
	bh=ybeysiln1arLPFOn44mZI7U6wTDKxbgcZkjm5Al4/ok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rjITWkhY8QFppWqW4ogNK3rO4NZHgVlCY3uo4F8mRkuiuEDT5XDnY88SEcEDdxyd9+Rrt1xklODbkb8oWduam5Bbw+pyN8u9RlIg9fsHGT41B+g8InZo4LRdQwNZs+EjcIXRBH1525CZ9zbyGjZV1XQz4fyHCL4FO9z5y/ZvZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxQYalDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2567CC43390;
	Fri,  8 Mar 2024 10:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709893834;
	bh=ybeysiln1arLPFOn44mZI7U6wTDKxbgcZkjm5Al4/ok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DxQYalDFR6fsHPYG75UlFIrPldH21l85DOKixy9Rf0XCNfhijTCNw1EhQBK4h+Wu2
	 47mTeGBqNHoS8PgJBFt3XzMlWQhW9QL24rJbz1rWfCzQuOYwPny8ECOtAQMuWETtM+
	 OTkV2VxulMRBgBqbZtRgUhCxibhv5bJGqkFyC1rIre0x74q4PVvdp2nRoLJKQBfa2R
	 BM70Z1bvA/QbGQtHd2yyhHelHhLncuI3iTwjgu2w+SsbTERLamKDfPsaPGBlcU9n+T
	 R6s7vh5TEb5LRDb48KBcvmcUeDOjhK2TSXyA7ON94Rmlf2jsIfjmXYziEqTg6ayDRb
	 kxX2AcWx0arpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F312FD84BB7;
	Fri,  8 Mar 2024 10:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: chelsio: remove unused function calc_tx_descs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170989383398.12583.5995436016062470108.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 10:30:33 +0000
References: <20240307112237.1982789-1-colin.i.king@gmail.com>
In-Reply-To: <20240307112237.1982789-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  7 Mar 2024 11:22:37 +0000 you wrote:
> The inlined helper function calc_tx_descs is not used and is redundant.
> Remove it.
> 
> Cleans up clang scan build warning:
> drivers/net/ethernet/chelsio/cxgb4/sge.c:814:28: warning: unused
> function 'calc_tx_descs' [-Wunused-function]
> 
> [...]

Here is the summary with links:
  - [next] net: chelsio: remove unused function calc_tx_descs
    https://git.kernel.org/netdev/net-next/c/9b78bbef5138

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



