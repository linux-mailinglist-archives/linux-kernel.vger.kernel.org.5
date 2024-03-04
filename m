Return-Path: <linux-kernel+bounces-90336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7025F86FDD4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20BAC283852
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C46C2134F;
	Mon,  4 Mar 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSBMt4F6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDAE1A29F;
	Mon,  4 Mar 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545227; cv=none; b=qBTUTRtGo6RKBY/V8dnd3B0tCrTjrlyY7q/RgoKBCBLCiT0gmflr9C5Kb8HrNG9/FXTWWZO+diH9xBsu3E3zJWHE+o4S71t/KbO+dMnR8U7l/9L8r3VLJNtJmwo3AhyRdAUr5oFUP8/X+W8/SuhJeLNkZibEPyeedD9T9QL610s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545227; c=relaxed/simple;
	bh=3++Vzv2/a3Eks7UzVNg8IkARrp7amDsx8Q+QmnKyHcQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lXdN9FglODelwRAyVB0deoKgF/c2w8mnTdszJj3CjZJwvw99XFbJ5jxbyd8HJ2bYArXtj5pdI/etNBFe/Rk9+pPYilLBy8KIi7y2Z5C3ggWOrTUjvjlA4/EBBUHekbXl6EYYT+q3YHYmHltiFNaJvYpuP/FTDTZrSaA+gCSUDwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSBMt4F6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB411C433F1;
	Mon,  4 Mar 2024 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709545227;
	bh=3++Vzv2/a3Eks7UzVNg8IkARrp7amDsx8Q+QmnKyHcQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PSBMt4F63+GM0hNVS7Rx8v+0oO8wSrs6YDrquvkpauWViO+JZPPTu5yOWAaS8edQS
	 n7Dk0RUNRTTZffp+xE4nzbAAC6RfrWMH7hQE1vpfEBpdSsxLFCGoihP/9OU30YJj7X
	 fEfN76V3hruq5vgAL0BQtMyF0D+B7RCztnvWqByooa+VrvZNOgPPXc5WhXzXQUC5N5
	 e8swIE//XZy847kKFLjP3wU7BNmFIs7iOh6fykErncvxedw5UUp9D4GPqROmDbQqrf
	 PEUlmDSQd6vU5FxGXxFcX5ueHYQeCWoH+l2PG0q+yaI07grDBpRqvyif4mEcSD6Mum
	 29oS0bJn1Wr3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1FD3D88F87;
	Mon,  4 Mar 2024 09:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tracing/net_sched: Fix tracepoints that save qdisc_dev() as
 a string
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170954522685.11015.14202389531025914162.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 09:40:26 +0000
References: <20240229143432.273b4871@gandalf.local.home>
In-Reply-To: <20240229143432.273b4871@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, xiyou.wangcong@gmail.com,
 vaclav.zindulka@tlapnet.cz, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Feb 2024 14:34:44 -0500 you wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> I'm updating __assign_str() and will be removing the second parameter. To
> make sure that it does not break anything, I make sure that it matches the
> __string() field, as that is where the string is actually going to be
> saved in. To make sure there's nothing that breaks, I added a WARN_ON() to
> make sure that what was used in __string() is the same that is used in
> __assign_str().
> 
> [...]

Here is the summary with links:
  - tracing/net_sched: Fix tracepoints that save qdisc_dev() as a string
    https://git.kernel.org/netdev/net/c/51270d573a8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



