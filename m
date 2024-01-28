Return-Path: <linux-kernel+bounces-41892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487EE83F939
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038F4282FD6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C325D3C466;
	Sun, 28 Jan 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDlz563V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D19E33CC2
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706467642; cv=none; b=Ar3oSdF0ILImpYrkAEk/rCAOjYHAXxilt6jwLXqF8aeg/IJvPQAPnfbLmU4aZ7i7Qxs39R4CNTjraNysJtAnOEnIaEYQhEizTbZAQebhzmWq68iKlnLR1LsUzWYO6VqXXSu/kslavLuVCJKlPtZ0GK6Lm5dxnvro1D72HqE+M08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706467642; c=relaxed/simple;
	bh=4zQXbvY91hnPD1zSkaAsXMewQm+KM5a6kJVquAUM7/E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SomxPvqNwDiES2zJbOPiLGl+wTF5zbn8foK4EycwGGDuub97YNUy1G8LKcPlzRmwyv4o1YcXwEJSyj7ZBfX+CXVikK/oos1bSgNm7xU2355GxuJSa3EoUQy9vgjw+xBditKSGdPx+dr9xZ5jhwD8BaT09b2QxAMEyRGjfJojqbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDlz563V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D16FFC433B1;
	Sun, 28 Jan 2024 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706467641;
	bh=4zQXbvY91hnPD1zSkaAsXMewQm+KM5a6kJVquAUM7/E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TDlz563VEht9agXUn5qYdoG/oCczA/Q7hC/z0YMsqE/h9SdrFvRRdzjNPd+7rEswV
	 GqZ6M+MSlPFshdslQC+ss6Rjq43SaEjNRIAIFxI4uMRHKYpV04e4d3anw61G3fA6Kn
	 dUr+O176t0kqQe9qxQqSRpwsiEITgI5AzOidAyQWE7RSoG5IkU+4n8DM1rJPHZyTki
	 z6042oGTZ5FbRrxk82Jb0lOPg9oDWSxnOj12iOvD+2OtcDCoLBfpwCeSuyT1bcj+6x
	 eJQAsvGFJ+pcM1tCpglgdamS5f8mIrDRrzjIhXZ30G6vrhDGA+hF6mPpzZ84xft9Cq
	 Juoy9j1JX3G3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE370DFF762;
	Sun, 28 Jan 2024 18:47:21 +0000 (UTC)
Subject: Re: [GIT PULL] locking/urgent for v6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240128102801.GAZbYsMbCfydNijU_y@fat_crate.local>
References: <20240128102801.GAZbYsMbCfydNijU_y@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240128102801.GAZbYsMbCfydNijU_y@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v6.8_rc2
X-PR-Tracked-Commit-Id: e626cb02ee8399fd42c415e542d031d185783903
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 648f575d5e626f8d45ef0989db60ea60a9067560
Message-Id: <170646764177.17624.13724775184138392076.pr-tracker-bot@kernel.org>
Date: Sun, 28 Jan 2024 18:47:21 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Jan 2024 11:28:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v6.8_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/648f575d5e626f8d45ef0989db60ea60a9067560

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

