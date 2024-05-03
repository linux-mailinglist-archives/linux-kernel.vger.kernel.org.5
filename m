Return-Path: <linux-kernel+bounces-167936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CABF8BB159
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64441C21513
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5BC1581F2;
	Fri,  3 May 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6+CkthK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF77157A61;
	Fri,  3 May 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714755630; cv=none; b=VKIR/5XP6d3p9sUMWO4CrabsQGP7+lx93L/F+zSqSOL1XpXZAzeCK5eRBuw22BwrbItgbJDJ+jFWr5NchyrYnlRqQz+Ku7zBvQBe4ogfn0rgB4Dea1LhMEOz+zeAwoHOft5JvWIuvUN5Sw0DnYF+lrKRlzGl2lf3IlpDse5gd10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714755630; c=relaxed/simple;
	bh=EQYWPXi+543mEoAiMQYQLCRnTT9yvWvfjueTnMNj+xI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tTb9F3fg06jmnd9xmjRQj1/5h5yJXqRDOtniSqZOndlXzUWAjiMurXkv2bu7dsSMIBIMtQ6lMDtF6WZLuuvUAqnT4CAcDsGxIR0PjHpqj3709ydT6sGvUJhXv/sW6mhTNrYmLDZBu68RI8ktXJTCxh7A03OahSluKds6nHjTCNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6+CkthK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C889DC4AF14;
	Fri,  3 May 2024 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714755629;
	bh=EQYWPXi+543mEoAiMQYQLCRnTT9yvWvfjueTnMNj+xI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D6+CkthKHMi3991EYVfhiZ3Nb0kRKXF/IvfM6AXLietFo1FD9C3YMELKLJVDFs0Yy
	 +vd7R7X4MYcExihL2kASx7v48S1Wrj6t94K9SFg1Frka+jWEG0L5R7lg5a8fuKCGX2
	 I5Ba8nTA8Y/rrsbajj+FQ/horZi2JaBDcPQ1MuFKpyc6WWpbDueW4twvdVm3H4yiPk
	 m8vr8//8bR5YF1NwiLfgBM6F++GPk6Jmu71LpUylaAHaF8jXNLys+xIOFfZ0k+NWAw
	 jz/E1yZhKspCU4LnORNqGCzGtjpRLqviqfd4jv5zjZjXALUq7AdekKVsb8HMQoGxAj
	 quLj08HZw75mQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5B6CC433A2;
	Fri,  3 May 2024 17:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_timeout
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171475562973.29614.6591900788209831933.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 17:00:29 +0000
References: <20240502125736.28034-1-duoming@zju.edu.cn>
In-Reply-To: <20240502125736.28034-1-duoming@zju.edu.cn>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 luiz.dentz@gmail.com, johan.hedberg@gmail.com, marcel@holtmann.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  2 May 2024 20:57:36 +0800 you wrote:
> There is a race condition between l2cap_chan_timeout() and
> l2cap_chan_del(). When we use l2cap_chan_del() to delete the
> channel, the chan->conn will be set to null. But the conn could
> be dereferenced again in the mutex_lock() of l2cap_chan_timeout().
> As a result the null pointer dereference bug will happen. The
> KASAN report triggered by POC is shown below:
> 
> [...]

Here is the summary with links:
  - Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_timeout
    https://git.kernel.org/bluetooth/bluetooth-next/c/8192cea84c6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



