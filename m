Return-Path: <linux-kernel+bounces-43854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0421E84198E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B33AB2106A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8E5374F6;
	Tue, 30 Jan 2024 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGH5OIXx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDD437179;
	Tue, 30 Jan 2024 02:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582970; cv=none; b=KuQE4RrzMpXFYlkHFdsekdWn6a6PxEV7rbclZ6f5h9v3UpALUU1lROoAIUyrVgJFxaqTryQ0KG9AQDOJdf3eXeRzFsT+nPu4z2l15hHKOAhzTSZeCY8dBS0hQgeytmlPQlzKs5fg65GiCvbhL4yHCKDrasqto5kJ/yrArsmN4mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582970; c=relaxed/simple;
	bh=hJWKNiFb57ncUXq+Tm5DaKBUr+YvxeE4Faa6RNKpKZ4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jXpdw4YYKSCYOM+GsFuf0eL8NXv7Q/V6hokYNbTrkNq9/En9F6Xovco6j66zPs5ealhGJX/ZpJDdvKfPSgqZ7btnFsQSuX3MnSuyVyWSxRscPZ7C9+A4kESAPRKkL6Wi/ft1ugnHzHbvQcXZtUDo9z16YhsYRlAaue/0gQN1QoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGH5OIXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 991A7C433F1;
	Tue, 30 Jan 2024 02:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706582969;
	bh=hJWKNiFb57ncUXq+Tm5DaKBUr+YvxeE4Faa6RNKpKZ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JGH5OIXx1ZsGagJt2BgMtfGKSNBGShDlk/rR9ZnuB0+mjAIMqUH3ajPxzHVzJZkqT
	 +46MaWbe3TS74joIWeOgZC6l6ww+zF14yKzJXffqKLIiI1Qjcfcn0xrsB1lUFYsPlx
	 BHvtDaA6rXoXjF4Xl0n2wUmTS1yFvTQCFEIEoF1xoLlJRWz4Oa/7i6c6ithbfOEGEu
	 AVjCZY69ZZxiRGIeT8cFLdVocBWWw1P52VujWYbPhPH9hbJcwOzLegnvYjBEsTXh7H
	 mBqqg2S88e73igf8vU9+INfrowLlIuZCy8C3Q846DYH0k6OwqwB93ZvFVbwIJjWV56
	 SBJxpak6GoxkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7FDD9C3274C;
	Tue, 30 Jan 2024 02:49:29 +0000 (UTC)
Subject: Re: [GIT PULL]  hotfixes for 6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240128232759.7535e6774bec152556fb9730@linux-foundation.org>
References: <20240128232759.7535e6774bec152556fb9730@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240128232759.7535e6774bec152556fb9730@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-01-28-23-21
X-PR-Tracked-Commit-Id: 96204e15310c218fd9355bdcacd02fed1d18070e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f3d7d5cedbad7a859bb34161a2807c58e6cdda8
Message-Id: <170658296952.4250.18222386329328793534.pr-tracker-bot@kernel.org>
Date: Tue, 30 Jan 2024 02:49:29 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Jan 2024 23:27:59 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-01-28-23-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f3d7d5cedbad7a859bb34161a2807c58e6cdda8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

