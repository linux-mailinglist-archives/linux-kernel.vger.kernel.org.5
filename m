Return-Path: <linux-kernel+bounces-107665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4376D87FFC9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F344B283D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0DC657AF;
	Tue, 19 Mar 2024 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCz5r99L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9D141A88;
	Tue, 19 Mar 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859228; cv=none; b=CoM6bPBK31h4GUddEJREt57NAj7RP7R9d7np5D+X9Hh3dy0Ft8aLnQt0fXAbbkEb3ns/ZndDPkmo7zvIsbGfi3sfz4q2mEGaSli83dscKkYsQt4p+NFtWSblt4SRILHlZDx8mbEZWUnZAnMBkE3h9vjbFQM/VMQ7MGJHvDhy9xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859228; c=relaxed/simple;
	bh=K687nVUSd4Nj8R+S1D9Gsc2gc3IuAiT6sst5UD96T8A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D0qXLZf9t9CmOs6vZbHc+2zR6e0DJ1UbEoSEg02OV3wvvcFqY9SB270F+Z9cAuI0eDbX9feK85Nz2x7x/iJ+Nsu6HIOjC5uH24Nu3UthPGVkQluaExKAr1/AwuZKH8gg4C6NRtQTv4r1cHBeSyd/Wr+D41IzT2WHg/C9D4zvewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCz5r99L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B2ACC43390;
	Tue, 19 Mar 2024 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710859227;
	bh=K687nVUSd4Nj8R+S1D9Gsc2gc3IuAiT6sst5UD96T8A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LCz5r99LwElEuaoFYodizITyW3M8AfIvkGshmmxuEtjYml9viHUZiTVEMkD4I8e9y
	 5J5owQKyhc1SIRthGI1jhxbu8axuf3ik0tYZX/J8T3amLZRNwTQ4Ngpk5fRUcBmqWo
	 1GTdei2fVKg4MkyTcALr/L3C8Bkfvu83NaBA+gdshbyFbV37i++lIF7XNbUuXBHQ/D
	 B2ZbOXDqyON+gmC+j++gZsRt/izjLQqGvRStltrtM1WtRQEKsRi4JrQAOwvYgG36EE
	 SFp7k2qH0cJUmeYpfWLjglq3KdAaieLs1mutsB7TaPmO7CmYBboa76WsmvxR0BbN2G
	 BfoPzJFvFSllg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 787ECD84BA6;
	Tue, 19 Mar 2024 14:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/sched: Add module alias for sch_fq_pie
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171085922748.31413.797932865821608705.git-patchwork-notify@kernel.org>
Date: Tue, 19 Mar 2024 14:40:27 +0000
References: <20240315160210.8379-1-mkoutny@suse.com>
In-Reply-To: <20240315160210.8379-1-mkoutny@suse.com>
To: =?utf-8?b?TWljaGFsIEtvdXRuw70gPG1rb3V0bnlAc3VzZS5jb20+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 15 Mar 2024 17:02:10 +0100 you wrote:
> The commit 2c15a5aee2f3 ("net/sched: Load modules via their alias")
> starts loading modules via aliases and not canonical names. The new
> aliases were added in commit 241a94abcf46 ("net/sched: Add module
> aliases for cls_,sch_,act_ modules") via a Coccinele script.
> 
> sch_fq_pie.c is missing module.h header and thus Coccinele did not patch
> it. Add the include and module alias manually, so that autoloading works
> for sch_fq_pie too.
> 
> [...]

Here is the summary with links:
  - net/sched: Add module alias for sch_fq_pie
    https://git.kernel.org/netdev/net/c/9474c62ab65f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



