Return-Path: <linux-kernel+bounces-59223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF76D84F36D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DFFA1C22633
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503E31CD2E;
	Fri,  9 Feb 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRdr605U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926FA3FEC;
	Fri,  9 Feb 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474631; cv=none; b=aQgsoH+kySuRE4SBuxOrDhx+5E5CCXEKp0vrk6fpVsicxvVKElJrbp41mwZ7D5dXx5HJ20BuYCSAdiZ5ZZpJQSN2cBDQOwHV1QFnojby0bi6gXpZqY7QAFNcW1+QRApGcBTrPAbY0G9m+ChIWI5yjDtw8z/D8VFsoIxQs5EK7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474631; c=relaxed/simple;
	bh=/XwFJi0uafiU4ftdmEiDaktNHhjpeW1zE9XAas5IOKk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LzvxEJKt9n5bMsZ7fXKcDuvnTKY/o/QV9weCJGPN8/Abhc8PM5WlHP/icY7cGPDwlAzdMb8WcqDmKhHWDwok8settgFcBTmEjcx0anT6Yh0ukvUb69LUfjhwAiTiS4II9uqu3jfrqPzSwjBwwr1eQUzodAYGF+xuaFvKkYZVbuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRdr605U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61F82C43390;
	Fri,  9 Feb 2024 10:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707474630;
	bh=/XwFJi0uafiU4ftdmEiDaktNHhjpeW1zE9XAas5IOKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aRdr605UI7cEn7UbE4arY3Y9L3jbN5TMojbFwuRo/iiJQt4iEt8ySa+EHKWgLOp9b
	 4ganBiL9V4mLyTTaEbRHMeMFYN3VSrg84qlNgPQwJsiAe9+NEMOFDQMW78FWPn0phL
	 7x2lEWd/rFPfYPWHPunKN7dro+hnGqLJc0IFOD1PGUKzqAO91AHnoLdUmiIZqlIsYx
	 zc0IWDT0c1eFFxudoLOcfTbsvJ03jZ9PnvPf7PlCR1O0UHwFf/uHjBvenTxVaQdYWS
	 WNxPLLZYy5LWtuvZ/oPgllzOoL/d8l8M38UeLDMfMNL1op7KUD5xngGFB8dyQ8PETW
	 5+cGXihHNUSiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49E7CC41677;
	Fri,  9 Feb 2024 10:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/8] netconsole: Add userdata append support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170747463029.16032.4812565371511263051.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 10:30:30 +0000
References: <20240204232744.91315-1-thepacketgeek@gmail.com>
In-Reply-To: <20240204232744.91315-1-thepacketgeek@gmail.com>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 leitao@debian.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun,  4 Feb 2024 15:27:31 -0800 you wrote:
> Add the ability to add custom userdata to every outbound netconsole message
> as a collection of key/value pairs, allowing users to add metadata to every
> netconsole message which can be used for  for tagging, filtering, and
> aggregating log messages.
> 
> In a previous patch series the ability to prepend the uname release was
> added towards the goals above. This patch series builds on that
> idea to allow any userdata, keyed by a user provided name, to be
> included in netconsole messages.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/8] net: netconsole: cleanup formatting lints
    https://git.kernel.org/netdev/net-next/c/602ad3b4dd57
  - [net-next,v3,2/8] net: netconsole: move netconsole_target config_item to config_group
    https://git.kernel.org/netdev/net-next/c/bd9c69a36efd
  - [net-next,v3,3/8] net: netconsole: move newline trimming to function
    https://git.kernel.org/netdev/net-next/c/ae001dc67907
  - [net-next,v3,4/8] net: netconsole: add docs for appending netconsole user data
    https://git.kernel.org/netdev/net-next/c/aa7b608d69ea
  - [net-next,v3,5/8] net: netconsole: add a userdata config_group member to netconsole_target
    https://git.kernel.org/netdev/net-next/c/8a6d5fec6c7f
  - [net-next,v3,6/8] net: netconsole: cache userdata formatted string in netconsole_target
    https://git.kernel.org/netdev/net-next/c/df03f830d099
  - [net-next,v3,7/8] net: netconsole: append userdata to netconsole messages
    https://git.kernel.org/netdev/net-next/c/b4ab4f2c0ff5
  - [net-next,v3,8/8] net: netconsole: append userdata to fragmented netconsole messages
    https://git.kernel.org/netdev/net-next/c/1ec9daf95093

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



