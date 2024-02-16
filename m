Return-Path: <linux-kernel+bounces-68076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F668575AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B8D285A36
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB74134BD;
	Fri, 16 Feb 2024 05:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftaC8Y/L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92B912E74;
	Fri, 16 Feb 2024 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708062026; cv=none; b=UcJBqGHoozNLMKEsJwv6MtStUHA8AufmJ3FQkoVa67nOvJZ1Y2vG8e6HN9chCFLYMruyVBzrFRhNAPaDEpd5a9f4h4ial8cV+NFVf8bayfCcFwPB9A2XN+fPOsKjUNLyFhJ6CEBgHvKPbQ4JseHxD/rBDAXrhlPaNbuKihUye9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708062026; c=relaxed/simple;
	bh=e0btg/nEkxmcE3ZWPeSYCuKrkKskM0N98V08CLYKCUc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h/jpNeHV33A2nAGlRLJ7oYL7pSarV8ySAmT5kJtX5BmTOb0Fov+e4bPQAR4hHNUXBkXZ7qAIyfJ4J2W6EZJW2sG/DEbw533W5vjOy809hv9DRpSJiTMybBSmqdOw4k8/ejxyZqnLsIeYcRdgwuKyNF6c3IpMoU6qPxqNU/wS/Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftaC8Y/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A4A5C43390;
	Fri, 16 Feb 2024 05:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708062025;
	bh=e0btg/nEkxmcE3ZWPeSYCuKrkKskM0N98V08CLYKCUc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ftaC8Y/L2MJLrxO8K3x9aCi1OcVZ7Q3iLr6Rkcoz9fyF61af8gnvcl+a2X7qUQ9QL
	 tESdu5xDv0nFdcLSw3RpAxY6LEwZe71uwHyXmDBDIvPCexy1MuqRLF3c31PW1U27I0
	 wpImsG8oxt4Ybc3i3qC8/zLkyU+wn1mKbtnWNZW8K2zhH6JlVBbStKzdNXoc/TlRf3
	 oYj9K5iTV8Q2MkMozU3l1JdrqrDRTGmRkV3gVoKOlGUmjOqaJ4zHAU8VzYCMYb+J4J
	 vun+yNgo6izH2PIIQi5X7ZXSEhnhutak5KqeWMLZa4J8mRkHEHoIfN4/obVUFx/9h8
	 TPg+JqJdiCwtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26666D8C97D;
	Fri, 16 Feb 2024 05:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: dsa: remove OF-based MDIO bus
 registration from DSA core
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170806202514.18199.5277727035517778240.git-patchwork-notify@kernel.org>
Date: Fri, 16 Feb 2024 05:40:25 +0000
References: <20240213-for-netnext-dsa-mdio-bus-v2-1-0ff6f4823a9e@arinc9.com>
In-Reply-To: <20240213-for-netnext-dsa-mdio-bus-v2-1-0ff6f4823a9e@arinc9.com>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCB2aWEgQjQgUmVsYXkgPGRldm51bGwrYXJpbmMudW5hbC5h?=@codeaurora.org,
	=?utf-8?b?cmluYzkuY29tQGtlcm5lbC5vcmc+?=@codeaurora.org
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, luizluca@gmail.com,
 ALSI@bang-olufsen.dk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 arinc.unal@arinc9.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Feb 2024 10:29:05 +0300 you wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The code block under the "!ds->user_mii_bus && ds->ops->phy_read" check
> under dsa_switch_setup() populates ds->user_mii_bus. The use of
> ds->user_mii_bus is inappropriate when the MDIO bus of the switch is
> described on the device tree [1].
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: dsa: remove OF-based MDIO bus registration from DSA core
    https://git.kernel.org/netdev/net-next/c/ae94dc25fd73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



