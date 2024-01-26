Return-Path: <linux-kernel+bounces-40758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B8483E571
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5A31F24873
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D7733CF7;
	Fri, 26 Jan 2024 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKclpH/q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D50925631;
	Fri, 26 Jan 2024 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308226; cv=none; b=dC5l4iMTFaiNelaUSU7biglATQIgUHuOTt/b0w+/LLD+ZjEcb8t2HOVr/1VlKD73fP3F6jjCFl6FniFKJgvfhpbjp81kfZ02xK5iLyQEe+MWLoR1d5SGuIJJ6i/tEZmrn2x/IKJm5QeiJzzW1kVdBJt3cvSdn2meZfNfTHa2M2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308226; c=relaxed/simple;
	bh=jNbmp8YEA445pIRhuvsH6MW9zescGh1Hj65YFJ4341Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XwehSrXLBxu7qAE9WmDw+3ARM0UJyJqqNujnnODKKGBlYoE0yxyuBDcBbDrsVZpsjBuGTOL8QZIMXM2jklb2GFcflROMIYTprwwyhak7Nj/0KYEgrf6DEDtqtl2u5Ex4FQrMu4ffuIqT9XQjD6Pf0A5ABV5BLfoef/4eql+TT8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKclpH/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C66EC43390;
	Fri, 26 Jan 2024 22:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706308225;
	bh=jNbmp8YEA445pIRhuvsH6MW9zescGh1Hj65YFJ4341Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SKclpH/q1/lseqlASPMIga1pozrXpQY7lZqwR5ajR0HSvNOqjr4BDqXi05rIaMv1V
	 lNAPBPqnA9DWqmEMCZmBQk1yP2Cblw2Yql3x1pa8PPbndVQjb7UmBHotv7tyn9itDw
	 JkWbfsGvPAFILnU6/uF8lQbhr8paecIDdA28UZcfUSoLUhcKf3BCzBKeAorA+8kT5M
	 1DdJ/NS5wFt5OF0LdIWZTQdAhBjX88k7Fz6IgrU3UL+y6z8AVQ2iB4wX1GosfKF00P
	 SC5bDS5AnWGQ+suegGSWaBl5kBq2DKUpxX8XZLUTEkWGaLuEANcUbC2xlGYcAQ/vEB
	 htDowzZsU/R/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71881D8C962;
	Fri, 26 Jan 2024 22:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: mt7530: fix 10M/100M speed on MT7988 switch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170630822546.5179.9954095426642384849.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 22:30:25 +0000
References: <a5b04dfa8256d8302f402545a51ac4c626fdba25.1706071272.git.daniel@makrotopia.org>
In-Reply-To: <a5b04dfa8256d8302f402545a51ac4c626fdba25.1706071272.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: arinc.unal@arinc9.com, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 john@phrozen.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jan 2024 05:17:25 +0000 you wrote:
> Setup PMCR port register for actual speed and duplex on internally
> connected PHYs of the MT7988 built-in switch. This fixes links with
> speeds other than 1000M.
> 
> Fixes: ("110c18bfed414 net: dsa: mt7530: introduce driver for MT7988 built-in switch")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: mt7530: fix 10M/100M speed on MT7988 switch
    https://git.kernel.org/netdev/net/c/dfa988b4c7c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



