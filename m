Return-Path: <linux-kernel+bounces-45296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E47842E35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99751C23152
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10EA762D4;
	Tue, 30 Jan 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzSiEehy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D186E2AA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647826; cv=none; b=hQWhV0X9pP4jvSpFqyFoPQxaUy0JrFFV3VeOPITeLNLT7Mw6p5aTdoMQ7WAvtgE25Hx7d6ZTIwXwmAhZ/rOgpAGK1rxp0GcyezyUEGb2K8Uks4KFhn73pSGhnYIYlSCCSWHxo8GRTFDJ0PwUi08a+fmFfRkGzxADMsAw4tP9l34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647826; c=relaxed/simple;
	bh=P9Nxfwsi22IBiRvPA+3XxCKQOS0jTpHQgVQTl1R2KsM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rTZzqTDE+5KLdpVG5UjDidRi7XiIQDawgIe3N8PE3TX+8kYYC4TcN4FzuBaNtRyvEvregTS61V9E0Hoo8n9wWnkP7IBRm+8FZESOYBOQeHUVY4AVJHjPhHgGNpjrKgl7YcJUeIG/s1B5aiQdE1qQgVVq/ypdE12WUsfPxjdwol8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzSiEehy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7A3EC43394;
	Tue, 30 Jan 2024 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706647826;
	bh=P9Nxfwsi22IBiRvPA+3XxCKQOS0jTpHQgVQTl1R2KsM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WzSiEehyX6Tp9o+FIoVXSXh9HQIC/PLdpk986JdLoKr5IFu1wT5kKH4jJhY3GXDBV
	 A1eBj9mmTavRR3TNw+zTU2Yv9ExdZihV7+ATMpja6RJV/EIVqfFmowwA4i1SPAcjT+
	 co0ilGsdsGqMe3/w+TTslncRXPnGwlExJ+DWIbKoYqDBRlCEXBDnaQyhA7q8hbs9xz
	 kvUke0sQnF07bKUC10egOsG5GYx5zCZCD6NkussKVbeZo6bFoOU+jmLvAXVF5eCsgD
	 L4fDSOKoNFfE/adNwHzFWAH8G8ZNi1FUHfWjYeQp3tH5zfDMDeP1zcsFy87N5JzwEE
	 3ALTk6hsc00UA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDD24C595C5;
	Tue, 30 Jan 2024 20:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: use IS_INODE replace IS_DNODE in
 f2fs_flush_inline_data
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170664782583.32692.9577632595929529789.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 20:50:25 +0000
References: <1705478398-10890-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1705478398-10890-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 niuzhiguo84@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 17 Jan 2024 15:59:58 +0800 you wrote:
> Now IS_DNODE is used in f2fs_flush_inline_data and it has some problems:
> 1. Just only inodes may include inline data,not all direct nodes
> 2. When system IO is busy, it is inefficient to lock a direct node page
> but not an inode page. Besides, if this direct node page is being
> locked by others for IO, f2fs_flush_inline_data will be blocked here,
> which will affects the checkpoint process, this is unreasonable.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: use IS_INODE replace IS_DNODE in f2fs_flush_inline_data
    https://git.kernel.org/jaegeuk/f2fs/c/5e9f083a7ae8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



