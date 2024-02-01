Return-Path: <linux-kernel+bounces-48532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25C9845D4B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312ED1C29759
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431771FDB;
	Thu,  1 Feb 2024 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEr6YX78"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846152C1AE;
	Thu,  1 Feb 2024 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805026; cv=none; b=reaaTn/n+QgvLMTlFXpgYZrxHoa7QPmn8uRBhittvaBTl5lAOeWWL8winrh8VQhYIUO0WqMyGu4sRaEiwuBY93oLfu6VcTSXqq3ficmAppy0dB0AypAg6ZPV9PxF9XEBtEpWW7wxzC7pdiwo6ikANaUBf4ndjT7PST423dZTfYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805026; c=relaxed/simple;
	bh=eceafvfYynU1zzp2FnC/0uoltxuM0zweeBVsbz35eJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IvCHOVLWVN8NAPOzAU3oDsrNd0PV+SujSbrnsSLz0Z9FC04o7L6c64Yr2lk4qrZykwrpYVjwTQQQjY1P823zLpwH6GuI2gaxJCHsXQN4ZYFiccuFhdRlDQ50tHaAkIvSkmqeGO3RX1MYpCuxNSTdgrwS1NyWUJlovRezIPVHLAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEr6YX78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 106FDC433F1;
	Thu,  1 Feb 2024 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706805026;
	bh=eceafvfYynU1zzp2FnC/0uoltxuM0zweeBVsbz35eJk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rEr6YX78cKcC0rx1Lt9P3TOfYOeTLUMAaW0HzDoc5jtyUI+ggFWQbfjcLJSOp6I69
	 iwAE13xxUf7ePDPFuqnx5sTav3VsSJFMO1PX8f0g6MDxPnqQVk635TVceRzgnZQ/GX
	 zRJrknBAQt4DK9lcE+QAd5JWayiQbULu7H8KU/qUu7Pa/6jSMerwUjPu9oVKG78a3C
	 Yz2vKZE6L1zywB+3sg0xcFlLs41fqK4sdD4GIB2nKKRlPrZ910YOt5etjJFPH/LmOv
	 yAjUFydbQAFvjqfcR7i4MTJAL5d6GY/yTQXbbGKzy2B0NXJMj+vPt6jzuLKLCWJJKL
	 IsrbHWzyesi0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECB13E3237E;
	Thu,  1 Feb 2024 16:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: dqs: NIC stall detector
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170680502596.24534.11598533255978552834.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 16:30:25 +0000
References: <20240131102150.728960-1-leitao@debian.org>
In-Reply-To: <20240131102150.728960-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 Jan 2024 02:21:48 -0800 you wrote:
> This is a patch that was sent by Jakub Kicinski six month ago, and I
> am reviving it.
> 
> This is still mostly Jakub's code, with some small improvements,
> described in the changelog.
> 
> Changelog:
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: sysfs: Fix /sys/class/net/<iface> path
    https://git.kernel.org/netdev/net/c/ae3f4b44641d
  - [net,v2,2/2] net: dqs: add NIC stall detector based on BQL
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



