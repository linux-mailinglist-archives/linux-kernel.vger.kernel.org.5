Return-Path: <linux-kernel+bounces-11686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5847881E9FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 21:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B4D1F22B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C33EAF2;
	Tue, 26 Dec 2023 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If10gHst"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2D85684;
	Tue, 26 Dec 2023 20:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B44D6C43391;
	Tue, 26 Dec 2023 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703622628;
	bh=ZBfFp/kOlQVvVXx7c1vaWsW1JqMtoH+X4lSKs07mt5I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=If10gHstX2yhMq8WqYN72j+cgWwx54S29WvXmIQG75OKnRJkwYVi5WDBf34p1ia5Y
	 z6DxpVZKF4DWH2mfKA1PG0bTCwQk1XDCKepp0YVp3zC8MVVVXDAkxAnalhuuUPKVAh
	 UPrewjCDi25QrB/jnZb5kI9+IKf4dcvlaS2xPl1hWUc6uRbHSuGa/ai105On1A+LuT
	 UJtNVf2rmNJu8QLLN593NK06RgO83N8kI9cCpZVh04mQ5ehEvI2fxGUO0ob7crzpaq
	 A9xVX/7Ro/eioEW3xpT+yFqQAhFOwbC5yTWb9dh9h4Wat307QVNrCQl47t04OvwXq8
	 81HPUCEzEJ9hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0959E333D7;
	Tue, 26 Dec 2023 20:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 00/10] net/smc: implement SMCv2.1 virtual ISM
 device support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170362262865.14680.2644729580463835169.git-patchwork-notify@kernel.org>
Date: Tue, 26 Dec 2023 20:30:28 +0000
References: <20231219142616.80697-1-guwen@linux.alibaba.com>
In-Reply-To: <20231219142616.80697-1-guwen@linux.alibaba.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kgraul@linux.ibm.com, jaka@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 raspl@linux.ibm.com, schnelle@linux.ibm.com,
 guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 22:26:06 +0800 you wrote:
> The fourth edition of SMCv2 adds the SMC version 2.1 feature updates for
> SMC-Dv2 with virtual ISM. Virtual ISM are created and supported mainly by
> OS or hypervisor software, comparable to IBM ISM which is based on platform
> firmware or hardware.
> 
> With the introduction of virtual ISM, SMCv2.1 makes some updates:
> 
> [...]

Here is the summary with links:
  - [net-next,v8,01/10] net/smc: rename some 'fce' to 'fce_v2x' for clarity
    https://git.kernel.org/netdev/net-next/c/ac053a169c71
  - [net-next,v8,02/10] net/smc: introduce sub-functions for smc_clc_send_confirm_accept()
    https://git.kernel.org/netdev/net-next/c/5205ac4483b6
  - [net-next,v8,03/10] net/smc: unify the structs of accept or confirm message for v1 and v2
    https://git.kernel.org/netdev/net-next/c/9505450d55b0
  - [net-next,v8,04/10] net/smc: support SMCv2.x supplemental features negotiation
    https://git.kernel.org/netdev/net-next/c/ece60db3a4ce
  - [net-next,v8,05/10] net/smc: introduce virtual ISM device support feature
    https://git.kernel.org/netdev/net-next/c/00e006a25718
  - [net-next,v8,06/10] net/smc: define a reserved CHID range for virtual ISM devices
    https://git.kernel.org/netdev/net-next/c/8dd512df3c98
  - [net-next,v8,07/10] net/smc: compatible with 128-bits extended GID of virtual ISM device
    https://git.kernel.org/netdev/net-next/c/b40584d14570
  - [net-next,v8,08/10] net/smc: support extended GID in SMC-D lgr netlink attribute
    https://git.kernel.org/netdev/net-next/c/01fd1617dbc6
  - [net-next,v8,09/10] net/smc: disable SEID on non-s390 archs where virtual ISM may be used
    https://git.kernel.org/netdev/net-next/c/c6b8b8eb4990
  - [net-next,v8,10/10] net/smc: manage system EID in SMC stack instead of ISM driver
    https://git.kernel.org/netdev/net-next/c/b3bf76024f64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



