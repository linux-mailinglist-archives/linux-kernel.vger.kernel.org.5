Return-Path: <linux-kernel+bounces-96515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A2D875D62
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B0D1F22B2E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6649C3612C;
	Fri,  8 Mar 2024 05:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mK6Kx6Ns"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A415B2DF87;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709874037; cv=none; b=RiKiEKwUBNeA93+Wm0T+YjYN3OVA2rvsjs+TGz0e8TQVbgNPoycIcs1/XpYCxZHfUBX6wpPAK+D/UcxSg2Gk5Va9AxdS3rslYJIVrwJaPF5uCR6KJ5bJ+mL/s6UDx0CtlNSjS8wsyVBbx2pCGYUoRQ5hYf9aRmIERXi9LsT++fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709874037; c=relaxed/simple;
	bh=BHl0KKjMXSoRPkwIfPzDenYmVN4+XtDKCpHbpUMDXos=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TMawWko0+2q7wXsxbm28LPtSnN/Zi/nqSmgGkB66uviCyIzyf+kh8W574Li+6ikpSABE7ju8RAqshkReNSz3pbL9um71j3NMsFnGI8EiKaoemWvfUI4hM4iisxg6Wsjp1pvLASd5qpJePkl1bAjup18qvY3j29kWLs1lZj1af0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mK6Kx6Ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 793DBC433B1;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709874037;
	bh=BHl0KKjMXSoRPkwIfPzDenYmVN4+XtDKCpHbpUMDXos=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mK6Kx6NsxYEfvtRYoPoZbL9h81mmlgv8VjW8cgs+2Lz47ur6zZpvCE42rFe4PmJWO
	 OcE+zVQ24r5egPiKBTeMxRr9ve3g/NbUEl3Ag2VfYZURax7Hkis4ydXWTYdAJ9252k
	 4BO8Fgp+9AlFo6PYl/bwDCewb30qlN9iB1N3xDtGJT1DKfFqJVpO5CEummBPVx7d8J
	 jrvgUpZSQE3kle0LCbDk+3UFY0U1AxVRd70vq8ukzSe2VifsEer5FIyfo1CzrzGVSX
	 Wi3PmfZHeYJHemXZmLl53VDDvMzS96CzKkI98ghRCcOOAU1XBMEurEoDLopnEG+uu4
	 G+hAiiM/WY9gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61459D84BBF;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: Leverage core stats allocator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170987403739.8362.4338116352781961619.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 05:00:37 +0000
References: <20240306200416.2973179-1-florian.fainelli@broadcom.com>
In-Reply-To: <20240306200416.2973179-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, leitao@debian.org, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Mar 2024 12:04:09 -0800 you wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core
> and convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: Leverage core stats allocator
    https://git.kernel.org/netdev/net-next/c/4f6473ad6094

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



