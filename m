Return-Path: <linux-kernel+bounces-78997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F97861BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77CD41C2360E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD6C1448E6;
	Fri, 23 Feb 2024 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkOvDbIj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9518526C;
	Fri, 23 Feb 2024 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713844; cv=none; b=LVpJ41XWaZ7wluw+Ge2obPkL55wFy/FxaeeQYcMwZ5RQbWVaBJLmtExFn/bLGb7JoLfZsH2PnlWoTecSZR6TGlfV/lLrm2uVbUragK6Upw2tm0uk3ez5db9N/MtO3ZUVWePV4JDKKhPU70dpQ9p6phX++IAZVushgHySBXyJ720=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713844; c=relaxed/simple;
	bh=LUsGM92A2fcLUKLMHYCOVWsjvzm7g3yTfbJcZAheDPY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TGzPv3M4idp94CQ9jjC59UT1EPbdho2ZzQY+IXK/nKx6sEyI02uwtLZjK//QzvVZXLVSKhlyS7g6eYvdlh3At4Uw4TKwqlsad0YasJJB10uAeZWhX79k6tYcPAU7t9QrTj9HNbtNQusSZbW9R04c9EhlA70U2nthuESYz/Qm8CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkOvDbIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D121DC433F1;
	Fri, 23 Feb 2024 18:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708713843;
	bh=LUsGM92A2fcLUKLMHYCOVWsjvzm7g3yTfbJcZAheDPY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UkOvDbIjrwBp2KCSGCyHJmj6Tn5HqL5RHB2hT9rOeV8SasogXQPtSJLCnBdyUuOzU
	 Vsj9LmnhKFgxK/343A4Q61XNeysqJFxB1uUERmlSnRq5s/fqrbe0Qre2+WWFn0F85R
	 c+7llRkHVXlhbxlkC4TsJszJn8bOHkUoQWAq65AaM7LYNtKVuMvbDhBgnxWSdF3lQJ
	 BAYmtBMKSUbb7I69c+8dNLZQlyyhbHfxmuL/PA2Y5GdG9MYk74ofBG9t03/nU17gV3
	 EY/M1HJ2I6tdBiMkq3mH7B7I6A8br+lyYNhZZ4K4tiGXLZE8FLkcVOu64olvg7vvec
	 gclySANFmVZ3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF0F8C39563;
	Fri, 23 Feb 2024 18:44:03 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240222150609.61c32cf2ababec81509bf5fc@linux-foundation.org>
References: <20240222150609.61c32cf2ababec81509bf5fc@linux-foundation.org>
X-PR-Tracked-List-Id: <mm-commits.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240222150609.61c32cf2ababec81509bf5fc@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-02-22-15-02
X-PR-Tracked-Commit-Id: 2597c9947b0174fcc71bdd7ab6cb49c2b4291e95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95e73fb16ad9c93174f2604e47d98dc3537d8f95
Message-Id: <170871384377.26987.17291639762398282086.pr-tracker-bot@kernel.org>
Date: Fri, 23 Feb 2024 18:44:03 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 22 Feb 2024 15:06:09 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-02-22-15-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95e73fb16ad9c93174f2604e47d98dc3537d8f95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

