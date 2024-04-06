Return-Path: <linux-kernel+bounces-133821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D563989A94A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 08:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDCE2836FE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 06:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F056F2C1B9;
	Sat,  6 Apr 2024 06:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+Wr4XWm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDFA2943A;
	Sat,  6 Apr 2024 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712383832; cv=none; b=cOaF7Cmw2A4rW0JQOzaKLEY4TcTY7THBG2SBHimZvVAibFNkEZAh4yXCFtLe7PwPUQrMWVey8We6uUuG4uMyqOM4pFAbnLWgt5+44TIJKtmyVKBlYHluE+mM6qcGQhATzD5ntjkN9LUvZn1bDA9fvNdvmCCctQZZiufaKHx+fnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712383832; c=relaxed/simple;
	bh=Cz33WU7Hc5FNwf5cwLTCx90x6NawtlSX4+6yThGEoOo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bu1s4zthFjzgQQWrLT4KehbMH39QKhqCUDx++ic8GFu9yRKOnArwXJ6bnDWIMuIfe1VoBzlOii19g+tN9ZfIRj/XWpNv5SAL0gGBqzt45KJxfZHWwF4dFsQOknaZeIvmRxFmbQKf5bQ24dKzsDdEsh4pHCv5HjqOZ3glEsWaD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+Wr4XWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA53EC433A6;
	Sat,  6 Apr 2024 06:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712383831;
	bh=Cz33WU7Hc5FNwf5cwLTCx90x6NawtlSX4+6yThGEoOo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A+Wr4XWmYw4shuqrXtTNzucM/vYtJPDJcZsI4Evy8rZYFN0TTjN6r/zF2OEFJU+eG
	 ZhAqWdcHx2Tx5eV6lzkNoVaUGMdsIIan5BK1alOb8J4AREz1p8JHzztuynlJqg6lnv
	 OOjfhwpciLwhuqotsDRy8kmNPhdK5WN3Vf/A985k52e+UxQox+o7JGTRb8NxFEixt8
	 Iu0eL6egLPwfxqI0Y2ftXA9ThFJhCJ8gVSEvIJ2wB+4U5eEL6j/ZwVu3DGPf14Jfax
	 /aypplMeYQRGc5UBfD+mDZHgaUg4LJCA3Ui02IySBpJa0LaEAdjVCcLJAio69iUj+e
	 txzZnBw4g7AyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCD43D8A103;
	Sat,  6 Apr 2024 06:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] ethtool HW timestamping statistics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171238383176.24936.1670208435099472529.git-patchwork-notify@kernel.org>
Date: Sat, 06 Apr 2024 06:10:31 +0000
References: <20240403212931.128541-1-rrameshbabu@nvidia.com>
In-Reply-To: <20240403212931.128541-1-rrameshbabu@nvidia.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, alexandre.torgue@foss.st.com, andrew@lunn.ch,
 cjubran@nvidia.com, corbet@lwn.net, davem@davemloft.net, dtatulea@nvidia.com,
 edumazet@google.com, gal@nvidia.com, hkallweit1@gmail.com,
 jacob.e.keller@intel.com, jiri@resnulli.us, joabreu@synopsys.com,
 justinstitt@google.com, kory.maincent@bootlin.com, kuba@kernel.org,
 leon@kernel.org, liuhangbin@gmail.com, maxime.chevallier@bootlin.com,
 pabeni@redhat.com, paul.greenwalt@intel.com, przemyslaw.kitszel@intel.com,
 rdunlap@infradead.org, richardcochran@gmail.com, saeed@kernel.org,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com,
 wojciech.drewek@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Apr 2024 14:28:38 -0700 you wrote:
> The goal of this patch series is to introduce a common set of ethtool statistics
> for hardware timestamping that a driver implementer can hook into. The
> statistics counters added are based on what I believe are common
> patterns/behaviors found across various hardware timestamping implementations
> seen in the kernel tree today. The mlx5 family of devices is used as the PoC for
> this patch series. Other vendors are more than welcome to chime in on this
> series.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] ethtool: add interface to read Tx hardware timestamping statistics
    https://git.kernel.org/netdev/net-next/c/0e9c127729be
  - [net-next,v2,2/6] net/mlx5e: Introduce lost_cqe statistic counter for PTP Tx port timestamping CQ
    https://git.kernel.org/netdev/net-next/c/adda54018078
  - [net-next,v2,3/6] net/mlx5e: Introduce timestamps statistic counter for Tx DMA layer
    https://git.kernel.org/netdev/net-next/c/cd429012f078
  - [net-next,v2,4/6] net/mlx5e: Implement ethtool hardware timestamping statistics
    https://git.kernel.org/netdev/net-next/c/3579032c08c1
  - [net-next,v2,5/6] netlink: specs: ethtool: add header-flags enumeration
    https://git.kernel.org/netdev/net-next/c/ff8877b04ef2
  - [net-next,v2,6/6] tools: ynl: ethtool.py: Output timestamping statistics from tsinfo-get operation
    https://git.kernel.org/netdev/net-next/c/2e0e148c7270

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



