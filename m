Return-Path: <linux-kernel+bounces-69394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D6D858863
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8945B1F230D0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86461487CB;
	Fri, 16 Feb 2024 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVro0Jlt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27A8148304;
	Fri, 16 Feb 2024 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708121399; cv=none; b=t5gmBpGrwPsZCox7A4ZWaHJ/d66IY0yVGn0beYEk7gIaF0E2O1BLMlq/MkIQaiumVQinFFj5WM22iRrXO6zeGoMCKVAsUeiJqYqAR8LyY0YxE5+ZVrSzFSlfK35SLVieKVEXR8qx3eo+873ntPTTqiXGEgvQ46FUe382TQystFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708121399; c=relaxed/simple;
	bh=v6+WUpJRUoig4DP4nx4iG7BJqVngHTx1esPETeMKxCc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a+BiiHVDQYTBIcan16gnTK7cv+1hqV+ESxrEqF4/uJg+yjZYYZPTnuuLD+xZqagDw4kcFcYZsZHIOx5zAZW/ZMWm+8k5Oyeab8YDvYXI9amAZzqiIiJPOEjp1t5tqe6veT8ivVgbWFOZy7YI0yMUkdVLEQogkWE97JiMR5Lr9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVro0Jlt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 835FDC43399;
	Fri, 16 Feb 2024 22:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708121398;
	bh=v6+WUpJRUoig4DP4nx4iG7BJqVngHTx1esPETeMKxCc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nVro0JltPrJgThKXextEwl5e3nR0s3aj1FMpcQJveTiRKH2pKBF1OMDs36SD+49gT
	 oZOqBD/NmsOs/CxuTlYNzVrOud1E4uHmuAkfSDFc835ZYn47uTl3uLd9AjSmPd5uAJ
	 3E8Yj4ydx069wbbcLylKfGGGR+wNma33E/WiwrSE6hso/G0/6AVQFMNpuyMGxvFeUi
	 W5T0avwmqUMDoOos/rdgrxgVQtvOkn8//BX2H961o3yXv66vW0LJGyeD0X6A0QzD3p
	 rTDR5wUH8/L/kmclz5HJ2N+ThTmhS14NdHc8ZwmTDcm8eq9NoPnwQz10tAvvkYGuUv
	 CcMIcKGplgxpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B281C04E24;
	Fri, 16 Feb 2024 22:09:58 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <fd86dd962555df8e53ba997f6b54fff822545667.camel@HansenPartnership.com>
References: <fd86dd962555df8e53ba997f6b54fff822545667.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <fd86dd962555df8e53ba997f6b54fff822545667.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 379a58caa19930e010b7efa1c1f3b9411d3d2ca3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1ca10ceffbb289ed02feaf005bc9ee6095b4507
Message-Id: <170812139843.30067.14767846889572201253.pr-tracker-bot@kernel.org>
Date: Fri, 16 Feb 2024 22:09:58 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Feb 2024 17:02:01 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1ca10ceffbb289ed02feaf005bc9ee6095b4507

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

