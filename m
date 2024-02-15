Return-Path: <linux-kernel+bounces-66879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCC385630F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00A43B258A6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8216512C529;
	Thu, 15 Feb 2024 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYbtvh3O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D6813FF5;
	Thu, 15 Feb 2024 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999627; cv=none; b=Bu+XRu5fI4G78FCzWd6DwnMNTY5Ru4Bm83e5NHiAs9W2Xn62J4k7QT6fjVb8hjTi0AMXcFdrthjYJUgyw394B4+/sd40pj33zr8HheuOdr7B0kY1Y+BuFno+WzaoTaEyLuCf/KcQ5sI/lFU3/YtCmNIhhbB/0NPq6/cm3K/eK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999627; c=relaxed/simple;
	bh=+FNKL+I27gOboAWeCkU7r/YfYNkM22lIkfaFADTMfr0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W1kV6Hy80kFgRFPuQFpnbYxtdxdHfJO1mM0X8xqLTINh4l/BqAch6gG+wsbpuMWzX6JDD64KSuDeqmgzjImNu0UtZYr2jQziwfdRyKtyWNF27wjFbAmgap276Y6BtwaUPRUMbY81b3RrH1TNYj/EymEelhVSUiMWLSonKQ1cS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYbtvh3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35FC5C433C7;
	Thu, 15 Feb 2024 12:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707999627;
	bh=+FNKL+I27gOboAWeCkU7r/YfYNkM22lIkfaFADTMfr0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kYbtvh3OC0ckX4DxQY/0jP6ewuOOXae6rJgIROrZY1gdGPR9lhm5TEj9b2jrdnbpV
	 0Q8r2tCPSrOkf+NAp3htMNNI2EmaFlcN62KPrEtCdp9PCFTnviCirGORcygxUdqXDn
	 xJH6BxBoYg+USR2f4pIYZOXjQTenTbiwXUqQfxwjdUhd5NDiXyMdk3w4KYcIefCHDc
	 1x4E78UWd4kUtt9cEmnJmTYxqbrY1uvQ1SFuiQsyiDaw0AIjZ4zqS0VvRJ2OB0zGka
	 dIcp7L/GPcf9+KK/zJ4luFicNKYig9KhzhjiV9NBtRGt7ORR7tyIaekIcXxGT8/DsD
	 kevnWHF4+IlOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1359AD8C97D;
	Thu, 15 Feb 2024 12:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] net: phy: aquantia: add AQR111 and AQR111B0 PHY ID
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170799962707.5511.1580795356908350792.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 12:20:27 +0000
References: <20240213133558.1836-1-ansuelsmth@gmail.com>
In-Reply-To: <20240213133558.1836-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rmk+kernel@armlinux.org.uk, robimarko@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Feb 2024 14:35:51 +0100 you wrote:
> Add Aquantia AQR111 and AQR111B0 PHY ID. These PHY advertise 10G speed
> but actually supports up to 5G speed, hence some manual fixup is needed.
> 
> The Aquantia AQR111B0 PHY is just a variant of the AQR111 with smaller
> chip size.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: aquantia: add AQR111 and AQR111B0 PHY ID
    https://git.kernel.org/netdev/net-next/c/038ba1dc4e54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



