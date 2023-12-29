Return-Path: <linux-kernel+bounces-13205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B24A82011E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7151C21722
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 19:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105AF134A0;
	Fri, 29 Dec 2023 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaoBjIYh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6253D12B98
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 19:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9B74C433CA;
	Fri, 29 Dec 2023 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703877024;
	bh=1u6y4yARCqRY7+e2rXMY/Xf05MSeoSpwpaXcLPm8MmU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YaoBjIYhg7svxuhYCMisexTJeVOQ1uWK7jiHzv0Qdln9Gemz7XTwo7u1D8HUBuS9C
	 NmtWpP7yW/qc8TYjViYqOWK1unjORvoCNr5RrV72K6RsMzPChSJWbszg9wffceMHVn
	 S1AmBOr6sb81cZn8Vqz/SRqKxIBu9SK1GFGKk5Znl7fDh0Lm8XYAvFeqyzyMddmWN/
	 QyYJm4/phqECiX4vpS5DxG6tlq2U4CWh+cdua8zVoRyUtJGUStfiBUf61W3BbwcyuL
	 Rvm6HOWSsQn7kYSSaReh3xV5GPoeuYSt9B+fAxspM3qvYxytaHsifNF4jVCRoKRFco
	 Frph1nx2LtB2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A10D8E333D8;
	Fri, 29 Dec 2023 19:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: Constrain the modification range of
 dir_level in the sysfs
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170387702465.8173.9564076529806115023.git-patchwork-notify@kernel.org>
Date: Fri, 29 Dec 2023 19:10:24 +0000
References: <20231222032901.3861649-1-yangyongpeng1@oppo.com>
In-Reply-To: <20231222032901.3861649-1-yangyongpeng1@oppo.com>
To: Yongpeng Yang <yangyongpeng1@oppo.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 22 Dec 2023 11:29:00 +0800 you wrote:
> The {struct f2fs_sb_info}->dir_level can be modified through the sysfs
> interface, but its value range is not limited. If the value exceeds
> MAX_DIR_HASH_DEPTH and the mount options include "noinline_dentry",
> the following error will occur:
> [root@fedora ~]# mount -o noinline_dentry /dev/sdb  /mnt/sdb/
> [root@fedora ~]# echo 128 > /sys/fs/f2fs/sdb/dir_level
> [root@fedora ~]# cd /mnt/sdb/
> [root@fedora sdb]# mkdir test
> [root@fedora sdb]# cd test/
> [root@fedora test]# mkdir test
> mkdir: cannot create directory 'test': Argument list too long
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: Constrain the modification range of dir_level in the sysfs
    https://git.kernel.org/jaegeuk/f2fs/c/0145eed6ed32
  - [f2fs-dev,2/2] f2fs: Add error handling for negative returns from do_garbage_collect
    https://git.kernel.org/jaegeuk/f2fs/c/19ec1d31fa56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



