Return-Path: <linux-kernel+bounces-120301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290D488D58A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CC81C237E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E3C5258;
	Wed, 27 Mar 2024 04:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq+fPVfj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2D3639;
	Wed, 27 Mar 2024 04:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711514888; cv=none; b=TJHrzNOFWz4xozHGtc7YrswaJ9l/q5JRlFYXqW365w8FG2ZYi4Tg3cegKPzAVqlo7uE8m7A91563FkPKqcsBdhLX2ycPaJHULc9/z9ozmoqcGKeVJ9bhW6ESZWEieB0hIwa/53RuRfw7+tdNi8t2XvedlFTKnTkRfOYUvGgHjEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711514888; c=relaxed/simple;
	bh=uWAuppfKIv+6QPjw6eP0ZldkO7CbP2+7dJhYWeKcAwg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WwpujaZBM53IA1wEhsBajj6Y3VnzZdGh3aiUTXF7BRS3vJhNK8iyJKeBAav3Z4G1M8DXJG8OwIQJDubzegk9mN2vCycqDttfK073Q3oIDGcMlD30pPrPxAN/cl6lwMmy8NfQFLz6Y2s/O0en+x/47XCoG0oBBf5GblL6hF8jLIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq+fPVfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4736AC433B1;
	Wed, 27 Mar 2024 04:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711514888;
	bh=uWAuppfKIv+6QPjw6eP0ZldkO7CbP2+7dJhYWeKcAwg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nq+fPVfjlUx2zeMIapvrYl7TVkDJz8bJcwhxeBSr/WWIdYd9AcGXw4FkzEa0UCG+s
	 pT/GU5Jb6XJS488ZLmcT1ZyfBVs2rI4ALg56S9EfU0hn0aEP4MOu1lRqsHT6XEYLTh
	 W5ihMTLqxfh5FuaoujVyPk4n565x64o1NsNm2QswCKdLn7o/3kVxlz2QXEHJXrmtYu
	 z6KZyf0YWcs1ZYT9CzeVWaLhp0q9B6F0GwMArvzcogAubuoNfXT8TI4zWCUgyQ4o5p
	 G1TGw9WQLI5an4ekcUfi0NBgLsrIZqUPCQBcWws13gwb3dMxnRC+fzEBt+G7+2o+rQ
	 YuLxPgncbF9og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D6E1D2D0EC;
	Wed, 27 Mar 2024 04:48:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] platform/chrome: cros_ec_proto: avoid
 -Wflex-array-member-not-at-end warnings
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171151488824.812.5983218096761719498.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 04:48:08 +0000
References: <ZgMaDl/of8YC445S@neat>
In-Reply-To: <ZgMaDl/of8YC445S@neat>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: bleung@chromium.org, tzungbi@kernel.org, groeck@chromium.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue, 26 Mar 2024 12:55:10 -0600 you wrote:
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> drivers/platform/chrome/cros_ec_proto_test.c:1547:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/platform/chrome/cros_ec_proto_test.c:1607:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/platform/chrome/cros_ec_proto_test.c:1645:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/platform/chrome/cros_ec_proto_test.c:1668:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> [...]

Here is the summary with links:
  - [next] platform/chrome: cros_ec_proto: avoid -Wflex-array-member-not-at-end warnings
    https://git.kernel.org/chrome-platform/c/6c85a13b133f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



