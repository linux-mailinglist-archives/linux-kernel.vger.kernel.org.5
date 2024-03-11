Return-Path: <linux-kernel+bounces-99644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B50878B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397CD1C209A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE2D5A108;
	Mon, 11 Mar 2024 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NK1Gc9EA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F658AC5;
	Mon, 11 Mar 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710198033; cv=none; b=A62jgwJdghId/8e3ETejNqpePeUIrrEcay/sJPbPMlnNAEEt/Kn4akNSksOZW2FRx9tRXqxCPO9kbyrGToaHIc5QaWaikXxDY1ajws2cfWqZx6Uh99UDiFgkUug0fyEcApHAFItnBGRp0WFoiHQxLFz7G/2KZ0ydQDnUc6u7c/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710198033; c=relaxed/simple;
	bh=ED43vI5cWYnsvXFR1lKPIq7mBDjYw2dgI0PJUJcNrA4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FgoZ09Yco0ojOVtDSnNrzr3nXCEUzGpiKkhXZgQNqRVqXRiHSgxmJS4Mrw/BcK4PNCMPkhD+sqStt8ijULkOtPTJJbrFgSvAR32LskQkRMYxJ4qjZKxGR220xGpivr0Tuy9UMvpJh3GrkxEFghWxBYlmvF1CchCnqrtpRn0xhbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NK1Gc9EA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10D89C43141;
	Mon, 11 Mar 2024 23:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710198033;
	bh=ED43vI5cWYnsvXFR1lKPIq7mBDjYw2dgI0PJUJcNrA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NK1Gc9EA8Uw7IouJfUdFpp3ZqgH7fqcj/4uXsHM/x57CmuuMJCF2Y9R6dtnHaTfBN
	 IOL2slTPzX+wkjKFU77biC4H19bkuzHNv7ZwI/igNHwv847L0fcesOdXZSiohx8Laf
	 zoyn3PVOPRx7qPXfRXhjDMIKpvxpjj61fQEaMqee+RNeiCBlaymqOgEZ694kb0NLQQ
	 sl7nOw3vrXz1nAZdWpNBse497eQ6OZh6PWXFC81Ev2Yeq7CF1rJzhy8G4GyutTi+2V
	 ORK075cqd6k5StNYBl8ncOs3ty3rr6CLRdHyiGQSRwYXXAGSRtY4+83EW6kYMqZU4L
	 iMjfNjsAEya9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F021ED95057;
	Mon, 11 Mar 2024 23:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net/packet: Add getsockopt support for
 PACKET_COPY_THRESH
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019803297.14238.1615699272620857308.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 23:00:32 +0000
References: <AM6PR03MB58487A9704FD150CF76F542899272@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB58487A9704FD150CF76F542899272@AM6PR03MB5848.eurprd03.prod.outlook.com>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Mar 2024 13:06:36 +0000 you wrote:
> Currently getsockopt does not support PACKET_COPY_THRESH,
> and we are unable to get the value of PACKET_COPY_THRESH
> socket option through getsockopt.
> 
> This patch adds getsockopt support for PACKET_COPY_THRESH.
> 
> In addition, this patch converts access to copy_thresh to
> READ_ONCE/WRITE_ONCE.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net/packet: Add getsockopt support for PACKET_COPY_THRESH
    https://git.kernel.org/netdev/net-next/c/76839e2f1fde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



