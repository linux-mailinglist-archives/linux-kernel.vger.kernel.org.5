Return-Path: <linux-kernel+bounces-133577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 970EB89A5E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51065283604
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C2F17556F;
	Fri,  5 Apr 2024 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/9U4EyC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25445175564
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351170; cv=none; b=aqgAqW/xdEDCLk9i2fsGZ59/45eVfj7aRYT8RuTo14H4jybIkoNbi4Oo1sFbJEAlIi6k9gRhIzYKOGMDnGFwpi5pi3zJGCAWAW6gUI9rsSL/tjlguqZdlpyxsPuCNSqfWUU6D/W6xwg9hOycRkA4rw7WNnh4snypyfXxusNUiD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351170; c=relaxed/simple;
	bh=B4Sgbntbvj+AgCtEMDhyAntY5n2I43aIiKKUajYQXQU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fJ1NHdTW5eXtXRysYa3f0Ur/zxipbh05FampUnaJvYi/eDPbD5mAlisM7+8i4j6pXqW0SRzVU5b/NYi9Ur60XRrIkf+rTjmPHMyMF5sGmpQHvEO7eZq33GWp71UDRjocY4ZDjaNwYp7xaOPuvUgP6kGtrmyBB3fnP67Cc84CwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/9U4EyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0284EC43390;
	Fri,  5 Apr 2024 21:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712351170;
	bh=B4Sgbntbvj+AgCtEMDhyAntY5n2I43aIiKKUajYQXQU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S/9U4EyCVHhbABqdO9RfMuPqzFd9XcePxdpuF2xTL7NRm/s8by7mcRgOTF3OlYpCB
	 7O3AS8LnR+aZwQlTouP/JkE2ubTM3eY9/J8u6Cpn5rXYfyEpZNjr+H7fC4E7BIv2W4
	 TELu7a1+v0THJwkZR7XbYLbVlOz1/CYLOgDHedbLQZ3xLnCgdpn1kfaWY54p3/faCi
	 ye9L65Uld/2/6YW+P2HBOt6iK44yax5P3mDJ1ZD8RLRRAbW8XP69FxJS0I9WhTb0HQ
	 RhjdZ2NSw4TpewGY0pG4hmxt7p7q2MF+wyea3vS9yuF6ARm7FrYWZQoj5qQM6lR4pv
	 5c7gde3iuKXyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDFE0D8A100;
	Fri,  5 Apr 2024 21:06:09 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-28e73e09-0100-4e0e-8c4a-490552b42c6f@palmer-ri-x1c9a>
References: <mhng-28e73e09-0100-4e0e-8c4a-490552b42c6f@palmer-ri-x1c9a>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-28e73e09-0100-4e0e-8c4a-490552b42c6f@palmer-ri-x1c9a>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.9-rc3
X-PR-Tracked-Commit-Id: d14fa1fcf69db9d070e75f1c4425211fa619dfc8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 261b8e89b6274f7f9c2fee5ff494dfb384d3e2c7
Message-Id: <171235116997.3156.1887417054016273983.pr-tracker-bot@kernel.org>
Date: Fri, 05 Apr 2024 21:06:09 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 05 Apr 2024 10:29:24 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/261b8e89b6274f7f9c2fee5ff494dfb384d3e2c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

