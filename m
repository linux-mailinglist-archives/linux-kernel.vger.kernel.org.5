Return-Path: <linux-kernel+bounces-99620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CDC878ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F77282308
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9701A58AA5;
	Mon, 11 Mar 2024 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYfY0ErC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92B95810E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197077; cv=none; b=PhROvreCtzacyxmoINwlWV3agLgrgxkpiT0NJhIe3nItS8/NQQw3WaIEvSrjc3VAHVN+q8pk7EuWLLbGKmJi664csW99Rali6eaTZaC6Iv3byJWEDY+FFsnFykxVcd+hFUqdWODa1m4thCwVfvXHWe86IhaGT+zPvqmPiB1JpFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197077; c=relaxed/simple;
	bh=gSLjUKQuiZ+go9sxFRBcW7++ax6JRsF9hPMbiCajCXI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KcdYlDQUV3W4nWza0vF2PA/rEabjjzQJNp0DVRWrCY2RfDyV3qLxFzXEHSIYjUA/ReFdhfCGJhw/xOpzU9MZdU0S+DD0l9zvw6RNH6bhjDw7gQzVamlYyTJ+0ronAdtxValCvlrmk444SvHg/a7HhZGErSRoSY7flcwIAZQ4LiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYfY0ErC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2C5FC43399;
	Mon, 11 Mar 2024 22:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710197077;
	bh=gSLjUKQuiZ+go9sxFRBcW7++ax6JRsF9hPMbiCajCXI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cYfY0ErCklYTmmBvfYz3aZvHXykN+xOeRce0ulSjG8+/nptpNP20LyJ+4RnMgqitO
	 bApIVTY/63TWcct1OZ6KbUtySaA+K5m+pGbzJJLdcjO+a+iF32aCDVCPQ19Rillc5N
	 TxyJiSkBoDQz5ENXkRfggMq5NkCPUjprcVYzj3N/pyoID0CKpAwybnob26s17o72J5
	 O4zZknZqxyGvLKN4tq1edzun818Rkudc52hTm4sWn2MtzB3sdAeOtdOrJjL7j8rJN5
	 dHr/caideDifMDnNR3avtez+hFGD2+Apwue/9VQO6AQ0eRTMLX8NwNZrIQGoR2mJBe
	 xj82IDFSidZLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B983D95055;
	Mon, 11 Mar 2024 22:44:37 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <171011361246.2468526.10740060923051583953.tglx@xen13>
References: <171011361246.2468526.10740060923051583953.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <171011361246.2468526.10740060923051583953.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-03-10
X-PR-Tracked-Commit-Id: f7f56d59a3923e95bad2c49615a4d7313ed78314
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02d4df78c5ae70d283ebb4f78b9dcfdd4dfb71c2
Message-Id: <171019707763.5315.41050767105686955.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 22:44:37 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 00:38:50 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-03-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02d4df78c5ae70d283ebb4f78b9dcfdd4dfb71c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

