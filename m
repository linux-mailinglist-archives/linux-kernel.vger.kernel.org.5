Return-Path: <linux-kernel+bounces-75649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA53B85ECD3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543F3287942
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB0B12AAFB;
	Wed, 21 Feb 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJwnLSFT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A593EA8E;
	Wed, 21 Feb 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557631; cv=none; b=tkvlFA4dkgraDHNb8aD2dhPQ9gqzhgLpOYj2baAekpzLx7QdplCEwS8unRhDdSt4rRFUMeqmNkDhJSDi8OxX+SwLfKdBICHPzzGzSrwO+8BdWeu6TlSeFARjmSbfgPL3mRFP5okDicG6thoBeqXehX2WdKp0VKmkXJJxY6WDrVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557631; c=relaxed/simple;
	bh=eC1hyR9pm50ESsSUHvDxGhzpAARS82WoJLl7mz9w2sY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZnsiQRqrhBuU+vQxa5Vg8e51i4EAo9uVcIbyJmx0ArPyYaUUDjOJpmsb9jNBHUliPpg0Qsc53IR+gKmrVR6KP+BgGyKeJ6KrINE2d0H5FgKrwpndzLOFi9JEUP8Jb8R1igGas90PP07s/rf/pmSqATHz7NOQAiyleOp0AAUBKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJwnLSFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FE8FC3278D;
	Wed, 21 Feb 2024 23:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708557631;
	bh=eC1hyR9pm50ESsSUHvDxGhzpAARS82WoJLl7mz9w2sY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LJwnLSFT2g28LehWfW2ljIN2vfLdnndqxdMyPeJVfzKQKYE66pP5lTDKOiChQb0Of
	 JaNsL4+Ttw0OD4QGOX8xEFBAaAcZKqd1O+dihiqRgnL2e6MIG3mmvgWKfdG/BAgis7
	 jnISo7+pOXvnbVzDc2yQ+ey35RQ4Ne/63dNQPizR1ybdi2MT/XS6IHPLSasW9Rm2Ms
	 VDjENoAqG5qQphDWFm9dU7VuSu7n3x3ZScC1qBE5ANhsh5oUXQ7p3ucikZr18eto9s
	 OCQUxXmyf7ktZU2sN0vQuidTpP9jYMuBF/nUNK9EMcbOmtww8zXgi374B4mZ1IZ9Ql
	 +/TClBf1muNxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2FBBED84BC0;
	Wed, 21 Feb 2024 23:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 net-next 00/14] net: phy: marvell-88q2xxx: add driver for
 the Marvell 88Q2220 PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170855763119.23011.17595811102580126405.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 23:20:31 +0000
References: <20240218075753.18067-1-dima.fedrau@gmail.com>
In-Reply-To: <20240218075753.18067-1-dima.fedrau@gmail.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 eichest@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 18 Feb 2024 08:57:37 +0100 you wrote:
> Changes in v2:
> 	- used defines MDIO_CTRL1_LPOWER and MDIO_PMA_CTRL1_SPEED1000
> 	  in mv88q222x_config_aneg_preinit
> 	- use genphy_c45_loopback
> 	- mv88q2xxx_read_status reads speed, master or slave state when
> 	  autonegotiation is enabled
> 	- added defines for magic values in mv88q222x_get_sqi
> 
> [...]

Here is the summary with links:
  - [v7,net-next,01/14] net: phy: Add BaseT1 auto-negotiation constants
    https://git.kernel.org/netdev/net-next/c/953cc643329b
  - [v7,net-next,02/14] net: phy: Support 100/1000BT1 linkmode advertisements
    https://git.kernel.org/netdev/net-next/c/ac0c530619ce
  - [v7,net-next,03/14] net: phy: c45: detect 100/1000BASE-T1 linkmode advertisements
    https://git.kernel.org/netdev/net-next/c/8d9a577f0eea
  - [v7,net-next,04/14] net: phy: marvell-88q2xxx: fix typos
    https://git.kernel.org/netdev/net-next/c/944767b00dd4
  - [v7,net-next,05/14] net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY
    https://git.kernel.org/netdev/net-next/c/e57e4c7f6cc9
  - [v7,net-next,06/14] net: phy: marvell-88q2xxx: add interrupt support for link detection
    https://git.kernel.org/netdev/net-next/c/caa858b75742
  - [v7,net-next,07/14] net: phy: marvell-88q2xxx: add suspend / resume ops
    https://git.kernel.org/netdev/net-next/c/5f9f361a3dab
  - [v7,net-next,08/14] net: phy: marvell-88q2xxx: add support for temperature sensor
    https://git.kernel.org/netdev/net-next/c/a557a92e6881
  - [v7,net-next,09/14] net: phy: marvell-88q2xxx: add cable test support
    https://git.kernel.org/netdev/net-next/c/560d9a39aeb0
  - [v7,net-next,10/14] net: phy: marvell-88q2xxx: make mv88q2xxx_config_aneg generic
    https://git.kernel.org/netdev/net-next/c/3810e029e23e
  - [v7,net-next,11/14] net: phy: marvell-88q2xxx: switch to mv88q2xxx_config_aneg
    https://git.kernel.org/netdev/net-next/c/969dd0cf295d
  - [v7,net-next,12/14] net: phy: marvell-88q2xxx: cleanup mv88q2xxx_config_init
    https://git.kernel.org/netdev/net-next/c/ec2660946a57
  - [v7,net-next,13/14] net: phy: marvell-88q2xxx: remove duplicated assignment of pma_extable
    https://git.kernel.org/netdev/net-next/c/923d3104f794
  - [v7,net-next,14/14] net: phy: marvell-88q2xxx: move interrupt configuration
    https://git.kernel.org/netdev/net-next/c/f29207d2e0fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



