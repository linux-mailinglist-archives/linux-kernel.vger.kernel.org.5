Return-Path: <linux-kernel+bounces-37657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AC883B323
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D2628403A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7A7134723;
	Wed, 24 Jan 2024 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ1jA/gb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10372AEEE;
	Wed, 24 Jan 2024 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706128826; cv=none; b=iLtDI3g2gsBPO9kNl6ACNxAwzoWr9YMb8Yt4Gh0ztet+yW8z7r0R2H0Tz2WcwrDYwRPBZ0HlG0pQ2r6uhO5YMwZi7HEI+Qy7LRK5fqSp2g2zSRnLxjho6rXj4vI32fMEBWy7gjSe9Evw7Jg5kLs9U/8uqVeKEw+kmsyxF4NrmHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706128826; c=relaxed/simple;
	bh=wxK0+Y4TomStm0KAfGk+VX83jR39mMxWmjbT3HXrJes=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EZ+GTWUEr+BkUaiUaiVnG/kZv7iJIF7kiDnXxSGuiCKEBW5D1y3Fug3dTfgWhRrnWLm8JmxNOVK5GAxLgU+VciB1Ulk6DE/mb3uOlXUCm8Yj0KwePDxGMGMj2oIHl9laXjnu40fQgttDPTxMFsGWGCfO0vwE5GSsdmgEqmwtwkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ1jA/gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93040C433C7;
	Wed, 24 Jan 2024 20:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706128825;
	bh=wxK0+Y4TomStm0KAfGk+VX83jR39mMxWmjbT3HXrJes=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oZ1jA/gb0v2BG2acW4NcjnoaKitl6nXPGBR1OL2LAUOWt6orAjtutYVSbzTddSl5h
	 Ht4we90CIWg2rsBfhGbqvEhjkYRgJHx4zFJWarim8qZgVIrTS0vlREdOvzS11NzK8e
	 Hi2c9avOd2AbXSIK8lARTn+DuKbKYIVywd02B8GjFtEKP9YgX7oF8K0LPjhEzwJku+
	 hVghTScxuIVUvmzwTWe2V9MihE9sHZ5S3phMpmyvxH2e0wtK4HSmFIa3vP3bxFkd99
	 Vwms0v7wlV1KCB69jH6BZmnQYhJ4QFJq25diTK9qARkUCSf7LjbX5xI7EYrL5hl21M
	 S/AklizdtpjRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 754FFDFF762;
	Wed, 24 Jan 2024 20:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net v4 PATCH 1/1] net: mvpp2: clear BM pool before initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170612882547.7254.6622322810423301984.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 20:40:25 +0000
References: <20240119035914.2595665-1-jpatel2@marvell.com>
In-Reply-To: <20240119035914.2595665-1-jpatel2@marvell.com>
To: Jenishkumar Patel [C] <jpatel2@marvell.com>
Cc: marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jan 2024 19:59:14 -0800 you wrote:
> Register value persist after booting the kernel using
> kexec which results in kernel panic. Thus clear the
> BM pool registers before initialisation to fix the issue.
> 
> Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
> Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net,v4,1/1] net: mvpp2: clear BM pool before initialization
    https://git.kernel.org/netdev/net/c/9f538b415db8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



