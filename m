Return-Path: <linux-kernel+bounces-161748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6246E8B50AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948EE1C21CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A76FDDD8;
	Mon, 29 Apr 2024 05:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFrAUDIY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB7DF42;
	Mon, 29 Apr 2024 05:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714368029; cv=none; b=b/uzsnGdvM4XmLJiqgYgPoXDlm3N+7SaJBYYz393T0lb/ndQIBY0qMQEYLd2IQRA7UHYukW7I56tADDxNoIubTRqSiycBJARSvbn/69749CXyQsNnuZyoJpOMSXVjalu2Ahdx91cHn4etSjDnxdOODIh/h1y1107s0W/Ljn7o2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714368029; c=relaxed/simple;
	bh=Wo/8jyOFvv40aWOe9D6ib4cudZP9jjxvEIduxgqymVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IetEK/x1PdtMaL4kKbhXM29sv19vTKuC4hhd9T6fn7K3p6PvawZ4aRL4ZpZGSmBANEntIP0CU/7Yr+NxScCIw6KnPI4GEO1Iwepdbm6VQF3qoDv+72QRGTTzXOpQCS6zbxmdhp6tf8cMFJ8ktdo1RP4bGT12IIclzgBahHyorto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFrAUDIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18701C4AF14;
	Mon, 29 Apr 2024 05:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714368029;
	bh=Wo/8jyOFvv40aWOe9D6ib4cudZP9jjxvEIduxgqymVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PFrAUDIYPi5jln4Yl2xEySAJ8cxdfQy8ArBXzXSSiYszCIicfaYahUQGIxNNSGEBM
	 kvEE/iyiUhV8VsqG8tmjfCTc3YglVBDnchTfO1Ct13fqMVnbovNve5jsuib81Jgaai
	 JGIpOTTY9jtgZnl8bQ5/WUoxUnPlJgTq1Ww9OktUaRsoEpNHy07ALeUONv9CTd44Zc
	 XEMd7AdigM5TpFrr+U/GH6/l0I/i2NYOBDLF4LrSKrJGQflDCXs+3MmVUGDA5WsgwE
	 9JfW3FZpFolYJc9cVp1JD7TENU60QyTDCUyZQ2Jvcf05yGT0//QcAqGjz1hugHgpk8
	 JkJVr1zDU6GCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07E3BC4361B;
	Mon, 29 Apr 2024 05:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw-qos: Add support to
 taprio for past base_time
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171436802902.5790.15930390940383797476.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 05:20:29 +0000
References: <20240425103142.1999123-1-c-vankar@ti.com>
In-Reply-To: <20240425103142.1999123-1-c-vankar@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
Cc: t-patil@ti.com, ast@fiberby.net, horms@kernel.org, rogerq@kernel.org,
 vladimir.oltean@nxp.com, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, s-vadapalli@ti.com, srk@ti.com,
 danishanwar@ti.com, r-gunasekaran@ti.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 25 Apr 2024 16:01:42 +0530 you wrote:
> From: Tanmay Patil <t-patil@ti.com>
> 
> If the base-time for taprio is in the past, start the schedule at the time
> of the form "base_time + N*cycle_time" where N is the smallest possible
> integer such that the above time is in the future.
> 
> Signed-off-by: Tanmay Patil <t-patil@ti.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: ti: am65-cpsw-qos: Add support to taprio for past base_time
    https://git.kernel.org/netdev/net-next/c/d63394abc923

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



