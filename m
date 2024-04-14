Return-Path: <linux-kernel+bounces-144227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FE88A435E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220D01C20B3E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2E41350DA;
	Sun, 14 Apr 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4oGpevJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8058D13443F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713108765; cv=none; b=VihlSWEtG4SVgv7mwI4V/JiBr/+AVH1jZ//LVZnDqy0zt4HlYk6qTGsjUm8RlnuMJzYgSJX7IdfHfjymOcdNbbdVn+l2XpyQcCfZjSk7gpmmuDX9RY90qCy/Osrd0qq/KxUGQf4gtjYrefHEDIpgIoov+dY8KYyyNFNK7DxWXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713108765; c=relaxed/simple;
	bh=DXSKgdJzVmHazsq2hEXi5c55HkvD/ZF2dqfR0/U9l64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iHEcrE19JEXJ0tJd2uHgHqaA9a4a8cJagVRsn3N42lCKG3JoyWZASWVxjZ9sIyINB0NqBiOp4CKCqvL/td5DGXhKM1IR0fcVPm04s4I0ZE0Y13AfqO0bOugqHH4793vxXnuX3znEzr+zB3GKpEvU60h+4pHxIVktSaMBs/W8+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4oGpevJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E199C32781;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713108765;
	bh=DXSKgdJzVmHazsq2hEXi5c55HkvD/ZF2dqfR0/U9l64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B4oGpevJo2dJXw4epeuwNrQ2HtBYNvKBgDga2ak/BbINJ0yJs54K2FlGXgdVZwxn7
	 51ZsQ1HWQr0dRO+OAmunl9BPEmNNz2OiMF4MlHxq4zae4QMeOnbkHgBap5XzHqV6Fg
	 xPS5hjW+IFarIfM/ZMB70dwrH/QvdyFM1w6+bbEOnB8/uNopL+o2Kla8uifahYHSO4
	 B4JD2xOB34R8F54SlPHbaEat/3SQU6TAnFUnGVvDSr++qZXce4/oRdu9mnidi9A25d
	 F53+N44fCRQhlNtjL/k08Kqq9JvshiHjHb7tg6qsbBG0cM3E+GgNHLTb1Ay+D7sbux
	 taMIK0Up30Vrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D0D9C32751;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v7] f2fs: fix zoned block device information
 initialization
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171310876511.3156.10918924129747857805.git-patchwork-notify@kernel.org>
Date: Sun, 14 Apr 2024 15:32:45 +0000
References: <20240407072123.3484300-1-chao@kernel.org>
In-Reply-To: <20240407072123.3484300-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, qwjhust@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun,  7 Apr 2024 15:21:23 +0800 you wrote:
> From: Wenjie Qi <qwjhust@gmail.com>
> 
> If the max open zones of zoned devices are less than
> the active logs of F2FS, the device may error due to
> insufficient zone resources when multiple active logs
> are being written at the same time.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v7] f2fs: fix zoned block device information initialization
    https://git.kernel.org/jaegeuk/f2fs/c/0f9b12142be1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



