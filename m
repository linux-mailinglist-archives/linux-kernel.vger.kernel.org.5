Return-Path: <linux-kernel+bounces-31571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F283483303C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94AF1F2414B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5459358AC8;
	Fri, 19 Jan 2024 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC7e37Kk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEAC58ABF;
	Fri, 19 Jan 2024 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699645; cv=none; b=DQX6hXyw8yXb6B4vFUEclAcF32KmVaTatehtXsN8FZnKf0zWe6RczZRPZVPfcB685YNRh8ZHhGtm9I0enA64fuLd6SgkWgOUJaSOP7yL/EBTYo7fn7MCkyKLIal6f0POdZ71WRpy3bIK7uPKpdFKhY3XwYDdcF0tJ+y0r28WRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699645; c=relaxed/simple;
	bh=p81D+KtVuMOdUg8Ur1q5YAWf/ow5gyrfFbc4kJwxrcU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LYT4R74Jg338Txn25j6eMutPahNSWWqXrQ0JcVJUqw0JBohDWLDqntV/JNrAtlGsvOw8pv6g8ytxOJEbtM2/yIipqQAhhOwoEFvDBwfpVKX+R2yxh+QFqBOIX3sk6pHxrrnWWyW3yeBYz2108oOh7NFTWNRvp01Z35Dsef5GwKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC7e37Kk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72882C433F1;
	Fri, 19 Jan 2024 21:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705699645;
	bh=p81D+KtVuMOdUg8Ur1q5YAWf/ow5gyrfFbc4kJwxrcU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PC7e37KkBPLUFWApAWnyidvRoC3JA7k7nJO2fMfdF3NYo/vTCsH9yPok+hu6imUoz
	 S3V8Nx87Duqw6V/MoC1xb+FEt6h9JIfT64uh5AzsFAQHe58JALaTPo4ibAWE3HJQdo
	 3iiJDJSamsU4A0IWrsQNiiQdntLWf8rsMVg/9yaFu1PiktoQjyabIop4IvspyvKRXm
	 mavP7nQ1n439W9coYyQB1UBjGM+UB94wJZoyQDO68bQrnabwgX3yLwUI4Ppoq5NlmI
	 MzitQbg1gT5WNqDUL1NY+wBgVQL9P+xNvoEyM2/FXa5FrczwD38DMQFz0Km247lVqm
	 z3FvtocagFg4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 621CEDFC688;
	Fri, 19 Jan 2024 21:27:25 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree header detangling for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240119162225.GA449893-robh@kernel.org>
References: <20240119162225.GA449893-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240119162225.GA449893-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.8-2
X-PR-Tracked-Commit-Id: ef175b29a242fea98f467f008237484b03c94834
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bc44c51a0461e099d4eb5dff86c2d72f0fb4a6c
Message-Id: <170569964539.21908.18318874787008701827.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 21:27:25 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jan 2024 10:22:25 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bc44c51a0461e099d4eb5dff86c2d72f0fb4a6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

