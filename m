Return-Path: <linux-kernel+bounces-41068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F03E83EB33
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 06:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FBB1C22DCE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 05:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B008017543;
	Sat, 27 Jan 2024 05:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WG1HZCq1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACD212B6B;
	Sat, 27 Jan 2024 05:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706332230; cv=none; b=PnF6BTQ6ZhhfB1Yuwj9lNB/h9fdL/KNCmQc9Zc9crI8J+EtpYtAaIWWPEkhKpXS+0rdgwoHwIDrVwyW3wqRmIkaP5hNz/wiFSlBQEYhIwkgEpnO+Zl8nlNqsPAnH+J92sr+F5vYMHrGb4eFAYdWP+8k6G+5vd2VXzs1J70MLX90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706332230; c=relaxed/simple;
	bh=c8OkF864VgYeRw7woWIVPNPvS2Vc3lcwaCYuza37+p4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WYkAowAYBdJDyP0ux3wTTxNKUuJ4tvT+2ndZFHY7LFUgRTTmg8+7tMiBC3j9vuwMGJ5t7jdv+H0C4EQm3+dqefuDNy6aCqZ8+k2f6GwSomlY4LbyGmKANbY7pkkwrUPd99QmKAKgIN9PMkK7GkNjAx9xaMd2FQIKqlZ0EJTdCds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WG1HZCq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0ECBC43399;
	Sat, 27 Jan 2024 05:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706332229;
	bh=c8OkF864VgYeRw7woWIVPNPvS2Vc3lcwaCYuza37+p4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WG1HZCq1oG/F3L2KKL7tao9SUb16qJs9lwaLs1tt8NXZIew3RCW3tw9wp2chAHE47
	 MJ4fYs+saBtS/pOsjSvJCBsnP7oFdDRCF3vA9k+HOBuuIEMceevgRZ+RR0bWBwfG7p
	 pAzg1JuBZxwz7whiA0TRZSSOjwAVlhxI0T1KF2VxcZPp+xn1IB+YZYQRW18COIGkUm
	 HgRzvvfesaUMaTrMgm2PIlveAHDEDS6g7vdakI3S9w7EHoyyDY87yn3GJj/LMlUts0
	 tIeblo0ltYqt2YiG0+L7BWnxNpF3taN0ADoIS17LwaU/RIcRmZxQuMpDL/DfMxJsNV
	 XGHzfnvfqRV9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94504D8C97E;
	Sat, 27 Jan 2024 05:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] drivers/ptp: Convert snprintf to sysfs_emit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170633222960.22327.6975138327319151209.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jan 2024 05:10:29 +0000
References: <20240125015329.123023-1-lizhijian@fujitsu.com>
In-Reply-To: <20240125015329.123023-1-lizhijian@fujitsu.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jan 2024 09:53:29 +0800 you wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
> > ./drivers/ptp/ptp_sysfs.c:27:8-16: WARNING: please use sysfs_emit
> 
> [...]

Here is the summary with links:
  - [v2] drivers/ptp: Convert snprintf to sysfs_emit
    https://git.kernel.org/netdev/net-next/c/8d0293302dfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



