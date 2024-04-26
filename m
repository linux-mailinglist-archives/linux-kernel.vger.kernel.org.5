Return-Path: <linux-kernel+bounces-160630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED3D8B406D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE2B288481
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0622423776;
	Fri, 26 Apr 2024 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeqK+ERh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B0D2F5;
	Fri, 26 Apr 2024 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161028; cv=none; b=ZS6eDjDfUWVStiMchU+N8i6AnIwzAp94jYlIBG07xNzKRT7kfiHx3r2c/UwM48WQlRXZCb/tTXjuqb05altvU2CEQJ+vZPEGS9B+DFXzV66zUOECT5FoHWhdA1pVHlu8m2MZ97Qo4yoJwE1fuGMFMSxogMPvpgDzybAQNSSiUG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161028; c=relaxed/simple;
	bh=vHRJZkQ8HpgX5+OE9Bp2bdD2mq+i0RcRBFQDwrjPHfc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QC9hJm7jh7dAnB0VKQwDszTMQ/XvQUSdU+fmSHI4wlt3luCt5y7nTPwFfoVJTNg2NAWyvkRvfYGP29G7uN1gWfJ9sOAx7iUuHluexbKLfdHFCexdAbQ5xJ+E0fQLcxdHRnebz+Tdkuq8Yvx9c0M06/ZYKaAh4CFn75TjU+X03kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeqK+ERh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E641BC4AF08;
	Fri, 26 Apr 2024 19:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714161027;
	bh=vHRJZkQ8HpgX5+OE9Bp2bdD2mq+i0RcRBFQDwrjPHfc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HeqK+ERhmZEUZbMVMpXcAc+GUxuHC6bJNFfMjnO1MgJwKDoJYnnVd4jg47s2tynlB
	 A4cvHMUEi1l0ireg53646LBNhW4RtESJmBH8FGiScb+OfQ0e21fMQ4GTI2W1JLHEBC
	 WXXst8hFBGKQKCxraHZe8+t0x7wPp5nCHVqiocwXMmx/lgxir1eTiRZ0HEFV5F83ky
	 EjFILSEkAiftifAMlkCz8/e2tFjWVvzsig1JushNufliXwiiFKk0i2vbtde6/94woY
	 JNt3SJJu1htoQjwSPDk/D0LTx9x2ScdhDdfYO6O4U0xgomLh5StRVkY/DApUiNrBZb
	 SJ3X+jD30kDnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA5EFC433F2;
	Fri, 26 Apr 2024 19:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: dsa: lan9303: use ethtool_puts() for
 lan9303_get_strings()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171416102788.32161.9363103402997234430.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 19:50:27 +0000
References: <20240425-strncpy-drivers-net-dsa-lan9303-core-c-v4-1-9fafd419d7bb@google.com>
In-Reply-To: <20240425-strncpy-drivers-net-dsa-lan9303-core-c-v4-1-9fafd419d7bb@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, keescook@chromium.org,
 aleksander.lobakin@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Apr 2024 01:19:13 +0000 you wrote:
> This pattern of strncpy with some pointer arithmetic setting fixed-sized
> intervals with string literal data is a bit weird so let's use
> ethtool_puts() as this has more obvious behavior and is less-error
> prone.
> 
> Nicely, we also get to drop a usage of the now deprecated strncpy() [1].
> 
> [...]

Here is the summary with links:
  - [v4] net: dsa: lan9303: use ethtool_puts() for lan9303_get_strings()
    https://git.kernel.org/netdev/net-next/c/8880e2666fa8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



