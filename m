Return-Path: <linux-kernel+bounces-159433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4DE8B2E92
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F20284D22
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68FF1C3E;
	Fri, 26 Apr 2024 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZPx1kVb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105756FA8;
	Fri, 26 Apr 2024 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714097427; cv=none; b=uaqL6uE6Nfi9GeyfG5b5Ma7Msy0OKdgh2iIUUyKN5DvgzQeCAkOuu7V0enqBVByO6+OPLkrF4iyUmwrYC6k5ymV/OgzreMjziQj0dGtuglFjXKMKi2si4WiHu9XyvSaRksXmnet1cnjURN9ihZbXEl3kG7nVRXSUd80UC9jydxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714097427; c=relaxed/simple;
	bh=d5NSKlfN8vFI8kmDT6ViieDuxmShiRbsDaoL13ffb6g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pyAWf/zM/aOzPiUZoTp3JLi0mPqsjLeRVHust8STsL/7IltpN/9lglzuWG3RG3r47WUWU/I6Pi6q2v1H/xSjdwxlqxOWVao4m4U7LC85a1e2p0oH3ySiG7f2cT7CupRrDcexK4gDS6k2xv3at1uDFQvq6u2k8NS3V4Ne7XNyXZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZPx1kVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84803C2BBFC;
	Fri, 26 Apr 2024 02:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714097426;
	bh=d5NSKlfN8vFI8kmDT6ViieDuxmShiRbsDaoL13ffb6g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kZPx1kVbBr87AkyaTEUJwUcWOOndd4LkJXrydvmccWWTFNfV6W6zE8liYWwoxvxQE
	 I/bdasHz+GM5fV8l4/rsag8biCdmejCqbw7GnG6+NvCv1uZGuH4wWMWdqKSqZsYNgM
	 FMJP5Sl0gMRnFZmPquyFZbcLeYUF6FtHM7yAFsEuk2tvmJ2GtXFmXhrNSqBSGVF0xh
	 fb4E9zmodNNMgBLfZRdHDUaoC6wUz8dg9TI83RhtkNotDRsft0jc4ZhLoee9CN88cU
	 tVPZ593ZUYYFX0xvLYxaNa4QrozMY1gEwZBqrIzmPXB2bpKvaSfw+/lEkJTToYuJaR
	 fTiKU9RrVIORQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FB13C595CE;
	Fri, 26 Apr 2024 02:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8152: replace dev_info with dev_dbg for loading
 firmware
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171409742644.3002.17427557542313626166.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 02:10:26 +0000
References: <20240424084532.159649-1-hayeswang@realtek.com>
In-Reply-To: <20240424084532.159649-1-hayeswang@realtek.com>
To: Hayes Wang <hayeswang@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Apr 2024 16:45:32 +0800 you wrote:
> Someone complains the message appears continuously. This occurs
> because the device is woken from UPS mode, and the driver re-loads
> the firmware.
> 
> When the device enters runtime suspend and cable is unplugged, the
> device would enter UPS mode. If the runtime resume occurs, and the
> device is woken from UPS mode, the driver has to re-load the firmware
> and causes the message. If someone wakes the device continuously, the
> message would be shown continuously, too. Use dev_dbg to avoid it.
> 
> [...]

Here is the summary with links:
  - [net-next] r8152: replace dev_info with dev_dbg for loading firmware
    https://git.kernel.org/netdev/net-next/c/092d214138fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



