Return-Path: <linux-kernel+bounces-125336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA36789244C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAEB1F249F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3244713AD38;
	Fri, 29 Mar 2024 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyGRb0BI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7046D651AE;
	Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740633; cv=none; b=k8jcvRLp1s25Rc30K0QmKFZJWHeB1cxVUXEIv+iGT8YcsG9K6O/bpUQ6SX+gBhbmnCaBJwnah7Kjx29PFhhxBZ8gTLm19e4OImQGZsIqKxm0WqX8BAQrQ8MOa8IlbweNojyyafMWie3dh10BwzU+pBhyzsekF9J0I36IKyrS3q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740633; c=relaxed/simple;
	bh=CHaBr4L7fJIzHfJY0qILhifaTUBUsVRxVvkX+TGOaa8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g+1nHPsC3LvcpRIALK9aLuWU7TFMh2aKO9JYHUzQVhgRyHRbO/+7q5G55f6t/ZZ1tdQ4z7S3L7EuPaXOfoFr/DfJmXxS98LkuXKeu0YhazkiXp0rIqw+RRSoDRClnCg250lu+a/H+goqovMwTjXhZhLQJ9QmRqxSqoqggeWIcvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyGRb0BI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31D90C43394;
	Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711740633;
	bh=CHaBr4L7fJIzHfJY0qILhifaTUBUsVRxVvkX+TGOaa8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XyGRb0BIBuUjxnneBRP6iQj4Ss1AwRZGYMO07XpAPNtR8rSV75VJPaS/GgUmRrOW9
	 F8QhuPNULPHBqCqPsMFqc9snRYvoVoZytd0sIDudyuqJl1zF4/cwlwk38o71bgBJtj
	 Wrw4TOYFRkZY28110EY8Z5bc4VPfrl1oAh8MolFMvDfJngD/gm3bsd6x4xCHIP4940
	 kZkrD6YwisBYKxeOlsn3itY55dqoo1cJARBu4Wdy9qFB4seXbyzeMGemDZVMxVpNzi
	 Mpnjho3WEyOgZNFeIY/cVN+2ZzA3qp/nu2kBT5ECFTuvnCQmfeAnSGirVwYB+c76K7
	 jMPReHn0Gw8AA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D482D8BD1D;
	Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next RESEND] octeontx2-af: Increase maximum BPID channels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171174063311.18563.4388557047700388378.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 19:30:33 +0000
References: <20240326184514.1628284-1-radhac@marvell.com>
In-Reply-To: <20240326184514.1628284-1-radhac@marvell.com>
To: Radha Mohan Chintakuntla <radhac@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, jerinj@marvell.com, sbhatta@marvell.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Mar 2024 11:45:14 -0700 you wrote:
> Any NIX interface type can have maximum 256 channels. So increased the
> backpressure ID count to 256 so that it can cover cn9k and cn10k SoCs that
> have different NIX interface types with varied maximum channels.
> 
> Signed-off-by: Radha Mohan Chintakuntla <radhac@marvell.com>
> ---
> Note: Earlier version didn't have 'net-next' designation in subject. No
> other changes.
> 
> [...]

Here is the summary with links:
  - [net-next,RESEND] octeontx2-af: Increase maximum BPID channels
    https://git.kernel.org/netdev/net-next/c/b6694abcf5df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



