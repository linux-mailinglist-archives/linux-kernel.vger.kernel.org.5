Return-Path: <linux-kernel+bounces-96822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4BE8761DE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739BB282B18
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAE455763;
	Fri,  8 Mar 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITcpoBDk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F253E02;
	Fri,  8 Mar 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893231; cv=none; b=gBGhefgSjLzH2i7cX6NF9yn2XY0B3+123KlLy0RjrzFUGa8zYvwGpLffQ7UqSdwXPh7Y0UqfCK1zlgYQsJufPvH8nnZL6EgSNabFohQNq2b2mqMwzFEgP9Dj32G2jpWv+upNvHGLHy1Cqdnpax8c2kCces64Iu/BESS+0lmjkow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893231; c=relaxed/simple;
	bh=4/oZal4/5iKFtxf9Y3vrEaP+XdcROgnJfuGVAdN4iIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YV2a/MXQ3743uUeGcQHAf4HKbAWCHbSQ/giILevUQYVi7pbfGVa6Kfhw8g9JR2pMQS6nHsF7XI+xBefMA27mKSFA3RTgREk3mhcFd7PTQDo+84XlK3pIr5Nxujp0ndvDFdBmQELwo3rQsRItKNsOWQzYOvsCncuPvew2UUe/U10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITcpoBDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39EA0C433B1;
	Fri,  8 Mar 2024 10:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709893231;
	bh=4/oZal4/5iKFtxf9Y3vrEaP+XdcROgnJfuGVAdN4iIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ITcpoBDkCSBG2hVY5GL3uvWs0td1mLBcoyzv97k8ZMjQIBBWBX5VYyNyVPkC1+OxT
	 SjGS1jqMU13mzXaxo0NxvFIQQvsqilOaalrRpPMZnK8uBWBBMNAbWsfHSRYeTrlFUg
	 /CWI6qu5XpJK+7kCvE6+eutaRmNlCL3Dfa2MKwBeho9vD3JSsblZFtusROfsRflMF8
	 u6/81PAYDRUVfquViW7+z+GkCaVhakw83DnxJBbca6mgHveuX4ZpjG3liAmvW3dKBR
	 6M1edN1/zcDE1odt/48tjKl/n2S1VKfnejfK2BDgLm/XkHjYkK6/NmcEQZxhSPs31E
	 NHF4wZ1Nw6CYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D688D84BBF;
	Fri,  8 Mar 2024 10:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] ipv6: fib6_rules: flush route cache when rule is
 changed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170989323111.6327.13031133027277965133.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 10:20:31 +0000
References: <20240307100157.29699-1-shiming.cheng@mediatek.com>
In-Reply-To: <20240307100157.29699-1-shiming.cheng@mediatek.com>
To: Shiming Cheng <shiming.cheng@mediatek.com>
Cc: jiri@resnulli.us, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, lena.wang@mediatek.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 7 Mar 2024 18:01:57 +0800 you wrote:
> When rule policy is changed, ipv6 socket cache is not refreshed.
> The sock's skb still uses a outdated route cache and was sent to
> a wrong interface.
> 
> To avoid this error we should update fib node's version when
> rule is changed. Then skb's route will be reroute checked as
> route cache version is already different with fib node version.
> The route cache is refreshed to match the latest rule.
> 
> [...]

Here is the summary with links:
  - [net,v5] ipv6: fib6_rules: flush route cache when rule is changed
    https://git.kernel.org/netdev/net/c/c4386ab4f6c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



