Return-Path: <linux-kernel+bounces-78219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229BE861066
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1D11F23820
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A782D79DB5;
	Fri, 23 Feb 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raAYZhMG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0C76C62;
	Fri, 23 Feb 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687827; cv=none; b=RDLbmUJfkNfnHh/fTLbrmaIw9RrUHgnPQzpd9ZsDONHx3rv4cjXTyfc03HNoIjw4fYrXil+WtVwOVa8ht1mpImnlsdofDyLYP3UH4BFrL7skdsicffagnx8w9euKOBSrEE2r39LDmISkKROwOzIoWiMApue+3YQrvTtqhJMWvTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687827; c=relaxed/simple;
	bh=Yvx8lu1+d4HmVl7q4rrTdL/ZqSrATFnVqJR1xZ1ppww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IcD57r3SJZM+83QtWzK07pDrrK4evVqfgz28MOXkZIYL/bKWsY7u9kZ3hVpB6XvAEW4pFbyKrAygfSR6dx831H7zBkPoWMlgHgfiivQWj59gJHvmLe31X0HIeb8qNLielorDxrmMp/jTLjbTY/KXce4LQFhezzQf8xoXbfyJBOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raAYZhMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A504C43390;
	Fri, 23 Feb 2024 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708687826;
	bh=Yvx8lu1+d4HmVl7q4rrTdL/ZqSrATFnVqJR1xZ1ppww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=raAYZhMGUdK/JjKCrmjG5kUpRADBoY3ZmuPKXrpAwSXtMilnROssvsZAh2IOqmdeg
	 K5ODg78Z4C3rCgLO32k6nCIQsIGFpnboIQDoXVO6gFFCKny0I5G8Jna96issNSPTWl
	 ol5hrOojec5a4P8rHA/Zy9yOD70iXTMmnNJzidCy0YuREpoPao9YMI8db8iXyMWvg6
	 u/9KrLdCOf0ECE6ebJCkC2C5gFKuj0McXwqdAzxFRQVP25h33PZDYQx3yyiH6g2C8N
	 0Prsa42WPmEnkUzkDmNmPdlcuHU0Ed/ver8hTC8bl1EsUl66tjNWvuglMcvsYF08dE
	 KxQV4oG0xxVqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F32FD990CB;
	Fri, 23 Feb 2024 11:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dpaa: fman_memac: accept phy-interface-type =
 "10gbase-r" in the device tree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170868782625.1391.6089450916134255111.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 11:30:26 +0000
References: <20240220223442.1275946-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240220223442.1275946-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, madalin.bucur@nxp.com,
 sean.anderson@seco.com, linux@armlinux.org.uk,
 zachary.goldstein@concurrent-rt.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 21 Feb 2024 00:34:42 +0200 you wrote:
> Since commit 5d93cfcf7360 ("net: dpaa: Convert to phylink"), we support
> the "10gbase-r" phy-mode through a driver-based conversion of "xgmii",
> but we still don't actually support it when the device tree specifies
> "10gbase-r" proper.
> 
> This is because boards such as LS1046A-RDB do not define pcs-handle-names
> (for whatever reason) in the ethernet@f0000 device tree node, and the
> code enters through this code path:
> 
> [...]

Here is the summary with links:
  - [net] net: dpaa: fman_memac: accept phy-interface-type = "10gbase-r" in the device tree
    https://git.kernel.org/netdev/net/c/734f06db599f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



