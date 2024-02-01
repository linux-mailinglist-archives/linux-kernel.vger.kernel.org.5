Return-Path: <linux-kernel+bounces-47443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10446844DFD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17D3288D78
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBF053AB;
	Thu,  1 Feb 2024 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvQBn2yG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0F14C7E;
	Thu,  1 Feb 2024 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748029; cv=none; b=rCRFDVgsGD4oVzNyORq0GLT+kb6al+Rm2kXklrxvfqelq6ZyZ/p6rasE/MzFYulLkTZAkTrDw73rrZ4ap7amxUQdlGmVlxp4+GI5l8FSnmtKF+VTKJfv8Svj27PCkM5Ua8iLj8m/lXCAUMpA83CEfnQBIP6EB/yh+V/nOxhRmWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748029; c=relaxed/simple;
	bh=vsNUuF8OUcsHh7WEArAfzLrUDIw2dZacCZ4FOyEzK9E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R/o2KcEbcNiDOFm81Qd50nwlWm1I+VLCaKzrvXc95MOLRLLLsk0Mgnxzspyh0/l9GZ0Ukoos3y7bo1pQhtSgHXDzpS3lIlVqnP0yKU4c1zU8bcsNQ/kn6hHvssJV4fhwL0HA3wHqNj0V4PMcRKv3NEifWck6aKsjD8wWCqTTZnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvQBn2yG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02E75C43609;
	Thu,  1 Feb 2024 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706748029;
	bh=vsNUuF8OUcsHh7WEArAfzLrUDIw2dZacCZ4FOyEzK9E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FvQBn2yGkKHU2Obyv9MHt6+9HZBIG8LiHQVjKKrQ5M/tcmgYZch2UrNkE27NmAoS5
	 +c/Ows2tTtrgDoJ77hdYYrgxKVaelQyWYeqa+DVkUxmhhKJnnTMxJr6PVmfbDcvHxq
	 PYJnP0B84e1SD6gkiaSzI/ESJCG18t0GiLafjqwg0gnR90EwWgfV+ySWd/T+MaJoIu
	 It/B69PqfBH0//5ZBayipGtfyuEPA5AtPR4cLBtGQ5wQNJkj0f4dQAeKEUrvsEPlX8
	 kV73BQnO1kePshH7e4+sNDV9LiUKgl7n3oEyOiiWQFfufW0VuHc9nuhzOruYld5nvP
	 UkHxNrvuOfaEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3717D8C96C;
	Thu,  1 Feb 2024 00:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v4 0/5] net: phy: split at803x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170674802892.22140.13615163666939732898.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 00:40:28 +0000
References: <20240129141600.2592-1-ansuelsmth@gmail.com>
In-Reply-To: <20240129141600.2592-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andersson@kernel.org, konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jan 2024 15:15:18 +0100 you wrote:
> This is the last patchset of a long series of cleanup and
> preparation to make at803x better maintainable and permit
> the addition of other QCOM PHY Families.
> 
> A shared library modules is created since many QCOM PHY share
> similar/exact implementation and are reused.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/5] net: phy: move at803x PHY driver to dedicated directory
    https://git.kernel.org/netdev/net-next/c/9e56ff53b411
  - [net-next,v4,2/5] net: phy: qcom: create and move functions to shared library
    https://git.kernel.org/netdev/net-next/c/6fb760972c49
  - [net-next,v4,3/5] net: phy: qcom: deatch qca83xx PHY driver from at803x
    https://git.kernel.org/netdev/net-next/c/2e45d404d99d
  - [net-next,v4,4/5] net: phy: qcom: move additional functions to shared library
    https://git.kernel.org/netdev/net-next/c/249d2b80e4db
  - [net-next,v4,5/5] net: phy: qcom: detach qca808x PHY driver from at803x
    https://git.kernel.org/netdev/net-next/c/c89414adf2ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



