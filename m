Return-Path: <linux-kernel+bounces-13868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851808213CF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 14:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28687282526
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 13:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927A046AF;
	Mon,  1 Jan 2024 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOZUXrrP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AB22595;
	Mon,  1 Jan 2024 13:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D22DC433C8;
	Mon,  1 Jan 2024 13:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704114624;
	bh=a9nV6QQCzdZu2gWZV3WKYqSAQJidFFU96EOKg81K2YY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fOZUXrrPRVtM5CnU3x2x/QvNWm+XyJW6WJkxtVtXVyTRIOHRUFVyWwphFQy+z3oLa
	 lfgkc/tvbNA7oagoi+aPlUNQOR7eo8LYAICJQJjnOvxberZF5pFHJacK1FL6N35j0E
	 lJJsx2TOuYIIVZXJVhnCUBx3wpDAn7dYmCS70CjCXAxt9RlDh+mBctBRgLiddTYWQt
	 j9ddRg5llJr2DPrHXbQDvU96LCp6t6CICWi7v5i/sGnculnm8jzbsBz67Q9u9XPpV5
	 05bCrL9+X9cb1vQSoYLipAJ3URpXyWJD0LaqisbzgzS9eQT+qPJ8CMppDXXS56tWxt
	 X/1PB1WoOqCmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2236BDCB6CE;
	Mon,  1 Jan 2024 13:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: sched: em_text: fix possible memory leak in
 em_text_destroy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170411462413.15417.7544747974620244482.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jan 2024 13:10:24 +0000
References: <20231221022531.9772-1-hbh25y@gmail.com>
In-Reply-To: <20231221022531.9772-1-hbh25y@gmail.com>
To: Hangyu Hua <hbh25y@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 tgraf@suug.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Dec 2023 10:25:31 +0800 you wrote:
> m->data needs to be freed when em_text_destroy is called.
> 
> Fixes: d675c989ed2d ("[PKT_SCHED]: Packet classification based on textsearch (ematch)")
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
> 
> [...]

Here is the summary with links:
  - [v2] net: sched: em_text: fix possible memory leak in em_text_destroy()
    https://git.kernel.org/netdev/net/c/8fcb0382af6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



