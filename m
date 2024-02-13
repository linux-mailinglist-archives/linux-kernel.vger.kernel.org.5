Return-Path: <linux-kernel+bounces-63344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C92852DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F89B21949
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8E9250F4;
	Tue, 13 Feb 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMhnXm9M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F26922630;
	Tue, 13 Feb 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820228; cv=none; b=Os7WioJEof1OPtuC4xv4iKj8WQ4xeI7YYEe1zR9RxXQ4rPLACS/ViwhU7RLCdk7+E6DUupkbcEIFD/I35JFs7YjUC/cuZVsFlATKvbJWTtXMBmWbQNIaey6k4kCsF24LnsJKe5Kv+3fKJuyT/WD7nURL6iTCDf7nD2nDVEJcqS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820228; c=relaxed/simple;
	bh=PvsziTachfkKbKcxeD5Jn6Kg8rcVXIpf8hQnSmGZUHU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cSRCO3VQtQkVHY0tPhR6/JjJnDpCvdhrMPW8usHPW1vC4ImySD5Mjvak8W3SJyst1lS9SLBCDFO7s/MWV+kNDvwHo5+1505UG0hzwwOYQTEEaALwWf7SnP1vp9mbwSxJg1tupt+ijzNA7pMA7hVXpRhK1fQbLSThnOwWsQQi0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMhnXm9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7C93C43390;
	Tue, 13 Feb 2024 10:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707820227;
	bh=PvsziTachfkKbKcxeD5Jn6Kg8rcVXIpf8hQnSmGZUHU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qMhnXm9M822Ztmdf9hVOruzAk0E6DWyVQZl8dA+ZJJjcG/b9rTO1ClsiPD2uMsFum
	 QOEqe44JxqgHYX/oKmLIOIB79PJ+S+xTb6HWXltgr4zSy2p7J/A0JhcyYUofkbItku
	 iktr8fUJF5qos9h3krrl7oGHBMARKMveian6GmaNibpaIDOiJlPKqlhqvOyi0pBFq4
	 QIy88SpH+D1B3FHWRRnOFwoXsuDOTwYQ5ffgoVQIPs2Y9Z4uZ65B30Vl/NVbDwQnUO
	 Aqo2my80zgdx+eu9A9f01Wr0Q4ZIxPB3a8pY7ziMy8u737ZC7Az2txspjjrQA6+ojf
	 K3Q8v7nCFVAjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC8B8C1614E;
	Tue, 13 Feb 2024 10:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] connector/cn_proc: revert "connector: Fix
 proc_event_num_listeners count not cleared"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170782022770.31378.2251191760632931872.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 10:30:27 +0000
References: <20240209091659.68723-1-wangkeqi_chris@163.com>
In-Reply-To: <20240209091659.68723-1-wangkeqi_chris@163.com>
To: Keqi Wang <wangkeqi_chris@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 oliver.sang@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  9 Feb 2024 17:16:59 +0800 you wrote:
> This reverts commit c46bfba1337d ("connector: Fix proc_event_num_listeners
> count not cleared").
> 
> It is not accurate to reset proc_event_num_listeners according to
> cn_netlink_send_mult() return value -ESRCH.
> 
> In the case of stress-ng netlink-proc, -ESRCH will always be returned,
> because netlink_broadcast_filtered will return -ESRCH,
> which may cause stress-ng netlink-proc performance degradation.
> 
> [...]

Here is the summary with links:
  - connector/cn_proc: revert "connector: Fix proc_event_num_listeners count not cleared"
    https://git.kernel.org/netdev/net/c/8929f95b2b58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



