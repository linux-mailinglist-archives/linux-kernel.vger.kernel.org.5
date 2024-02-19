Return-Path: <linux-kernel+bounces-71167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB4C85A18A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0272831DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353262C6AF;
	Mon, 19 Feb 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9gYk8je"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609962C1AA;
	Mon, 19 Feb 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340426; cv=none; b=DZglIKlBaQtLe4X2xZFrRj2FOVfBFJmMAMOxISgx5vM+3TT6U0zUp3xfCkh4zBC+cTgeEr2yaLRlEgrtiCddjlUuqHsT1s294+teVyzsioDOkDwNutoacx984d01dktpRChPLZYtuDl9txLqGkHSCFiiHC2bZmXDnx4Fu/hFzq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340426; c=relaxed/simple;
	bh=uvA9+6Dw90IYg/Zyk244coxsLVp6cYV58Ros7J2iFVY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U/pwj2524sN3MQQuT7zcX8Pk9t1ZaKO37GdIwsD8GlBTt/lFCQ1vvioSpH+fT9orqX1jZft8dXoBJd8bG4opfvbwRVmnRZvwxbkYyHtAPvaMhYRr8wb/8hsJAY9RrdCn7Q4uJdQ7PFPHeP0PLVXALAiPC97DLwqSXR/sZP72Kc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9gYk8je; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E03B8C43330;
	Mon, 19 Feb 2024 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708340425;
	bh=uvA9+6Dw90IYg/Zyk244coxsLVp6cYV58Ros7J2iFVY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c9gYk8jeBAlGoKZ43r7vGX6dsYF9PppEMzdgBg8Xb4YsjydCQ/kdDQUIp3ARocahj
	 hik9ULU0JYZ8DnK0nXiFziLKVAAeKeYhhtEO3dGzBvRLF1BO/6pWXghZsIBMHBlmfd
	 H84FyCAFAN3RTQMv0BbsqupHuz4edg24bvGfhIcrF6lElwqxQ5s2+rNTQ85boo9Y88
	 Nmmh9/99l05RB2F2Xo8mdjQjLluPEpAuQmHq6SsNGQixCuqa3UPKM/xmFd59H68sME
	 XiRGKdRViYTJIcHYRkkRYIh3MpfKmd3X2tmObGGv1q4NxVLOHmsCj10eBGm0WWVim4
	 GZcdLhjyTP/ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCA59D990D8;
	Mon, 19 Feb 2024 11:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sched: Annotate struct tc_pedit with __counted_by
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170834042583.18215.251918949799805641.git-patchwork-notify@kernel.org>
Date: Mon, 19 Feb 2024 11:00:25 +0000
References: <20240216232744.work.514-kees@kernel.org>
In-Reply-To: <20240216232744.work.514-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: kuba@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, gustavoars@kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 16 Feb 2024 15:27:44 -0800 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct tc_pedit.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [...]

Here is the summary with links:
  - net: sched: Annotate struct tc_pedit with __counted_by
    https://git.kernel.org/netdev/net-next/c/1e63e5a813fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



