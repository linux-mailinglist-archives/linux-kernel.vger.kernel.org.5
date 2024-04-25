Return-Path: <linux-kernel+bounces-157954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1388B1932
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC1628589A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E4D1CFBC;
	Thu, 25 Apr 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d961RFXZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896B17578;
	Thu, 25 Apr 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014629; cv=none; b=rWIbwfnjz3q09NYodW7xEsn6vf3WWfR+PERcaON8JTMaPEBwdBN4PeAI5VFO6aPffUHiwzyB01S8FHoP2HTTVJRVCmbSjVSaW6yZZsherILR2TI6qnrQXLuMNMxLjh7Z3EhpjeKQ2+6NJ5JWra/uBLplsh1FrLJkxny3emYw1dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014629; c=relaxed/simple;
	bh=Na+79jN4ihtVcXKmfLdMltW3hg4oUuFIHlU59f/pwPY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iOvLzyxV5slB8EO24MA7UQWrqKJrGDR71B3f8ffhAnxCYeXeghktz4sJvc5uO4MlCGQCWp3k2pvEsNoeXh+nqBdWjWGXphe7D4KGFtaVzOb05Yb0C40EOF2lH1SWPlPbUmB7QyuCkMq5X1f9wV3LwcUm5TS2whhWN4yHCE9gv1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d961RFXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F1C3C32781;
	Thu, 25 Apr 2024 03:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714014628;
	bh=Na+79jN4ihtVcXKmfLdMltW3hg4oUuFIHlU59f/pwPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d961RFXZlNVA6qOzRZa82wZKTccrLLa9zFFTaizzFTkI5O99Kr10hdgXiqpTrbUJS
	 aIoaUZmTKw1tRYLvPkmc2zs/r8H3JoZQpupzs06MRmDnfuIBbHv/oji+IiM1sqnwBf
	 /hclw3Y+kgRi+Y6PTqScfLTjdUkJUvEwVey+RoLzsKrMtFIPwTrSiNFFhSWOKNL1NL
	 hSmX/4ZEbajh2kYmoib9Aex6pOXBPayWPxdaFEUsPYSce+2neDRHTNxBA37ji4n3O3
	 0BA6OfzdaPZ5SH8fDjgrQYf6M37u022knVcUCFAUxoQ0GWLnzfS5gIrf6ryvPEQLgk
	 W2LEhWk5+TVjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EF05CF21C2;
	Thu, 25 Apr 2024 03:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-pf: flower: check for unsupported control
 flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171401462838.4490.15538727466149973306.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 03:10:28 +0000
References: <20240422152735.175693-1-ast@fiberby.net>
In-Reply-To: <20240422152735.175693-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, sumang@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Apr 2024 15:27:34 +0000 you wrote:
> Use flow_rule_is_supp_control_flags() to reject filters with
> unsupported control flags.
> 
> In case any unsupported control flags are masked,
> flow_rule_is_supp_control_flags() sets a NL extended
> error message, and we return -EOPNOTSUPP.
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-pf: flower: check for unsupported control flags
    https://git.kernel.org/netdev/net-next/c/3c3adb22510c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



