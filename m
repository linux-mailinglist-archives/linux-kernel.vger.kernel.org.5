Return-Path: <linux-kernel+bounces-100645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5004E879B36
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8412851C8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9124B139569;
	Tue, 12 Mar 2024 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rucpyEOS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CFA13956C;
	Tue, 12 Mar 2024 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267607; cv=none; b=AhwdJtlla700fm41XszVr5te9vyyVw9oZ1Voev1RxtOoFRnHEJrTGZJLpl7nRA//sHmY+fX8emgWdct6Vx4I2wQtrN8D+tL2aWa8m6aTa9aze1iCfyfmlmJBGVYDXmJAV9ai6vjSx153V0GISMG1+JemgokfM3WmcWb0QRrQ7yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267607; c=relaxed/simple;
	bh=hqWitlsPnL+8yPjT+KvzavZzgnkaJT/HqdtzAkufuqc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sMX0co9VIf9a7TYL7qkrwR+SPV+pJvx6I31tIL/PTLPrLldwvrciY5hxxggbh39F0OBN5UkbdABfzVBYuZbfAaZymh7IeemVIg4tcQxxmb1ZW5UV/8v4te+vph+D0mqCHHwhlF0ZH0s6ZGb4/xh2eI+RERc97FMz61g9cP6pW/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rucpyEOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABCC7C433C7;
	Tue, 12 Mar 2024 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710267607;
	bh=hqWitlsPnL+8yPjT+KvzavZzgnkaJT/HqdtzAkufuqc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rucpyEOS2KtZ7n86w4aIDhBFDELDjA50fJqzbewKJWj+IbEyLaPomcNnZSXoxFIcq
	 zlbpHdF+PD/Gjr7n/A192/moTXeszrTOvWIuy2tkELuGa1epsHM0otl7foygZt+He4
	 TB/on4DOTs4DC2b0IkR/UrqZ4vAaQjNYxQuFse53RAARmwYBFEdlnnwPr8e2CgTOu9
	 v7oy5YREGFTIpg096qq0j5yxR61P8cliyVWobAVcDu61OA8tRZmaF5XS4mjA6ehnJn
	 2wVZgKUEyov6QYzK58nsfKd49jW+6gQeFbG5TuqlgOvLJoI0y1L32J68p9KYFW98mo
	 YCzzBbo2QBF0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92352D84BAD;
	Tue, 12 Mar 2024 18:20:07 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.9 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311105146.20399-B-hca@linux.ibm.com>
References: <20240311105146.20399-B-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311105146.20399-B-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.9-1
X-PR-Tracked-Commit-Id: fa9e3139e6c5ac756e1ab2a6c7eca99eb684a2fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 691632f0e86973604678d193ccfa47b9614581aa
Message-Id: <171026760756.25732.8596407807038646032.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 18:20:07 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 11:51:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/691632f0e86973604678d193ccfa47b9614581aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

