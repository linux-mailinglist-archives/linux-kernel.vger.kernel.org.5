Return-Path: <linux-kernel+bounces-46970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFC984472D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE9128B73B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A401862D;
	Wed, 31 Jan 2024 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hI3/K2IB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B37CA7F;
	Wed, 31 Jan 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725917; cv=none; b=booNGGaLhaIFtuzP5XUbW173gjoGec9pnJvWuMks5JqCUlzSIn1zX7GS2G6IXLERZHvBlQDWmY2czfZmNsIFKwKpTjIyUiYfPi9crak7wKpZ/GSmDGH0rnOMGP+xCovTL9jTZbCaJgRtaSK3P6YUYxTsTdW41SUURLdz3ckNC88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725917; c=relaxed/simple;
	bh=5eXQYJ2QVcSsWUt1n52QPxc9VZNtEGN+35a7POQ9WeY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UVu555g7TbkCq3KI9sBTIouXeX9hBwMC0cmAK0V0XSH/uZ0bccVKlN5AwnMF4vvoxjXdwjt+VwZltMuAw9AC8blk722zH60BMnDlt6bWIH6xn26fLFTCcKR4GIr7QKUsBV43X0StyVWVs6oC7MM7OnEh/uhTZ7vhJ0ty5/Qtcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hI3/K2IB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68EECC433C7;
	Wed, 31 Jan 2024 18:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706725917;
	bh=5eXQYJ2QVcSsWUt1n52QPxc9VZNtEGN+35a7POQ9WeY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hI3/K2IBGvAKVgvokn/oaAJVEXL7bk2b3Tebw06cSxx2Djb8EvC/zpAgYdwzopNLY
	 ESrHLX9l5WLWwNGPJFRUx1pNU00pq+KtHqgsE3bhINczKj05bC2eNmxPKZ2BdVZ3gg
	 yuWqQ91IHyDsIyOpZOH2YcmnJMUm2sOnNG5AqbtHiiWIGiER5Z+qOWEwG9DoJS4aQN
	 +DDnuavnpHsgsSkTINOIgrECHOF6Oz2ngp2SUw92vp1VtEvXA4jXIx/EehNnF4rgrw
	 pbx9BLrWz/lT2VhF9mJT67RGSNA4XlGStFXvVnsOw+GDTzsnBhimgl2iQ+aAVN7S1L
	 xWu1CgdwT2JtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 533A8C4166F;
	Wed, 31 Jan 2024 18:31:57 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <c350958c01b9985e1f9bf9c041d1203eb8d82b19.camel@HansenPartnership.com>
References: <c350958c01b9985e1f9bf9c041d1203eb8d82b19.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c350958c01b9985e1f9bf9c041d1203eb8d82b19.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: f4469f3858352ad1197434557150b1f7086762a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6764c317b6bb91bd806ef79adf6d9c0e428b191e
Message-Id: <170672591732.10826.9240785950043375034.pr-tracker-bot@kernel.org>
Date: Wed, 31 Jan 2024 18:31:57 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 31 Jan 2024 09:12:03 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6764c317b6bb91bd806ef79adf6d9c0e428b191e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

