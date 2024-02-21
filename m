Return-Path: <linux-kernel+bounces-74467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8223285D4EA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374DA1F2196D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081503DB97;
	Wed, 21 Feb 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3xY46Qu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A1C3D967;
	Wed, 21 Feb 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509029; cv=none; b=QyK3L1yUvBP1kCkd6RJGEUFzJj0TTbDYSNdGGDh1WIiK+WhU3OWuBypLCMANBwwoWN3mjux+rh1+tTlKAd8mVighfVS+X6uDvoSsaZu8d+MYIZhglHHq1s6fRwSIX+k/Un/6wXIDp5WSEGB4stUdRo545yIgX8kVmJoTrwh7JP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509029; c=relaxed/simple;
	bh=hJc1l2nWRdBSrrbHMGP272huJQt0hk1LeTA+XnuSVsA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jwZUf7SzcpEBfty+tk3u5mdKN7gaZBrj/OW9PSkYRDRfrxrzpJTjeIr3jFDbTRIgQPcPWTidNgVDW8KmrDCvEnkGzAwk59FM68E8CFy+GYZHMWLmxmG/HddLcCOK5D7/5j8sUH9a4EzSRmv9DHsWBEQd562CKGOXGtRSEWobcDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3xY46Qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F99CC43330;
	Wed, 21 Feb 2024 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708509028;
	bh=hJc1l2nWRdBSrrbHMGP272huJQt0hk1LeTA+XnuSVsA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f3xY46QuaXsixdUhH84gtWqPnyuDuJmv7S7QwvILmc7BmiAHwtI72xR/HWW9Q5L5C
	 Q2B8w/A+7+R6YXS4K2sAqFzJ1fV5Av5IzPsblYLuL849U2IbKOXwzbbONwcvAwdhaX
	 MooXv5jOUqPLvvjSJOyIH0k4GfYUW4nUbgAuT5P99iVjFLm+mVEBYHIqlpIUvmT53o
	 3Xcpb2P9YeyQl/QQvMKoiVOnUPikY2PZAfMtU6atqbxw7FCRKUgyrHc4Mv/gdcb4jk
	 EHyC1lm9HG5KT/ERhnf+qI8nNHyxHQqboSPJKwlE2dponjUAWJX5Ta7J1f6oo14BaL
	 33dydvsMVGDlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77BABC00446;
	Wed, 21 Feb 2024 09:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/12] net: constify struct device_type usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170850902848.18277.9807669869009277382.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 09:50:28 +0000
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
In-Reply-To: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
To: Ricardo B. Marliere <ricardo@marliere.net>
Cc: oneukum@suse.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, roopa@nvidia.com, razor@blackwall.org,
 loic.poulain@linaro.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-ppp@vger.kernel.org, gregkh@linuxfoundation.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 17 Feb 2024 17:13:22 -0300 you wrote:
> This is a simple and straight forward cleanup series that makes all device
> types in the net subsystem constants. This has been possible since 2011 [1]
> but not all occurrences were cleaned. I have been sweeping the tree to fix
> them all.
> 
> I was not sure if I should send these squashed, but there are quite a few
> changes so I decided to send them separately. Please let me know if that is
> not desirable.
> 
> [...]

Here is the summary with links:
  - [01/12] net: usbnet: constify the struct device_type usage
    https://git.kernel.org/netdev/net-next/c/3ce7caee3af0
  - [02/12] net: dsa: constify the struct device_type usage
    https://git.kernel.org/netdev/net-next/c/7e0acba3b49e
  - [03/12] net: bridge: constify the struct device_type usage
    https://git.kernel.org/netdev/net-next/c/bbc7e4cc21a4
  - [04/12] net: vxlan: constify the struct device_type usage
    https://git.kernel.org/netdev/net-next/c/c7170e7672e5
  - [05/12] net: ppp: constify the struct device_type usage
    https://git.kernel.org/netdev/net-next/c/908ada0da6d4
  - [06/12] net: geneve: constify the struct device_type usage
    https://git.kernel.org/netdev/net-next/c/e443f3acbc6d
  - [07/12] net: hsr: constify the struct device_type usage
    https://git.kernel.org/netdev/net-next/c/0072b2c1ffd0
  - [08/12] net: l2tp: constify the struct device_type usage
    https://git.kernel.org/netdev/net-next/c/43820fd1ddb5
  - [09/12] net: vlan: constify the struct device_type usage
    https://git.kernel.org/netdev/net-next/c/7ae9d3423f1d
  - [10/12] net: netdevsim: constify the struct device_type usage
    https://git.kernel.org/netdev/net-next/c/52042e092ba9
  - [11/12] net: wwan: core: constify the struct device_type usage
    https://git.kernel.org/netdev/net-next/c/7eccf41b3bac
  - [12/12] net: hso: constify the struct device_type usage
    https://git.kernel.org/netdev/net-next/c/55fad9c4a3c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



