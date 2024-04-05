Return-Path: <linux-kernel+bounces-133574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 963BC89A5E5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E62EB22969
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7E9174EF0;
	Fri,  5 Apr 2024 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj/GGG5L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0DF174ED4;
	Fri,  5 Apr 2024 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351157; cv=none; b=rt65iDtn9/ws3ZNzl1rr3X9XxMZANJR9q0DI3DdgiFYyKiagbkQKlDOBq+zOQmRe7vyiXoMuFrmeaU9XA76OwZtRucS906mP0H/parQmVxRqqKYZ21gqKxsXv60aOVoQ8+O179qIAfQvxUxZh612Fd4UpqeOpUOBpR314Dl/ufA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351157; c=relaxed/simple;
	bh=Mnp3gzKytpGEUmpl4ZLH3YKDGURbl4vst+EeQKBRt9A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=n8HOuIm1bWjzT4MZGgik5gFreJKXa9Kaz5v66mgM+yHNPWzdALsuZ/c/dFO3GMC1QZHMwTZasDqc+6RESWmQOfe4wS9BNINDdRR4vRFHFzIQLEXBBMsKrck3fJoRbhsYlqOJLJ/CNTZp8PvEuLOOL+y8IczEmGQDLU0Y6tVqRRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj/GGG5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9B62C433F1;
	Fri,  5 Apr 2024 21:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712351156;
	bh=Mnp3gzKytpGEUmpl4ZLH3YKDGURbl4vst+EeQKBRt9A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gj/GGG5Ldv+6JhE6PqNRGZJ6da5ym1eKewF5wxdUesUZAZxHcEJcS3oSny6jylFo5
	 nPKrTKE4xNIFrfgjD3hWQTKRScNgSiCp7UFN2x/N7jwx8ZOMlboNjgJ5+d4DXi7DVk
	 1UAZRBhV8U2bj8oGF233pLYlyUxuewqWT4y7+Sgze6kpZJ0KZo7Ks8jnKaHnY5ffod
	 L3XkfDKxZJz519pR4yyXWV0Q1l+pDD5KIHmpuiVImB4C8Cr1OKqZls/aQOKigxT3ia
	 hbVkKIoY8Ad4TR5dHhJco5g2O4ECOKPDdZZvnBps6uULdFt2iXYgKdA96cRJDJ0/hU
	 EgRA5ckxB0m+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFA2DD8A101;
	Fri,  5 Apr 2024 21:05:56 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240405114018.48d320803e1b3920f68f9f96@linux-foundation.org>
References: <20240405114018.48d320803e1b3920f68f9f96@linux-foundation.org>
X-PR-Tracked-List-Id: <mm-commits.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240405114018.48d320803e1b3920f68f9f96@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-04-05-11-30
X-PR-Tracked-Commit-Id: a6c1d9cb9a68bfa4512248419c4f4d880d19fe90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af709adfaa6e8a2f7f44b6beea5e6325ac8720c2
Message-Id: <171235115670.3156.2651182565768349192.pr-tracker-bot@kernel.org>
Date: Fri, 05 Apr 2024 21:05:56 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Apr 2024 11:40:18 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-04-05-11-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af709adfaa6e8a2f7f44b6beea5e6325ac8720c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

