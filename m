Return-Path: <linux-kernel+bounces-16165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0028823A01
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB601C24B8B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF98D443E;
	Thu,  4 Jan 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POdFtFS1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1761C33;
	Thu,  4 Jan 2024 01:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01FBBC433A9;
	Thu,  4 Jan 2024 01:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704330035;
	bh=lKy2wDhddyrNqvHgVFhg/7dYUMk1c2bBA8TL8RhnJ4Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=POdFtFS1dW+xL4B6vu3gMJdKKFpjdk4mazSeBOwixiF2Xgu4nWqoKeZjZ1xvwouRq
	 VUNpGMmLpBdYiUuClUFBDL32OMhufqRaB0iusf0BzhIw+vdLkaWB9zjnXFQPFQcLpY
	 sY8M1VFt47rOcjPJgQKsKguhTeyEHRjLXjzeqmC12U9k5IFdeimPszUzbEKmwo+4wE
	 9X9fDOlfZsRFivKJz3f6qKlT3LBdpLV4t1I5RA/dVG+4UvcAxYPj2ZJSY0oDXYVksF
	 XWz9c8vfmuboZvzeE21gMPjAN/0bJN2Y4D8M01TtTuh/2SKj10FfF459lyPW4oTMNQ
	 AZvczEaBSw88w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1016DCB6D8;
	Thu,  4 Jan 2024 01:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: fix invalid link access in dumping SMC-R
 connections
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170433003491.5757.13749232143692078528.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 01:00:34 +0000
References: <1703662835-53416-1-git-send-email-guwen@linux.alibaba.com>
In-Reply-To: <1703662835-53416-1-git-send-email-guwen@linux.alibaba.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 ubraun@linux.vnet.ibm.com, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Dec 2023 15:40:35 +0800 you wrote:
> A crash was found when dumping SMC-R connections. It can be reproduced
> by following steps:
> 
> - environment: two RNICs on both sides.
> - run SMC-R between two sides, now a SMC_LGR_SYMMETRIC type link group
>   will be created.
> - set the first RNIC down on either side and link group will turn to
>   SMC_LGR_ASYMMETRIC_LOCAL then.
> - run 'smcss -R' and the crash will be triggered.
> 
> [...]

Here is the summary with links:
  - [net] net/smc: fix invalid link access in dumping SMC-R connections
    https://git.kernel.org/netdev/net/c/9dbe086c69b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



