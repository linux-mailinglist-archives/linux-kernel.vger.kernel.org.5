Return-Path: <linux-kernel+bounces-163853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A388B74A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C101F22CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AF4131725;
	Tue, 30 Apr 2024 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVFUyQE/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E636A1304BA;
	Tue, 30 Apr 2024 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477234; cv=none; b=Y/w7bkb1brh7whZhLxzF+9z/lRdqnNVmRoI+fPYAlc8m1WU86SYp/r+uNJxhPeg/Qq/zdB/z28bhrkfulVfV4MsKfJnAOtahlYJr8lJ2Pytu8/SQSwenr73OEjNgB2ZbUIc6hR+nu8iw1Kku/p/RzPTTZKfiITQWyYH+VMVskyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477234; c=relaxed/simple;
	bh=wGhItbg8hWpo6Y3Z2EUM1pYHhakVAaxuom4u9x7t8KI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kDYBJKHEahojEw8WBb2Q+9+Uis71z7hlHmVRpzuyzbM5fHKiAA9PpO3Esq7pyQqwGXf//rPZg4TfCbcJCxthCCGM1T4NNDMcFKHVu5ZyuBDMXgG4wIxEMcXNK5A946RUubg370/fgtRP8c9vg0AOn6Prqx11qzyE6MBxf0432Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVFUyQE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FC4BC4AF18;
	Tue, 30 Apr 2024 11:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714477233;
	bh=wGhItbg8hWpo6Y3Z2EUM1pYHhakVAaxuom4u9x7t8KI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qVFUyQE/3JznSZlQI0nbEO3LrrIlBeZe29GwHTM8YX1OLe7EeXEZSekzjd6a9pOD0
	 VQqCkugKMBc6ot7zsGdeZAMIqjdZvznS9r6CF6atMybWCz84MrHuKNxsX+Nc+w3Dsr
	 EyYna3ZXzQqld+vxsN2EpqFUvwZ7NU5KJg9ZjztQQyOYzTAKcf/5kLy6xKWH8ZX3rF
	 mOqoFMpV5sonHzM0fpuZoXOKZ8oBUFG0iqvPhC+lpNusGAU6LTIiwkdwCxZd6RRcPV
	 oIBRmoDNOIyUQdToxizmr89E82ZLXWw7Tb3KNLrDj+tSWiqYiHLBgFSg0ncFygmBjq
	 XMggzAF4KN/ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D60FC43440;
	Tue, 30 Apr 2024 11:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171447723331.10444.16965496844638818442.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 11:40:33 +0000
References: <20240428060738.60843-1-guwen@linux.alibaba.com>
In-Reply-To: <20240428060738.60843-1-guwen@linux.alibaba.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 28 Apr 2024 14:07:27 +0800 you wrote:
> This patch set acts as the second part of the new version of [1] (The first
> part can be referred from [2]), the updated things of this version are listed
> at the end.
> 
> - Background
> 
> SMC-D is now used in IBM z with ISM function to optimize network interconnect
> for intra-CPC communications. Inspired by this, we try to make SMC-D available
> on the non-s390 architecture through a software-implemented Emulated-ISM device,
> that is the loopback-ism device here, to accelerate inter-process or
> inter-containers communication within the same OS instance.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,01/11] net/smc: decouple ism_client from SMC-D DMB registration
    https://git.kernel.org/netdev/net-next/c/784c46f5467c
  - [net-next,v7,02/11] net/smc: introduce loopback-ism for SMC intra-OS shortcut
    https://git.kernel.org/netdev/net-next/c/46ac64419ded
  - [net-next,v7,03/11] net/smc: implement ID-related operations of loopback-ism
    https://git.kernel.org/netdev/net-next/c/45783ee85bf3
  - [net-next,v7,04/11] net/smc: implement DMB-related operations of loopback-ism
    https://git.kernel.org/netdev/net-next/c/f7a22071dbf3
  - [net-next,v7,05/11] net/smc: mark optional smcd_ops and check for support when called
    https://git.kernel.org/netdev/net-next/c/d1d8d0b6c7c6
  - [net-next,v7,06/11] net/smc: ignore loopback-ism when dumping SMC-D devices
    https://git.kernel.org/netdev/net-next/c/c8df2d449f64
  - [net-next,v7,07/11] net/smc: register loopback-ism into SMC-D device list
    https://git.kernel.org/netdev/net-next/c/04791343d858
  - [net-next,v7,08/11] net/smc: add operations to merge sndbuf with peer DMB
    https://git.kernel.org/netdev/net-next/c/439888826858
  - [net-next,v7,09/11] net/smc: {at|de}tach sndbuf to peer DMB if supported
    https://git.kernel.org/netdev/net-next/c/ae2be35cbed2
  - [net-next,v7,10/11] net/smc: adapt cursor update when sndbuf and peer DMB are merged
    https://git.kernel.org/netdev/net-next/c/cc0ab806fc52
  - [net-next,v7,11/11] net/smc: implement DMB-merged operations of loopback-ism
    https://git.kernel.org/netdev/net-next/c/c3a910f2380f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



