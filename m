Return-Path: <linux-kernel+bounces-103963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3707C87C711
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFEF91F22632
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A956FD9;
	Fri, 15 Mar 2024 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="av1ssiSP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8423B612E;
	Fri, 15 Mar 2024 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710465608; cv=none; b=rWdKT3bif0ah4fWS+mH37nEiREPiS3CbPL/eMmbRY/KA2eKaaiV4MV121Af63uCCs0bXHe4/UoBnHmDjTs/sCThFUVg1mCrgXDvYtqqfw9d9iJIY9xi47gUJV8uTUhWA6H18ljd8Jnqm3QeSeQzS1YrK1/Sn4qEjOfaGYcmoA08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710465608; c=relaxed/simple;
	bh=hSHsG4i6rRC3IkQ1SMTQdWnz5zKMzoqWn3a1jkqbbE8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MYRAcCacGt8Bw0FCw5JrlIUA1DNMD9HjINhrDHjgCUUAHDseW8CDAjN65y+cLf5QEpOObv2+OZcNez7PkqNIKCdxxBGVzvS50d4XHROTiVwm+3OY9FEzV9aGgtwTrIy/bSjl4l4V8oqEBu3sJasjC0Tcsajz3KfiwN1ZqtrTGPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=av1ssiSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 648EFC433F1;
	Fri, 15 Mar 2024 01:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710465608;
	bh=hSHsG4i6rRC3IkQ1SMTQdWnz5zKMzoqWn3a1jkqbbE8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=av1ssiSP/YOAmzaAmFcK5xRUKR/gWEQidgF3psWXIPIgzqyQ0XA7gCAIJCNWhr0NN
	 x5TbYmzL/85F0OjiE6G/E3T9VaYpvWkA0D9IIycF/uB46fSteaW7Zt9ikIjAH5cBHJ
	 GE+PpNxwG4QR5jECFR49LqRINecqtrYBQ7XWcG3yEvOU94jQAbAYhhgU7Kh69vgfx/
	 nTrAsOgwsd/TXPIaBvwyscSKflUAo8IDW6tGAevlGKVrW5MPzn4bFVUGADcsihkr83
	 UkDMjx8EXfivWUbl+rC6sHjbgRozfDFuF5BjairCphuNJC8FndlOFQItjFh3We6ehE
	 Yu1bWqLtObBgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AEA3C595C3;
	Fri, 15 Mar 2024 01:20:08 +0000 (UTC)
Subject: Re: [GIT PULL] non-MM updates for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240314094319.5d6cc99c653e4797f162af04@linux-foundation.org>
References: <20240314094319.5d6cc99c653e4797f162af04@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240314094319.5d6cc99c653e4797f162af04@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2024-03-14-09-36
X-PR-Tracked-Commit-Id: 269cdf353b5bdd15f1a079671b0f889113865f20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5eb28f6d1afebed4bb7d740a797d0390bd3a357
Message-Id: <171046560836.16379.17783243307509900674.pr-tracker-bot@kernel.org>
Date: Fri, 15 Mar 2024 01:20:08 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Mar 2024 09:43:19 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2024-03-14-09-36

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5eb28f6d1afebed4bb7d740a797d0390bd3a357

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

