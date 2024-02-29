Return-Path: <linux-kernel+bounces-86426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE786C533
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93821F23DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19755D72E;
	Thu, 29 Feb 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bly0mF69"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDB65B5C5;
	Thu, 29 Feb 2024 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199030; cv=none; b=Wv0BVh2WyHAoNMBzFwLRNYiYBfrfT+5LmqBmdzdcQeJHaNzBJoukZ/PcGhzA+LR0wooBrESoPpvXLhatsQhCnP+CuDFvtueCBZ8DVeoql60yY29rv/cyw8qupW/UNsZl0TQEan8alwwUOXcdm/6Yqx0gkpMS0eyQqwDzfXI401g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199030; c=relaxed/simple;
	bh=rbxQAgvhbs+/87PU6qBCLzhxrec6kb/VvGHR3TzfCfk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A0X2CFypE1MOxacK3UcqlgRfoZ4nAc9+gMQdTGUvqo0AU9G7ESA2J7NgofSa63QUjG9p3NOEOxs+iOLYc6QtRGyO5cUS4Hhnpo0eII9+ufd+AizF94D7ar1CtCHW7eRFSxv5AZYDM7IFnzYBqxdh4qcv/lnmoRsZ6s9XmsSeXUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bly0mF69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89ED1C433F1;
	Thu, 29 Feb 2024 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709199029;
	bh=rbxQAgvhbs+/87PU6qBCLzhxrec6kb/VvGHR3TzfCfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bly0mF69I/tEoOa4hxFUnuL8qVvVuf+0TXoZOTovDOga4cKE4TwWnvRQfYoe/RVA1
	 kIHBrg87GTJoLqrIBnuU+ZUPeqURAd/hDIt9kwxEre+JCZNd4rwHZruqRAZuewG9ZI
	 D5GfwwpwA0/PbQZD2JvBICjVfhHsp6vzdkRhsm871VjvVlaXDhuucPVCehJrS9z27H
	 SL/N26bMkoedeSbP7umRdcQTVWN4W8iRaaHcldcFxqSVUVnxKT5wVSRwc2imgToI3g
	 /iyQcYi3RcDZj0NfRXtE8KeA91aIiRoGJNGoKH/Bnt69GkDkAG3y19bc57N4XZx9VB
	 SLmHt+ktaVDtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 747F3C595D1;
	Thu, 29 Feb 2024 09:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: dsa: mv88e6xxx: add Amethyst specific
 SMI GPIO function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170919902947.26621.622513714154438592.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 09:30:29 +0000
References: <20240227175457.2766628-1-robimarko@gmail.com>
In-Reply-To: <20240227175457.2766628-1-robimarko@gmail.com>
To: Robert Marko <robimarko@gmail.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 Feb 2024 18:54:20 +0100 you wrote:
> Amethyst family (MV88E6191X/6193X/6393X) has a simplified SMI GPIO setting
> via the Scratch and Misc register so it requires family specific function.
> 
> In the v1 review, Andrew pointed out that it would make sense to rename the
> existing mv88e6xxx_g2_scratch_gpio_set_smi as it only works on the MV6390
> family.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: dsa: mv88e6xxx: rename mv88e6xxx_g2_scratch_gpio_set_smi
    https://git.kernel.org/netdev/net-next/c/5c5b0c444be3
  - [net-next,v2,2/2] net: dsa: mv88e6xxx: add Amethyst specific SMI GPIO function
    https://git.kernel.org/netdev/net-next/c/e3ab3267a0bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



