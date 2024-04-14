Return-Path: <linux-kernel+bounces-144230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 561CE8A4369
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5CB1F21307
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B001350E3;
	Sun, 14 Apr 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diGEszRY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5C313473E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713108765; cv=none; b=A6ST52/QBUzJmBouSpbY42mci0nM+hXeK7zQHgezvBDJDKLpxBvd+pQRbpfLamLYgynxidV9+0sRR/3gVXA2cyCwMBrZhl1NJ3BZOcsul0TMnpV7ZpnOCenboYiXf1MtqZNR5ekvpaqD43tXGtx2LbJDJN3kJRSMArd4zDLcb0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713108765; c=relaxed/simple;
	bh=i8hC/qYdO20bTDFXhf1UZr6iGIZ79ePp+iQi/dhLKic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=InoLHftw4UBWvmiW08FED3CUUHLsQyb8y2vXO8oSlqvaZnOE+UoP6ZlMPHUplEte+BxnlZ+hhxm//UxbWr8nVsOY4hCU0tb18+QT3+w7Y0C0Kfd6cl6cs99/RDiAS0fF+oaEupYLuNVKmnXdpHqyitBPVeowMJ/PDBgO5VHIJUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diGEszRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46AB1C4AF07;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713108765;
	bh=i8hC/qYdO20bTDFXhf1UZr6iGIZ79ePp+iQi/dhLKic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=diGEszRY6aqfAL6yojlRjG5f1kWvpK0fp2xVwVHCr+/6ywC7miiqzHxLFRDn7Gb63
	 mE7jCoA03+fFXEd4FSZZBPPpvdUwBE6tt4phpMSCz+mp5XHxPkhSPKFSCk3qAD5d7u
	 F8amcKppqmg+AE/LMSqqqN6oVkYHa92AmSYEZ2Tl/I3tutLm4fk9vVQBwbOsLf9UTu
	 Q71gsX7ugdXO6vcSvKrnxGnw2JLVmcKykdoMCKhnbCcHt1cXqNejCyGOqQxc1pgDoK
	 4HTJxjLbD+jOSwNcwZmiWsAZvAX8u308kklNFd6bvWyEbIDtrucPfAzK9Tyb6sJg7X
	 v3lntI2ycZ73g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BA43C54BD2;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to relocate check condition in
 f2fs_fallocate()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171310876517.3156.14366722531397621692.git-patchwork-notify@kernel.org>
Date: Sun, 14 Apr 2024 15:32:45 +0000
References: <20240403142420.2042498-1-chao@kernel.org>
In-Reply-To: <20240403142420.2042498-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  3 Apr 2024 22:24:19 +0800 you wrote:
> compress and pinfile flag should be checked after inode lock held to
> avoid race condition, fix it.
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Fixes: 5fed0be8583f ("f2fs: do not allow partial truncation on pinned file")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix to relocate check condition in f2fs_fallocate()
    https://git.kernel.org/jaegeuk/f2fs/c/278a6253a673
  - [f2fs-dev,2/2] f2fs: fix to check pinfile flag in f2fs_move_file_range()
    https://git.kernel.org/jaegeuk/f2fs/c/e07230da0500

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



