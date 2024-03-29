Return-Path: <linux-kernel+bounces-123975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E20489108E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6AD6B218E2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4271E504;
	Fri, 29 Mar 2024 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R215C3m+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A01804A;
	Fri, 29 Mar 2024 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677030; cv=none; b=K9tShQiHU/mW+KDdEO6txBPZmEL5U2JqXNuDHxQAao1N+oFI2euZaswG3HNcFdLLgajILkmhecgxBSjfQPCo6O+yDeSE0Hq3eR/UN5zo/robojRccmNtseTaDt4ESuxL+7PVRw59Xkl12MppBZqbcLKqsnqANOp8Ff1v3LT5tqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677030; c=relaxed/simple;
	bh=TyrbEvDtkz2nyXjs2SKTqUUeTwFDMInI+ccUM9psvD8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fvNfWNR6hxxcyr29Zai4TE1ykIQNhJ9N2aT8S+WfmRwgjH/VYQvJ1kjhcOJtmy5UFSDfknzkEbamyEReynkm5mdM1Cb165vK5f/DB1Fr8hLnxjdR5pkYllrSxTVDAHtqkyICEGwxu3mlyy3lHP71bnWFr9+qeQaP7yHQNMUZvsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R215C3m+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE66BC433C7;
	Fri, 29 Mar 2024 01:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711677029;
	bh=TyrbEvDtkz2nyXjs2SKTqUUeTwFDMInI+ccUM9psvD8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R215C3m+IWpiL1H2B7vGekMURdhvchPl9i4ZI1ine2M9gQFPgALRg0SBPJPZgsapZ
	 gkHELWju80PifF30lwOLs/b+tZTAhQyy08OxdcPyLyuQkRVnFxXsxdnTR08f2l7S8H
	 rVvQ+WkphZFRVe+rE/DTvGsP1MyiQ1+wXvsW3W5dfmyTSvFgIUTzivCf0Fgt0pbLLQ
	 giEpMKZv7AGr7vV6iyRIXdq7KAUh2FEnep9avOeuZ0jEhpjcYMeX7Uap1SrQMoK2BJ
	 4lRW1cZRaRMH9qA2AyjEnWhla6OL3DQQ1r6xZnstUsXv/pDuGpQibtnTNK7URZ8iQH
	 irzsBWPJK2Ejg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB4B0D8BCE9;
	Fri, 29 Mar 2024 01:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qed: Drop useless pci_params.pm_cap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171167702976.13430.129214121849793526.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 01:50:29 +0000
References: <20240325224931.1462051-1-helgaas@kernel.org>
In-Reply-To: <20240325224931.1462051-1-helgaas@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: aelior@marvell.com, manishc@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Mar 2024 17:49:31 -0500 you wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> qed_init_pci() used pci_params.pm_cap only to cache the pci_dev.pm_cap.
> Drop the cache and use pci_dev.pm_cap directly.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> [...]

Here is the summary with links:
  - qed: Drop useless pci_params.pm_cap
    https://git.kernel.org/netdev/net-next/c/49d665b8535e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



